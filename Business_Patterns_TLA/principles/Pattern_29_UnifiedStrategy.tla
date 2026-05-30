-------------------- MODULE Pattern_29_UnifiedStrategy --------------------
(*
ГРАНД-МОДЕЛЬ: Идеальный Фриланс-Бизнес (CMS & Telegram Bots)
Синтез всех 26 глав экономики.

Механики:
1. Лестница продуктов (Price Discrimination)
2. Сигнализирование (Portfolio Strategy)
3. Просеивание (Screening bad leads)
4. Положительные экстерналии (Referral loop)
5. Минимизация альтернативных издержек (AI-assisted coding)
*)
EXTENDS Naturals, Integers

VARIABLES 
    time_pool,        \* Ресурс времени (160ч/мес)
    budget,           \* Наличные ($)
    portfolio_size,   \* Количество кейсов (0..6)
    leads_low,        \* Лиды на дешевый продукт ($200)
    leads_main,       \* Лиды на средний чек ($500)
    leads_high,       \* Лиды на флагман ($1500)
    reputation,       \* Уровень бренда (влияет на конверсию)
    total_profit      \* Итоговая прибыль

vars == <<time_pool, budget, portfolio_size, leads_low, leads_main, leads_high, reputation, total_profit>>

\* БИЗНЕС-ПАРАМЕТРЫ
CONSTANT FIXED_COSTS          \* $30 / 12 = $3/мес
CONSTANT ENTRY_PRICE, MAIN_PRICE, ANCHOR_PRICE
CONSTANT PRODUCTION_TIME_AI    \* Время на проект с ИИ (эффективность)

TypeOK ==
    /\ time_pool \in Int
    /\ budget \in Int
    /\ portfolio_size \in 0..6
    /\ reputation \in Nat
    /\ total_profit \in Int

Init ==
    /\ time_pool = 160
    /\ budget = 100
    /\ portfolio_size = 0
    /\ leads_low = 0
    /\ leads_main = 0
    /\ leads_high = 0
    /\ reputation = 0
    /\ total_profit = 0

(* 1. ФАЗА ИНВЕСТИЦИЙ: Создаем 6 "Сигналов" (Signaling) *)
BuildSignal ==
    /\ portfolio_size < 6
    /\ time_pool >= 10
    /\ portfolio_size' = portfolio_size + 1
    /\ time_pool' = time_pool - 10
    /\ reputation' = reputation + 10
    /\ UNCHANGED <<budget, leads_low, leads_main, leads_high, total_profit>>

(* 2. МАРКЕТИНГ: Генерация лидов разных тиров (Elasticity) *)
GenerateLeads ==
    /\ portfolio_size >= 3 \* Начинаем только когда есть база
    /\ time_pool >= 5
    /\ time_pool' = time_pool - 5
    /\ leads_low' = leads_low + 5
    /\ leads_main' = leads_main + 3
    /\ leads_high' = leads_high + 1
    /\ UNCHANGED <<budget, portfolio_size, reputation, total_profit>>

(* 3. ПРОСЕИВАНИЕ (Screening): Тратим 1 час, чтобы убрать "лимонов" *)
ScreenLeads ==
    /\ (leads_low + leads_main + leads_high) > 5
    /\ time_pool >= 1
    /\ time_pool' = time_pool - 1
    \* Убираем мусорные заявки, оставляем только целевые
    /\ leads_low' = leads_low \div 2
    /\ leads_main' = leads_main \div 2
    /\ UNCHANGED <<budget, portfolio_size, leads_high, reputation, total_profit>>

(* 4. ПРОДАЖИ И ИСПОЛНЕНИЕ (Product Ladder) *)
SellEntry ==
    /\ leads_low > 0 /\ time_pool >= 2
    /\ time_pool' = time_pool - 2
    /\ leads_low' = leads_low - 1
    /\ budget' = budget + ENTRY_PRICE
    /\ total_profit' = total_profit + ENTRY_PRICE
    /\ reputation' = reputation + 1 \* Быстрый отзыв
    /\ UNCHANGED <<portfolio_size, leads_main, leads_high>>

SellMain ==
    /\ leads_main > 0 /\ time_pool >= PRODUCTION_TIME_AI
    /\ time_pool' = time_pool - PRODUCTION_TIME_AI
    /\ leads_main' = leads_main - 1
    /\ budget' = budget + MAIN_PRICE
    /\ total_profit' = total_profit + MAIN_PRICE
    /\ reputation' = reputation + 5
    /\ UNCHANGED <<portfolio_size, leads_low, leads_high>>

SellAnchor ==
    /\ leads_high > 0 /\ time_pool >= 20
    /\ reputation >= 30 \* Требует высокого доверия
    /\ time_pool' = time_pool - 20
    /\ leads_high' = leads_high - 1
    /\ budget' = budget + ANCHOR_PRICE
    /\ total_profit' = total_profit + ANCHOR_PRICE
    /\ reputation' = reputation + 20
    /\ UNCHANGED <<portfolio_size, leads_low, leads_main>>

Next == 
    \/ BuildSignal 
    \/ GenerateLeads 
    \/ ScreenLeads 
    \/ SellEntry 
    \/ SellMain 
    \/ SellAnchor

Spec == Init /\ [][Next]_vars

(* ЦЕЛЬ: заработать $5000 за месяц (или цикл) *)
GoalNotReached == total_profit < 5000

=============================================================================