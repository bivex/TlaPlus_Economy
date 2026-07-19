-------------------- MODULE Pattern_35_MultiServiceFreelance --------------------
(*
Цей паттерн моделює багатопрофільного IT-фрилансера в Україні.
Список послуг та ціни (в UAH) взяті з реального прайс-листа користувача.
Маркетингові витрати часу та продажі враховані безпосередньо у "ефективному часі" 
виконання кожного проєкту (Effective Time = coding + sales + marketing overhead).
*)
EXTENDS Naturals, Integers, TLC

SERVICES == {"bot", "web_simple", "qa", "coding_mid", "advanced_dev", "devops", "blockchain"}

VARIABLES
    budget,           \* Бюджет (готівка в UAH)
    time_pool,        \* Вільний час у годинах (на місяць)
    completed_tasks,  \* Функція [SERVICES -> Nat] (к-сть виконаних проєктів)
    revenue,          \* Загальний дохід
    expenses          \* Загальні витрати (оверхед)

vars == <<budget, time_pool, completed_tasks, revenue, expenses>>

CONSTANT MONTHLY_TIME_LIMIT   \* 160 годин
CONSTANT OVERHEAD_COST        \* Накладні витрати (1500 UAH)

\* Ціни послуг (UAH)
ServicePrice(s) ==
    IF s = "bot" THEN 300
    ELSE IF s = "web_simple" THEN 500
    ELSE IF s = "qa" THEN 1000
    ELSE IF s = "coding_mid" THEN 1500
    ELSE IF s = "advanced_dev" THEN 2000
    ELSE IF s = "devops" THEN 2350
    ELSE 2500 \* blockchain

\* Ефективний час виконання проєкту (кодинг + продажі + маркетинг) в годинах
EffectiveTime(s) ==
    IF s = "bot" THEN 3        \* 1h coding + 1h sales + 1h marketing
    ELSE IF s = "web_simple" THEN 4   \* 2h coding + 1h sales + 1.3h marketing
    ELSE IF s = "qa" THEN 7           \* 4h coding + 1h sales + 2h marketing
    ELSE IF s = "coding_mid" THEN 9   \* 6h coding + 1h sales + 2h marketing
    ELSE IF s = "advanced_dev" THEN 14 \* 9h coding + 1h sales + 4h marketing
    ELSE IF s = "devops" THEN 15      \* 10h coding + 1h sales + 4h marketing
    ELSE 16 \* blockchain              \* 11h coding + 1h sales + 4h marketing

TypeOK ==
    /\ budget \in Int
    /\ time_pool \in 0..MONTHLY_TIME_LIMIT
    /\ completed_tasks \in [SERVICES -> Nat]
    /\ revenue \in Nat
    /\ expenses \in Nat

Init ==
    /\ budget = 1000
    /\ time_pool = MONTHLY_TIME_LIMIT
    /\ completed_tasks = [s \in SERVICES |-> 0]
    /\ revenue = 0
    /\ expenses = 0

(* 1. Виконання проєкту обраного типу s *)
ExecuteProject(s) ==
    /\ time_pool >= EffectiveTime(s)
    /\ time_pool' = time_pool - EffectiveTime(s)
    /\ completed_tasks' = [completed_tasks EXCEPT ![s] = completed_tasks[s] + 1]
    /\ budget' = budget + ServicePrice(s)
    /\ revenue' = revenue + ServicePrice(s)
    /\ UNCHANGED <<expenses>>

(* 2. Оплата накладних витрат *)
PayOverhead ==
    /\ budget >= OVERHEAD_COST
    /\ expenses = 0
    /\ budget' = budget - OVERHEAD_COST
    /\ expenses' = OVERHEAD_COST
    /\ UNCHANGED <<time_pool, completed_tasks, revenue>>

Next ==
    \/ (\E s \in SERVICES : ExecuteProject(s))
    \/ PayOverhead

Spec == Init /\ [][Next]_vars

StateConstraint ==
    budget <= 50000

(* Цільова чиста прибутковість: 20,000 UAH *)
GoalNotReached == (revenue - expenses) < 20000

=============================================================================
