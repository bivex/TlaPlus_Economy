-------------------- MODULE Pattern_35_MultiServiceFreelance --------------------
(*
Цей паттерн моделює РЕАЛІСТИЧНУ роботу багатопрофільного фрилансера в Україні у 2026 році.
Враховує:
1. Обов'язковість сплати накладних витрат (overhead_paid) для досягнення цілі.
2. Реалістичні ціни та премію за ризик (Risk Premium), особливо для Блокчейну.
3. Податки та збори у 2026 році (ЄСВ 1902 UAH + ЄП 5% + ВЗ 1%).
4. Ризики відключень світла (Blackouts) як форс-мажорів, що забирають час та збільшують витрати.
5. Штраф за перемикання контексту (-2 години) та ризики зриву дедлайнів/продажів.
*)
EXTENDS Naturals, Integers, TLC

SERVICES == {"bot", "coding_mid", "blockchain"}

VARIABLES
    budget,           \* Бюджет (готівка в UAH)
    time_pool,        \* Вільний час у годинах (на місяць)
    leads,            \* Функція [SERVICES -> Nat] (ліди в черзі)
    active_projects,  \* Функція [SERVICES -> Nat] (активні проєкти в роботі)
    completed_tasks,  \* Функція [SERVICES -> Nat] (виконані проєкти)
    revenue,          \* Загальний дохід
    expenses,         \* Загальні витрати (податки, софт, форс-мажори)
    last_service,     \* Останній вид діяльності (для штрафу перемикання контексту)
    overhead_paid     \* Прапор обов'язкової сплати накладних витрат/податків

vars == <<budget, time_pool, leads, active_projects, completed_tasks, revenue, expenses, last_service, overhead_paid>>

CONSTANT MONTHLY_TIME_LIMIT   \* 160 годин
CONSTANT OVERHEAD_COST        \* Фіксовані налоги та софт (~2700 UAH: ЄСВ 1902.34 + ЄП + ВЗ + софт)

\* Ціни послуг з урахуванням премії за ризик (UAH)
ServicePrice(s) ==
    IF s = "bot" THEN 800             \* Підняли ціну за бота
    ELSE IF s = "coding_mid" THEN 4000 \* Реалістичний середній чек
    ELSE 12000                        \* Blockchain з урахуванням високої кваліфікації та ризиків

\* Номінальний час розробки (годин)
ServiceTime(s) ==
    IF s = "bot" THEN 2
    ELSE IF s = "coding_mid" THEN 10
    ELSE 16

\* Ризик затягування проєкту (оверхед у годинах у разі факапу/змін від клієнта)
RiskTime(s) ==
    IF s = "bot" THEN 2
    ELSE IF s = "coding_mid" THEN 6
    ELSE 15 \* Blockchain (високий ризик, але тепер компенсується чеком)

TypeOK ==
    /\ budget \in Int
    /\ time_pool \in 0..MONTHLY_TIME_LIMIT
    /\ leads \in [SERVICES -> Nat]
    /\ active_projects \in [SERVICES -> Nat]
    /\ completed_tasks \in [SERVICES -> Nat]
    /\ revenue \in Nat
    /\ expenses \in Nat
    /\ last_service \in SERVICES \union {"none", "marketing", "sales"}
    /\ overhead_paid \in BOOLEAN

Init ==
    /\ budget = 3000         \* Стартовий бюджет підвищено для сплати податків
    /\ time_pool = MONTHLY_TIME_LIMIT
    /\ leads = [s \in SERVICES |-> 0]
    /\ active_projects = [s \in SERVICES |-> 0]
    /\ completed_tasks = [s \in SERVICES |-> 0]
    /\ revenue = 0
    /\ expenses = 0
    /\ last_service = "none"
    /\ overhead_paid = FALSE

(* 1. Маркетинг: витрачаємо 4 години. Отримуємо лідів. *)
MarketingWork ==
    /\ time_pool >= 4
    /\ time_pool' = time_pool - 4
    /\ leads' = [s \in SERVICES |->
                    IF s = "bot" THEN leads[s] + 3
                    ELSE IF s = "coding_mid" THEN leads[s] + 1
                    ELSE leads[s] + 1]
    /\ last_service' = "marketing"
    /\ UNCHANGED <<budget, active_projects, completed_tasks, revenue, expenses, overhead_paid>>

(* 2. Продажі: зідзвон з лідом (1 година). Два варіанти (успіх/фейл). *)
SalesSuccess(s) ==
    /\ leads[s] > 0
    /\ time_pool >= 1
    /\ time_pool' = time_pool - 1
    /\ leads' = [leads EXCEPT ![s] = leads[s] - 1]
    /\ active_projects' = [active_projects EXCEPT ![s] = active_projects[s] + 1]
    /\ last_service' = "sales"
    /\ UNCHANGED <<budget, completed_tasks, revenue, expenses, overhead_paid>>

SalesFailure(s) ==
    /\ leads[s] > 0
    /\ time_pool >= 1
    /\ time_pool' = time_pool - 1
    /\ leads' = [leads EXCEPT ![s] = leads[s] - 1]
    /\ last_service' = "sales"
    /\ UNCHANGED <<budget, active_projects, completed_tasks, revenue, expenses, overhead_paid>>

(* 3. Виконання проєкту (номінальний час або оверран).
   Якщо тип роботи змінився, додається штраф 2 години за перемикання контексту. *)
ExecuteNominal(s) ==
    /\ active_projects[s] > 0
    /\ LET penalty == IF last_service = s THEN 0 ELSE 2
       IN  /\ time_pool >= ServiceTime(s) + penalty
           /\ time_pool' = time_pool - (ServiceTime(s) + penalty)
    /\ active_projects' = [active_projects EXCEPT ![s] = active_projects[s] - 1]
    /\ completed_tasks' = [completed_tasks EXCEPT ![s] = completed_tasks[s] + 1]
    /\ budget' = budget + ServicePrice(s)
    /\ revenue' = revenue + ServicePrice(s)
    /\ last_service' = s
    /\ UNCHANGED <<leads, expenses, overhead_paid>>

ExecuteWithOverrun(s) ==
    /\ active_projects[s] > 0
    /\ LET penalty == IF last_service = s THEN 0 ELSE 2
           overrun == RiskTime(s)
       IN  /\ time_pool >= ServiceTime(s) + overrun + penalty
           /\ time_pool' = time_pool - (ServiceTime(s) + overrun + penalty)
    /\ active_projects' = [active_projects EXCEPT ![s] = active_projects[s] - 1]
    /\ completed_tasks' = [completed_tasks EXCEPT ![s] = completed_tasks[s] + 1]
    /\ budget' = budget + ServicePrice(s)
    /\ revenue' = revenue + ServicePrice(s)
    /\ last_service' = s
    /\ UNCHANGED <<leads, expenses, overhead_paid>>

(* 4. Оплата обов'язкових податків та оверхеду (ЄСВ, софт, ведення ФОП) *)
PayOverhead ==
    /\ budget >= OVERHEAD_COST
    /\ ~overhead_paid
    /\ budget' = budget - OVERHEAD_COST
    /\ expenses' = expenses + OVERHEAD_COST
    /\ overhead_paid' = TRUE
    /\ last_service' = "none"
    /\ UNCHANGED <<time_pool, leads, active_projects, completed_tasks, revenue>>

(* 5. Форс-мажор: Відключення світла (Blackout).
   Зменшує вільний час фрилансера на 6 годин (простій або пошук коворкінгу) 
   та несе фінансові витрати (паливо для генератора або коворкінг — 300 UAH).
   Перериває поточний робочий контекст. *)
BlackoutEvent ==
    /\ time_pool >= 6
    /\ time_pool' = time_pool - 6
    /\ expenses' = expenses + 300
    /\ budget' = budget - 300
    /\ last_service' = "none"
    /\ UNCHANGED <<leads, active_projects, completed_tasks, revenue, overhead_paid>>

Next ==
    \/ MarketingWork
    \/ (\E s \in SERVICES : SalesSuccess(s) \/ SalesFailure(s))
    \/ (\E s \in SERVICES : ExecuteNominal(s) \/ ExecuteWithOverrun(s))
    \/ PayOverhead
    \/ BlackoutEvent

Spec == Init /\ [][Next]_vars

StateConstraint ==
    /\ budget <= 50000
    /\ \A s \in SERVICES : completed_tasks[s] <= 8
    /\ \A s \in SERVICES : leads[s] <= 20
    /\ \A s \in SERVICES : active_projects[s] <= 5

(* РЕАЛІСТИЧНА ЦІЛЬ: заробити чистими не менше 15,000 UAH за місяць З УРАХУВАННЯМ сплати податків *)
GoalNotReached == ~(overhead_paid /\ (revenue - expenses) >= 15000)

=============================================================================
