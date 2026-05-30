-------------------- MODULE Pattern_24_CurrencyUnion --------------------
EXTENDS Naturals, Integers

VARIABLES 
    debt_A,               \* Долг страны А (Греция)
    debt_B,               \* Долг страны Б (Германия)
    union_interest_rate,  \* Общая ставка для всего союза
    cost_of_debt_B        \* Сколько платит страна Б за обслуживание своего долга

vars == <<debt_A, debt_B, union_interest_rate, cost_of_debt_B>>

TypeOK ==
    /\ debt_A \in Nat
    /\ debt_B \in Nat
    /\ union_interest_rate \in Nat
    /\ cost_of_debt_B \in Nat

Init ==
    /\ debt_A = 10
    /\ debt_B = 10
    /\ union_interest_rate = 5
    /\ cost_of_debt_B = 50 \* (10 * 5)

(* Страна А берет в долг (сверх лимитов Пакта стабильности) *)
CountryA_Borrows ==
    /\ debt_A < 50
    /\ debt_A' = debt_A + 20
    \* Рынки пугаются дефолта страны А и повышают ставку для всего союза
    /\ union_interest_rate' = union_interest_rate + 2
    \* Издержки страны Б растут автоматически, хотя её долг не изменился!
    /\ cost_of_debt_B' = debt_B * (union_interest_rate + 2)
    /\ UNCHANGED <<debt_B>>

Next == CountryA_Borrows

Spec == Init /\ [][Next]_vars

StateConstraint == TRUE

(* 
   Свойство: доказать, что издержки страны Б могут вырасти до 90, 
   даже если она не брала ни копейки в долг.
*)
GoalNotReached == cost_of_debt_B < 90

=============================================================================