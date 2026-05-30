-------------------- MODULE Pattern_27_PortfolioStrategy --------------------
(*
Этот паттерн ищет оптимальное количество готовых продуктов в портфолио.
Базируется на:
- Паттерн 17 (Сигнализирование): Портфолио - это сигнал качества.
- Паттерн 11 (Убывающая отдача): Каждый новый кейс дает меньше профита, чем первый.
- Паттерн 01 (Альтернативные издержки): Время на портфолио могло пойти на оплачиваемый кодинг.
*)
EXTENDS Naturals, Integers

VARIABLES 
    portfolio_items,   \* Количество готовых продуктов в портфолио
    time_pool,         \* Часы (на горизонте 3 месяца = 480 часов)
    leads,             \* Входящие заявки
    revenue,           \* Выручка ($)
    projects_done      \* Закрытые платные заказы

vars == <<portfolio_items, time_pool, leads, revenue, projects_done>>

CONSTANT BUILD_TIME_PORTFOLIO    \* Время на 1 демо-продукт (10 часов)
CONSTANT BUILD_TIME_CLIENT       \* Время на 1 клиентский заказ (5 часов)
CONSTANT MARKETING_HOUR_COST     \* 1 час маркетинга
CONSTANT PRICE                   \* $500

TypeOK ==
    /\ portfolio_items \in 0..20
    /\ time_pool \in Int
    /\ leads \in Nat
    /\ revenue \in Nat
    /\ projects_done \in Nat

Init ==
    /\ portfolio_items = 0
    /\ time_pool = 480 \* 3 месяца работы по 160 часов
    /\ leads = 0
    /\ revenue = 0
    /\ projects_done = 0

(* 1. Создание портфолио: Тратим время, получаем "сигнал" *)
BuildPortfolioItem ==
    /\ time_pool >= BUILD_TIME_PORTFOLIO
    /\ portfolio_items < 15 \* Больше 15 никто не смотрит
    /\ portfolio_items' = portfolio_items + 1
    /\ time_pool' = time_pool - BUILD_TIME_PORTFOLIO
    /\ UNCHANGED <<leads, revenue, projects_done>>

(* 2. Маркетинг: Привлекаем лидов. 
   Эффективность маркетинга растет от размера портфолио!
   Если 0 работ - 1 час дает 0.5 лида.
   Если 5 работ - 1 час дает 3 лида.
*)
DoMarketing ==
    /\ time_pool >= 1
    /\ time_pool' = time_pool - 1
    /\ LET efficiency == 1 + (portfolio_items \div 2) \* Целочисленный рост
       IN  leads' = leads + efficiency
    /\ UNCHANGED <<portfolio_items, revenue, projects_done>>

(* 3. Продажи и Выполнение: Конвертируем лидов в деньги.
   Вероятность закрытия (Конверсия) растет от портфолио.
   В TLA+ моделируем это через порог "качества лида".
*)
CloseAndExecute ==
    /\ leads > 0
    /\ time_pool >= BUILD_TIME_CLIENT
    \* Шанс успеха: если портфолио > 3, закрываем легко
    /\ (portfolio_items >= 3 \/ (leads % 2 = 0)) \* Упрощенная логика вероятности
    /\ projects_done' = projects_done + 1
    /\ revenue' = revenue + PRICE
    /\ leads' = leads - 1
    /\ time_pool' = time_pool - BUILD_TIME_CLIENT
    /\ UNCHANGED <<portfolio_items>>

Next == 
    \/ BuildPortfolioItem 
    \/ DoMarketing 
    \/ CloseAndExecute

Spec == Init /\ [][Next]_vars

(* ЦЕЛЬ: Мы хотим узнать, какая стратегия принесет > $10,000 за 3 месяца. *)
GoalNotReached == revenue < 10000

=============================================================================