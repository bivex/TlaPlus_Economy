-------------------- MODULE Pattern_01_ROI --------------------
EXTENDS Naturals, Integers

VARIABLES 
    budget,       \* Ограниченный бюджет проекта
    features,     \* Разработанные фичи
    marketing,    \* Уровень узнаваемости
    revenue       \* Доход

vars == <<budget, features, marketing, revenue>>

TypeOK ==
    /\ budget \in Int
    /\ features \in Nat
    /\ marketing \in Nat
    /\ revenue \in Nat

Init == 
    /\ budget = 50 
    /\ features = 0 
    /\ marketing = 0 
    /\ revenue = 0

(* Вложить деньги в разработку. Дает продукт, но не дает моментальных продаж *)
InvestInProduct ==
    /\ budget >= 10
    /\ budget' = budget - 10
    /\ features' = features + 1
    /\ UNCHANGED <<marketing, revenue>>

(* Вложить деньги в маркетинг. Дает продажи ТОЛЬКО если уже есть фичи *)
InvestInMarketing ==
    /\ budget >= 5
    /\ features > 0   \* Продавать можно только то, что уже сделано
    /\ budget' = budget - 5
    /\ marketing' = marketing + 1
    /\ revenue' = revenue + (features * 5) \* Эффект синергии

Next == InvestInProduct \/ InvestInMarketing

Spec == Init /\ [][Next]_vars

(* Цель: найти путь максимизации дохода *)
GoalNotReached == revenue < 100

=============================================================================