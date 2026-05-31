---- MODULE Pattern_31_BotNicheMarket_TTrace_1780182009 ----
EXTENDS Sequences, TLCExt, Toolbox, Naturals, TLC, Pattern_31_BotNicheMarket

_expression ==
    LET Pattern_31_BotNicheMarket_TEExpression == INSTANCE Pattern_31_BotNicheMarket_TEExpression
    IN Pattern_31_BotNicheMarket_TEExpression!expression
----

_trace ==
    LET Pattern_31_BotNicheMarket_TETrace == INSTANCE Pattern_31_BotNicheMarket_TETrace
    IN Pattern_31_BotNicheMarket_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        b2b_mini_apps = (7)
        /\
        niche_parsers = (0)
        /\
        ai_oracles = (0)
        /\
        accumulated_profit = (10500)
        /\
        time_spent = (280)
    )
----

_init ==
    /\ time_spent = _TETrace[1].time_spent
    /\ niche_parsers = _TETrace[1].niche_parsers
    /\ ai_oracles = _TETrace[1].ai_oracles
    /\ b2b_mini_apps = _TETrace[1].b2b_mini_apps
    /\ accumulated_profit = _TETrace[1].accumulated_profit
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ time_spent  = _TETrace[i].time_spent
        /\ time_spent' = _TETrace[j].time_spent
        /\ niche_parsers  = _TETrace[i].niche_parsers
        /\ niche_parsers' = _TETrace[j].niche_parsers
        /\ ai_oracles  = _TETrace[i].ai_oracles
        /\ ai_oracles' = _TETrace[j].ai_oracles
        /\ b2b_mini_apps  = _TETrace[i].b2b_mini_apps
        /\ b2b_mini_apps' = _TETrace[j].b2b_mini_apps
        /\ accumulated_profit  = _TETrace[i].accumulated_profit
        /\ accumulated_profit' = _TETrace[j].accumulated_profit

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("Pattern_31_BotNicheMarket_TTrace_1780182009.json", _TETrace)

=============================================================================

 Note that you can extract this module `Pattern_31_BotNicheMarket_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `Pattern_31_BotNicheMarket_TEExpression.tla` file takes precedence 
  over the module `Pattern_31_BotNicheMarket_TEExpression` below).

---- MODULE Pattern_31_BotNicheMarket_TEExpression ----
EXTENDS Sequences, TLCExt, Toolbox, Naturals, TLC, Pattern_31_BotNicheMarket

expression == 
    [
        \* To hide variables of the `Pattern_31_BotNicheMarket` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        time_spent |-> time_spent
        ,niche_parsers |-> niche_parsers
        ,ai_oracles |-> ai_oracles
        ,b2b_mini_apps |-> b2b_mini_apps
        ,accumulated_profit |-> accumulated_profit
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_time_spentUnchanged |-> time_spent = time_spent'
        
        \* Format the `time_spent` variable as Json value.
        \* ,_time_spentJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(time_spent)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_time_spentModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].time_spent # _TETrace[s-1].time_spent
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE Pattern_31_BotNicheMarket_TETrace ----
\*EXTENDS IOUtils, TLC, Pattern_31_BotNicheMarket
\*
\*trace == IODeserialize("Pattern_31_BotNicheMarket_TTrace_1780182009.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_31_BotNicheMarket_TETrace ----
EXTENDS TLC, Pattern_31_BotNicheMarket

trace == 
    <<
    ([b2b_mini_apps |-> 0,niche_parsers |-> 0,ai_oracles |-> 0,accumulated_profit |-> 0,time_spent |-> 0]),
    ([b2b_mini_apps |-> 1,niche_parsers |-> 0,ai_oracles |-> 0,accumulated_profit |-> 1500,time_spent |-> 40]),
    ([b2b_mini_apps |-> 2,niche_parsers |-> 0,ai_oracles |-> 0,accumulated_profit |-> 3000,time_spent |-> 80]),
    ([b2b_mini_apps |-> 3,niche_parsers |-> 0,ai_oracles |-> 0,accumulated_profit |-> 4500,time_spent |-> 120]),
    ([b2b_mini_apps |-> 4,niche_parsers |-> 0,ai_oracles |-> 0,accumulated_profit |-> 6000,time_spent |-> 160]),
    ([b2b_mini_apps |-> 5,niche_parsers |-> 0,ai_oracles |-> 0,accumulated_profit |-> 7500,time_spent |-> 200]),
    ([b2b_mini_apps |-> 6,niche_parsers |-> 0,ai_oracles |-> 0,accumulated_profit |-> 9000,time_spent |-> 240]),
    ([b2b_mini_apps |-> 7,niche_parsers |-> 0,ai_oracles |-> 0,accumulated_profit |-> 10500,time_spent |-> 280])
    >>
----


=============================================================================

---- CONFIG Pattern_31_BotNicheMarket_TTrace_1780182009 ----
CONSTANTS
    PARSER_BUILD_TIME = 10
    PARSER_MONTHLY_PAY = 50
    TMA_BUILD_TIME = 40
    TMA_PROJECT_PRICE = 1500
    AI_BUILD_TIME = 30
    AI_MONTHLY_PAY = 100

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
\* Generated on Sun May 31 02:00:09 EEST 2026