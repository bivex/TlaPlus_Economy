---- MODULE Pattern_28_ContentStrategy_TTrace_1780179596 ----
EXTENDS Sequences, TLCExt, Toolbox, Pattern_28_ContentStrategy, Naturals, TLC

_expression ==
    LET Pattern_28_ContentStrategy_TEExpression == INSTANCE Pattern_28_ContentStrategy_TEExpression
    IN Pattern_28_ContentStrategy_TEExpression!expression
----

_trace ==
    LET Pattern_28_ContentStrategy_TETrace == INSTANCE Pattern_28_ContentStrategy_TETrace
    IN Pattern_28_ContentStrategy_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        warm_up_level = (305)
        /\
        cases_youtube = (6)
        /\
        cases_posts = (6)
        /\
        cases_shorts = (6)
        /\
        accounts_ready = (TRUE)
        /\
        total_hours = (53)
    )
----

_init ==
    /\ cases_youtube = _TETrace[1].cases_youtube
    /\ warm_up_level = _TETrace[1].warm_up_level
    /\ cases_posts = _TETrace[1].cases_posts
    /\ accounts_ready = _TETrace[1].accounts_ready
    /\ total_hours = _TETrace[1].total_hours
    /\ cases_shorts = _TETrace[1].cases_shorts
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ cases_youtube  = _TETrace[i].cases_youtube
        /\ cases_youtube' = _TETrace[j].cases_youtube
        /\ warm_up_level  = _TETrace[i].warm_up_level
        /\ warm_up_level' = _TETrace[j].warm_up_level
        /\ cases_posts  = _TETrace[i].cases_posts
        /\ cases_posts' = _TETrace[j].cases_posts
        /\ accounts_ready  = _TETrace[i].accounts_ready
        /\ accounts_ready' = _TETrace[j].accounts_ready
        /\ total_hours  = _TETrace[i].total_hours
        /\ total_hours' = _TETrace[j].total_hours
        /\ cases_shorts  = _TETrace[i].cases_shorts
        /\ cases_shorts' = _TETrace[j].cases_shorts

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("Pattern_28_ContentStrategy_TTrace_1780179596.json", _TETrace)

=============================================================================

 Note that you can extract this module `Pattern_28_ContentStrategy_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `Pattern_28_ContentStrategy_TEExpression.tla` file takes precedence 
  over the module `Pattern_28_ContentStrategy_TEExpression` below).

---- MODULE Pattern_28_ContentStrategy_TEExpression ----
EXTENDS Sequences, TLCExt, Toolbox, Pattern_28_ContentStrategy, Naturals, TLC

expression == 
    [
        \* To hide variables of the `Pattern_28_ContentStrategy` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        cases_youtube |-> cases_youtube
        ,warm_up_level |-> warm_up_level
        ,cases_posts |-> cases_posts
        ,accounts_ready |-> accounts_ready
        ,total_hours |-> total_hours
        ,cases_shorts |-> cases_shorts
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_cases_youtubeUnchanged |-> cases_youtube = cases_youtube'
        
        \* Format the `cases_youtube` variable as Json value.
        \* ,_cases_youtubeJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(cases_youtube)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_cases_youtubeModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].cases_youtube # _TETrace[s-1].cases_youtube
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE Pattern_28_ContentStrategy_TETrace ----
\*EXTENDS IOUtils, Pattern_28_ContentStrategy, TLC
\*
\*trace == IODeserialize("Pattern_28_ContentStrategy_TTrace_1780179596.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE Pattern_28_ContentStrategy_TETrace ----
EXTENDS Pattern_28_ContentStrategy, TLC

trace == 
    <<
    ([warm_up_level |-> 0,cases_youtube |-> 0,cases_posts |-> 0,cases_shorts |-> 0,accounts_ready |-> FALSE,total_hours |-> 0]),
    ([warm_up_level |-> 5,cases_youtube |-> 0,cases_posts |-> 0,cases_shorts |-> 0,accounts_ready |-> TRUE,total_hours |-> 5]),
    ([warm_up_level |-> 15,cases_youtube |-> 0,cases_posts |-> 0,cases_shorts |-> 1,accounts_ready |-> TRUE,total_hours |-> 7]),
    ([warm_up_level |-> 25,cases_youtube |-> 0,cases_posts |-> 0,cases_shorts |-> 2,accounts_ready |-> TRUE,total_hours |-> 9]),
    ([warm_up_level |-> 35,cases_youtube |-> 0,cases_posts |-> 0,cases_shorts |-> 3,accounts_ready |-> TRUE,total_hours |-> 11]),
    ([warm_up_level |-> 45,cases_youtube |-> 0,cases_posts |-> 0,cases_shorts |-> 4,accounts_ready |-> TRUE,total_hours |-> 13]),
    ([warm_up_level |-> 55,cases_youtube |-> 0,cases_posts |-> 0,cases_shorts |-> 5,accounts_ready |-> TRUE,total_hours |-> 15]),
    ([warm_up_level |-> 65,cases_youtube |-> 0,cases_posts |-> 0,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 17]),
    ([warm_up_level |-> 90,cases_youtube |-> 1,cases_posts |-> 0,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 22]),
    ([warm_up_level |-> 115,cases_youtube |-> 2,cases_posts |-> 0,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 27]),
    ([warm_up_level |-> 140,cases_youtube |-> 3,cases_posts |-> 0,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 32]),
    ([warm_up_level |-> 165,cases_youtube |-> 4,cases_posts |-> 0,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 37]),
    ([warm_up_level |-> 190,cases_youtube |-> 5,cases_posts |-> 0,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 42]),
    ([warm_up_level |-> 215,cases_youtube |-> 6,cases_posts |-> 0,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 47]),
    ([warm_up_level |-> 230,cases_youtube |-> 6,cases_posts |-> 1,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 48]),
    ([warm_up_level |-> 245,cases_youtube |-> 6,cases_posts |-> 2,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 49]),
    ([warm_up_level |-> 260,cases_youtube |-> 6,cases_posts |-> 3,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 50]),
    ([warm_up_level |-> 275,cases_youtube |-> 6,cases_posts |-> 4,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 51]),
    ([warm_up_level |-> 290,cases_youtube |-> 6,cases_posts |-> 5,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 52]),
    ([warm_up_level |-> 305,cases_youtube |-> 6,cases_posts |-> 6,cases_shorts |-> 6,accounts_ready |-> TRUE,total_hours |-> 53])
    >>
----


=============================================================================

---- CONFIG Pattern_28_ContentStrategy_TTrace_1780179596 ----
CONSTANTS
    SETUP_TIME = 5
    SHORTS_TIME = 2
    YOUTUBE_TIME = 5
    POST_TIME = 1
    MAX_CASES = 6

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
\* Generated on Sun May 31 01:19:56 EEST 2026