-------------------- MODULE Pattern_26_FreelanceBusiness --------------------
(*
Этот паттерн применяет библиотеку экономических законов к конкретному бизнесу:
IT-портфолио фрилансера (CMS, Telegram боты).

Интегрирует:
- Паттерн 01 (ROI): Баланс времени на маркетинг и разработку.
- Паттерн 04 (Воронка): Конверсия лидов в заказы.
- Паттерн 11 (Издержки): Учет фиксированных затрат (VPS, Domain).
*)
EXTENDS Naturals, Integers

VARIABLES 
    budget,           \* Наличные деньги (USD)
    time_pool,        \* Доступное рабочее время (часы в месяц)
    leads,            \* Потенциальные клиенты в воронке
    active_projects,  \* Заказы в работе (WIP)
    completed_tasks,  \* Успешно сданные проекты
    revenue,          \* Общая выручка
    expenses          \* Общие расходы

vars == <<budget, time_pool, leads, active_projects, completed_tasks, revenue, expenses>>

\* КОНСТАНТЫ БИЗНЕСА
CONSTANT PROJECT_PRICE        \* Средний чек ($500)
CONSTANT OPS_COST_ANNUAL      \* VPS ($25) + Domain ($5) = $30
CONSTANT PRODUCTION_TIME      \* Время на 1 проект (часы, например 5 часов)
CONSTANT MONTHLY_TIME_LIMIT   \* 160 часов (40ч/неделя)

TypeOK ==
    /\ budget \in Int
    /\ time_pool \in 0..MONTHLY_TIME_LIMIT
    /\ leads \in Nat
    /\ active_projects \in Nat
    /\ completed_tasks \in Nat
    /\ revenue \in Nat
    /\ expenses \in Nat

Init ==
    /\ budget = 100         \* Стартовый капитал
    /\ time_pool = MONTHLY_TIME_LIMIT
    /\ leads = 0
    /\ active_projects = 0
    /\ completed_tasks = 0
    /\ revenue = 0
    /\ expenses = 0

(* 1. Маркетинг (из Паттерна 04): Тратим время на контент, получаем лидов *)
MarketingWork ==
    /\ time_pool >= 2
    /\ time_pool' = time_pool - 2
    /\ leads' = leads + 3 \* 2 часа работы дают 3 лида
    /\ UNCHANGED <<budget, active_projects, completed_tasks, revenue, expenses>>

(* 2. Продажи: Конвертируем лидов в активные проекты (Паттерн 07: Эффективность) *)
SalesClosing ==
    /\ leads > 0
    /\ time_pool >= 1
    /\ time_pool' = time_pool - 1
    /\ leads' = leads - 1
    /\ active_projects' = active_projects + 1
    /\ UNCHANGED <<budget, completed_tasks, revenue, expenses>>

(* 3. Производство: Выполнение заказа (Паттерн 11: Убывающая отдача) *)
ExecuteProject ==
    /\ active_projects > 0
    /\ time_pool >= PRODUCTION_TIME
    /\ time_pool' = time_pool - PRODUCTION_TIME
    /\ active_projects' = active_projects - 1
    /\ completed_tasks' = completed_tasks + 1
    /\ budget' = budget + PROJECT_PRICE
    /\ revenue' = revenue + PROJECT_PRICE
    /\ UNCHANGED <<leads, expenses>>

(* 4. Оплата инфраструктуры (Паттерн 08: Налоги/Издержки) *)
PayOverhead ==
    /\ budget >= OPS_COST_ANNUAL
    /\ expenses = 0 \* Платим один раз за год (для модели - один раз за цикл)
    /\ budget' = budget - OPS_COST_ANNUAL
    /\ expenses' = OPS_COST_ANNUAL
    /\ UNCHANGED <<time_pool, leads, active_projects, completed_tasks, revenue>>

Next == 
    \/ MarketingWork 
    \/ SalesClosing 
    \/ ExecuteProject 
    \/ PayOverhead

Spec == Init /\ [][Next]_vars

(* Ограничения для чекера *)
StateConstraint ==
    /\ budget <= 5000
    /\ completed_tasks <= 10

(* ЦЕЛЬ: Может ли фрилансер заработать чистыми $2000 за месяц, учитывая издержки? *)
GoalNotReached == (revenue - expenses) < 2000

=============================================================================