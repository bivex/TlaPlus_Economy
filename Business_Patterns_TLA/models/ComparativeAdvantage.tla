-------------------- MODULE ComparativeAdvantage --------------------
(*
Эта TLA+ спецификация формализует Принцип 5 (Торговля во благо каждого) 
и концепцию Сравнительного преимущества из Главы 3.
Используется пример из книги: Германия и Япония производят Автомобили и Еду.
*)
EXTENDS Naturals, Integers

VARIABLES
    hours_G,    \* Рабочие часы Германии
    hours_J,    \* Рабочие часы Японии
    cars_G,     \* Автомобили в Германии
    food_G,     \* Еда в Германии
    cars_J,     \* Автомобили в Японии
    food_J      \* Еда в Японии

vars == <<hours_G, hours_J, cars_G, food_G, cars_J, food_J>>

(* Инвариант типов *)
TypeOK ==
    /\ hours_G \in Nat
    /\ hours_J \in Nat
    /\ cars_G \in Nat
    /\ food_G \in Nat
    /\ cars_J \in Nat
    /\ food_J \in Nat

Init ==
    /\ hours_G = 10
    /\ hours_J = 10
    /\ cars_G = 0
    /\ food_G = 0
    /\ cars_J = 0
    /\ food_J = 0

(* 
   Германия (G):
   1 час = 1 автомобиль
   1 час = 2 тонны еды
   Альтернативные издержки 1 авто = 2 еды.
   Сравнительное преимущество: Еда.
*)
ProduceCarG ==
    /\ hours_G > 0
    /\ hours_G' = hours_G - 1
    /\ cars_G' = cars_G + 1
    /\ UNCHANGED <<hours_J, food_G, cars_J, food_J>>

ProduceFoodG ==
    /\ hours_G > 0
    /\ hours_G' = hours_G - 1
    /\ food_G' = food_G + 2
    /\ UNCHANGED <<hours_J, cars_G, cars_J, food_J>>

(* 
   Япония (J):
   1 час = 1 автомобиль
   1 час = 1 тонна еды
   Альтернативные издержки 1 авто = 1 еды.
   Сравнительное преимущество: Автомобили.
*)
ProduceCarJ ==
    /\ hours_J > 0
    /\ hours_J' = hours_J - 1
    /\ cars_J' = cars_J + 1
    /\ UNCHANGED <<hours_G, cars_G, food_G, food_J>>

ProduceFoodJ ==
    /\ hours_J > 0
    /\ hours_J' = hours_J - 1
    /\ food_J' = food_J + 1
    /\ UNCHANGED <<hours_G, cars_G, food_G, cars_J>>

(*
   Торговля:
   Так как Японии автомобиль стоит 1 еду, а Германии - 2 еды,
   справедливая цена обмена: 1 Автомобиль = 1.5 Еды.
   Для целых чисел в TLA+ сделаем: 2 Автомобиля = 3 Еды.
   Германия отдает 3 Еды, Япония отдает 2 Автомобиля.
*)
Trade ==
    /\ food_G >= 3
    /\ cars_J >= 2
    /\ food_G' = food_G - 3
    /\ cars_G' = cars_G + 2
    /\ cars_J' = cars_J - 2
    /\ food_J' = food_J + 3
    /\ UNCHANGED <<hours_G, hours_J>>

Next ==
    \/ ProduceCarG
    \/ ProduceFoodG
    \/ ProduceCarJ
    \/ ProduceFoodJ
    \/ Trade

Spec == Init /\ [][Next]_vars

(* 
   Благосостояние будем измерять как произведение имеющихся благ, 
   так как людям нужно и то, и другое.
*)
WelfareG == cars_G * food_G
WelfareJ == cars_J * food_J
TotalWelfare == WelfareG + WelfareJ

(* 
   Проверяемое свойство: "Суммарное благосостояние никогда не достигнет 85".
   Мы просим чекер доказать это, чтобы он нашел путь максимизации.
*)
GoalNotReached == TotalWelfare < 85

StateConstraint ==
    /\ hours_G <= 10
    /\ hours_J <= 10
    /\ cars_G <= 20
    /\ food_G <= 30
    /\ cars_J <= 20
    /\ food_J <= 30

=============================================================================