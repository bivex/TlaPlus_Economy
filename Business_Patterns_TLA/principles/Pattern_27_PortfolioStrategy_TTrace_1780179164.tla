---- MODULE Pattern_27_PortfolioStrategy_TTrace_1780179164 ----
EXTENDS Sequences, Pattern_27_PortfolioStrategy, TLCExt, Toolbox, Naturals, TLC

_expression ==
    LET Pattern_27_PortfolioStrategy_TEExpression == INSTANCE Pattern_27_PortfolioStrategy_TEExpression
    IN Pattern_27_PortfolioStrategy_TEExpression!expression
----

_trace ==
    LET Pattern_27_PortfolioStrategy_TETrace == INSTANCE Pattern_27_PortfolioStrategy_TETrace
    IN Pattern_27_PortfolioStrategy_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        revenue = (10000)
        /\
        time_pool = (315)
        /\
        leads = (0)
        /\
        projects_done = (20)
        /\
        portfolio_items = (6)
    )
----

_init ==
    /\ portfolio_items = _TETrace[1].portfolio_items
    /\ revenue = _TETrace[1].revenue
    /\ time_pool = _TETrace[1].time_pool
    /\ leads = _TETrace[1].leads
    /\ projects_done = _TETrace[1].projects_done
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ portfolio_items  = _TETrace[i].portfolio_items
        /\ portfolio_items' = _TETrace[j].portfolio_items
        /\ revenue  = _TETrace[i].revenue
        /\ revenue' = _TETrace[j].revenue
        /\ time_pool  = _TETrace[i].time_pool
        /\ time_pool' = _TETrace[j].time_pool
        /\ leads  = _TETrace[i].leads
        /\ leads' = _TETrace[j].leads
        /\ projects_done  = _TETrace[i].projects_done
        /\ projects_done' = _TETrace[j].projects_done

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("Pattern_27_PortfolioStrategy_TTrace_1780179164.json", _TETrace)

=============================================================================

 Note that you can extract this module `Pattern_27_PortfolioStrategy_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `Pattern_27_PortfolioStrategy_TEExpression.tla` file takes precedence 
  over the module `Pattern_27_PortfolioStrategy_TEExpression` below).

---- MODULE Pattern_27_PortfolioStrategy_TEExpression ----
EXTENDS Sequences, Pattern_27_PortfolioStrategy, TLCExt, Toolbox, Naturals, TLC

expression == 
    [
        \* To hide variables of the `Pattern_27_PortfolioStrategy` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        portfolio_items |-> portfolio_items
        ,revenue |-> revenue
        ,time_pool |-> time_pool
        ,leads |-> leads
        ,projects_done |-> projects_done
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_portfolio_itemsUnchanged |-> portfolio_items = portfolio_items'
        
        \* Format the `portfolio_items` variable as Json value.
        \* ,_portfolio_itemsJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(portfolio_items)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_portfolio_itemsModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].portfolio_items # _TETrace[s-1].portfolio_items
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE Pattern_27_PortfolioStrategy_TETrace ----
\*EXTENDS IOUtils, Pattern_27_PortfolioStrategy, TLC
\*
\*trace == IODeserialize("Pattern_27_PortfolioStrategy_TTrace_1780179164.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_27_PortfolioStrategy_TETrace ----
EXTENDS Pattern_27_PortfolioStrategy, TLC

trace == 
    <<
    ([revenue |-> 0,time_pool |-> 480,leads |-> 0,projects_done |-> 0,portfolio_items |-> 0]),
    ([revenue |-> 0,time_pool |-> 470,leads |-> 0,projects_done |-> 0,portfolio_items |-> 1]),
    ([revenue |-> 0,time_pool |-> 460,leads |-> 0,projects_done |-> 0,portfolio_items |-> 2]),
    ([revenue |-> 0,time_pool |-> 450,leads |-> 0,projects_done |-> 0,portfolio_items |-> 3]),
    ([revenue |-> 0,time_pool |-> 440,leads |-> 0,projects_done |-> 0,portfolio_items |-> 4]),
    ([revenue |-> 0,time_pool |-> 430,leads |-> 0,projects_done |-> 0,portfolio_items |-> 5]),
    ([revenue |-> 0,time_pool |-> 420,leads |-> 0,projects_done |-> 0,portfolio_items |-> 6]),
    ([revenue |-> 0,time_pool |-> 419,leads |-> 4,projects_done |-> 0,portfolio_items |-> 6]),
    ([revenue |-> 0,time_pool |-> 418,leads |-> 8,projects_done |-> 0,portfolio_items |-> 6]),
    ([revenue |-> 0,time_pool |-> 417,leads |-> 12,projects_done |-> 0,portfolio_items |-> 6]),
    ([revenue |-> 0,time_pool |-> 416,leads |-> 16,projects_done |-> 0,portfolio_items |-> 6]),
    ([revenue |-> 0,time_pool |-> 415,leads |-> 20,projects_done |-> 0,portfolio_items |-> 6]),
    ([revenue |-> 500,time_pool |-> 410,leads |-> 19,projects_done |-> 1,portfolio_items |-> 6]),
    ([revenue |-> 1000,time_pool |-> 405,leads |-> 18,projects_done |-> 2,portfolio_items |-> 6]),
    ([revenue |-> 1500,time_pool |-> 400,leads |-> 17,projects_done |-> 3,portfolio_items |-> 6]),
    ([revenue |-> 2000,time_pool |-> 395,leads |-> 16,projects_done |-> 4,portfolio_items |-> 6]),
    ([revenue |-> 2500,time_pool |-> 390,leads |-> 15,projects_done |-> 5,portfolio_items |-> 6]),
    ([revenue |-> 3000,time_pool |-> 385,leads |-> 14,projects_done |-> 6,portfolio_items |-> 6]),
    ([revenue |-> 3500,time_pool |-> 380,leads |-> 13,projects_done |-> 7,portfolio_items |-> 6]),
    ([revenue |-> 4000,time_pool |-> 375,leads |-> 12,projects_done |-> 8,portfolio_items |-> 6]),
    ([revenue |-> 4500,time_pool |-> 370,leads |-> 11,projects_done |-> 9,portfolio_items |-> 6]),
    ([revenue |-> 5000,time_pool |-> 365,leads |-> 10,projects_done |-> 10,portfolio_items |-> 6]),
    ([revenue |-> 5500,time_pool |-> 360,leads |-> 9,projects_done |-> 11,portfolio_items |-> 6]),
    ([revenue |-> 6000,time_pool |-> 355,leads |-> 8,projects_done |-> 12,portfolio_items |-> 6]),
    ([revenue |-> 6500,time_pool |-> 350,leads |-> 7,projects_done |-> 13,portfolio_items |-> 6]),
    ([revenue |-> 7000,time_pool |-> 345,leads |-> 6,projects_done |-> 14,portfolio_items |-> 6]),
    ([revenue |-> 7500,time_pool |-> 340,leads |-> 5,projects_done |-> 15,portfolio_items |-> 6]),
    ([revenue |-> 8000,time_pool |-> 335,leads |-> 4,projects_done |-> 16,portfolio_items |-> 6]),
    ([revenue |-> 8500,time_pool |-> 330,leads |-> 3,projects_done |-> 17,portfolio_items |-> 6]),
    ([revenue |-> 9000,time_pool |-> 325,leads |-> 2,projects_done |-> 18,portfolio_items |-> 6]),
    ([revenue |-> 9500,time_pool |-> 320,leads |-> 1,projects_done |-> 19,portfolio_items |-> 6]),
    ([revenue |-> 10000,time_pool |-> 315,leads |-> 0,projects_done |-> 20,portfolio_items |-> 6])
    >>
----


=============================================================================

---- CONFIG Pattern_27_PortfolioStrategy_TTrace_1780179164 ----
CONSTANTS
    BUILD_TIME_PORTFOLIO = 10
    BUILD_TIME_CLIENT = 5
    MARKETING_HOUR_COST = 1
    PRICE = 500

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
\* Generated on Sun May 31 01:12:45 EEST 2026