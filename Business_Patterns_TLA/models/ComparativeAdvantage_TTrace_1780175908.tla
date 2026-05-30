---- MODULE ComparativeAdvantage_TTrace_1780175908 ----
EXTENDS Sequences, TLCExt, Toolbox, Naturals, TLC, ComparativeAdvantage

_expression ==
    LET ComparativeAdvantage_TEExpression == INSTANCE ComparativeAdvantage_TEExpression
    IN ComparativeAdvantage_TEExpression!expression
----

_trace ==
    LET ComparativeAdvantage_TETrace == INSTANCE ComparativeAdvantage_TETrace
    IN ComparativeAdvantage_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        hours_J = (1)
        /\
        cars_J = (5)
        /\
        food_J = (6)
        /\
        food_G = (8)
        /\
        cars_G = (7)
        /\
        hours_G = (0)
    )
----

_init ==
    /\ food_G = _TETrace[1].food_G
    /\ food_J = _TETrace[1].food_J
    /\ cars_G = _TETrace[1].cars_G
    /\ cars_J = _TETrace[1].cars_J
    /\ hours_G = _TETrace[1].hours_G
    /\ hours_J = _TETrace[1].hours_J
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ food_G  = _TETrace[i].food_G
        /\ food_G' = _TETrace[j].food_G
        /\ food_J  = _TETrace[i].food_J
        /\ food_J' = _TETrace[j].food_J
        /\ cars_G  = _TETrace[i].cars_G
        /\ cars_G' = _TETrace[j].cars_G
        /\ cars_J  = _TETrace[i].cars_J
        /\ cars_J' = _TETrace[j].cars_J
        /\ hours_G  = _TETrace[i].hours_G
        /\ hours_G' = _TETrace[j].hours_G
        /\ hours_J  = _TETrace[i].hours_J
        /\ hours_J' = _TETrace[j].hours_J

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("ComparativeAdvantage_TTrace_1780175908.json", _TETrace)

=============================================================================

 Note that you can extract this module `ComparativeAdvantage_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `ComparativeAdvantage_TEExpression.tla` file takes precedence 
  over the module `ComparativeAdvantage_TEExpression` below).

---- MODULE ComparativeAdvantage_TEExpression ----
EXTENDS Sequences, TLCExt, Toolbox, Naturals, TLC, ComparativeAdvantage

expression == 
    [
        \* To hide variables of the `ComparativeAdvantage` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        food_G |-> food_G
        ,food_J |-> food_J
        ,cars_G |-> cars_G
        ,cars_J |-> cars_J
        ,hours_G |-> hours_G
        ,hours_J |-> hours_J
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_food_GUnchanged |-> food_G = food_G'
        
        \* Format the `food_G` variable as Json value.
        \* ,_food_GJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(food_G)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_food_GModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].food_G # _TETrace[s-1].food_G
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE ComparativeAdvantage_TETrace ----
\*EXTENDS IOUtils, TLC, ComparativeAdvantage
\*
\*trace == IODeserialize("ComparativeAdvantage_TTrace_1780175908.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE ComparativeAdvantage_TETrace ----
EXTENDS TLC, ComparativeAdvantage

trace == 
    <<
    ([hours_J |-> 10,cars_J |-> 0,food_J |-> 0,food_G |-> 0,cars_G |-> 0,hours_G |-> 10]),
    ([hours_J |-> 10,cars_J |-> 0,food_J |-> 0,food_G |-> 0,cars_G |-> 1,hours_G |-> 9]),
    ([hours_J |-> 10,cars_J |-> 0,food_J |-> 0,food_G |-> 0,cars_G |-> 2,hours_G |-> 8]),
    ([hours_J |-> 10,cars_J |-> 0,food_J |-> 0,food_G |-> 0,cars_G |-> 3,hours_G |-> 7]),
    ([hours_J |-> 10,cars_J |-> 0,food_J |-> 0,food_G |-> 2,cars_G |-> 3,hours_G |-> 6]),
    ([hours_J |-> 10,cars_J |-> 0,food_J |-> 0,food_G |-> 4,cars_G |-> 3,hours_G |-> 5]),
    ([hours_J |-> 10,cars_J |-> 0,food_J |-> 0,food_G |-> 6,cars_G |-> 3,hours_G |-> 4]),
    ([hours_J |-> 10,cars_J |-> 0,food_J |-> 0,food_G |-> 8,cars_G |-> 3,hours_G |-> 3]),
    ([hours_J |-> 10,cars_J |-> 0,food_J |-> 0,food_G |-> 10,cars_G |-> 3,hours_G |-> 2]),
    ([hours_J |-> 10,cars_J |-> 0,food_J |-> 0,food_G |-> 12,cars_G |-> 3,hours_G |-> 1]),
    ([hours_J |-> 10,cars_J |-> 0,food_J |-> 0,food_G |-> 14,cars_G |-> 3,hours_G |-> 0]),
    ([hours_J |-> 9,cars_J |-> 1,food_J |-> 0,food_G |-> 14,cars_G |-> 3,hours_G |-> 0]),
    ([hours_J |-> 8,cars_J |-> 2,food_J |-> 0,food_G |-> 14,cars_G |-> 3,hours_G |-> 0]),
    ([hours_J |-> 7,cars_J |-> 3,food_J |-> 0,food_G |-> 14,cars_G |-> 3,hours_G |-> 0]),
    ([hours_J |-> 6,cars_J |-> 4,food_J |-> 0,food_G |-> 14,cars_G |-> 3,hours_G |-> 0]),
    ([hours_J |-> 5,cars_J |-> 5,food_J |-> 0,food_G |-> 14,cars_G |-> 3,hours_G |-> 0]),
    ([hours_J |-> 4,cars_J |-> 6,food_J |-> 0,food_G |-> 14,cars_G |-> 3,hours_G |-> 0]),
    ([hours_J |-> 3,cars_J |-> 7,food_J |-> 0,food_G |-> 14,cars_G |-> 3,hours_G |-> 0]),
    ([hours_J |-> 2,cars_J |-> 8,food_J |-> 0,food_G |-> 14,cars_G |-> 3,hours_G |-> 0]),
    ([hours_J |-> 1,cars_J |-> 9,food_J |-> 0,food_G |-> 14,cars_G |-> 3,hours_G |-> 0]),
    ([hours_J |-> 1,cars_J |-> 7,food_J |-> 3,food_G |-> 11,cars_G |-> 5,hours_G |-> 0]),
    ([hours_J |-> 1,cars_J |-> 5,food_J |-> 6,food_G |-> 8,cars_G |-> 7,hours_G |-> 0])
    >>
----


=============================================================================

---- CONFIG ComparativeAdvantage_TTrace_1780175908 ----

INVARIANT
    _inv

CHECK_DEADLOCK
    \* CHECK_DEADLOCK off because of PROPERTY or INVARIANT above.
    FALSE

INIT
    _init

NEXT
    _next

CONSTANT
    _TETrace <- _trace

ALIAS
    _expression
=============================================================================
\* Generated on Sun May 31 00:18:28 EEST 2026