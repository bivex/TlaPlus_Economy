---- MODULE Pattern_26_FreelanceBusiness_TTrace_1780178777 ----
EXTENDS Sequences, TLCExt, Toolbox, Naturals, TLC, Pattern_26_FreelanceBusiness

_expression ==
    LET Pattern_26_FreelanceBusiness_TEExpression == INSTANCE Pattern_26_FreelanceBusiness_TEExpression
    IN Pattern_26_FreelanceBusiness_TEExpression!expression
----

_trace ==
    LET Pattern_26_FreelanceBusiness_TETrace == INSTANCE Pattern_26_FreelanceBusiness_TETrace
    IN Pattern_26_FreelanceBusiness_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        revenue = (2000)
        /\
        time_pool = (132)
        /\
        active_projects = (0)
        /\
        leads = (2)
        /\
        completed_tasks = (4)
        /\
        budget = (2100)
        /\
        expenses = (0)
    )
----

_init ==
    /\ revenue = _TETrace[1].revenue
    /\ budget = _TETrace[1].budget
    /\ time_pool = _TETrace[1].time_pool
    /\ completed_tasks = _TETrace[1].completed_tasks
    /\ leads = _TETrace[1].leads
    /\ expenses = _TETrace[1].expenses
    /\ active_projects = _TETrace[1].active_projects
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ revenue  = _TETrace[i].revenue
        /\ revenue' = _TETrace[j].revenue
        /\ budget  = _TETrace[i].budget
        /\ budget' = _TETrace[j].budget
        /\ time_pool  = _TETrace[i].time_pool
        /\ time_pool' = _TETrace[j].time_pool
        /\ completed_tasks  = _TETrace[i].completed_tasks
        /\ completed_tasks' = _TETrace[j].completed_tasks
        /\ leads  = _TETrace[i].leads
        /\ leads' = _TETrace[j].leads
        /\ expenses  = _TETrace[i].expenses
        /\ expenses' = _TETrace[j].expenses
        /\ active_projects  = _TETrace[i].active_projects
        /\ active_projects' = _TETrace[j].active_projects

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("Pattern_26_FreelanceBusiness_TTrace_1780178777.json", _TETrace)

=============================================================================

 Note that you can extract this module `Pattern_26_FreelanceBusiness_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `Pattern_26_FreelanceBusiness_TEExpression.tla` file takes precedence 
  over the module `Pattern_26_FreelanceBusiness_TEExpression` below).

---- MODULE Pattern_26_FreelanceBusiness_TEExpression ----
EXTENDS Sequences, TLCExt, Toolbox, Naturals, TLC, Pattern_26_FreelanceBusiness

expression == 
    [
        \* To hide variables of the `Pattern_26_FreelanceBusiness` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        revenue |-> revenue
        ,budget |-> budget
        ,time_pool |-> time_pool
        ,completed_tasks |-> completed_tasks
        ,leads |-> leads
        ,expenses |-> expenses
        ,active_projects |-> active_projects
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_revenueUnchanged |-> revenue = revenue'
        
        \* Format the `revenue` variable as Json value.
        \* ,_revenueJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(revenue)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_revenueModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].revenue # _TETrace[s-1].revenue
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE Pattern_26_FreelanceBusiness_TETrace ----
\*EXTENDS IOUtils, TLC, Pattern_26_FreelanceBusiness
\*
\*trace == IODeserialize("Pattern_26_FreelanceBusiness_TTrace_1780178777.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_26_FreelanceBusiness_TETrace ----
EXTENDS TLC, Pattern_26_FreelanceBusiness

trace == 
    <<
    ([revenue |-> 0,time_pool |-> 160,active_projects |-> 0,leads |-> 0,completed_tasks |-> 0,budget |-> 100,expenses |-> 0]),
    ([revenue |-> 0,time_pool |-> 158,active_projects |-> 0,leads |-> 3,completed_tasks |-> 0,budget |-> 100,expenses |-> 0]),
    ([revenue |-> 0,time_pool |-> 156,active_projects |-> 0,leads |-> 6,completed_tasks |-> 0,budget |-> 100,expenses |-> 0]),
    ([revenue |-> 0,time_pool |-> 155,active_projects |-> 1,leads |-> 5,completed_tasks |-> 0,budget |-> 100,expenses |-> 0]),
    ([revenue |-> 0,time_pool |-> 154,active_projects |-> 2,leads |-> 4,completed_tasks |-> 0,budget |-> 100,expenses |-> 0]),
    ([revenue |-> 0,time_pool |-> 153,active_projects |-> 3,leads |-> 3,completed_tasks |-> 0,budget |-> 100,expenses |-> 0]),
    ([revenue |-> 0,time_pool |-> 152,active_projects |-> 4,leads |-> 2,completed_tasks |-> 0,budget |-> 100,expenses |-> 0]),
    ([revenue |-> 500,time_pool |-> 147,active_projects |-> 3,leads |-> 2,completed_tasks |-> 1,budget |-> 600,expenses |-> 0]),
    ([revenue |-> 1000,time_pool |-> 142,active_projects |-> 2,leads |-> 2,completed_tasks |-> 2,budget |-> 1100,expenses |-> 0]),
    ([revenue |-> 1500,time_pool |-> 137,active_projects |-> 1,leads |-> 2,completed_tasks |-> 3,budget |-> 1600,expenses |-> 0]),
    ([revenue |-> 2000,time_pool |-> 132,active_projects |-> 0,leads |-> 2,completed_tasks |-> 4,budget |-> 2100,expenses |-> 0])
    >>
----


=============================================================================

---- CONFIG Pattern_26_FreelanceBusiness_TTrace_1780178777 ----
CONSTANTS
    PROJECT_PRICE = 500
    OPS_COST_ANNUAL = 30
    PRODUCTION_TIME = 5
    MONTHLY_TIME_LIMIT = 160

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
\* Generated on Sun May 31 01:06:17 EEST 2026