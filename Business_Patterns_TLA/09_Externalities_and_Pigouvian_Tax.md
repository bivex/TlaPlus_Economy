# Паттерн 09: Экстерналии и Налог Пигу

**Экономическая база:** Глава 9 (Внешние эффекты).

## Суть для Бизнеса
Внешний эффект (Экстерналия) возникает, когда ваши действия наносят ущерб или приносят пользу третьим лицам (не покупателям и не продавцам).
* **Отрицательная экстерналия**: Спам-рассылка. Вы отправляете письма (вам это выгодно), но вы засоряете почтовые ящики людей (ущерб для них). 
* **Положительная экстерналия**: Open Source разработка. Вы пишете код для себя, но им пользуется весь мир (выгода для общества).

Если на рынке есть отрицательные экстерналии, рынок производит **слишком много** товара. Чтобы вернуть баланс, вводится **Налог Пигу** (штрафы за спам, квоты на API-запросы), который заставляет бизнес платить за ущерб третьим лицам.

## Как моделировать в TLA+

Добавьте к `seller_cost` внешние издержки `external_cost`. Равновесие рынка без налога приведет к потерям для общества.

### Пример кода:

```tla
VARIABLES 
    production_volume, 
    private_profit, 
    social_damage, 
    pigouvian_tax

(* Производство без налога (Private Market) *)
ProduceWithoutTax ==
    /\ pigouvian_tax = 0
    /\ production_volume' = production_volume + 1
    /\ private_profit' = private_profit + 50
    /\ social_damage' = social_damage + 20
    /\ UNCHANGED <<pigouvian_tax>>

(* Производство с налогом Пигу (Social Optimum) *)
ProduceWithTax ==
    /\ pigouvian_tax = 20 \* Налог равен ущербу
    /\ IF (50 - pigouvian_tax) > 0 THEN 
          /\ production_volume' = production_volume + 1
          /\ private_profit' = private_profit + (50 - pigouvian_tax)
          /\ social_damage' = social_damage + 20
       ELSE 
          \* Если налог съедает прибыль, производство останавливается
          /\ UNCHANGED <<production_volume, private_profit, social_damage>>
```

## Как проверять модель (Model Checking)
Эта модель позволяет вычислить "идеальный налог Пигу". Вы ставите условие: `GoalNotReached == (private_profit - social_damage) < MAX_SOCIAL_WELFARE`. Чекер докажет, что при `pigouvian_tax = 0` общество страдает, а при правильном налоге — благосостояние максимизируется.