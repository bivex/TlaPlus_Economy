---- MODULE Pattern_35_MultiServiceFreelance_TTrace_1784488001 ----
EXTENDS Pattern_35_MultiServiceFreelance, Sequences, TLCExt, Toolbox, Naturals, TLC

_expression ==
    LET Pattern_35_MultiServiceFreelance_TEExpression == INSTANCE Pattern_35_MultiServiceFreelance_TEExpression
    IN Pattern_35_MultiServiceFreelance_TEExpression!expression
----

_trace ==
    LET Pattern_35_MultiServiceFreelance_TETrace == INSTANCE Pattern_35_MultiServiceFreelance_TETrace
    IN Pattern_35_MultiServiceFreelance_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        last_service = ("blockchain")
        /\
        revenue = (12500)
        /\
        time_pool = (78)
        /\
        active_projects = ([bot |-> 0, coding_mid |-> 0, blockchain |-> 0])
        /\
        leads = ([bot |-> 15, coding_mid |-> 5, blockchain |-> 0])
        /\
        completed_tasks = ([bot |-> 0, coding_mid |-> 0, blockchain |-> 5])
        /\
        budget = (13500)
        /\
        expenses = (0)
    )
----

_init ==
    /\ revenue = _TETrace[1].revenue
    /\ budget = _TETrace[1].budget
    /\ time_pool = _TETrace[1].time_pool
    /\ last_service = _TETrace[1].last_service
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
        /\ last_service  = _TETrace[i].last_service
        /\ last_service' = _TETrace[j].last_service
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
    \*         IN J!JsonSerialize("Pattern_35_MultiServiceFreelance_TTrace_1784488001.json", _TETrace)

=============================================================================

 Note that you can extract this module `Pattern_35_MultiServiceFreelance_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `Pattern_35_MultiServiceFreelance_TEExpression.tla` file takes precedence 
  over the module `Pattern_35_MultiServiceFreelance_TEExpression` below).

---- MODULE Pattern_35_MultiServiceFreelance_TEExpression ----
EXTENDS Pattern_35_MultiServiceFreelance, Sequences, TLCExt, Toolbox, Naturals, TLC

expression == 
    [
        \* To hide variables of the `Pattern_35_MultiServiceFreelance` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        revenue |-> revenue
        ,budget |-> budget
        ,time_pool |-> time_pool
        ,last_service |-> last_service
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
\*---- MODULE Pattern_35_MultiServiceFreelance_TETrace ----
\*EXTENDS Pattern_35_MultiServiceFreelance, IOUtils, TLC
\*
\*trace == IODeserialize("Pattern_35_MultiServiceFreelance_TTrace_1784488001.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_35_MultiServiceFreelance_TETrace ----
EXTENDS Pattern_35_MultiServiceFreelance, TLC

trace == 
    <<
    ([last_service |-> "none",revenue |-> 0,time_pool |-> 160,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([last_service |-> "marketing",revenue |-> 0,time_pool |-> 156,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 3, coding_mid |-> 1, blockchain |-> 1],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([last_service |-> "marketing",revenue |-> 0,time_pool |-> 152,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 6, coding_mid |-> 2, blockchain |-> 2],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([last_service |-> "marketing",revenue |-> 0,time_pool |-> 148,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 9, coding_mid |-> 3, blockchain |-> 3],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([last_service |-> "marketing",revenue |-> 0,time_pool |-> 144,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 12, coding_mid |-> 4, blockchain |-> 4],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([last_service |-> "marketing",revenue |-> 0,time_pool |-> 140,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 15, coding_mid |-> 5, blockchain |-> 5],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([last_service |-> "sales",revenue |-> 0,time_pool |-> 139,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 1],leads |-> [bot |-> 15, coding_mid |-> 5, blockchain |-> 4],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([last_service |-> "sales",revenue |-> 0,time_pool |-> 138,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 2],leads |-> [bot |-> 15, coding_mid |-> 5, blockchain |-> 3],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([last_service |-> "sales",revenue |-> 0,time_pool |-> 137,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 3],leads |-> [bot |-> 15, coding_mid |-> 5, blockchain |-> 2],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([last_service |-> "sales",revenue |-> 0,time_pool |-> 136,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 4],leads |-> [bot |-> 15, coding_mid |-> 5, blockchain |-> 1],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([last_service |-> "sales",revenue |-> 0,time_pool |-> 135,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 5],leads |-> [bot |-> 15, coding_mid |-> 5, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([last_service |-> "blockchain",revenue |-> 2500,time_pool |-> 122,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 4],leads |-> [bot |-> 15, coding_mid |-> 5, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 1],budget |-> 3500,expenses |-> 0]),
    ([last_service |-> "blockchain",revenue |-> 5000,time_pool |-> 111,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 3],leads |-> [bot |-> 15, coding_mid |-> 5, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 2],budget |-> 6000,expenses |-> 0]),
    ([last_service |-> "blockchain",revenue |-> 7500,time_pool |-> 100,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 2],leads |-> [bot |-> 15, coding_mid |-> 5, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 3],budget |-> 8500,expenses |-> 0]),
    ([last_service |-> "blockchain",revenue |-> 10000,time_pool |-> 89,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 1],leads |-> [bot |-> 15, coding_mid |-> 5, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 4],budget |-> 11000,expenses |-> 0]),
    ([last_service |-> "blockchain",revenue |-> 12500,time_pool |-> 78,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 15, coding_mid |-> 5, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 5],budget |-> 13500,expenses |-> 0])
    >>
----


=============================================================================

---- CONFIG Pattern_35_MultiServiceFreelance_TTrace_1784488001 ----
CONSTANTS
    MONTHLY_TIME_LIMIT = 160
    OVERHEAD_COST = 1500

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
\* Generated on Sun Jul 19 22:06:53 EEST 2026