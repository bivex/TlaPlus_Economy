-------------------- MODULE Pattern_09_Externalities --------------------
EXTENDS Naturals, Integers

VARIABLES 
    production_volume, 
    private_profit, 
    social_damage, 
    pigouvian_tax

vars == <<production_volume, private_profit, social_damage, pigouvian_tax>>

TypeOK ==
    /\ production_volume \in Nat
    /\ private_profit \in Nat
    /\ social_damage \in Nat
    /\ pigouvian_tax \in Nat

Init ==
    /\ pigouvian_tax \in {0, 20, 50} \* Тестируем разные налоги: 0 (нет налога), 20 (идеальный налог Пигу), 50 (запретительный налог)
    /\ production_volume = 0
    /\ private_profit = 0
    /\ social_damage = 0

(* Предприятие зарабатывает 50, но наносит ущерб природе/обществу на 20 *)
Produce ==
    /\ production_volume < 10
    /\ IF (50 - pigouvian_tax) > 0 
       THEN 
          /\ production_volume' = production_volume + 1
          /\ private_profit' = private_profit + (50 - pigouvian_tax)
          /\ social_damage' = social_damage + 20
       ELSE 
          \* Если налог съедает прибыль, производство не имеет смысла
          /\ UNCHANGED <<production_volume, private_profit, social_damage>>
    /\ UNCHANGED <<pigouvian_tax>>

Next == Produce

Spec == Init /\ [][Next]_vars

StateConstraint == production_volume <= 10

TotalSocialWelfare == private_profit - social_damage + (pigouvian_tax * production_volume)

(* Мы просим чекер найти путь максимизации общего благосостояния *)
GoalNotReached == TotalSocialWelfare < 300

=============================================================================