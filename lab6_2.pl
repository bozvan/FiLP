% Lab 6, task 2.
% starts_with(List1, List2) is true when List2 is a proper prefix of List1.

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
