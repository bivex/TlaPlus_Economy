---- MODULE TenPrinciplesOfEconomics_TTrace_1780175528 ----
EXTENDS Sequences, TenPrinciplesOfEconomics, TLCExt, Toolbox, Naturals, TLC

_expression ==
    LET TenPrinciplesOfEconomics_TEExpression == INSTANCE TenPrinciplesOfEconomics_TEExpression
    IN TenPrinciplesOfEconomics_TEExpression!expression
----

_trace ==
    LET TenPrinciplesOfEconomics_TETrace == INSTANCE TenPrinciplesOfEconomics_TETrace
    IN TenPrinciplesOfEconomics_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        money_supply = (100)
        /\
        productivity = (8)
        /\
        price_level = (1)
        /\
        unemployment = (5)
        /\
        goods = (0)
        /\
        resources = (3)
        /\
        welfare = (100)
        /\
        inflation = (2)
    )
----

_init ==
    /\ productivity = _TETrace[1].productivity
    /\ welfare = _TETrace[1].welfare
    /\ unemployment = _TETrace[1].unemployment
    /\ price_level = _TETrace[1].price_level
    /\ goods = _TETrace[1].goods
    /\ resources = _TETrace[1].resources
    /\ money_supply = _TETrace[1].money_supply
    /\ inflation = _TETrace[1].inflation
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ productivity  = _TETrace[i].productivity
        /\ productivity' = _TETrace[j].productivity
        /\ welfare  = _TETrace[i].welfare
        /\ welfare' = _TETrace[j].welfare
        /\ unemployment  = _TETrace[i].unemployment
        /\ unemployment' = _TETrace[j].unemployment
        /\ price_level  = _TETrace[i].price_level
        /\ price_level' = _TETrace[j].price_level
        /\ goods  = _TETrace[i].goods
        /\ goods' = _TETrace[j].goods
        /\ resources  = _TETrace[i].resources
        /\ resources' = _TETrace[j].resources
        /\ money_supply  = _TETrace[i].money_supply
        /\ money_supply' = _TETrace[j].money_supply
        /\ inflation  = _TETrace[i].inflation
        /\ inflation' = _TETrace[j].inflation

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("TenPrinciplesOfEconomics_TTrace_1780175528.json", _TETrace)

=============================================================================

 Note that you can extract this module `TenPrinciplesOfEconomics_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `TenPrinciplesOfEconomics_TEExpression.tla` file takes precedence 
  over the module `TenPrinciplesOfEconomics_TEExpression` below).

---- MODULE TenPrinciplesOfEconomics_TEExpression ----
EXTENDS Sequences, TenPrinciplesOfEconomics, TLCExt, Toolbox, Naturals, TLC

expression == 
    [
        \* To hide variables of the `TenPrinciplesOfEconomics` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        productivity |-> productivity
        ,welfare |-> welfare
        ,unemployment |-> unemployment
        ,price_level |-> price_level
        ,goods |-> goods
        ,resources |-> resources
        ,money_supply |-> money_supply
        ,inflation |-> inflation
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_productivityUnchanged |-> productivity = productivity'
        
        \* Format the `productivity` variable as Json value.
        \* ,_productivityJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(productivity)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_productivityModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].productivity # _TETrace[s-1].productivity
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE TenPrinciplesOfEconomics_TETrace ----
\*EXTENDS IOUtils, TenPrinciplesOfEconomics, TLC
\*
\*trace == IODeserialize("TenPrinciplesOfEconomics_TTrace_1780175528.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE TenPrinciplesOfEconomics_TETrace ----
EXTENDS TenPrinciplesOfEconomics, TLC

trace == 
    <<
    ([money_supply |-> 100,productivity |-> 1,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 100,welfare |-> 10,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 1,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 95,welfare |-> 20,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 1,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 90,welfare |-> 26,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 1,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 85,welfare |-> 32,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 1,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 80,welfare |-> 37,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 1,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 75,welfare |-> 42,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 2,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 65,welfare |-> 42,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 3,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 55,welfare |-> 42,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 4,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 45,welfare |-> 42,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 5,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 35,welfare |-> 42,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 6,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 25,welfare |-> 42,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 7,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 15,welfare |-> 42,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 8,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 5,welfare |-> 42,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 8,price_level |-> 1,unemployment |-> 5,goods |-> 8,resources |-> 4,welfare |-> 43,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 8,price_level |-> 1,unemployment |-> 5,goods |-> 16,resources |-> 3,welfare |-> 44,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 8,price_level |-> 1,unemployment |-> 5,goods |-> 14,resources |-> 3,welfare |-> 51,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 8,price_level |-> 1,unemployment |-> 5,goods |-> 12,resources |-> 3,welfare |-> 58,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 8,price_level |-> 1,unemployment |-> 5,goods |-> 10,resources |-> 3,welfare |-> 65,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 8,price_level |-> 1,unemployment |-> 5,goods |-> 8,resources |-> 3,welfare |-> 72,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 8,price_level |-> 1,unemployment |-> 5,goods |-> 6,resources |-> 3,welfare |-> 79,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 8,price_level |-> 1,unemployment |-> 5,goods |-> 4,resources |-> 3,welfare |-> 86,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 8,price_level |-> 1,unemployment |-> 5,goods |-> 2,resources |-> 3,welfare |-> 93,inflation |-> 2]),
    ([money_supply |-> 100,productivity |-> 8,price_level |-> 1,unemployment |-> 5,goods |-> 0,resources |-> 3,welfare |-> 100,inflation |-> 2])
    >>
----


=============================================================================

---- CONFIG TenPrinciplesOfEconomics_TTrace_1780175528 ----

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
\* Generated on Sun May 31 00:12:23 EEST 2026