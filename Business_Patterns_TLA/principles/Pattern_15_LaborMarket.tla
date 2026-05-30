-------------------- MODULE Pattern_15_LaborMarket --------------------
EXTENDS Naturals, Integers

VARIABLES 
    workers, 
    production, 
    profit

vars == <<workers, production, profit>>

CONSTANT PRICE, WAGE

TypeOK ==
    /\ workers \in Nat
    /\ production \in Nat
    /\ profit \in Int

Init ==
    /\ workers = 0
    /\ production = 0
    /\ profit = 0

(* 
   Фирма решает, нанимать ли еще одного сотрудника.
   Условие: Стоимость маржинального продукта (VMPL) должна превышать зарплату.
   MPL = 10 для первого, 9 для второго, ..., 1 для десятого.
*)
HireWorker ==
    /\ workers < 10
    /\ LET next_worker == workers + 1
           mpl == 11 - next_worker
           vmpl == PRICE * mpl
       IN vmpl > WAGE \* Правило найма
    /\ workers' = workers + 1
    /\ production' = production + (11 - workers')
    /\ profit' = (production' * PRICE) - (workers' * WAGE)

Next == HireWorker

Spec == Init /\ [][Next]_vars

StateConstraint == TRUE

(* 
   Цель: Чекер должен достичь максимальной прибыли.
   Если PRICE = 10, WAGE = 50. 
   1-й: VMPL = 10*10 = 100 > 50 (найм). Profit = 50.
   2-й: VMPL = 10*9 = 90 > 50 (найм). Profit = 50 + 40 = 90.
   3-й: VMPL = 10*8 = 80 > 50 (найм). Profit = 90 + 30 = 120.
   4-й: VMPL = 10*7 = 70 > 50 (найм). Profit = 120 + 20 = 140.
   5-й: VMPL = 10*6 = 60 > 50 (найм). Profit = 140 + 10 = 150.
   6-й: VMPL = 10*5 = 50. Условие > WAGE не выполняется. Найм останавливается.
*)
GoalNotReached == profit < 150

=============================================================================