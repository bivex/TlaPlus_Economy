-------------------- MODULE Pattern_35_MultiServiceFreelance --------------------
(*
Цей паттерн моделює РЕАЛІСТИЧНУ роботу багатопрофільного фрилансера в Україні.
Для прискорення верифікації обрано 3 представницькі класи послуг з прайс-листа:
- Дешеві швидкі замовлення (bot): 300 UAH (1 година номінал, +2 години ризик)
- Середні замовлення розробки (coding_mid): 1500 UAH (6 годин номінал, +6 годин ризик)
- Дорогі блокчейн-проєкти (blockchain): 2500 UAH (11 годин номінал, +15 годин ризик)

Враховує:
1. Вартість перемикання контексту (Context Switching): -2 години при зміні типу замовлень.
2. Ризик у продажах (Sales Conversion Risk): зідзвон (1 година) може завершитися невдачею.
3. Проєктні ризики (Project Overruns): затримки через вимоги клієнта чи баги.
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
    expenses,         \* Загальні витрати
    last_service      \* Останній вид діяльності (для штрафу перемикання контексту)

vars == <<budget, time_pool, leads, active_projects, completed_tasks, revenue, expenses, last_service>>

CONSTANT MONTHLY_TIME_LIMIT   \* 160 годин
CONSTANT OVERHEAD_COST        \* Накладні витрати (1500 UAH)

\* Ціни послуг (UAH)
ServicePrice(s) ==
    IF s = "bot" THEN 300
    ELSE IF s = "coding_mid" THEN 1500
    ELSE 2500 \* blockchain

\* Номінальний час розробки (годин)
ServiceTime(s) ==
    IF s = "bot" THEN 1
    ELSE IF s = "coding_mid" THEN 6
    ELSE 11 \* blockchain

\* Ризик затягування проєкту (оверхед у годинах у разі ускладнень)
RiskTime(s) ==
    IF s = "bot" THEN 2
    ELSE IF s = "coding_mid" THEN 6
    ELSE 15 \* blockchain (дуже високий ризик)

TypeOK ==
    /\ budget \in Int
    /\ time_pool \in 0..MONTHLY_TIME_LIMIT
    /\ leads \in [SERVICES -> Nat]
    /\ active_projects \in [SERVICES -> Nat]
    /\ completed_tasks \in [SERVICES -> Nat]
    /\ revenue \in Nat
    /\ expenses \in Nat
    /\ last_service \in SERVICES \union {"none", "marketing", "sales"}

Init ==
    /\ budget = 1000
    /\ time_pool = MONTHLY_TIME_LIMIT
    /\ leads = [s \in SERVICES |-> 0]
    /\ active_projects = [s \in SERVICES |-> 0]
    /\ completed_tasks = [s \in SERVICES |-> 0]
    /\ revenue = 0
    /\ expenses = 0
    /\ last_service = "none"

(* 1. Маркетинг: витрачаємо 4 години. Отримуємо лідів. *)
MarketingWork ==
    /\ time_pool >= 4
    /\ time_pool' = time_pool - 4
    /\ leads' = [s \in SERVICES |->
                    IF s = "bot" THEN leads[s] + 3
                    ELSE IF s = "coding_mid" THEN leads[s] + 1
                    ELSE leads[s] + 1]
    /\ last_service' = "marketing"
    /\ UNCHANGED <<budget, active_projects, completed_tasks, revenue, expenses>>

(* 2. Продажі: зідзвон з лідом (1 година). Два варіанти (успіх/фейл). *)
SalesSuccess(s) ==
    /\ leads[s] > 0
    /\ time_pool >= 1
    /\ time_pool' = time_pool - 1
    /\ leads' = [leads EXCEPT ![s] = leads[s] - 1]
    /\ active_projects' = [active_projects EXCEPT ![s] = active_projects[s] + 1]
    /\ last_service' = "sales"
    /\ UNCHANGED <<budget, completed_tasks, revenue, expenses>>

SalesFailure(s) ==
    /\ leads[s] > 0
    /\ time_pool >= 1
    /\ time_pool' = time_pool - 1
    /\ leads' = [leads EXCEPT ![s] = leads[s] - 1]
    /\ last_service' = "sales"
    /\ UNCHANGED <<budget, active_projects, completed_tasks, revenue, expenses>>

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
    /\ UNCHANGED <<leads, expenses>>

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
    /\ UNCHANGED <<leads, expenses>>

(* 4. Оплата накладних витрат *)
PayOverhead ==
    /\ budget >= OVERHEAD_COST
    /\ expenses = 0
    /\ budget' = budget - OVERHEAD_COST
    /\ expenses' = OVERHEAD_COST
    /\ last_service' = "none"
    /\ UNCHANGED <<time_pool, leads, active_projects, completed_tasks, revenue>>

Next ==
    \/ MarketingWork
    \/ (\E s \in SERVICES : SalesSuccess(s) \/ SalesFailure(s))
    \/ (\E s \in SERVICES : ExecuteNominal(s) \/ ExecuteWithOverrun(s))
    \/ PayOverhead

Spec == Init /\ [][Next]_vars

StateConstraint ==
    /\ budget <= 40000
    /\ \A s \in SERVICES : completed_tasks[s] <= 15
    /\ \A s \in SERVICES : leads[s] <= 30
    /\ \A s \in SERVICES : active_projects[s] <= 5

(* РЕАЛІСТИЧНА ЦІЛЬ: заробити чистими 12,000 UAH за місяць *)
GoalNotReached == (revenue - expenses) < 12000

=============================================================================
