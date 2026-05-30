-------------------- MODULE Pattern_05_Elasticity --------------------
EXTENDS Naturals, Integers

VARIABLES 
    price, 
    demand_inelastic, 
    revenue_inelastic, 
    demand_elastic, 
    revenue_elastic

vars == <<price, demand_inelastic, revenue_inelastic, demand_elastic, revenue_elastic>>

TypeOK ==
    /\ price \in Nat
    /\ demand_inelastic \in Nat
    /\ revenue_inelastic \in Nat
    /\ demand_elastic \in Nat
    /\ revenue_elastic \in Nat

Init ==
    /\ price = 50
    /\ demand_inelastic = 20
    /\ revenue_inelastic = 1000
    /\ demand_elastic = 20
    /\ revenue_elastic = 1000

IncreasePrice ==
    /\ price' = price + 10
    \* Для неэластичного товара спрос падает слабо (-1)
    /\ demand_inelastic' = IF demand_inelastic >= 1 THEN demand_inelastic - 1 ELSE 0
    \* Для эластичного товара спрос обваливается (-5)
    /\ demand_elastic' = IF demand_elastic >= 5 THEN demand_elastic - 5 ELSE 0
    /\ revenue_inelastic' = demand_inelastic' * price'
    /\ revenue_elastic' = demand_elastic' * price'

DecreasePrice ==
    /\ price > 10
    /\ price' = price - 10
    \* При скидке неэластичный спрос растет слабо
    /\ demand_inelastic' = demand_inelastic + 1
    \* При скидке эластичный спрос (масс-маркет) взлетает
    /\ demand_elastic' = demand_elastic + 5
    /\ revenue_inelastic' = demand_inelastic' * price'
    /\ revenue_elastic' = demand_elastic' * price'

Next == IncreasePrice \/ DecreasePrice

Spec == Init /\ [][Next]_vars

StateConstraint ==
    /\ price <= 200

(* Цель: Попросить чекер найти сценарий, где мы зарабатываем 1500+ на эластичном товаре *)
GoalNotReached == revenue_elastic < 1500

=============================================================================