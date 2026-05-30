-------------------- MODULE Pattern_04_Funnel --------------------
EXTENDS Naturals, Integers

VARIABLES 
    content, 
    cold_traffic, 
    warm_audience, 
    leads, 
    revenue

vars == <<content, cold_traffic, warm_audience, leads, revenue>>

TypeOK ==
    /\ content \in Nat
    /\ cold_traffic \in Nat
    /\ warm_audience \in Nat
    /\ leads \in Nat
    /\ revenue \in Nat

Init ==
    /\ content = 0
    /\ cold_traffic = 0
    /\ warm_audience = 0
    /\ leads = 0
    /\ revenue = 0

(* 1. Производство контента (статьи, видео, реклама) *)
CreateContent ==
    /\ content' = content + 1
    /\ UNCHANGED <<cold_traffic, warm_audience, leads, revenue>>

(* 2. Привлечение трафика (алгоритмы дают показы на контент) *)
GetTraffic ==
    /\ content > 0
    /\ cold_traffic' = cold_traffic + (content * 100)
    /\ UNCHANGED <<content, warm_audience, leads, revenue>>

(* 3. Прогрев (часть холодного трафика проникается доверием) *)
WarmUp ==
    /\ cold_traffic >= 10
    /\ cold_traffic' = cold_traffic - 10
    /\ warm_audience' = warm_audience + 2 \* Конверсия 20%
    /\ UNCHANGED <<content, leads, revenue>>

(* 4. Лидогенерация (теплая аудитория оставляет контакты) *)
CaptureLeads ==
    /\ warm_audience >= 5
    /\ warm_audience' = warm_audience - 5
    /\ leads' = leads + 1 \* Конверсия 20%
    /\ UNCHANGED <<content, cold_traffic, revenue>>

(* 5. Монетизация (продажа продукта лидам) *)
SellProduct ==
    /\ leads > 0
    /\ leads' = leads - 1
    /\ revenue' = revenue + 100 \* Высокий чек
    /\ UNCHANGED <<content, cold_traffic, warm_audience>>

Next == CreateContent \/ GetTraffic \/ WarmUp \/ CaptureLeads \/ SellProduct

Spec == Init /\ [][Next]_vars

(* Ограничиваем пространство состояний для чекера *)
StateConstraint ==
    /\ content <= 3
    /\ cold_traffic <= 500
    /\ warm_audience <= 100
    /\ leads <= 20
    /\ revenue <= 1000

(* Цель: найти путь, как заработать 500 *)
GoalNotReached == revenue < 500

=============================================================================