% Lab 6, task 4.
% my_flatten(NestedList, FlattenedList) flattens a nested list.

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
