---- MODULE Pattern_34_IndieSteamStudio_TTrace_1780247350 ----
EXTENDS Sequences, TLCExt, Toolbox, Naturals, TLC, Pattern_34_IndieSteamStudio

_expression ==
    LET Pattern_34_IndieSteamStudio_TEExpression == INSTANCE Pattern_34_IndieSteamStudio_TEExpression
    IN Pattern_34_IndieSteamStudio_TEExpression!expression
----

_trace ==
    LET Pattern_34_IndieSteamStudio_TETrace == INSTANCE Pattern_34_IndieSteamStudio_TETrace
    IN Pattern_34_IndieSteamStudio_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        months_passed = (36)
        /\
        micro_games = (0)
        /\
        total_revenue = (1050000)
        /\
        quality_games = (0)
        /\
        cash = (990000)
        /\
        premium_games = (2)
    )
----

_init ==
    /\ micro_games = _TETrace[1].micro_games
    /\ months_passed = _TETrace[1].months_passed
    /\ quality_games = _TETrace[1].quality_games
    /\ total_revenue = _TETrace[1].total_revenue
    /\ cash = _TETrace[1].cash
    /\ premium_games = _TETrace[1].premium_games
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ micro_games  = _TETrace[i].micro_games
        /\ micro_games' = _TETrace[j].micro_games
        /\ months_passed  = _TETrace[i].months_passed
        /\ months_passed' = _TETrace[j].months_passed
        /\ quality_games  = _TETrace[i].quality_games
        /\ quality_games' = _TETrace[j].quality_games
        /\ total_revenue  = _TETrace[i].total_revenue
        /\ total_revenue' = _TETrace[j].total_revenue
        /\ cash  = _TETrace[i].cash
        /\ cash' = _TETrace[j].cash
        /\ premium_games  = _TETrace[i].premium_games
        /\ premium_games' = _TETrace[j].premium_games

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("Pattern_34_IndieSteamStudio_TTrace_1780247350.json", _TETrace)

=============================================================================

 Note that you can extract this module `Pattern_34_IndieSteamStudio_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `Pattern_34_IndieSteamStudio_TEExpression.tla` file takes precedence 
  over the module `Pattern_34_IndieSteamStudio_TEExpression` below).

---- MODULE Pattern_34_IndieSteamStudio_TEExpression ----
EXTENDS Sequences, TLCExt, Toolbox, Naturals, TLC, Pattern_34_IndieSteamStudio

expression == 
    [
        \* To hide variables of the `Pattern_34_IndieSteamStudio` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        micro_games |-> micro_games
        ,months_passed |-> months_passed
        ,quality_games |-> quality_games
        ,total_revenue |-> total_revenue
        ,cash |-> cash
        ,premium_games |-> premium_games
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_micro_gamesUnchanged |-> micro_games = micro_games'
        
        \* Format the `micro_games` variable as Json value.
        \* ,_micro_gamesJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(micro_games)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_micro_gamesModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].micro_games # _TETrace[s-1].micro_games
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE Pattern_34_IndieSteamStudio_TETrace ----
\*EXTENDS IOUtils, TLC, Pattern_34_IndieSteamStudio
\*
\*trace == IODeserialize("Pattern_34_IndieSteamStudio_TTrace_1780247350.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_34_IndieSteamStudio_TETrace ----
EXTENDS TLC, Pattern_34_IndieSteamStudio

trace == 
    <<
    ([months_passed |-> 0,micro_games |-> 0,total_revenue |-> 0,quality_games |-> 0,cash |-> 0,premium_games |-> 0]),
    ([months_passed |-> 18,micro_games |-> 0,total_revenue |-> 525000,quality_games |-> 0,cash |-> 495000,premium_games |-> 1]),
    ([months_passed |-> 36,micro_games |-> 0,total_revenue |-> 1050000,quality_games |-> 0,cash |-> 990000,premium_games |-> 2])
    >>
----


=============================================================================

---- CONFIG Pattern_34_IndieSteamStudio_TTrace_1780247350 ----
CONSTANTS
    MICRO_DEV_MONTHS = 2
    MICRO_DEV_COST = 500
    MICRO_PRICE = 3
    MICRO_SALES = 3000
    QUALITY_DEV_MONTHS = 9
    QUALITY_DEV_COST = 8000
    QUALITY_PRICE = 15
    QUALITY_SALES = 10000
    PREMIUM_DEV_MONTHS = 18
    PREMIUM_DEV_COST = 30000
    PREMIUM_PRICE = 30
    PREMIUM_SALES = 25000
    STEAM_CUT = 30
    MONTHS_AVAILABLE = 36

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
\* Generated on Sun May 31 20:09:11 EEST 2026