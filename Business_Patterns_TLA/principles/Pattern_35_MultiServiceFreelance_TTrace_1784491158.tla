---- MODULE Pattern_35_MultiServiceFreelance_TTrace_1784491158 ----
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
        revenue = (17350)
        /\
        overhead_paid = (TRUE)
        /\
        time_pool = (99)
        /\
        retainers = (0)
        /\
        active_projects = ([bot |-> 0, coding_mid |-> 0])
        /\
        leads = ([bot |-> 5, coding_mid |-> 0])
        /\
        completed_tasks = ([bot |-> 2, coding_mid |-> 3])
        /\
        budget = (15150)
        /\
        expenses = (5200)
        /\
        retainers_collected = (FALSE)
    )
----

_init ==
    /\ overhead_paid = _TETrace[1].overhead_paid
    /\ revenue = _TETrace[1].revenue
    /\ retainers = _TETrace[1].retainers
    /\ budget = _TETrace[1].budget
    /\ time_pool = _TETrace[1].time_pool
    /\ last_service = _TETrace[1].last_service
    /\ completed_tasks = _TETrace[1].completed_tasks
    /\ leads = _TETrace[1].leads
    /\ expenses = _TETrace[1].expenses
    /\ retainers_collected = _TETrace[1].retainers_collected
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
        /\ retainers  = _TETrace[i].retainers
        /\ retainers' = _TETrace[j].retainers
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
        /\ retainers_collected  = _TETrace[i].retainers_collected
        /\ retainers_collected' = _TETrace[j].retainers_collected
        /\ active_projects  = _TETrace[i].active_projects
        /\ active_projects' = _TETrace[j].active_projects

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("Pattern_35_MultiServiceFreelance_TTrace_1784491158.json", _TETrace)

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
        ,retainers |-> retainers
        ,budget |-> budget
        ,time_pool |-> time_pool
        ,last_service |-> last_service
        ,completed_tasks |-> completed_tasks
        ,leads |-> leads
        ,expenses |-> expenses
        ,retainers_collected |-> retainers_collected
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
\*trace == IODeserialize("Pattern_35_MultiServiceFreelance_TTrace_1784491158.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_35_MultiServiceFreelance_TETrace ----
EXTENDS Pattern_35_MultiServiceFreelance, TLC

trace == 
    <<
    ([last_service |-> "none",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 160,retainers |-> 0,active_projects |-> [bot |-> 0, coding_mid |-> 0],leads |-> [bot |-> 0, coding_mid |-> 0],completed_tasks |-> [bot |-> 0, coding_mid |-> 0],budget |-> 3000,expenses |-> 0,retainers_collected |-> FALSE]),
    ([last_service |-> "marketing",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 156,retainers |-> 0,active_projects |-> [bot |-> 0, coding_mid |-> 0],leads |-> [bot |-> 3, coding_mid |-> 1],completed_tasks |-> [bot |-> 0, coding_mid |-> 0],budget |-> 3000,expenses |-> 0,retainers_collected |-> FALSE]),
    ([last_service |-> "sales",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 155,retainers |-> 0,active_projects |-> [bot |-> 1, coding_mid |-> 0],leads |-> [bot |-> 2, coding_mid |-> 1],completed_tasks |-> [bot |-> 0, coding_mid |-> 0],budget |-> 3000,expenses |-> 0,retainers_collected |-> FALSE]),
    ([last_service |-> "marketing",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 151,retainers |-> 0,active_projects |-> [bot |-> 1, coding_mid |-> 0],leads |-> [bot |-> 5, coding_mid |-> 2],completed_tasks |-> [bot |-> 0, coding_mid |-> 0],budget |-> 3000,expenses |-> 0,retainers_collected |-> FALSE]),
    ([last_service |-> "sales",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 150,retainers |-> 0,active_projects |-> [bot |-> 2, coding_mid |-> 0],leads |-> [bot |-> 4, coding_mid |-> 2],completed_tasks |-> [bot |-> 0, coding_mid |-> 0],budget |-> 3000,expenses |-> 0,retainers_collected |-> FALSE]),
    ([last_service |-> "sales",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 149,retainers |-> 0,active_projects |-> [bot |-> 2, coding_mid |-> 0],leads |-> [bot |-> 3, coding_mid |-> 2],completed_tasks |-> [bot |-> 0, coding_mid |-> 0],budget |-> 3000,expenses |-> 0,retainers_collected |-> FALSE]),
    ([last_service |-> "sales",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 148,retainers |-> 0,active_projects |-> [bot |-> 2, coding_mid |-> 0],leads |-> [bot |-> 2, coding_mid |-> 2],completed_tasks |-> [bot |-> 0, coding_mid |-> 0],budget |-> 3000,expenses |-> 0,retainers_collected |-> FALSE]),
    ([last_service |-> "marketing",revenue |-> 0,overhead_paid |-> FALSE,time_pool |-> 144,retainers |-> 0,active_projects |-> [bot |-> 2, coding_mid |-> 0],leads |-> [bot |-> 5, coding_mid |-> 3],completed_tasks |-> [bot |-> 0, coding_mid |-> 0],budget |-> 3000,expenses |-> 0,retainers_collected |-> FALSE]),
    ([last_service |-> "affiliate",revenue |-> 3750,overhead_paid |-> FALSE,time_pool |-> 142,retainers |-> 0,active_projects |-> [bot |-> 2, coding_mid |-> 0],leads |-> [bot |-> 5, coding_mid |-> 3],completed_tasks |-> [bot |-> 0, coding_mid |-> 0],budget |-> 4250,expenses |-> 2500,retainers_collected |-> FALSE]),
    ([last_service |-> "sales",revenue |-> 3750,overhead_paid |-> FALSE,time_pool |-> 141,retainers |-> 0,active_projects |-> [bot |-> 2, coding_mid |-> 1],leads |-> [bot |-> 5, coding_mid |-> 2],completed_tasks |-> [bot |-> 0, coding_mid |-> 0],budget |-> 4250,expenses |-> 2500,retainers_collected |-> FALSE]),
    ([last_service |-> "sales",revenue |-> 3750,overhead_paid |-> FALSE,time_pool |-> 140,retainers |-> 0,active_projects |-> [bot |-> 2, coding_mid |-> 2],leads |-> [bot |-> 5, coding_mid |-> 1],completed_tasks |-> [bot |-> 0, coding_mid |-> 0],budget |-> 4250,expenses |-> 2500,retainers_collected |-> FALSE]),
    ([last_service |-> "bot",revenue |-> 4550,overhead_paid |-> FALSE,time_pool |-> 136,retainers |-> 0,active_projects |-> [bot |-> 1, coding_mid |-> 2],leads |-> [bot |-> 5, coding_mid |-> 1],completed_tasks |-> [bot |-> 1, coding_mid |-> 0],budget |-> 5050,expenses |-> 2500,retainers_collected |-> FALSE]),
    ([last_service |-> "bot",revenue |-> 5350,overhead_paid |-> FALSE,time_pool |-> 134,retainers |-> 0,active_projects |-> [bot |-> 0, coding_mid |-> 2],leads |-> [bot |-> 5, coding_mid |-> 1],completed_tasks |-> [bot |-> 2, coding_mid |-> 0],budget |-> 5850,expenses |-> 2500,retainers_collected |-> FALSE]),
    ([last_service |-> "coding_mid",revenue |-> 9350,overhead_paid |-> FALSE,time_pool |-> 122,retainers |-> 0,active_projects |-> [bot |-> 0, coding_mid |-> 1],leads |-> [bot |-> 5, coding_mid |-> 1],completed_tasks |-> [bot |-> 2, coding_mid |-> 1],budget |-> 9850,expenses |-> 2500,retainers_collected |-> FALSE]),
    ([last_service |-> "sales",revenue |-> 9350,overhead_paid |-> FALSE,time_pool |-> 121,retainers |-> 0,active_projects |-> [bot |-> 0, coding_mid |-> 2],leads |-> [bot |-> 5, coding_mid |-> 0],completed_tasks |-> [bot |-> 2, coding_mid |-> 1],budget |-> 9850,expenses |-> 2500,retainers_collected |-> FALSE]),
    ([last_service |-> "coding_mid",revenue |-> 13350,overhead_paid |-> FALSE,time_pool |-> 109,retainers |-> 0,active_projects |-> [bot |-> 0, coding_mid |-> 1],leads |-> [bot |-> 5, coding_mid |-> 0],completed_tasks |-> [bot |-> 2, coding_mid |-> 2],budget |-> 13850,expenses |-> 2500,retainers_collected |-> FALSE]),
    ([last_service |-> "coding_mid",revenue |-> 17350,overhead_paid |-> FALSE,time_pool |-> 99,retainers |-> 0,active_projects |-> [bot |-> 0, coding_mid |-> 0],leads |-> [bot |-> 5, coding_mid |-> 0],completed_tasks |-> [bot |-> 2, coding_mid |-> 3],budget |-> 17850,expenses |-> 2500,retainers_collected |-> FALSE]),
    ([last_service |-> "none",revenue |-> 17350,overhead_paid |-> TRUE,time_pool |-> 99,retainers |-> 0,active_projects |-> [bot |-> 0, coding_mid |-> 0],leads |-> [bot |-> 5, coding_mid |-> 0],completed_tasks |-> [bot |-> 2, coding_mid |-> 3],budget |-> 15150,expenses |-> 5200,retainers_collected |-> FALSE])
    >>
----


=============================================================================

---- CONFIG Pattern_35_MultiServiceFreelance_TTrace_1784491158 ----
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
\* Generated on Sun Jul 19 22:59:21 EEST 2026