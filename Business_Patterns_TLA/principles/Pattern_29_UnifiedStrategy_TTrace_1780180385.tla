---- MODULE Pattern_29_UnifiedStrategy_TTrace_1780180385 ----
EXTENDS Sequences, TLCExt, Toolbox, Pattern_29_UnifiedStrategy, Naturals, TLC

_expression ==
    LET Pattern_29_UnifiedStrategy_TEExpression == INSTANCE Pattern_29_UnifiedStrategy_TEExpression
    IN Pattern_29_UnifiedStrategy_TEExpression!expression
----

_trace ==
    LET Pattern_29_UnifiedStrategy_TETrace == INSTANCE Pattern_29_UnifiedStrategy_TETrace
    IN Pattern_29_UnifiedStrategy_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        time_pool = (50)
        /\
        portfolio_size = (3)
        /\
        leads_main = (8)
        /\
        reputation = (95)
        /\
        total_profit = (5000)
        /\
        leads_low = (15)
        /\
        budget = (5100)
        /\
        leads_high = (0)
    )
----

_init ==
    /\ reputation = _TETrace[1].reputation
    /\ total_profit = _TETrace[1].total_profit
    /\ leads_low = _TETrace[1].leads_low
    /\ budget = _TETrace[1].budget
    /\ time_pool = _TETrace[1].time_pool
    /\ portfolio_size = _TETrace[1].portfolio_size
    /\ leads_main = _TETrace[1].leads_main
    /\ leads_high = _TETrace[1].leads_high
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ reputation  = _TETrace[i].reputation
        /\ reputation' = _TETrace[j].reputation
        /\ total_profit  = _TETrace[i].total_profit
        /\ total_profit' = _TETrace[j].total_profit
        /\ leads_low  = _TETrace[i].leads_low
        /\ leads_low' = _TETrace[j].leads_low
        /\ budget  = _TETrace[i].budget
        /\ budget' = _TETrace[j].budget
        /\ time_pool  = _TETrace[i].time_pool
        /\ time_pool' = _TETrace[j].time_pool
        /\ portfolio_size  = _TETrace[i].portfolio_size
        /\ portfolio_size' = _TETrace[j].portfolio_size
        /\ leads_main  = _TETrace[i].leads_main
        /\ leads_main' = _TETrace[j].leads_main
        /\ leads_high  = _TETrace[i].leads_high
        /\ leads_high' = _TETrace[j].leads_high

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("Pattern_29_UnifiedStrategy_TTrace_1780180385.json", _TETrace)

=============================================================================

 Note that you can extract this module `Pattern_29_UnifiedStrategy_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `Pattern_29_UnifiedStrategy_TEExpression.tla` file takes precedence 
  over the module `Pattern_29_UnifiedStrategy_TEExpression` below).

---- MODULE Pattern_29_UnifiedStrategy_TEExpression ----
EXTENDS Sequences, TLCExt, Toolbox, Pattern_29_UnifiedStrategy, Naturals, TLC

expression == 
    [
        \* To hide variables of the `Pattern_29_UnifiedStrategy` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        reputation |-> reputation
        ,total_profit |-> total_profit
        ,leads_low |-> leads_low
        ,budget |-> budget
        ,time_pool |-> time_pool
        ,portfolio_size |-> portfolio_size
        ,leads_main |-> leads_main
        ,leads_high |-> leads_high
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_reputationUnchanged |-> reputation = reputation'
        
        \* Format the `reputation` variable as Json value.
        \* ,_reputationJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(reputation)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_reputationModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].reputation # _TETrace[s-1].reputation
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE Pattern_29_UnifiedStrategy_TETrace ----
\*EXTENDS IOUtils, Pattern_29_UnifiedStrategy, TLC
\*
\*trace == IODeserialize("Pattern_29_UnifiedStrategy_TTrace_1780180385.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_29_UnifiedStrategy_TETrace ----
EXTENDS Pattern_29_UnifiedStrategy, TLC

trace == 
    <<
    ([time_pool |-> 160,portfolio_size |-> 0,leads_main |-> 0,reputation |-> 0,total_profit |-> 0,leads_low |-> 0,budget |-> 100,leads_high |-> 0]),
    ([time_pool |-> 150,portfolio_size |-> 1,leads_main |-> 0,reputation |-> 10,total_profit |-> 0,leads_low |-> 0,budget |-> 100,leads_high |-> 0]),
    ([time_pool |-> 140,portfolio_size |-> 2,leads_main |-> 0,reputation |-> 20,total_profit |-> 0,leads_low |-> 0,budget |-> 100,leads_high |-> 0]),
    ([time_pool |-> 130,portfolio_size |-> 3,leads_main |-> 0,reputation |-> 30,total_profit |-> 0,leads_low |-> 0,budget |-> 100,leads_high |-> 0]),
    ([time_pool |-> 125,portfolio_size |-> 3,leads_main |-> 3,reputation |-> 30,total_profit |-> 0,leads_low |-> 5,budget |-> 100,leads_high |-> 1]),
    ([time_pool |-> 120,portfolio_size |-> 3,leads_main |-> 6,reputation |-> 30,total_profit |-> 0,leads_low |-> 10,budget |-> 100,leads_high |-> 2]),
    ([time_pool |-> 115,portfolio_size |-> 3,leads_main |-> 9,reputation |-> 30,total_profit |-> 0,leads_low |-> 15,budget |-> 100,leads_high |-> 3]),
    ([time_pool |-> 110,portfolio_size |-> 3,leads_main |-> 8,reputation |-> 35,total_profit |-> 500,leads_low |-> 15,budget |-> 600,leads_high |-> 3]),
    ([time_pool |-> 90,portfolio_size |-> 3,leads_main |-> 8,reputation |-> 55,total_profit |-> 2000,leads_low |-> 15,budget |-> 2100,leads_high |-> 2]),
    ([time_pool |-> 70,portfolio_size |-> 3,leads_main |-> 8,reputation |-> 75,total_profit |-> 3500,leads_low |-> 15,budget |-> 3600,leads_high |-> 1]),
    ([time_pool |-> 50,portfolio_size |-> 3,leads_main |-> 8,reputation |-> 95,total_profit |-> 5000,leads_low |-> 15,budget |-> 5100,leads_high |-> 0])
    >>
----


=============================================================================

---- CONFIG Pattern_29_UnifiedStrategy_TTrace_1780180385 ----
CONSTANTS
    ENTRY_PRICE = 200
    MAIN_PRICE = 500
    ANCHOR_PRICE = 1500
    PRODUCTION_TIME_AI = 5
    FIXED_COSTS = 3

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
\* Generated on Sun May 31 01:33:05 EEST 2026