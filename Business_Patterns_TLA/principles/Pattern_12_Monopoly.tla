-------------------- MODULE Pattern_12_Monopoly --------------------
EXTENDS Naturals, Integers

VARIABLES 
    price, 
    quantity, 
    profit

vars == <<price, quantity, profit>>

CONSTANT MARGINAL_COST

TypeOK ==
    /\ price \in Nat
    /\ quantity \in Nat
    /\ profit \in Int

Init ==
    /\ price = 0
    /\ quantity = 0
    /\ profit = 0

(* 
   Монополист выбирает цену. 
   Мы задаем кривую спроса: Q = 100 - P 
   Например, если цена 100, купят 0. Если цена 20, купят 80.
*)
ChoosePrice(p) ==
    /\ price' = p
    /\ quantity' = 100 - p
    /\ profit' = (p - MARGINAL_COST) * (100 - p)

Next == \E p \in 20..100 : ChoosePrice(p)

Spec == Init /\ [][Next]_vars

StateConstraint == TRUE

(* 
   Если MARGINAL_COST = 20, идеальная цена для монополиста будет 60.
   При P=60, Q=40, Прибыль = (60-20)*40 = 1600.
   Попросим чекер доказать, что прибыль не может быть 1600. 
   Он выдаст ошибку и покажет, что нужно установить цену 60.
*)
GoalNotReached == profit < 1600

=============================================================================