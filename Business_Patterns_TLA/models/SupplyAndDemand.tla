-------------------- MODULE SupplyAndDemand --------------------
(*
Эта TLA+ спецификация формализует принципы из Главы 4 (Спрос и Предложение).
Модель демонстрирует работу "невидимой руки" рынка: как цена 
автоматически корректируется для достижения равновесия между 
величиной спроса и величиной предложения.
*)
EXTENDS Naturals, Integers

VARIABLES
    price,             \* Текущая рыночная цена
    quantity_demanded, \* Величина спроса
    quantity_supplied, \* Величина предложения
    market_status      \* Статус: "Shortage" (дефицит), "Surplus" (избыток), "Equilibrium" (равновесие)

vars == <<price, quantity_demanded, quantity_supplied, market_status>>

(* Инвариант типов *)
TypeOK ==
    /\ price \in Nat \ {0}
    /\ quantity_demanded \in Nat
    /\ quantity_supplied \in Nat
    /\ market_status \in {"Shortage", "Surplus", "Equilibrium"}

(* 
   Начальное состояние рынка: цена случайная (например, слишком низкая). 
   Спрос высокий (потому что дешево), предложение низкое (потому что невыгодно).
*)
Init ==
    /\ price = 2
    \* Закон спроса: величина обратно пропорциональна цене (условно: 20 - price * 2)
    /\ quantity_demanded = 16 
    \* Закон предложения: величина прямо пропорциональна цене (условно: price * 2)
    /\ quantity_supplied = 4
    /\ market_status = "Shortage"

(* 
   Действие 1: Реакция на Дефицит (Shortage).
   Если спрос превышает предложение, продавцы видят очередь и повышают цену.
*)
PriceIncreases ==
    /\ quantity_demanded > quantity_supplied
    /\ price' = price + 1
    /\ quantity_demanded' = 20 - (price' * 2)
    /\ quantity_supplied' = price' * 2
    /\ market_status' = IF quantity_demanded' > quantity_supplied' THEN "Shortage"
                        ELSE IF quantity_demanded' < quantity_supplied' THEN "Surplus"
                        ELSE "Equilibrium"

(* 
   Действие 2: Реакция на Избыток (Surplus).
   Если предложение превышает спрос, товары залеживаются на складе, 
   и продавцы вынуждены снижать цену (распродажи).
*)
PriceDecreases ==
    /\ quantity_supplied > quantity_demanded
    /\ price > 1 \* Цена не может упасть до 0
    /\ price' = price - 1
    /\ quantity_demanded' = 20 - (price' * 2)
    /\ quantity_supplied' = price' * 2
    /\ market_status' = IF quantity_demanded' > quantity_supplied' THEN "Shortage"
                        ELSE IF quantity_demanded' < quantity_supplied' THEN "Surplus"
                        ELSE "Equilibrium"

(* Возможные шаги: цена либо растет из-за дефицита, либо падает из-за избытка *)
Next ==
    \/ PriceIncreases
    \/ PriceDecreases

Spec == Init /\ [][Next]_vars

(* 
   Проверяемое свойство: "Рынок никогда не достигнет равновесия".
   Мы просим чекер попытаться опровергнуть это утверждение, 
   чтобы он показал нам путь к точке равновесия.
*)
GoalNotReached == market_status /= "Equilibrium"

(* Ограничиваем пространство, хотя наша модель сходится очень быстро *)
StateConstraint ==
    /\ price <= 10

=============================================================================