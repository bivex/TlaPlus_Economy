-------------------- MODULE Pattern_31_BotNicheMarket --------------------
(*
Этот паттерн сравнивает 3 ниши ботов, найденные в исследовании YouTube (2026):
1. Niche Parsers (Парсеры: недвижка, крипта, скидки) - Средняя сложность, высокая польза.
2. B2B Mini Apps (TMA) - Высокая сложность, огромный чек.
3. AI Oracles (ИИ-боты на базе LLM) - Высокая сложность, хайповый спрос.
*)
EXTENDS Naturals, Integers

VARIABLES 
    time_spent,        \* Потраченное время (часы)
    niche_parsers,     \* Количество запущенных парсеров
    b2b_mini_apps,     \* Количество запущенных B2B Mini Apps
    ai_oracles,        \* Количество запущенных AI ботов
    accumulated_profit \* Накопленная прибыль ($)

vars == <<time_spent, niche_parsers, b2b_mini_apps, ai_oracles, accumulated_profit>>

\* ХАРАКТЕРИСТИКИ НИШ
CONSTANT PARSER_BUILD_TIME    \* 10 часов
CONSTANT PARSER_MONTHLY_PAY   \* $50 (подписка)

CONSTANT TMA_BUILD_TIME       \* 40 часов
CONSTANT TMA_PROJECT_PRICE    \* $1500 (разово)

CONSTANT AI_BUILD_TIME        \* 30 часов
CONSTANT AI_MONTHLY_PAY       \* $100 (премиум)

TypeOK ==
    /\ time_spent \in Nat
    /\ niche_parsers \in Nat
    /\ b2b_mini_apps \in Nat
    /\ ai_oracles \in Nat
    /\ accumulated_profit \in Int

Init ==
    /\ time_spent = 0
    /\ niche_parsers = 0
    /\ b2b_mini_apps = 0
    /\ ai_oracles = 0
    /\ accumulated_profit = 0

(* Действие 1: Строим парсер (Нишевая польза) *)
BuildParser ==
    /\ time_spent < 480 \* Лимит на 3 месяца
    /\ time_spent' = time_spent + PARSER_BUILD_TIME
    /\ niche_parsers' = niche_parsers + 1
    /\ accumulated_profit' = accumulated_profit + PARSER_MONTHLY_PAY \* Первый месяц оплаты
    /\ UNCHANGED <<b2b_mini_apps, ai_oracles>>

(* Действие 2: Строим B2B Mini App (Серьезный бизнес) *)
BuildTMA ==
    /\ time_spent < 480
    /\ time_spent' = time_spent + TMA_BUILD_TIME
    /\ b2b_mini_apps' = b2b_mini_apps + 1
    /\ accumulated_profit' = accumulated_profit + TMA_PROJECT_PRICE
    /\ UNCHANGED <<niche_parsers, ai_oracles>>

(* Действие 3: Строим AI Oracle (Технологическое превосходство) *)
BuildAI ==
    /\ time_spent < 480
    /\ time_spent' = time_spent + AI_BUILD_TIME
    /\ ai_oracles' = ai_oracles + 1
    /\ accumulated_profit' = accumulated_profit + AI_MONTHLY_PAY
    /\ UNCHANGED <<niche_parsers, b2b_mini_apps>>

(* Ежемесячный цикл: Капает пассивный доход от подписок *)
MonthlyCycle ==
    /\ time_spent < 480
    /\ accumulated_profit' = accumulated_profit 
                             + (niche_parsers * PARSER_MONTHLY_PAY) 
                             + (ai_oracles * AI_MONTHLY_PAY)
    /\ UNCHANGED <<time_spent, niche_parsers, b2b_mini_apps, ai_oracles>>

Next == 
    \/ BuildParser 
    \/ BuildTMA 
    \/ BuildAI 
    \/ MonthlyCycle

Spec == Init /\ [][Next]_vars

(* ЦЕЛЬ: найти комбинацию, которая дает $10,000 быстрее всего *)
GoalNotReached == accumulated_profit < 10000

=============================================================================