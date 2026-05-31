---------------------------- MODULE Pattern_34_IndieSteamStudio ----------------------------
(*
Pattern 34: Indie Game Studio Economics on Steam
Data source: Steam Spy API (steamspy.com), May 2026
61,485 indie games analyzed. All values in DOLLARS (not cents).

3 strategies: Micro (fast/cheap), Quality (median indie), Premium (hit)
Steam Spy: median indie price $4.99, median owners 10K, positive ratio 76.1%
*)
EXTENDS Naturals, Integers

CONSTANT MICRO_DEV_MONTHS,
         MICRO_DEV_COST,
         MICRO_PRICE,
         MICRO_SALES,

         QUALITY_DEV_MONTHS,
         QUALITY_DEV_COST,
         QUALITY_PRICE,
         QUALITY_SALES,

         PREMIUM_DEV_MONTHS,
         PREMIUM_DEV_COST,
         PREMIUM_PRICE,
         PREMIUM_SALES,

         STEAM_CUT,
         MONTHS_AVAILABLE

VARIABLES months_passed,
           cash,
           micro_games,
           quality_games,
           premium_games,
           total_revenue

TypeOK ==
    /\ months_passed \in Nat
    /\ cash \in Int
    /\ micro_games \in Nat
    /\ quality_games \in Nat
    /\ premium_games \in Nat
    /\ total_revenue \in Int

Init ==
    /\ months_passed = 0
    /\ cash = 0
    /\ micro_games = 0
    /\ quality_games = 0
    /\ premium_games = 0
    /\ total_revenue = 0

\* Net revenue after Steam cut (all values in dollars)
\* STEAM_CUT = 30 means 30% cut
NetRev(price, copies) ==
    (price * copies * (100 - STEAM_CUT)) \div 100

(* STRATEGY 1: Micro Game — 2 months, $500 cost, $2.99, 3K sales *)
MakeMicro ==
    /\ months_passed + MICRO_DEV_MONTHS <= MONTHS_AVAILABLE
    /\ months_passed' = months_passed + MICRO_DEV_MONTHS
    /\ micro_games' = micro_games + 1
    /\ LET rev == NetRev(MICRO_PRICE, MICRO_SALES)
       IN  /\ cash' = cash - MICRO_DEV_COST + rev
            /\ total_revenue' = total_revenue + rev
    /\ UNCHANGED <<quality_games, premium_games>>

(* STRATEGY 2: Quality Indie — 9 months, $8K cost, $14.99, 10K sales *)
MakeQuality ==
    /\ months_passed + QUALITY_DEV_MONTHS <= MONTHS_AVAILABLE
    /\ months_passed' = months_passed + QUALITY_DEV_MONTHS
    /\ quality_games' = quality_games + 1
    /\ LET rev == NetRev(QUALITY_PRICE, QUALITY_SALES)
       IN  /\ cash' = cash - QUALITY_DEV_COST + rev
            /\ total_revenue' = total_revenue + rev
    /\ UNCHANGED <<micro_games, premium_games>>

(* STRATEGY 3: Premium Indie — 18 months, $30K cost, $29.99, 25K sales *)
MakePremium ==
    /\ months_passed + PREMIUM_DEV_MONTHS <= MONTHS_AVAILABLE
    /\ months_passed' = months_passed + PREMIUM_DEV_MONTHS
    /\ premium_games' = premium_games + 1
    /\ LET rev == NetRev(PREMIUM_PRICE, PREMIUM_SALES)
       IN  /\ cash' = cash - PREMIUM_DEV_COST + rev
            /\ total_revenue' = total_revenue + rev
    /\ UNCHANGED <<micro_games, quality_games>>

(* Long tail: monthly passive income from released games *)
TailMonth ==
    /\ months_passed < MONTHS_AVAILABLE
    /\ months_passed' = months_passed + 1
    /\ LET tail_units == ((micro_games * MICRO_SALES) \div 12)
                       + ((quality_games * QUALITY_SALES) \div 12)
                       + ((premium_games * PREMIUM_SALES) \div 12)
           tail_rev  == NetRev(5, tail_units)
       IN  /\ cash' = cash + tail_rev
            /\ total_revenue' = total_revenue + tail_rev
    /\ UNCHANGED <<micro_games, quality_games, premium_games>>

Next ==
    \/ MakeMicro
    \/ MakeQuality
    \/ MakePremium
    \/ TailMonth
    \/ UNCHANGED <<months_passed, cash, micro_games, quality_games, premium_games, total_revenue>>

Spec == Init /\ [][Next]_<<months_passed, cash, micro_games, quality_games, premium_games, total_revenue>>

(* GOAL: $100K profit in 3 years *)
GoalNotReached == cash < 100000

NoBankruptcy == cash >= -50000

=============================================================================
