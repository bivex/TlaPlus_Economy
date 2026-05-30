-------------------- MODULE Pattern_10_Commons --------------------
EXTENDS Naturals, Integers

VARIABLES 
    shared_capacity, 
    teamA_profit, 
    teamB_profit,
    system_crashed

vars == <<shared_capacity, teamA_profit, teamB_profit, system_crashed>>

TypeOK ==
    /\ shared_capacity \in Nat
    /\ teamA_profit \in Nat
    /\ teamB_profit \in Nat
    /\ system_crashed \in BOOLEAN

Init ==
    /\ shared_capacity = 10
    /\ teamA_profit = 0
    /\ teamB_profit = 0
    /\ system_crashed = FALSE

(* Если ресурс исчерпан, система падает, и обе команды теряют прибыль *)
CrashSystem ==
    /\ shared_capacity = 0
    /\ system_crashed = FALSE
    /\ system_crashed' = TRUE
    /\ teamA_profit' = 0
    /\ teamB_profit' = 0
    /\ UNCHANGED <<shared_capacity>>

TeamA_Consumes ==
    /\ shared_capacity > 0
    /\ system_crashed = FALSE
    /\ shared_capacity' = shared_capacity - 1
    /\ teamA_profit' = teamA_profit + 10
    /\ UNCHANGED <<teamB_profit, system_crashed>>

TeamB_Consumes ==
    /\ shared_capacity > 0
    /\ system_crashed = FALSE
    /\ shared_capacity' = shared_capacity - 1
    /\ teamB_profit' = teamB_profit + 10
    /\ UNCHANGED <<teamA_profit, system_crashed>>

Next == CrashSystem \/ TeamA_Consumes \/ TeamB_Consumes

Spec == Init /\ [][Next]_vars

(* 
   Свойство: доказать, что при жадном поведении система неизбежно крашится 
   (или чекер найдет путь, как этого избежать? Спойлер: жадные алгоритмы всегда крашат общие ресурсы).
*)
GoalNotReached == system_crashed = FALSE

=============================================================================