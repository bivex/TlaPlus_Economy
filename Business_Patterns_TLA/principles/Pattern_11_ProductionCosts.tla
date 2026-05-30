-------------------- MODULE Pattern_11_ProductionCosts --------------------
EXTENDS Naturals, Integers

VARIABLES 
    workers, 
    features, 
    total_cost

vars == <<workers, features, total_cost>>

CONSTANT FIXED_COST, SALARY

TypeOK ==
    /\ workers \in Nat
    /\ features \in Nat
    /\ total_cost \in Nat

Init ==
    /\ workers = 0
    /\ features = 0
    /\ total_cost = FIXED_COST

(* 
   Нанимаем сотрудника. Зарплата всегда одинаковая, 
   но маржинальная полезность каждого следующего падает 
   из-за сложности координации (митинги, конфликты).
*)
HireWorker ==
    /\ workers < 10
    /\ workers' = workers + 1
    /\ total_cost' = total_cost + SALARY
    \* Формула убывающего маржинального продукта:
    \* 1-й приносит 10, 2-й приносит 9, ..., 10-й приносит 1
    /\ features' = features + (11 - workers')

Next == HireWorker

Spec == Init /\ [][Next]_vars

(* Средняя стоимость одной фичи (нужно минимизировать) *)
\* В TLA+ деление целочисленное, поэтому для точности умножим на 100
AverageCost == IF features = 0 THEN 999999 ELSE (total_cost * 100) \div features

(* Чекер может найти момент, когда средние издержки снова начинают расти *)
GoalNotReached == workers < 10

=============================================================================