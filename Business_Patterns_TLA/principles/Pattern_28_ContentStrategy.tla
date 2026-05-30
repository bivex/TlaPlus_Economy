-------------------- MODULE Pattern_28_ContentStrategy --------------------
(*
Этот паттерн рассчитывает затраты ресурсов на контент-стратегию для 6 кейсов.
Моделирует "Триаду материалов" (Shorts, YouTube, Post) для каждого продукта.
*)
EXTENDS Naturals, Integers

VARIABLES 
    accounts_ready,    \* Флаг готовности всех аккаунтов (YT, ТГ, ТТ, LI)
    cases_shorts,      \* Количество созданных Shorts (0..6)
    cases_youtube,     \* Количество созданных Full Videos (0..6)
    cases_posts,       \* Количество созданных текстовых постов (0..6)
    total_hours,       \* Потраченное время
    warm_up_level      \* Уровень прогрева аудитории (KPI)

vars == <<accounts_ready, cases_shorts, cases_youtube, cases_posts, total_hours, warm_up_level>>

\* ВРЕМЕННЫЕ ЗАТРАТЫ (КОНСТАНТЫ)
CONSTANT SETUP_TIME         \* Настройка всех аккаунтов (5ч)
CONSTANT SHORTS_TIME        \* 1 ролик Shorts (2ч)
CONSTANT YOUTUBE_TIME       \* 1 обзор на YouTube (5ч)
CONSTANT POST_TIME          \* 1 экспертный пост (1ч)
CONSTANT MAX_CASES          \* 6

TypeOK ==
    /\ accounts_ready \in BOOLEAN
    /\ cases_shorts \in 0..MAX_CASES
    /\ cases_youtube \in 0..MAX_CASES
    /\ cases_posts \in 0..MAX_CASES
    /\ total_hours \in Nat
    /\ warm_up_level \in Nat

Init ==
    /\ accounts_ready = FALSE
    /\ cases_shorts = 0
    /\ cases_youtube = 0
    /\ cases_posts = 0
    /\ total_hours = 0
    /\ warm_up_level = 0

(* 1. Подготовка инфраструктуры (Один раз) *)
SetupAccounts ==
    /\ accounts_ready = FALSE
    /\ accounts_ready' = TRUE
    /\ total_hours' = total_hours + SETUP_TIME
    /\ warm_up_level' = warm_up_level + 5 \* Первые ссылки в профиле
    /\ UNCHANGED <<cases_shorts, cases_youtube, cases_posts>>

(* 2. Создание Shorts (Hook) *)
CreateShorts ==
    /\ accounts_ready = TRUE
    /\ cases_shorts < MAX_CASES
    /\ cases_shorts' = cases_shorts + 1
    /\ total_hours' = total_hours + SHORTS_TIME
    /\ warm_up_level' = warm_up_level + 10 \* Быстрый охват
    /\ UNCHANGED <<accounts_ready, cases_youtube, cases_posts>>

(* 3. Создание YouTube видео (Proof) *)
CreateYouTube ==
    /\ accounts_ready = TRUE
    /\ cases_youtube < MAX_CASES
    /\ cases_youtube' = cases_youtube + 1
    /\ total_hours' = total_hours + YOUTUBE_TIME
    /\ warm_up_level' = warm_up_level + 25 \* Глубокое доверие
    /\ UNCHANGED <<accounts_ready, cases_shorts, cases_posts>>

(* 4. Написание Поста (Value) *)
CreatePost ==
    /\ accounts_ready = TRUE
    /\ cases_posts < MAX_CASES
    /\ cases_posts' = cases_posts + 1
    /\ total_hours' = total_hours + POST_TIME
    /\ warm_up_level' = warm_up_level + 15 \* Социальное доказательство
    /\ UNCHANGED <<accounts_ready, cases_shorts, cases_youtube>>

Next == 
    \/ SetupAccounts 
    \/ CreateShorts 
    \/ CreateYouTube 
    \/ CreatePost

Spec == Init /\ [][Next]_vars

(* 
   Свойство: сколько часов нужно, чтобы закончить ВСЕ материалы 
   для всех 6 кейсов? 
   Мы ставим цель "Мы никогда не закончим", чтобы чекер нашел путь завершения.
*)
GoalNotReached == 
    ~(cases_shorts = MAX_CASES /\ cases_youtube = MAX_CASES /\ cases_posts = MAX_CASES)

=============================================================================