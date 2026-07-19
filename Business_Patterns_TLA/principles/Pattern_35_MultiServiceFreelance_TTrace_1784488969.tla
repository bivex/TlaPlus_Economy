---- MODULE Pattern_35_MultiServiceFreelance_TTrace_1784488969 ----
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
        last_service = ("none")
        /\
        revenue = (24000)
        /\
        overhead_paid = (TRUE)
        /\
        time_pool = (116)
        /\
        active_projects = ([bot |-> 0, coding_mid |-> 0, blockchain |-> 0])
        /\
        leads = ([bot |-> 6, coding_mid |-> 2, blockchain |-> 0])
        /\
        completed_tasks = ([bot |-> 0, coding_mid |-> 0, blockchain |-> 2])
        /\
        budget = (24300)
        /\
        expenses = (2700)
    )
----

_init ==
    /\ overhead_paid = _TETrace[1].overhead_paid
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
        /\ overhead_paid  = _TETrace[i].overhead_paid
        /\ overhead_paid' = _TETrace[j].overhead_paid
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
    \*         IN J!JsonSerialize("Pattern_35_MultiServiceFreelance_TTrace_1784488969.json", _TETrace)

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
        overhead_paid |-> overhead_paid
        ,revenue |-> revenue
        ,budget |-> budget
        ,time_pool |-> time_pool
        ,last_service |-> last_service
        ,completed_tasks |-> completed_tasks
        ,leads |-> leads
        ,expenses |-> expenses
        ,active_projects |-> active_projects
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_overhead_paidUnchanged |-> overhead_paid = overhead_paid'
        
        \* Format the `overhead_paid` variable as Json value.
        \* ,_overhead_paidJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(overhead_paid)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_overhead_paidModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].overhead_paid # _TETrace[s-1].overhead_paid
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
\*trace == IODeserialize("Pattern_35_MultiServiceFreelance_TTrace_1784488969.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_35_MultiServiceFreelance_TETrace ----
EXTENDS Pattern_35_MultiServiceFreelance, TLC

trace == 
    <<
    ([last_service |-> "none",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 160,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 3000,expenses |-> 0]),
    ([last_service |-> "marketing",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 156,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 3, coding_mid |-> 1, blockchain |-> 1],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 3000,expenses |-> 0]),
    ([last_service |-> "marketing",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 152,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 6, coding_mid |-> 2, blockchain |-> 2],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 3000,expenses |-> 0]),
    ([last_service |-> "sales",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 151,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 1],leads |-> [bot |-> 6, coding_mid |-> 2, blockchain |-> 1],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 3000,expenses |-> 0]),
    ([last_service |-> "sales",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 150,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 2],leads |-> [bot |-> 6, coding_mid |-> 2, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],budget |-> 3000,expenses |-> 0]),
    ([last_service |-> "blockchain",revenue |-> 12000,overhead_paid |-> FALSE,time_pool |-> 132,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 1],leads |-> [bot |-> 6, coding_mid |-> 2, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 1],budget |-> 15000,expenses |-> 0]),
    ([last_service |-> "blockchain",revenue |-> 24000,overhead_paid |-> FALSE,time_pool |-> 116,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 6, coding_mid |-> 2, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 2],budget |-> 27000,expenses |-> 0]),
    ([last_service |-> "none",revenue |-> 24000,overhead_paid |-> TRUE,time_pool |-> 116,active_projects |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 0],leads |-> [bot |-> 6, coding_mid |-> 2, blockchain |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0, blockchain |-> 2],budget |-> 24300,expenses |-> 2700])
    >>
----


=============================================================================

---- CONFIG Pattern_35_MultiServiceFreelance_TTrace_1784488969 ----
CONSTANTS
    MONTHLY_TIME_LIMIT = 160
    OVERHEAD_COST = 2700

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
\* Generated on Sun Jul 19 22:22:50 EEST 2026