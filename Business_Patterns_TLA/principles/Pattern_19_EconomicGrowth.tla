-------------------- MODULE Pattern_19_EconomicGrowth --------------------
EXTENDS Naturals, Integers

VARIABLES 
    year, 
    capital, 
    production, 
    total_dividends

vars == <<year, capital, production, total_dividends>>

CONSTANT SAVINGS_RATE \* Норма сбережений (процент реинвестирования) от 0 до 100

TypeOK ==
    /\ year \in Nat
    /\ capital \in Nat
    /\ production \in Nat
    /\ total_dividends \in Nat

Init ==
    /\ year = 0
    /\ capital = 100
    /\ production = 50
    /\ total_dividends = 0

(* 
   Цикл: 
   1. Производим продукт (зависит от капитала)
   2. Часть реинвестируем (capital +), часть платим акционерам (total_dividends +)
   3. Капитал амортизируется (-10 каждый год)
*)
BusinessCycle ==
    /\ year < 20
    /\ year' = year + 1
    \* Упрощенная производственная функция с убывающей отдачей
    /\ production' = (capital * 12) \div 10 \* Прирост 20%
    \* Реинвестируем
    /\ LET investment == (production' * SAVINGS_RATE) \div 100
           dividends  == production' - investment
       IN
           \* Проверяем, чтобы амортизация не увела капитал в минус
           /\ IF capital + investment >= 10 
              THEN capital' = capital + investment - 10 
              ELSE capital' = 0
           /\ total_dividends' = total_dividends + dividends

Next == BusinessCycle

Spec == Init /\ [][Next]_vars

StateConstraint == year <= 20

(* 
   Поставим цель: "Может ли компания выплатить инвесторам суммарно более 500 дивидендов за 20 лет?"
*)
GoalNotReached == total_dividends < 500

=============================================================================