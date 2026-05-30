-------------------- MODULE Pattern_25_ForecastingLimits --------------------
EXTENDS Naturals, Integers

VARIABLES 
    day, 
    confidence_level, 
    alive

vars == <<day, confidence_level, alive>>

TypeOK ==
    /\ day \in Nat
    /\ confidence_level \in Nat
    /\ alive \in BOOLEAN

Init ==
    /\ day = 1
    /\ confidence_level = 1
    /\ alive = TRUE

(* Обычный день: индюшку кормят, её уверенность в будущем крепнет *)
NormalDay ==
    /\ alive = TRUE
    /\ day < 100
    /\ day' = day + 1
    /\ confidence_level' = confidence_level + 1
    /\ UNCHANGED <<alive>>

(* Черный Лебедь: День Благодарения (непредсказуемое событие) *)
BlackSwanEvent ==
    /\ day = 100
    /\ alive = TRUE
    /\ alive' = FALSE
    /\ confidence_level' = 0
    /\ UNCHANGED <<day>>

Next == NormalDay \/ BlackSwanEvent

Spec == Init /\ [][Next]_vars

StateConstraint == TRUE

(* 
   Свойство: доказать, что в момент краха (alive = FALSE) 
   уверенность системы была максимальной (100).
   Модель покажет этот парадокс прогнозирования.
*)
GoalNotReached == ~(alive = FALSE /\ confidence_level = 0)

=============================================================================