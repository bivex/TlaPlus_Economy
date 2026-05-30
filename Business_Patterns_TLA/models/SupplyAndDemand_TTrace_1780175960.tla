---- MODULE SupplyAndDemand_TTrace_1780175960 ----
EXTENDS Sequences, TLCExt, Toolbox, SupplyAndDemand, Naturals, TLC

_expression ==
    LET SupplyAndDemand_TEExpression == INSTANCE SupplyAndDemand_TEExpression
    IN SupplyAndDemand_TEExpression!expression
----

_trace ==
    LET SupplyAndDemand_TETrace == INSTANCE SupplyAndDemand_TETrace
    IN SupplyAndDemand_TETrace!trace
----

_inv ==
    ~(
        TLCGet("level") = Len(_TETrace)
        /\
        price = (5)
        /\
        quantity_supplied = (10)
        /\
        market_status = ("Equilibrium")
        /\
        quantity_demanded = (10)
    )
----

_init ==
    /\ price = _TETrace[1].price
    /\ market_status = _TETrace[1].market_status
    /\ quantity_demanded = _TETrace[1].quantity_demanded
    /\ quantity_supplied = _TETrace[1].quantity_supplied
----

_next ==
    /\ \E i,j \in DOMAIN _TETrace:
        /\ \/ /\ j = i + 1
              /\ i = TLCGet("level")
        /\ price  = _TETrace[i].price
        /\ price' = _TETrace[j].price
        /\ market_status  = _TETrace[i].market_status
        /\ market_status' = _TETrace[j].market_status
        /\ quantity_demanded  = _TETrace[i].quantity_demanded
        /\ quantity_demanded' = _TETrace[j].quantity_demanded
        /\ quantity_supplied  = _TETrace[i].quantity_supplied
        /\ quantity_supplied' = _TETrace[j].quantity_supplied

\* Uncomment the ASSUME below to write the states of the error trace
\* to the given file in Json format. Note that you can pass any tuple
\* to `JsonSerialize`. For example, a sub-sequence of _TETrace.
    \* ASSUME
    \*     LET J == INSTANCE Json
    \*         IN J!JsonSerialize("SupplyAndDemand_TTrace_1780175960.json", _TETrace)

=============================================================================

 Note that you can extract this module `SupplyAndDemand_TEExpression`
  to a dedicated file to reuse `expression` (the module in the 
  dedicated `SupplyAndDemand_TEExpression.tla` file takes precedence 
  over the module `SupplyAndDemand_TEExpression` below).

---- MODULE SupplyAndDemand_TEExpression ----
EXTENDS Sequences, TLCExt, Toolbox, SupplyAndDemand, Naturals, TLC

expression == 
    [
        \* To hide variables of the `SupplyAndDemand` spec from the error trace,
        \* remove the variables below.  The trace will be written in the order
        \* of the fields of this record.
        price |-> price
        ,market_status |-> market_status
        ,quantity_demanded |-> quantity_demanded
        ,quantity_supplied |-> quantity_supplied
        
        \* Put additional constant-, state-, and action-level expressions here:
        \* ,_stateNumber |-> _TEPosition
        \* ,_priceUnchanged |-> price = price'
        
        \* Format the `price` variable as Json value.
        \* ,_priceJson |->
        \*     LET J == INSTANCE Json
        \*     IN J!ToJson(price)
        
        \* Lastly, you may build expressions over arbitrary sets of states by
        \* leveraging the _TETrace operator.  For example, this is how to
        \* count the number of times a spec variable changed up to the current
        \* state in the trace.
        \* ,_priceModCount |->
        \*     LET F[s \in DOMAIN _TETrace] ==
        \*         IF s = 1 THEN 0
        \*         ELSE IF _TETrace[s].price # _TETrace[s-1].price
        \*             THEN 1 + F[s-1] ELSE F[s-1]
        \*     IN F[_TEPosition - 1]
    ]

=============================================================================



Parsing and semantic processing can take forever if the trace below is long.
 In this case, it is advised to uncomment the module below to deserialize the
 trace from a generated binary file.

\*
\*---- MODULE SupplyAndDemand_TETrace ----
\*EXTENDS IOUtils, SupplyAndDemand, TLC
\*
\*trace == IODeserialize("SupplyAndDemand_TTrace_1780175960.bin", TRUE)
\*
\*=============================================================================
\*

---- MODULE SupplyAndDemand_TETrace ----
EXTENDS SupplyAndDemand, TLC

trace == 
    <<
    ([price |-> 2,quantity_supplied |-> 4,market_status |-> "Shortage",quantity_demanded |-> 16]),
    ([price |-> 3,quantity_supplied |-> 6,market_status |-> "Shortage",quantity_demanded |-> 14]),
    ([price |-> 4,quantity_supplied |-> 8,market_status |-> "Shortage",quantity_demanded |-> 12]),
    ([price |-> 5,quantity_supplied |-> 10,market_status |-> "Equilibrium",quantity_demanded |-> 10])
    >>
----


=============================================================================

---- CONFIG SupplyAndDemand_TTrace_1780175960 ----

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
\* Generated on Sun May 31 00:19:20 EEST 2026