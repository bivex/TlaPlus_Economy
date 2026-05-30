-------------------- MODULE Pattern_06_MarketConstraints --------------------
EXTENDS Naturals, Integers

VARIABLES 
    price, 
    demand, 
    supply, 
    market_status

vars == <<price, demand, supply, market_status>>

CONSTANT PRICE_CEILING

TypeOK ==
    /\ price \in Nat \ {0}
    /\ demand \in Nat
    /\ supply \in Nat
    /\ market_status \in {"Shortage", "Surplus", "Equilibrium"}

Init ==
    /\ price = 2
    /\ demand = 16
    /\ supply = 4
    /\ market_status = "Shortage"

(* 
   Действие 1: Реакция на Дефицит. Продавцы хотят повысить цену.
   Но государство/платформа запрещает поднимать цену выше PRICE_CEILING.
*)
PriceIncreases ==
    /\ demand > supply
    /\ price < PRICE_CEILING \* ЖЕСТКОЕ ОГРАНИЧЕНИЕ
    /\ price' = price + 1
    /\ demand' = 20 - (price' * 2)
    /\ supply' = price' * 2
    /\ market_status' = IF demand' > supply' THEN "Shortage"
                        ELSE IF demand' < supply' THEN "Surplus"
                        ELSE "Equilibrium"

(* 
   Действие 2: Реакция на Избыток.
*)
PriceDecreases ==
    /\ supply > demand
    /\ price > 1
    /\ price' = price - 1
    /\ demand' = 20 - (price' * 2)
    /\ supply' = price' * 2
    /\ market_status' = IF demand' > supply' THEN "Shortage"
                        ELSE IF demand' < supply' THEN "Surplus"
                        ELSE "Equilibrium"

Next == PriceIncreases \/ PriceDecreases

Spec == Init /\ [][Next]_vars

(* 
   Свойство: Рынок должен смочь достичь равновесия.
   Мы просим чекер найти путь к равновесию.
*)
GoalNotReached == market_status /= "Equilibrium"

=============================================================================