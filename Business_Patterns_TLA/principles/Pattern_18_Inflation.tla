-------------------- MODULE Pattern_18_Inflation --------------------
EXTENDS Naturals, Integers

VARIABLES 
    year, 
    nominal_revenue, 
    real_revenue, 
    cpi

vars == <<year, nominal_revenue, real_revenue, cpi>>

CONSTANT INFLATION_RATE, NOMINAL_GROWTH

TypeOK ==
    /\ year \in Nat
    /\ nominal_revenue \in Nat
    /\ real_revenue \in Nat
    /\ cpi \in Nat

Init ==
    /\ year = 1
    /\ nominal_revenue = 1000
    /\ real_revenue = 1000
    /\ cpi = 100 \* Базовый год

(* Переход к следующему году: растут и цены (инфляция), и номинальная выручка *)
NextYear ==
    /\ year < 10
    /\ year' = year + 1
    /\ cpi' = cpi + (cpi * INFLATION_RATE \div 100)
    /\ nominal_revenue' = nominal_revenue + (nominal_revenue * NOMINAL_GROWTH \div 100)
    /\ real_revenue' = (nominal_revenue' * 100) \div cpi'

Next == NextYear

Spec == Init /\ [][Next]_vars

StateConstraint == year <= 10

(* 
   Свойство: доказать, что реальная выручка не упадет ниже изначальной (1000).
   Если INFLATION_RATE (например, 15) > NOMINAL_GROWTH (например, 10), 
   чекер найдет ошибку: реальные доходы падают!
*)
GoalNotReached == real_revenue >= 1000

=============================================================================