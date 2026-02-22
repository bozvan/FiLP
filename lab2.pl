pair(X, Y, (X, Y)).
double(X, R) :- R is X * 2.
square(X, R) :- R is X * X.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. min_positive_number(List, Result)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

min_positive_number(List, Result) :-
    include(is_positive_number, List, Positives),
    ( Positives = [] ->
        Result = error
    ;
        min_list(Positives, Result)
    ).

is_positive_number(X) :-
    number(X),
    X > 0.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. zipwith(F, List1, List2, Result)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

zipwith(_, [], [], []).
zipwith(F, [X|Xs], [Y|Ys], [R|Rs]) :-
    call(F, X, Y, R),
    zipwith(F, Xs, Ys, Rs).
zipwith(_, [], [_|_], _) :-
    throw(error(different_length_lists)).
zipwith(_, [_|_], [], _) :-
    throw(error(different_length_lists)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3. iteratemap(F, X0, N, Result)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iteratemap(_, _, 0, []).
iteratemap(F, X, N, [X|Rest]) :-
    N > 0,
    N1 is N - 1,
    call(F, X, Next),
    iteratemap(F, Next, N1, Rest).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 4. diff(F, DX, X, Result)
%% Центральная разностная формула
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diff(F, DX, X, Result) :-
    X1 is X + DX,
    X2 is X - DX,
    call(F, X1, F1),
    call(F, X2, F2),
    Result is (F1 - F2) / (2 * DX).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 5. for(Init, Cond, Step, Body)
%%
%% Реализация цикла:
%% for (I = Init; Cond(I); I = Step(I)) { Body(I) }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cond_less_5(I) :- I < 5.
step_plus_1(I, Next) :- Next is I + 1.
body_print(I) :- writeln(I).


for(Init, Cond, Step, Body) :-
    call(Cond, Init),
    !,
    call(Body, Init),
    call(Step, Init, Next),
    for(Next, Cond, Step, Body).
for(_, _, _, _).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 6. sortBy(Comparator, List, Sorted)
%%
%% Используется сортировка слиянием (merge sort)
%% Хорошо подходит для списков в Prolog
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Компаратор для чисел по возрастанию
num_compare(X, Y, less)    :- X < Y.
num_compare(X, Y, equal)   :- X =:= Y.
num_compare(X, Y, greater) :- X > Y.

% Компаратор по убыванию
num_compare_desc(X, Y, less)    :- X > Y.
num_compare_desc(X, Y, equal)   :- X =:= Y.
num_compare_desc(X, Y, greater) :- X < Y.

sortBy(_, [], []).
sortBy(_, [X], [X]).
sortBy(Comp, List, Sorted) :-
    List = [_,_|_],                 % минимум 2 элемента
    split(List, L1, L2),
    sortBy(Comp, L1, S1),
    sortBy(Comp, L2, S2),
    merge(Comp, S1, S2, Sorted).


%% Разделение списка пополам

split([], [], []).
split([X], [X], []).
split([X,Y|Rest], [X|L1], [Y|L2]) :-
    split(Rest, L1, L2).


%% Слияние двух отсортированных списков

merge(_, [], L, L).
merge(_, L, [], L).
merge(Comp, [X|Xs], [Y|Ys], [X|Rest]) :-
    call(Comp, X, Y, Res),
    (Res = less ; Res = equal),
    !,
    merge(Comp, Xs, [Y|Ys], Rest).
merge(Comp, [X|Xs], [Y|Ys], [Y|Rest]) :-
    merge(Comp, [X|Xs], Ys, Rest).
