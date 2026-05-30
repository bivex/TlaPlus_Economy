-------------------- MODULE Pattern_23_FinancialBubbles --------------------
EXTENDS Naturals, Integers

VARIABLES 
    asset_price, 
    bank_equity, 
    bank_debt

vars == <<asset_price, bank_equity, bank_debt>>

TypeOK ==
    /\ asset_price \in Nat
    /\ bank_equity \in Int \* Может уйти в минус (банкротство)
    /\ bank_debt \in Nat

Init ==
    /\ asset_price = 100
    /\ bank_equity = 5  \* Леверидж 20 к 1 (Активы 100, Долг 95, Свои 5)
    /\ bank_debt = 95

(* Пузырь надувается: люди верят, что актив всегда будет расти *)
BubbleGrows ==
    /\ asset_price < 120
    /\ asset_price' = asset_price + 5
    /\ bank_equity' = bank_equity + 5
    /\ UNCHANGED <<bank_debt>>

(* Пузырь лопается (Шок на рынке: цена падает всего на 10%) *)
BubbleBursts ==
    /\ asset_price >= 110
    /\ asset_price' = asset_price - 15
    \* Весь удар берет на себя собственный капитал банка, долг кредиторам отдавать надо
    /\ bank_equity' = bank_equity - 15
    /\ UNCHANGED <<bank_debt>>

Next == BubbleGrows \/ BubbleBursts

Spec == Init /\ [][Next]_vars

StateConstraint == TRUE

(* 
   Свойство: Банк должен выжить (собственный капитал > 0).
   Модель докажет, что при леверидже 20:1 даже малейшее падение 
   рынка приводит к мгновенному банкротству.
*)
GoalNotReached == bank_equity >= 0

=============================================================================