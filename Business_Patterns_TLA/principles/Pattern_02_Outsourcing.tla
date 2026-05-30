-------------------- MODULE Pattern_02_Outsourcing --------------------
EXTENDS Naturals, Integers

VARIABLES
    ceo_hours, 
    jun_hours,
    sales_closed, 
    servers_configured

vars == <<ceo_hours, jun_hours, sales_closed, servers_configured>>

TypeOK ==
    /\ ceo_hours \in Nat
    /\ jun_hours \in Nat
    /\ sales_closed \in Nat
    /\ servers_configured \in Nat

Init ==
    /\ ceo_hours = 10
    /\ jun_hours = 10
    /\ sales_closed = 0
    /\ servers_configured = 0

(* CEO может настраивать сервер быстрее Джуниора (1 час вместо 3) *)
CEO_ConfiguresServer ==
    /\ ceo_hours > 0
    /\ ceo_hours' = ceo_hours - 1
    /\ servers_configured' = servers_configured + 1
    /\ UNCHANGED <<jun_hours, sales_closed>>

(* Но CEO может продавать (1 час = 1 сделка). Джуниор не может продавать. *)
CEO_Sells ==
    /\ ceo_hours > 0
    /\ ceo_hours' = ceo_hours - 1
    /\ sales_closed' = sales_closed + 1
    /\ UNCHANGED <<jun_hours, servers_configured>>

(* Джуниор медленный, но его время стоит дешевле для бизнеса *)
Jun_ConfiguresServer ==
    /\ jun_hours >= 3
    /\ jun_hours' = jun_hours - 3
    /\ servers_configured' = servers_configured + 1
    /\ UNCHANGED <<ceo_hours, sales_closed>>

Next == CEO_ConfiguresServer \/ CEO_Sells \/ Jun_ConfiguresServer

Spec == Init /\ [][Next]_vars

(* Бизнес требует как минимум 3 сервера для работы. Остальное время - в продажи. *)
GoalNotReached == ~(servers_configured >= 3 /\ sales_closed >= 10)

=============================================================================