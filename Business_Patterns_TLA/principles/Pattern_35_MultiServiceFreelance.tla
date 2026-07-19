-------------------- MODULE Pattern_35_MultiServiceFreelance --------------------
(*
Цей паттерн моделює роботу фрилансера за схемою з puppet_mailserver/bussiness/freelance.
Він поєднує дві бізнес-лінії (Dual-Revenue Model):
1. Активний дохід (Client Service Delivery): розробка ботів та середній кодинг.
2. Пасивний дохід (Retainers / Підтримка): підтримка сайтів та оновлення за абонплату.
3. Арбітраж трафіку (Affiliate Campaigns): фінансові інвестиції у рекламу з ризиком ROI.

Враховує:
* Податки (ЄСВ, ЄП 5%, ВЗ 1%) та оверхед (2700 UAH).
* Відключення світла (Blackouts) як форс-мажор.
* Штраф за перемикання контексту (-2 години).
*)
EXTENDS Naturals, Integers, TLC

SERVICES == {"bot", "coding_mid"}

VARIABLES
    budget,               \* Бюджет (готівка в UAH)
    time_pool,            \* Вільний час у годинах (на місяць)
    leads,                \* Функція [SERVICES -> Nat] (ліди в черзі)
    active_projects,      \* Функція [SERVICES -> Nat] (активні проєкти в роботі)
    completed_tasks,      \* Функція [SERVICES -> Nat] (виконані проєкти)
    revenue,              \* Загальний дохід
    expenses,             \* Загальні витрати (податки, реклама, форс-мажори)
    last_service,         \* Останній вид діяльності (для штрафу перемикання контексту)
    overhead_paid,        \* Прапор обов'язкової сплати накладних витрат
    retainers,            \* Кількість активних контрактів на підтримку (0..3)
    retainers_collected   \* Прапор збору абонплати за поточний місяць

vars == <<budget, time_pool, leads, active_projects, completed_tasks, revenue, expenses, last_service, overhead_paid, retainers, retainers_collected>>

CONSTANT MONTHLY_TIME_LIMIT   \* 160 годин
CONSTANT OVERHEAD_COST        \* Фіксовані налоги та софт (2700 UAH)

\* Ціни послуг (UAH)
ServicePrice(s) ==
    IF s = "bot" THEN 800             
    ELSE 4000 \* coding_mid

\* Номінальний час розробки (годин)
ServiceTime(s) ==
    IF s = "bot" THEN 2
    ELSE 10

TypeOK ==
    /\ budget \in Int
    /\ time_pool \in 0..MONTHLY_TIME_LIMIT
    /\ leads \in [SERVICES -> Nat]
    /\ active_projects \in [SERVICES -> Nat]
    /\ completed_tasks \in [SERVICES -> Nat]
    /\ revenue \in Nat
    /\ expenses \in Nat
    /\ last_service \in SERVICES \union {"none", "marketing", "sales", "affiliate"}
    /\ overhead_paid \in BOOLEAN
    /\ retainers \in 0..3
    /\ retainers_collected \in BOOLEAN

Init ==
    /\ budget = 3000
    /\ time_pool = MONTHLY_TIME_LIMIT
    /\ leads = [s \in SERVICES |-> 0]
    /\ active_projects = [s \in SERVICES |-> 0]
    /\ completed_tasks = [s \in SERVICES |-> 0]
    /\ revenue = 0
    /\ expenses = 0
    /\ last_service = "none"
    /\ overhead_paid = FALSE
    /\ retainers = 0
    /\ retainers_collected = FALSE

(* 1. Маркетинг: витрачаємо 4 години. Отримуємо лідів. *)
MarketingWork ==
    /\ time_pool >= 4
    /\ time_pool' = time_pool - 4
    /\ leads' = [s \in SERVICES |->
                    IF s = "bot" THEN leads[s] + 3
                    ELSE leads[s] + 1]
    /\ last_service' = "marketing"
    /\ UNCHANGED <<budget, active_projects, completed_tasks, revenue, expenses, overhead_paid, retainers, retainers_collected>>

(* 2. Продажі: зідзвон з лідом (1 година). *)
SalesSuccess(s) ==
    /\ leads[s] > 0
    /\ time_pool >= 1
    /\ time_pool' = time_pool - 1
    /\ leads' = [leads EXCEPT ![s] = leads[s] - 1]
    /\ active_projects' = [active_projects EXCEPT ![s] = active_projects[s] + 1]
    /\ last_service' = "sales"
    /\ UNCHANGED <<budget, completed_tasks, revenue, expenses, overhead_paid, retainers, retainers_collected>>

SalesFailure(s) ==
    /\ leads[s] > 0
    /\ time_pool >= 1
    /\ time_pool' = time_pool - 1
    /\ leads' = [leads EXCEPT ![s] = leads[s] - 1]
    /\ last_service' = "sales"
    /\ UNCHANGED <<budget, active_projects, completed_tasks, revenue, expenses, overhead_paid, retainers, retainers_collected>>

(* 3. Виконання проєкту (номінальний час розробки).
   Якщо тип роботи змінився, додається штраф 2 години за перемикання контексту. *)
ExecuteProject(s) ==
    /\ active_projects[s] > 0
    /\ LET penalty == IF last_service = s THEN 0 ELSE 2
       IN  /\ time_pool >= ServiceTime(s) + penalty
           /\ time_pool' = time_pool - (ServiceTime(s) + penalty)
    /\ active_projects' = [active_projects EXCEPT ![s] = active_projects[s] - 1]
    /\ completed_tasks' = [completed_tasks EXCEPT ![s] = completed_tasks[s] + 1]
    /\ budget' = budget + ServicePrice(s)
    /\ revenue' = revenue + ServicePrice(s)
    /\ last_service' = s
    /\ UNCHANGED <<leads, expenses, overhead_paid, retainers, retainers_collected>>

(* 4. Отримання контракту на підтримку (Retainer).
   Кожен контракт дає 1000 UAH/місяць, але вимагає 2 години часу на оновлення та бекапи.
   Для отримання контракту треба мати хоча б один виконаний проєкт. *)
AcquireRetainer ==
    /\ last_service \in {"bot", "coding_mid"}
    /\ retainers < 3
    /\ completed_tasks["bot"] + completed_tasks["coding_mid"] > retainers
    /\ time_pool >= 2
    /\ time_pool' = time_pool - 2
    /\ retainers' = retainers + 1
    /\ last_service' = "sales"
    /\ UNCHANGED <<budget, leads, active_projects, completed_tasks, revenue, expenses, overhead_paid, retainers_collected>>

(* 5. Збір абонентської плати за підтримку.
   Виконується один раз за місяць, забирає час на роботи (2 год на кожен контракт). *)
CollectRetainers ==
    /\ retainers > 0
    /\ ~retainers_collected
    /\ time_pool <= 30
    /\ time_pool >= retainers * 2
    /\ time_pool' = time_pool - (retainers * 2)
    /\ budget' = budget + (retainers * 1000)
    /\ revenue' = revenue + (retainers * 1000)
    /\ retainers_collected' = TRUE
    /\ last_service' = "none"
    /\ UNCHANGED <<leads, active_projects, completed_tasks, expenses, overhead_paid, retainers>>

(* 6. Запуск рекламної кампанії (Affiliate Campaign).
   Вимагає бюджету на рекламу (2500 UAH) та 2 години часу на налаштування Keitaro/WordPress.
   Має два результати (успішна кампанія з ROI +50% або злив бюджету з ROI -60%): *)
RunAffiliateSuccess ==
    /\ last_service = "marketing"
    /\ budget >= 2500
    /\ time_pool >= 2
    /\ time_pool' = time_pool - 2
    /\ budget' = budget - 2500 + 3750  \* Повернення бюджету + 50% прибутку
    /\ revenue' = revenue + 3750
    /\ expenses' = expenses + 2500
    /\ last_service' = "affiliate"
    /\ UNCHANGED <<leads, active_projects, completed_tasks, overhead_paid, retainers, retainers_collected>>

RunAffiliateFailure ==
    /\ last_service = "marketing"
    /\ budget >= 2500
    /\ time_pool >= 2
    /\ time_pool' = time_pool - 2
    /\ budget' = budget - 2500 + 1000  \* Втрата 60% бюджету
    /\ revenue' = revenue + 1000
    /\ expenses' = expenses + 2500
    /\ last_service' = "affiliate"
    /\ UNCHANGED <<leads, active_projects, completed_tasks, overhead_paid, retainers, retainers_collected>>

(* 7. Оплата податків *)
PayOverhead ==
    /\ budget >= OVERHEAD_COST
    /\ ~overhead_paid
    /\ budget' = budget - OVERHEAD_COST
    /\ expenses' = expenses + OVERHEAD_COST
    /\ overhead_paid' = TRUE
    /\ last_service' = "none"
    /\ UNCHANGED <<time_pool, leads, active_projects, completed_tasks, revenue, retainers, retainers_collected>>

(* 8. Форс-мажор: Блекаут *)
BlackoutEvent ==
    /\ time_pool >= 6
    /\ time_pool' = time_pool - 6
    /\ expenses' = expenses + 300
    /\ budget' = budget - 300
    /\ last_service' = "none"
    /\ UNCHANGED <<leads, active_projects, completed_tasks, revenue, overhead_paid, retainers, retainers_collected>>

Next ==
    \/ MarketingWork
    \/ (\E s \in SERVICES : SalesSuccess(s) \/ SalesFailure(s))
    \/ (\E s \in SERVICES : ExecuteProject(s))
    \/ AcquireRetainer
    \/ CollectRetainers
    \/ RunAffiliateSuccess
    \/ RunAffiliateFailure
    \/ PayOverhead
    \/ BlackoutEvent

Spec == Init /\ [][Next]_vars

StateConstraint ==
    /\ budget <= 50000
    /\ \A s \in SERVICES : completed_tasks[s] <= 3
    /\ \A s \in SERVICES : leads[s] <= 5
    /\ \A s \in SERVICES : active_projects[s] <= 2

(* ЦІЛЬ: заробити чистими не менше 12,000 UAH (масштабування через підписку та рекламу) *)
GoalNotReached == ~(overhead_paid /\ (revenue - expenses) >= 12000)

=============================================================================
