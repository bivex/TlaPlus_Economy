-------------------- MODULE Pattern_22_PhillipsCurve --------------------
EXTENDS Naturals, Integers

VARIABLES 
    unemployment, 
    actual_inflation, 
    expected_inflation

vars == <<unemployment, actual_inflation, expected_inflation>>

CONSTANT NATURAL_UNEMPLOYMENT

TypeOK ==
    /\ unemployment \in Int
    /\ actual_inflation \in Nat
    /\ expected_inflation \in Nat

Init ==
    /\ unemployment = NATURAL_UNEMPLOYMENT
    /\ actual_inflation = 2
    /\ expected_inflation = 2

(* ЦБ заливает рынок деньгами *)
StimulateEconomy ==
    /\ actual_inflation < 15
    /\ actual_inflation' = actual_inflation + 5
    \* Безработица падает, так как факт > ожиданий
    /\ unemployment' = NATURAL_UNEMPLOYMENT - (actual_inflation' - expected_inflation)
    /\ UNCHANGED <<expected_inflation>>

(* Ожидания рынка подстраиваются под реальность *)
ExpectationsAdjust ==
    /\ expected_inflation < actual_inflation
    /\ expected_inflation' = actual_inflation
    \* Безработица возвращается к естественному уровню
    /\ unemployment' = NATURAL_UNEMPLOYMENT - (actual_inflation - expected_inflation')
    /\ UNCHANGED <<actual_inflation>>

Next == StimulateEconomy \/ ExpectationsAdjust

Spec == Init /\ [][Next]_vars

StateConstraint == actual_inflation <= 15

(* 
   Свойство: доказать, что после корректировки ожиданий мы всегда 
   возвращаемся к естественному уровню безработицы, но с высокой инфляцией.
*)
GoalNotReached == ~(unemployment = NATURAL_UNEMPLOYMENT /\ actual_inflation > 2 /\ expected_inflation = actual_inflation)

=============================================================================