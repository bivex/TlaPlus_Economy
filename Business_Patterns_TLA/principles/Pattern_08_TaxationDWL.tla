-------------------- MODULE Pattern_08_TaxationDWL --------------------
EXTENDS Naturals, Integers

VARIABLES 
    tax, 
    buyer_wtp, 
    seller_cost, 
    state_revenue, 
    deadweight_loss,
    deals_done

vars == <<tax, buyer_wtp, seller_cost, state_revenue, deadweight_loss, deals_done>>

TypeOK ==
    /\ tax \in Nat
    /\ buyer_wtp \in Nat
    /\ seller_cost \in Nat
    /\ state_revenue \in Nat
    /\ deadweight_loss \in Nat
    /\ deals_done \in Nat

Init ==
    /\ tax \in {10, 30, 50, 70} \* Платформа тестирует разные комиссии
    /\ buyer_wtp = 120
    /\ seller_cost = 80
    /\ state_revenue = 0
    /\ deadweight_loss = 0
    /\ deals_done = 0

AttemptTrade ==
    /\ deals_done < 10
    /\ deals_done' = deals_done + 1
    /\ IF (buyer_wtp - tax) >= seller_cost 
       THEN 
           /\ state_revenue' = state_revenue + tax
           /\ deadweight_loss' = deadweight_loss
       ELSE 
           \* Сделка сорвалась из-за налога! 
           \* Общество потеряло потенциальный излишек (120 - 80 = 40)
           /\ state_revenue' = state_revenue
           /\ deadweight_loss' = deadweight_loss + (buyer_wtp - seller_cost)
    /\ UNCHANGED <<tax, buyer_wtp, seller_cost>>

Next == AttemptTrade

Spec == Init /\ [][Next]_vars

StateConstraint == deals_done <= 10

(* Мы можем попросить чекер показать, как платформа может заработать максимум *)
GoalNotReached == state_revenue < 300

=============================================================================