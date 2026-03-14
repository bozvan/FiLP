/*
 * Бозванов Иван
 * ПИН - 33
 * Лабораторная работа №3
 * Вариант 4
 */
% 1. Подсчёт листьев бинарного дерева
% дерево представляется так:
% empty
% node(Value, Left, Right)

count_leaves(empty, 0).
count_leaves(node(_, empty, empty), 1).
count_leaves(node(_, L, R), Count) :-
    count_leaves(L, CL),
    count_leaves(R, CR),
    Count is CL + CR.



% 2. Интерфейс очереди с приоритетом
% Реализация 1 — неупорядоченный список
% очередь = [(Priority,Value), ...]

empty_q([]).
push(Q, Value, Priority, [(Priority,Value)|Q]).

% поиск минимального элемента
find_min([(P,V)], P, V).
find_min([(P,V)|T], MinP, MinV) :-
    find_min(T, P2, V2),
    ( P =< P2 ->
        (MinP = P, MinV = V)
    ;
        (MinP = P2, MinV = V2)
    ).

% удаление одного элемента
remove_one((P,V), [(P,V)|T], T).
remove_one(E, [H|T], [H|T2]) :-
    remove_one(E, T, T2).

pop(Q, Value, Priority, RestQ) :-
    find_min(Q, Priority, Value),
    remove_one((Priority,Value), Q, RestQ).


% 3. to_list
to_list([], []).
to_list(Q, [V|Rest]) :-
    pop(Q, V, _, Q2),
    to_list(Q2, Rest).


% 4. Реализация 2 — отсортированный список
empty_q2([]).

push2([], V, P, [(P,V)]).
push2([(P1,V1)|T], V, P, [(P,V),(P1,V1)|T]) :-
    P =< P1.
push2([(P1,V1)|T], V, P, [(P1,V1)|T2]) :-
    P > P1,
    push2(T, V, P, T2).
pop2([(P,V)|T], V, P, T).


% to_list для второй реализации
to_list2([], []).
to_list2([(_,V)|T], [V|Rest]) :-
    to_list2(T, Rest).


/*
 * ==== Проверка дерева ====
 * count_leaves(empty, C).
 * T = node(1, node(2, empty, empty), node(3, empty, empty)),
   count_leaves(T, C).
 * T = node(1,
        node(2, node(4,empty,empty), node(5,empty,empty)),
        node(3, empty, empty)),
   count_leaves(T, C).
 * 
 * 
 * === Проверка очереди (1 реализация) ===
 * empty_q(Q),
   push(Q, a, 3, Q1),
   push(Q1, b, 1, Q2),
   push(Q2, c, 2, Q3),
   to_list(Q3, L).
 * empty_q(Q),
   push(Q, x, 5, Q1),
   push(Q1, y, 2, Q2),
   push(Q2, z, 1, Q3),
   pop(Q3, V, P, Q4).
 * 
 * 
 * === Проверка второй реализации ===
 * empty_q2(Q),
   push2(Q, a, 3, Q1),
   push2(Q1, b, 1, Q2),
   push2(Q2, c, 2, Q3),
   to_list2(Q3, L).
 * 
 * 
 * 
 * Алгоритмическая сложность
 * Реализация 1 (неупорядоченный список)
    push	O(1)
    pop	O(n)
    to_list	O(n²)
 * 
 * Реализация 2 (отсортированный список)
    push	O(n)
    pop	O(1)
    to_list	O(n)
 * 
 * */
