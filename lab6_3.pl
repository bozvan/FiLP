% Lab 6, task 3.
% replace(List, Member, Replacement, ResultList) replaces
% all occurrences of Member in List with Replacement.
%
% Note: according to the task text, replacing 1 with 5 in
% [1,2,3,1,2,3] should produce [5,2,3,5,2,3].
% The sample [1,2,5,1,2,5] appears to contain a typo.

replace([], _, _, []).
replace([Head | Tail], Member, Replacement, [Replacement | ResultTail]) :-
    Head = Member,
    replace(Tail, Member, Replacement, ResultTail).
replace([Head | Tail], Member, Replacement, [Head | ResultTail]) :-
    dif(Head, Member),
    replace(Tail, Member, Replacement, ResultTail).

% Example queries:
% ?- replace([1,2,3,1,2,3], 1, 5, X).
% X = [5,2,3,5,2,3].
%
% ?- replace([1,2,1], What, 5, [5,2,5]).
% What = 1.
%
% ?- replace(List, 1, 5, [5,2,3]).
% List = [1,2,3] ;
% List = [5,2,3].
