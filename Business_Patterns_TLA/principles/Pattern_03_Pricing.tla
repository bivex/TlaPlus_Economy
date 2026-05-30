-------------------- MODULE Pattern_03_Pricing --------------------
EXTENDS Naturals, Integers

VARIABLES 
    price, 
    stock, 
    demand, 
    revenue

vars == <<price, stock, demand, revenue>>

TypeOK ==
    /\ price \in Nat \ {0}
    /\ stock \in Nat
    /\ demand \in Nat
    /\ revenue \in Nat

Init ==
    /\ price = 20
    /\ stock = 100
    /\ demand = 50
    /\ revenue = 0

(* Если есть дефицит (спрос больше наличия), алгоритм ценообразования повышает цену *)
IncreasePrice ==
    /\ demand > stock
    /\ price' = price + 10
    \* Спрос падает при росте цены (эластичность)
    /\ demand' = IF demand >= 5 THEN demand - 5 ELSE 0
    /\ UNCHANGED <<stock, revenue>>

(* Если продажи идут медленно, включается скидка / распродажа *)
DecreasePrice ==
    /\ stock > demand
    /\ price > 10
    /\ price' = price - 10
    \* Скидка провоцирует рост спроса
    /\ demand' = demand + 5
    /\ UNCHANGED <<stock, revenue>>

(* Сделка происходит только по текущей установленной цене *)
MakeSale ==
    /\ demand > 0
    /\ stock > 0
    /\ demand' = demand - 1
    /\ stock' = stock - 1
    /\ revenue' = revenue + price
    /\ UNCHANGED <<price>>

Next == IncreasePrice \/ DecreasePrice \/ MakeSale

Spec == Init /\ [][Next]_vars

(* Ограничение для избежания взрыва состояний *)
StateConstraint ==
    /\ price <= 100
    /\ revenue <= 5000

(* Цель: найти стратегию ценообразования для максимизации выручки *)
GoalNotReached == revenue < 2000

=============================================================================