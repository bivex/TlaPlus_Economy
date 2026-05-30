-------------------- MODULE Pattern_16_AsymmetricInfo --------------------
EXTENDS Naturals, Integers

VARIABLES 
    peaches,    \* Количество хороших товаров/кандидатов на рынке
    lemons,     \* Количество плохих товаров/кандидатов на рынке
    avg_price   \* Цена, которую готов платить неинформированный покупатель

vars == <<peaches, lemons, avg_price>>

TypeOK ==
    /\ peaches \in Nat
    /\ lemons \in Nat
    /\ avg_price \in Nat

Init ==
    /\ peaches = 10
    /\ lemons = 10
    /\ avg_price = 75 \* (10*100 + 10*50) / 20

(* 
   Шаг 1: Если средняя цена меньше 100, владельцы хороших товаров уходят с рынка.
*)
GoodSellersLeave ==
    /\ peaches > 0
    /\ avg_price < 100
    /\ peaches' = 0
    /\ UNCHANGED <<lemons, avg_price>>

(* 
   Шаг 2: Покупатель видит, что качество рынка упало, и пересчитывает среднюю цену.
*)
BuyerRecalculates ==
    /\ peaches = 0
    /\ lemons > 0
    /\ avg_price > 50
    /\ avg_price' = 50 \* (0*100 + 10*50) / 10
    /\ UNCHANGED <<peaches, lemons>>

Next == GoodSellersLeave \/ BuyerRecalculates

Spec == Init /\ [][Next]_vars

StateConstraint == TRUE

(* 
   Доказываем разрушение рынка: в конце концов на рынке не останется хороших товаров, 
   а цена упадет до уровня плохих товаров.
*)
GoalNotReached == ~(peaches = 0 /\ avg_price = 50)

=============================================================================