-------------------- MODULE Pattern_20_FinancialMarkets --------------------
EXTENDS Naturals, Integers

VARIABLES 
    interest_rate, 
    savings, 
    investments,
    gov_borrowing

vars == <<interest_rate, savings, investments, gov_borrowing>>

TypeOK ==
    /\ interest_rate \in Nat \ {0}
    /\ savings \in Nat
    /\ investments \in Nat
    /\ gov_borrowing \in Nat

Init ==
    /\ interest_rate = 5
    /\ savings = 100
    /\ investments = 100
    /\ gov_borrowing = 0

(* Государство решает занять деньги на рынке (дефицит бюджета) *)
GovBorrows ==
    /\ gov_borrowing = 0
    /\ gov_borrowing' = 20
    \* Сбережения рынка уходят государству, инвестициям бизнеса остается меньше
    /\ savings' = savings - 20
    /\ UNCHANGED <<interest_rate, investments>>

(* Рыночный механизм: балансировка ставки *)
AdjustRateUp ==
    /\ investments > savings
    /\ interest_rate' = interest_rate + 1
    \* Высокая ставка стимулирует людей копить
    /\ savings' = savings + 10
    \* Высокая ставка убивает бизнес-проекты
    /\ investments' = investments - 10
    /\ UNCHANGED <<gov_borrowing>>

AdjustRateDown ==
    /\ savings > investments
    /\ interest_rate > 1
    /\ interest_rate' = interest_rate - 1
    /\ savings' = savings - 10
    /\ investments' = investments + 10
    /\ UNCHANGED <<gov_borrowing>>

Next == GovBorrows \/ AdjustRateUp \/ AdjustRateDown

Spec == Init /\ [][Next]_vars

StateConstraint == interest_rate <= 20

(* 
   Мы доказываем, что в равновесии (S = I) после вмешательства государства
   процентная ставка станет ВЫШЕ изначальных 5%, а инвестиции НИЖЕ 100.
*)
GoalNotReached == ~(savings = investments /\ interest_rate > 5 /\ investments < 100)

=============================================================================