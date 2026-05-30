-------------------- MODULE Pattern_07_MarketEfficiency --------------------
EXTENDS Naturals, Integers

VARIABLES 
    price, 
    buyer_wtp,      \* Willingness To Pay (готовность платить)
    seller_cost,    \* Себестоимость
    consumer_surplus, 
    producer_surplus,
    deals_done

vars == <<price, buyer_wtp, seller_cost, consumer_surplus, producer_surplus, deals_done>>

TypeOK ==
    /\ price \in Nat
    /\ buyer_wtp \in Nat
    /\ seller_cost \in Nat
    /\ consumer_surplus \in Nat
    /\ producer_surplus \in Nat
    /\ deals_done \in Nat

Init ==
    /\ price \in {50, 60, 70, 80, 90, 100, 110} \* Алгоритм переберет все эти стартовые цены
    /\ buyer_wtp = 100
    /\ seller_cost = 50
    /\ consumer_surplus = 0
    /\ producer_surplus = 0
    /\ deals_done = 0

(* Сделка происходит, только если цена устраивает обе стороны *)
MakeTrade ==
    /\ buyer_wtp >= price
    /\ price >= seller_cost
    /\ deals_done < 10 \* Проводим 10 сделок
    /\ consumer_surplus' = consumer_surplus + (buyer_wtp - price)
    /\ producer_surplus' = producer_surplus + (price - seller_cost)
    /\ deals_done' = deals_done + 1
    /\ UNCHANGED <<price, buyer_wtp, seller_cost>>

Next == MakeTrade

Spec == Init /\ [][Next]_vars

TotalSurplus == consumer_surplus + producer_surplus

(* 
   Теорема: Совокупный излишек (Total Surplus) всегда зависит от разницы 
   между ценностью для покупателя и себестоимостью, и не зависит от цены, 
   ПРИ УСЛОВИИ, что сделка вообще состоялась. Цена лишь решает, 
   КАК этот излишек делится между продавцом и покупателем.
   Если сделка не состоялась из-за плохой цены, излишек = 0 (неэффективность).
*)

StateConstraint == deals_done <= 10

(* Просим чекер найти сценарий, где общая выгода от 10 сделок составит 500 *)
GoalNotReached == TotalSurplus < 500

=============================================================================