-------------------- MODULE Pattern_33_PassiveLevers --------------------
(*
ПАТТЕРН №33: Рычаги Пассивного Дохода.
Сравнение моделей на основе реальных кейсов ($23k-$60k/мес).

Инсайты из транскриптов:
- "Data Fetcher": Успех за счет интеграции в чужую платформу (Airtable).
- "Boring SaaS": Успех за счет решения скучных, неизменных проблем.
- "Programmatic SEO": Успех за счет автоматизации дистрибуции контента.
*)
EXTENDS Naturals, Integers

VARIABLES 
    maintenance_pool,  \* Часы поддержки в месяц (чем меньше, тем "пассивнее")
    revenue,           \* Месячный доход ($)
    growth_potential,  \* Потенциал масштабирования
    platform_risk      \* Риск, что платформу закроют или изменят правила

vars == <<maintenance_pool, revenue, growth_potential, platform_risk>>

TypeOK ==
    /\ maintenance_pool \in Nat
    /\ revenue \in Nat
    /\ growth_potential \in Nat
    /\ platform_risk \in 0..100

Init ==
    /\ maintenance_pool = 0
    /\ revenue = 0
    /\ growth_potential = 100
    /\ platform_risk = 0

(* Стратегия 1: Marketplace Add-on (типа Data Fetcher)
   Плюсы: Трафик дает сама платформа (Airtable/Google).
   Минусы: Высокий риск изменения API платформы.
*)
BuildMarketplaceAddon ==
    /\ revenue' = 5000
    /\ maintenance_pool' = 5 \* Низкая поддержка, UI на стороне платформы
    /\ platform_risk' = 70   \* В любой момент могут выкинуть из стора
    /\ growth_potential' = 80
    /\ UNCHANGED <<>>

(* Стратегия 2: Programmatic SEO (Авто-сайты)
   Плюсы: Почти 0 поддержки после индексации.
   Минусы: Сложный и долгий старт.
*)
BuildProgrammaticSEO ==
    /\ revenue' = 3000
    /\ maintenance_pool' = 1 \* Почти абсолютная пассивность
    /\ platform_risk' = 40   \* Риск только от апдейтов Google
    /\ growth_potential' = 100 \* Легко генерить миллионы страниц
    /\ UNCHANGED <<>>

(* Стратегия 3: Boring Micro-SaaS (типа конвертера PDF)
   Плюсы: Стабильность, вы решаете "вечную" проблему.
   Минусы: Нужно самому гнать трафик.
*)
BuildBoringSaaS ==
    /\ revenue' = 8000
    /\ maintenance_pool' = 15 \* Нужно отвечать в саппорт и фиксить баги
    /\ platform_risk' = 10    \* Полный контроль над кодом и базой
    /\ growth_potential' = 50
    /\ UNCHANGED <<>>

Next == 
    \/ BuildMarketplaceAddon 
    \/ BuildProgrammaticSEO 
    \/ BuildBoringSaaS

Spec == Init /\ [][Next]_vars

(* Коэффициент пассивности: доход на 1 час поддержки *)
PassiveRatio == IF maintenance_pool = 0 THEN 0 ELSE revenue \div maintenance_pool

(* ЦЕЛЬ: найти стратегию, где PassiveRatio > 2000 (т.е. $2000 за 1 час работы) *)
GoalNotReached == PassiveRatio < 2000

=============================================================================