-------------------- MODULE Pattern_13_Monopolistic_Competition --------------------
EXTENDS Naturals, Integers

VARIABLES 
    firms, 
    price, 
    average_cost, 
    profit

vars == <<firms, price, average_cost, profit>>

TypeOK ==
    /\ firms \in Nat
    /\ price \in Int
    /\ average_cost \in Int
    /\ profit \in Int

Init ==
    /\ firms = 1
    /\ price = 100
    /\ average_cost = 40
    /\ profit = 60

(* 
   В краткосрочном периоде фирма-пионер получает сверхприбыль.
   Но это привлекает конкурентов.
*)
CompetitorEnters ==
    /\ profit > 0
    /\ firms' = firms + 1
    \* Спрос размывается, фирма вынуждена снижать цену
    /\ price' = price - 10
    \* Из-за снижения объема продаж на одну фирму, средние издержки растут
    /\ average_cost' = average_cost + 5
    /\ profit' = (price - 10) - (average_cost + 5)

Next == CompetitorEnters

Spec == Init /\ [][Next]_vars

StateConstraint == TRUE

(* 
   Мы доказываем, что в долгосрочном периоде рынок НЕ МОЖЕТ 
   удерживать прибыль. Рано или поздно profit упадет до 0.
*)
GoalNotReached == profit > 0

=============================================================================