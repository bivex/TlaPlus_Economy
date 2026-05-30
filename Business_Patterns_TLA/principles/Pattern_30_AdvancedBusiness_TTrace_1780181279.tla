---- MODULE Pattern_30_AdvancedBusiness_TTrace_1780181279 ----
EXTENDS Sequences, TLCExt, Toolbox, Naturals, TLC, Pattern_30_AdvancedBusiness

_expression ==
    LET Pattern_30_AdvancedBusiness_TEExpression == INSTANCE Pattern_30_AdvancedBusiness_TEExpression
    IN Pattern_30_AdvancedBusiness_TEExpression!expression
----

_trace ==
    LET Pattern_30_AdvancedBusiness_TETrace == INSTANCE Pattern_30_AdvancedBusiness_TETrace
    IN Pattern_30_AdvancedBusiness_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        own_user_base = (180000)
        /\
        passive_revenue = (3150)
        /\
        time_pool = (30)
        /\
        service_revenue = (0)
        /\
        active_own_bots = (1)
    )
----

_init ==
    /\ own_user_base = _TETrace[1].own_user_base
    /\ time_pool = _TETrace[1].time_pool
    /\ passive_revenue = _TETrace[1].passive_revenue
    /\ service_revenue = _TETrace[1].service_revenue
    /\ active_own_bots = _TETrace[1].active_own_bots
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ own_user_base  = _TETrace[i].own_user_base
        /\ own_user_base' = _TETrace[j].own_user_base
        /\ time_pool  = _TETrace[i].time_pool
        /\ time_pool' = _TETrace[j].time_pool
        /\ passive_revenue  = _TETrace[i].passive_revenue
        /\ passive_revenue' = _TETrace[j].passive_revenue
        /\ service_revenue  = _TETrace[i].service_revenue
        /\ service_revenue' = _TETrace[j].service_revenue
        /\ active_own_bots  = _TETrace[i].active_own_bots
        /\ active_own_bots' = _TETrace[j].active_own_bots

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("Pattern_30_AdvancedBusiness_TTrace_1780181279.json", _TETrace)

=============================================================================

 Note that you can extract this module `Pattern_30_AdvancedBusiness_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `Pattern_30_AdvancedBusiness_TEExpression.tla` file takes precedence 
  over the module `Pattern_30_AdvancedBusiness_TEExpression` below).

---- MODULE Pattern_30_AdvancedBusiness_TEExpression ----
EXTENDS Sequences, TLCExt, Toolbox, Naturals, TLC, Pattern_30_AdvancedBusiness

expression == 
    [
        \* To hide variables of the `Pattern_30_AdvancedBusiness` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        own_user_base |-> own_user_base
        ,time_pool |-> time_pool
        ,passive_revenue |-> passive_revenue
        ,service_revenue |-> service_revenue
        ,active_own_bots |-> active_own_bots
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_own_user_baseUnchanged |-> own_user_base = own_user_base'
        
        \* Format the `own_user_base` variable as Json value.
        \* ,_own_user_baseJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(own_user_base)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_own_user_baseModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].own_user_base # _TETrace[s-1].own_user_base
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE Pattern_30_AdvancedBusiness_TETrace ----
\*EXTENDS IOUtils, TLC, Pattern_30_AdvancedBusiness
\*
\*trace == IODeserialize("Pattern_30_AdvancedBusiness_TTrace_1780181279.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_30_AdvancedBusiness_TETrace ----
EXTENDS TLC, Pattern_30_AdvancedBusiness

trace == 
    <<
    ([own_user_base |-> 0,passive_revenue |-> 0,time_pool |-> 160,service_revenue |-> 0,active_own_bots |-> 0]),
    ([own_user_base |-> 0,passive_revenue |-> 0,time_pool |-> 120,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 20000,passive_revenue |-> 0,time_pool |-> 110,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 40000,passive_revenue |-> 0,time_pool |-> 100,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 60000,passive_revenue |-> 0,time_pool |-> 90,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 80000,passive_revenue |-> 0,time_pool |-> 80,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 100000,passive_revenue |-> 0,time_pool |-> 70,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 120000,passive_revenue |-> 0,time_pool |-> 60,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 140000,passive_revenue |-> 0,time_pool |-> 50,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 160000,passive_revenue |-> 0,time_pool |-> 40,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 180000,passive_revenue |-> 0,time_pool |-> 30,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 180000,passive_revenue |-> 630,time_pool |-> 30,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 180000,passive_revenue |-> 1260,time_pool |-> 30,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 180000,passive_revenue |-> 1890,time_pool |-> 30,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 180000,passive_revenue |-> 2520,time_pool |-> 30,service_revenue |-> 0,active_own_bots |-> 1]),
    ([own_user_base |-> 180000,passive_revenue |-> 3150,time_pool |-> 30,service_revenue |-> 0,active_own_bots |-> 1])
    >>
----


=============================================================================

---- CONFIG Pattern_30_AdvancedBusiness_TTrace_1780181279 ----
CONSTANTS
    ARPU_PASSIVE = 1
    SERVICE_TICKET = 100
    SERVICE_TIME = 2
    SCALING_TIME = 10
    SCALING_FACTOR = 20000

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
\* Generated on Sun May 31 01:47:59 EEST 2026