-------------------- MODULE Pattern_21_MacroShocks --------------------
EXTENDS Naturals, Integers

VARIABLES 
    gdp, 
    price_level, 
    expected_price_level,
    stage

vars == <<gdp, price_level, expected_price_level, stage>>

CONSTANT NATURAL_GDP

TypeOK ==
    /\ gdp \in Nat
    /\ price_level \in Nat
    /\ expected_price_level \in Nat
    /\ stage \in {"Equilibrium", "Recession", "Recovered"}

Init ==
    /\ gdp = NATURAL_GDP
    /\ price_level = 100
    /\ expected_price_level = 100
    /\ stage = "Equilibrium"

(* 1. Негативный шок спроса (кризис) *)
DemandShock ==
    /\ stage = "Equilibrium"
    /\ gdp' = gdp - 20
    /\ price_level' = price_level - 10
    /\ stage' = "Recession"
    /\ UNCHANGED <<expected_price_level>>

(* 2. Долгосрочная самокоррекция: ожидания подстраиваются под новую реальность *)
SelfCorrection ==
    /\ stage = "Recession"
    /\ expected_price_level' = price_level
    \* Издержки падают (так как ожидания инфляции упали), предложение растет
    /\ gdp' = NATURAL_GDP
    /\ price_level' = price_level - 10
    /\ stage' = "Recovered"

Next == DemandShock \/ SelfCorrection

Spec == Init /\ [][Next]_vars

StateConstraint == TRUE

(* 
   Мы доказываем, что система сама выйдет из рецессии.
   Чекер найдет путь к состоянию "Recovered", где ВВП снова равен естественному,
   но уровень цен навсегда остался ниже изначального.
*)
GoalNotReached == stage /= "Recovered"

=============================================================================