-------------------- MODULE Pattern_17_MacroGDP --------------------
EXTENDS Naturals, Integers

VARIABLES 
    consumption, 
    investment, 
    gov_spending, 
    net_exports, 
    gdp

vars == <<consumption, investment, gov_spending, net_exports, gdp>>

TypeOK ==
    /\ consumption \in Nat
    /\ investment \in Nat
    /\ gov_spending \in Nat
    /\ net_exports \in Int
    /\ gdp \in Nat

Init ==
    /\ consumption = 60
    /\ investment = 20
    /\ gov_spending = 20
    /\ net_exports = 0
    /\ gdp = 100

(* Государство стимулирует экономику через гос. закупки *)
GovStimulus ==
    /\ gov_spending < 50
    /\ gov_spending' = gov_spending + 10
    /\ UNCHANGED <<consumption, investment, net_exports, gdp>>

(* Внешний шок: падение экспорта *)
ExportShock ==
    /\ net_exports > -20
    /\ net_exports' = net_exports - 10
    /\ UNCHANGED <<consumption, investment, gov_spending, gdp>>

(* Тождество национального дохода *)
UpdateGDP ==
    /\ gdp' = consumption + investment + gov_spending + net_exports
    /\ UNCHANGED <<consumption, investment, gov_spending, net_exports>>

Next == GovStimulus \/ ExportShock \/ UpdateGDP

Spec == Init /\ [][Next]_vars

StateConstraint == TRUE

(* 
   Свойство: Можем ли мы достичь ВВП = 110, несмотря на экспортный шок?
   Чекер найдет путь: ExportShock -> GovStimulus -> GovStimulus -> UpdateGDP
*)
GoalNotReached == gdp < 110

=============================================================================