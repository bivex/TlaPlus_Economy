---- MODULE Pattern_35_MultiServiceFreelance_TTrace_1784487216 ----
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
        revenue = (20000)
        /\
        time_pool = (32)
        /\
        completed_tasks = ([bot |-> 0, web_simple |-> 0, qa |-> 0, coding_mid |-> 0, advanced_dev |-> 0, devops |-> 0, blockchain |-> 8])
        /\
        budget = (21000)
        /\
        expenses = (0)
    )
----

_init ==
    /\ revenue = _TETrace[1].revenue
    /\ budget = _TETrace[1].budget
    /\ time_pool = _TETrace[1].time_pool
    /\ completed_tasks = _TETrace[1].completed_tasks
    /\ expenses = _TETrace[1].expenses
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
        /\ expenses  = _TETrace[i].expenses
        /\ expenses' = _TETrace[j].expenses

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("Pattern_35_MultiServiceFreelance_TTrace_1784487216.json", _TETrace)

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
        ,completed_tasks |-> completed_tasks
        ,expenses |-> expenses
        
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
\*trace == IODeserialize("Pattern_35_MultiServiceFreelance_TTrace_1784487216.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_35_MultiServiceFreelance_TETrace ----
EXTENDS Pattern_35_MultiServiceFreelance, TLC

trace == 
    <<
    ([revenue |-> 0,time_pool |-> 160,completed_tasks |-> [bot |-> 0, web_simple |-> 0, qa |-> 0, coding_mid |-> 0, advanced_dev |-> 0, devops |-> 0, blockchain |-> 0],budget |-> 1000,expenses |-> 0]),
    ([revenue |-> 2500,time_pool |-> 144,completed_tasks |-> [bot |-> 0, web_simple |-> 0, qa |-> 0, coding_mid |-> 0, advanced_dev |-> 0, devops |-> 0, blockchain |-> 1],budget |-> 3500,expenses |-> 0]),
    ([revenue |-> 5000,time_pool |-> 128,completed_tasks |-> [bot |-> 0, web_simple |-> 0, qa |-> 0, coding_mid |-> 0, advanced_dev |-> 0, devops |-> 0, blockchain |-> 2],budget |-> 6000,expenses |-> 0]),
    ([revenue |-> 7500,time_pool |-> 112,completed_tasks |-> [bot |-> 0, web_simple |-> 0, qa |-> 0, coding_mid |-> 0, advanced_dev |-> 0, devops |-> 0, blockchain |-> 3],budget |-> 8500,expenses |-> 0]),
    ([revenue |-> 10000,time_pool |-> 96,completed_tasks |-> [bot |-> 0, web_simple |-> 0, qa |-> 0, coding_mid |-> 0, advanced_dev |-> 0, devops |-> 0, blockchain |-> 4],budget |-> 11000,expenses |-> 0]),
    ([revenue |-> 12500,time_pool |-> 80,completed_tasks |-> [bot |-> 0, web_simple |-> 0, qa |-> 0, coding_mid |-> 0, advanced_dev |-> 0, devops |-> 0, blockchain |-> 5],budget |-> 13500,expenses |-> 0]),
    ([revenue |-> 15000,time_pool |-> 64,completed_tasks |-> [bot |-> 0, web_simple |-> 0, qa |-> 0, coding_mid |-> 0, advanced_dev |-> 0, devops |-> 0, blockchain |-> 6],budget |-> 16000,expenses |-> 0]),
    ([revenue |-> 17500,time_pool |-> 48,completed_tasks |-> [bot |-> 0, web_simple |-> 0, qa |-> 0, coding_mid |-> 0, advanced_dev |-> 0, devops |-> 0, blockchain |-> 7],budget |-> 18500,expenses |-> 0]),
    ([revenue |-> 20000,time_pool |-> 32,completed_tasks |-> [bot |-> 0, web_simple |-> 0, qa |-> 0, coding_mid |-> 0, advanced_dev |-> 0, devops |-> 0, blockchain |-> 8],budget |-> 21000,expenses |-> 0])
    >>
----


=============================================================================

---- CONFIG Pattern_35_MultiServiceFreelance_TTrace_1784487216 ----
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
\* Generated on Sun Jul 19 21:53:36 EEST 2026