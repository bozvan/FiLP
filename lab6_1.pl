% Lab 6, task 1.
% Call trees for:
%   ?- predok_potomok(alexey, X).
%   ?- my_append([a,b,c], List, [Head | Tail]).
%
% The file also contains the predicates used in the trees
% so the queries can be reproduced in SWI-Prolog.

:- use_module(library(plunit)).

parent(alexey, boris).
parent(alexey, viktor).
parent(boris, galina).
parent(boris, dmitriy).
parent(viktor, elena).

predok_potomok(X, Y) :-
    parent(X, Y).
predok_potomok(X, Y) :-
    parent(X, Z),
    predok_potomok(Z, Y).

my_append([], List, List).
my_append([Head | Tail], List, [Head | Result]) :-
    my_append(Tail, List, Result).

% Query 1 call tree:
%
% predok_potomok(alexey, X)
% |- parent(alexey, X)                  => X = boris ; X = viktor
% `- parent(alexey, Z), predok_potomok(Z, X)
%    |- Z = boris
%    |  `- predok_potomok(boris, X)
%    |     |- parent(boris, X)          => X = galina ; X = dmitriy
%    |     `- parent(boris, Z1), predok_potomok(Z1, X)
%    |        |- Z1 = galina            => fail
%    |        `- Z1 = dmitriy           => fail
%    `- Z = viktor
%       `- predok_potomok(viktor, X)
%          |- parent(viktor, X)         => X = elena
%          `- parent(viktor, Z1), predok_potomok(Z1, X)
%             `- Z1 = elena             => fail
%
% Answers in search order:
% X = boris ; X = viktor ; X = galina ; X = dmitriy ; X = elena.
%
% Query 2 call tree:
%
% my_append([a,b,c], List, [Head | Tail])
% `- second clause of my_append/3
%    |- Head = a
%    `- my_append([b,c], List, Tail1), Tail = Tail1
%       `- second clause of my_append/3
%          |- Tail1 = [b | Tail2]
%          `- my_append([c], List, Tail2)
%             `- second clause of my_append/3
%                |- Tail2 = [c | Tail3]
%                `- my_append([], List, Tail3)
%                   `- first clause of my_append/3
%                      `- Tail3 = List
%
% Final bindings:
% Head = a,
% Tail = [b, c | List].

:- begin_tests(lab6_task1).

test(predok_potomok_answers,
     true(Descendants == [boris, viktor, galina, dmitriy, elena])) :-
    findall(X, predok_potomok(alexey, X), Descendants).

test(predok_potomok_leaf_has_no_descendants, fail) :-
    predok_potomok(elena, _).

test(my_append_query_bindings) :-
    my_append([a,b,c], List, [Head | Tail]),
    assertion(Head == a),
    assertion(var(List)),
    assertion(Tail =@= [b, c | List]).

:- end_tests(lab6_task1).
