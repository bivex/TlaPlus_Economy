---- MODULE Pattern_33_PassiveLevers_TTrace_1780182780 ----
EXTENDS Sequences, TLCExt, Toolbox, Pattern_33_PassiveLevers, Naturals, TLC

_expression ==
    LET Pattern_33_PassiveLevers_TEExpression == INSTANCE Pattern_33_PassiveLevers_TEExpression
    IN Pattern_33_PassiveLevers_TEExpression!expression
----

_trace ==
    LET Pattern_33_PassiveLevers_TETrace == INSTANCE Pattern_33_PassiveLevers_TETrace
    IN Pattern_33_PassiveLevers_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        revenue = (3000)
        /\
        growth_potential = (100)
        /\
        maintenance_pool = (1)
        /\
        platform_risk = (40)
    )
----

_init ==
    /\ maintenance_pool = _TETrace[1].maintenance_pool
    /\ revenue = _TETrace[1].revenue
    /\ growth_potential = _TETrace[1].growth_potential
    /\ platform_risk = _TETrace[1].platform_risk
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ maintenance_pool  = _TETrace[i].maintenance_pool
        /\ maintenance_pool' = _TETrace[j].maintenance_pool
        /\ revenue  = _TETrace[i].revenue
        /\ revenue' = _TETrace[j].revenue
        /\ growth_potential  = _TETrace[i].growth_potential
        /\ growth_potential' = _TETrace[j].growth_potential
        /\ platform_risk  = _TETrace[i].platform_risk
        /\ platform_risk' = _TETrace[j].platform_risk

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("Pattern_33_PassiveLevers_TTrace_1780182780.json", _TETrace)

=============================================================================

 Note that you can extract this module `Pattern_33_PassiveLevers_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `Pattern_33_PassiveLevers_TEExpression.tla` file takes precedence 
  over the module `Pattern_33_PassiveLevers_TEExpression` below).

---- MODULE Pattern_33_PassiveLevers_TEExpression ----
EXTENDS Sequences, TLCExt, Toolbox, Pattern_33_PassiveLevers, Naturals, TLC

expression == 
    [
        \* To hide variables of the `Pattern_33_PassiveLevers` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        maintenance_pool |-> maintenance_pool
        ,revenue |-> revenue
        ,growth_potential |-> growth_potential
        ,platform_risk |-> platform_risk
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_maintenance_poolUnchanged |-> maintenance_pool = maintenance_pool'
        
        \* Format the `maintenance_pool` variable as Json value.
        \* ,_maintenance_poolJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(maintenance_pool)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_maintenance_poolModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].maintenance_pool # _TETrace[s-1].maintenance_pool
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE Pattern_33_PassiveLevers_TETrace ----
\*EXTENDS IOUtils, Pattern_33_PassiveLevers, TLC
\*
\*trace == IODeserialize("Pattern_33_PassiveLevers_TTrace_1780182780.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_33_PassiveLevers_TETrace ----
EXTENDS Pattern_33_PassiveLevers, TLC

trace == 
    <<
    ([revenue |-> 0,growth_potential |-> 100,maintenance_pool |-> 0,platform_risk |-> 0]),
    ([revenue |-> 3000,growth_potential |-> 100,maintenance_pool |-> 1,platform_risk |-> 40])
    >>
----


=============================================================================

---- CONFIG Pattern_33_PassiveLevers_TTrace_1780182780 ----

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
\* Generated on Sun May 31 02:13:01 EEST 2026