-------------------- MODULE Pattern_30_AdvancedBusiness --------------------
(*
ПРОДВИНУТАЯ МОДЕЛЬ (на основе YouTube кейсов): 
Скейлинг Трафика vs Услуги-Множители.

Сценарии:
1. Air Trackbot ($7,000/мес): Огромная база пользователей, пассивный доход.
2. Parsing Bot ($100/заказ): Быстрые деньги, помогающие клиенту зарабатывать $5,000.
*)
EXTENDS Naturals, Integers

VARIABLES 
    time_pool,          \* Часы (160ч/мес)
    own_user_base,      \* Пользователи своего продукта (Air Trackbot)
    passive_revenue,    \* Доход от своих продуктов (аффилиаты/реклама)
    service_revenue,    \* Доход от фриланс-заказов (Parsing/CMS)
    active_own_bots     \* Свои запущенные проекты

vars == <<time_pool, own_user_base, passive_revenue, service_revenue, active_own_bots>>

\* ПАРАМЕТРЫ ИЗ КЕЙСОВ
CONSTANT ARPU_PASSIVE           \* Доход с 1 пользователя в месяц ($0.0035 - для 2 млн юзеров)
CONSTANT SERVICE_TICKET         \* Средний чек парсера ($100)
CONSTANT SERVICE_TIME           \* Время на сборку парсера (2 часа)
CONSTANT SCALING_TIME           \* Время на маркетинг своего бота (10 часов)
CONSTANT SCALING_FACTOR         \* Сколько юзеров приносит 1 цикл маркетинга (10,000)

TypeOK ==
    /\ time_pool \in Int
    /\ own_user_base \in Nat
    /\ passive_revenue \in Nat
    /\ service_revenue \in Nat
    /\ active_own_bots \in Nat

Init ==
    /\ time_pool = 160
    /\ own_user_base = 0
    /\ passive_revenue = 0
    /\ service_revenue = 0
    /\ active_own_bots = 0

(* Сценарий 1: Работа на "Air Trackbot" (Скейлинг) *)
BuildOwnBot ==
    /\ active_own_bots = 0
    /\ time_pool >= 40 \* 1 неделя на мощный продукт
    /\ time_pool' = time_pool - 40
    /\ active_own_bots' = 1
    /\ UNCHANGED <<own_user_base, passive_revenue, service_revenue>>

MarketingOwnBot ==
    /\ active_own_bots > 0
    /\ time_pool >= SCALING_TIME
    /\ time_pool' = time_pool - SCALING_TIME
    /\ own_user_base' = own_user_base + SCALING_FACTOR
    /\ UNCHANGED <<active_own_bots, passive_revenue, service_revenue>>

GeneratePassiveIncome ==
    /\ own_user_base > 0
    \* Доход = база * ARPU. В TLA+ используем целые числа.
    /\ passive_revenue' = passive_revenue + ((own_user_base * 35) \div 10000)
    /\ UNCHANGED <<time_pool, own_user_base, service_revenue, active_own_bots>>

(* Сценарий 2: Работа на "Парсинг/CMS" (Кэш сейчас) *)
DoFreelanceTask ==
    /\ time_pool >= SERVICE_TIME
    /\ time_pool' = time_pool - SERVICE_TIME
    /\ service_revenue' = service_revenue + SERVICE_TICKET
    /\ UNCHANGED <<own_user_base, passive_revenue, active_own_bots>>

Next == 
    \/ BuildOwnBot 
    \/ MarketingOwnBot 
    \/ GeneratePassiveIncome 
    \/ DoFreelanceTask

Spec == Init /\ [][Next]_vars

(* ЦЕЛЬ: найти стратегию, где Суммарный доход (Passive + Service) > $3000 *)
GoalNotReached == (passive_revenue + service_revenue) < 3000

=============================================================================