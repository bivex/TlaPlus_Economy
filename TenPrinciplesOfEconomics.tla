-------------------- MODULE TenPrinciplesOfEconomics --------------------
(*
Эта TLA+ спецификация формализует 10 принципов экономики (по Н. Мэнкью),
изложенных в Chapter1_10Principles_FNR.txt.
Модель показывает, как макро- и микроэкономические решения влияют на состояние общества.
*)
EXTENDS Naturals, Integers

VARIABLES
    resources,     \* Ограниченные ресурсы (Принцип 1: Необходимость выбора)
    goods,         \* Произведенные блага
    welfare,       \* Общее благосостояние
    productivity,  \* Производительность труда (Принцип 8)
    money_supply,  \* Денежная масса (Принцип 9)
    price_level,   \* Уровень цен (Принцип 9)
    inflation,     \* Инфляция (Принцип 10)
    unemployment   \* Безработица (Принцип 10)

vars == <<resources, goods, welfare, productivity, money_supply, price_level, inflation, unemployment>>

(* Инвариант: проверка допустимых типов и границ значений *)
TypeOK ==
    /\ resources \in Nat
    /\ goods \in Nat
    /\ welfare \in Nat
    /\ productivity \in Nat \ {0}
    /\ money_supply \in Nat \ {0}
    /\ price_level \in Nat \ {0}
    /\ inflation \in 0..100
    /\ unemployment \in 0..100

(* Проверяемое свойство: "Благосостояние никогда не достигнет 100" *)
GoalNotReached == welfare < 100

Init ==
    /\ resources = 100
    /\ goods = 0
    /\ welfare = 10
    /\ productivity = 1
    /\ money_supply = 100
    /\ price_level = 1
    /\ inflation = 2
    /\ unemployment = 5

(* Принципы 1 и 2: Человек выбирает (Trade-offs) и Альтернативные издержки.
   Трата ресурсов на текущее потребление (goods) лишает возможности 
   вложить их в рост производительности или госуслуги. *)
ProduceGoods ==
    /\ resources > 0
    /\ resources' = resources - 1
    /\ goods' = goods + productivity
    /\ welfare' = welfare + 1
    /\ UNCHANGED <<productivity, money_supply, price_level, inflation, unemployment>>

(* Принцип 5: Торговля во благо каждого.
   Торговля превращает произведенные товары в еще большее благосостояние,
   особенно если производительность высока (высокотехнологичный экспорт). *)
Trade ==
    /\ goods >= 2
    /\ goods' = goods - 2
    /\ welfare' = welfare + 3 + (productivity \div 2)
    /\ UNCHANGED <<resources, productivity, money_supply, price_level, inflation, unemployment>>

(* Принципы 6 и 7: Рынок и Государство.
   Государство расходует ресурсы на институты. Чем выше уже достигнуто благосостояние, 
   тем меньше эффект от прямого гос. вмешательства (закон убывающей отдачи). *)
GovtIntervention ==
    /\ resources >= 5
    /\ resources' = resources - 5
    /\ welfare' = welfare + (20 \div (welfare \div 10 + 1))
    /\ UNCHANGED <<goods, productivity, money_supply, price_level, inflation, unemployment>>

(* Принцип 8: Уровень жизни зависит от производительности.
   Общество инвестирует ресурсы в технологии, увеличивая будущую отдачу (productivity). *)
InvestInProductivity ==
    /\ resources >= 10
    /\ resources' = resources - 10
    /\ productivity' = productivity + 1
    /\ UNCHANGED <<goods, welfare, money_supply, price_level, inflation, unemployment>>

(* Принцип 9: Цены растут, когда печатается слишком много денег. *)
PrintMoney ==
    /\ money_supply' = money_supply + 50
    /\ price_level' = price_level + 1
    /\ inflation' = IF inflation + 5 <= 100 THEN inflation + 5 ELSE 100
    /\ UNCHANGED <<resources, goods, welfare, productivity, unemployment>>

(* Принцип 10: Краткосрочный выбор между инфляцией и безработицей (Кривая Филлипса). *)
\* Политика 1: Стимулирование (снижение безработицы ценой разгона инфляции)
StimulateEconomy ==
    /\ unemployment >= 2
    /\ inflation + 2 <= 100
    /\ unemployment' = unemployment - 2
    /\ inflation' = inflation + 2
    /\ UNCHANGED <<resources, goods, welfare, productivity, money_supply, price_level>>

\* Политика 2: Охлаждение (снижение инфляции ценой роста безработицы)
CoolDownEconomy ==
    /\ inflation >= 2
    /\ unemployment + 2 <= 100
    /\ inflation' = inflation - 2
    /\ unemployment' = unemployment + 2
    /\ UNCHANGED <<resources, goods, welfare, productivity, money_supply, price_level>>

(* Возможные шаги системы *)
Next ==
    \/ ProduceGoods
    \/ Trade
    \/ GovtIntervention
    \/ InvestInProductivity
    \/ PrintMoney
    \/ StimulateEconomy
    \/ CoolDownEconomy

Spec == Init /\ [][Next]_vars

(* Ограничение для Model Checker'а (TLC), чтобы предотвратить взрыв пространства состояний *)
StateConstraint ==
    /\ resources <= 100
    /\ goods <= 50
    /\ welfare <= 150
    /\ productivity <= 10
    /\ money_supply <= 200
    /\ price_level <= 5

=============================================================================