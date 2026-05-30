-------------------- MODULE Pattern_14_Oligopoly --------------------
EXTENDS Naturals, Strings

VARIABLES 
    actionA, 
    actionB, 
    profitA, 
    profitB

vars == <<actionA, actionB, profitA, profitB>>

TypeOK ==
    /\ actionA \in {"Wait", "Cooperate", "Defect"}
    /\ actionB \in {"Wait", "Cooperate", "Defect"}
    /\ profitA \in Nat
    /\ profitB \in Nat

Init ==
    /\ actionA = "Wait"
    /\ actionB = "Wait"
    /\ profitA = 0
    /\ profitB = 0

(* Фирма А делает свой выбор *)
FirmAChooses(act) ==
    /\ actionA = "Wait"
    /\ actionA' = act
    /\ UNCHANGED <<actionB, profitA, profitB>>

(* Фирма Б делает свой выбор *)
FirmBChooses(act) ==
    /\ actionB = "Wait"
    /\ actionB' = act
    /\ UNCHANGED <<actionA, profitA, profitB>>

(* Система подсчитывает результаты (Матрица Дилеммы Заключенного) *)
ResolveGame ==
    /\ actionA /= "Wait"
    /\ actionB /= "Wait"
    /\ profitA = 0 \* Убеждаемся, что еще не считали
    /\ IF actionA = "Cooperate" /\ actionB = "Cooperate" THEN
           /\ profitA' = 50
           /\ profitB' = 50
       ELSE IF actionA = "Defect" /\ actionB = "Defect" THEN
           /\ profitA' = 10
           /\ profitB' = 10
       ELSE IF actionA = "Defect" /\ actionB = "Cooperate" THEN
           /\ profitA' = 100
           /\ profitB' = 0
       ELSE \* actionA = "Cooperate" /\ actionB = "Defect"
           /\ profitA' = 0
           /\ profitB' = 100
    /\ UNCHANGED <<actionA, actionB>>

Next == 
    \/ FirmAChooses("Cooperate")
    \/ FirmAChooses("Defect")
    \/ FirmBChooses("Cooperate")
    \/ FirmBChooses("Defect")
    \/ ResolveGame

Spec == Init /\ [][Next]_vars

StateConstraint == TRUE

(* 
   В "Равновесии Нэша" рациональные эгоистичные агенты 
   приходят к результату (Defect, Defect).
   Докажем, что это состояние достижимо.
*)
GoalNotReached == ~(profitA = 10 /\ profitB = 10)

=============================================================================