% Lab 6, task 2.
% starts_with(List1, List2) is true when List2 is a proper prefix of List1.

:- use_module(library(plunit)).

my_append([], List, List).
my_append([Head | Tail], List, [Head | Result]) :-
    my_append(Tail, List, Result).

starts_with(List1, List2) :-
    my_append(List2, [_ | _], List1).

% Example queries:
% ?- starts_with([a,b,c], X).
% X = [] ;
% X = [a] ;
% X = [a, b].
%
% ?- starts_with(X, [a,b]).
% X = [a, b, _A | _B].
%
% ?- starts_with([a,b], [a,b]).
% false.

:- begin_tests(lab6_task2).

test(generates_all_proper_prefixes,
     all(Prefix == [[], [a], [a, b]])) :-
    starts_with([a,b,c], Prefix).

test(known_prefix_succeeds) :-
    starts_with([a,b,c], [a,b]).

test(full_list_is_not_a_proper_prefix, fail) :-
    starts_with([a,b], [a,b]).

test(infers_longer_list_from_prefix) :-
    starts_with(List, [a,b]),
    assertion(List = [a, b | Rest]),
    assertion(Rest = [_ | _]).

:- end_tests(lab6_task2).
