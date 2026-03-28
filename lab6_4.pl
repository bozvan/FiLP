% Lab 6, task 4.
% my_flatten(NestedList, FlattenedList) flattens a nested list.

:- use_module(library(plunit)).

my_append([], List, List).
my_append([Head | Tail], List, [Head | Result]) :-
    my_append(Tail, List, Result).

my_flatten([], []).
my_flatten([Head | Tail], FlattenedList) :-
    my_flatten(Head, FlattenedHead),
    my_flatten(Tail, FlattenedTail),
    my_append(FlattenedHead, FlattenedTail, FlattenedList).
my_flatten(Item, [Item]) :-
    Item \= [],
    Item \= [_ | _].

% Example queries:
% ?- my_flatten([a, [[b], c], [[d]]], X).
% X = [a, b, c, d].
%
% ?- my_flatten([[a, [b]], [], [c, [d, e]]], X).
% X = [a, b, c, d, e].

:- begin_tests(lab6_task4).

test(flattens_example,
     true(Results == [[a, b, c, d]])) :-
    findall(Result, my_flatten([a, [[b], c], [[d]]], Result), Results).

test(flattens_mixed_nested_list,
     true(Results == [[a, b, c, d, e]])) :-
    findall(Result, my_flatten([[a, [b]], [], [c, [d, e]]], Result), Results).

test(empty_list_stays_empty,
     true(Results == [[]])) :-
    findall(Result, my_flatten([], Result), Results).

test(non_list_term_becomes_singleton_list,
     true(Result == [atom])) :-
    my_flatten(atom, Result).

:- end_tests(lab6_task4).
