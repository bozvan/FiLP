% Lab 6, task 5.
% gray(L, Code) returns the Gray code for N bits,
% where N is the length of list L.

:- use_module(library(plunit)).

my_append([], List, List).
my_append([Head | Tail], List, [Head | Result]) :-
    my_append(Tail, List, Result).

my_reverse([], []).
my_reverse([Head | Tail], Reversed) :-
    my_reverse(Tail, ReversedTail),
    my_append(ReversedTail, [Head], Reversed).

add_bit_to_all(_, [], []).
add_bit_to_all(Bit, [Code | Codes], [[Bit | Code] | Result]) :-
    add_bit_to_all(Bit, Codes, Result).

gray([], [[]]).
gray([_ | Tail], Code) :-
    gray(Tail, SmallerCode),
    my_reverse(SmallerCode, ReversedCode),
    add_bit_to_all(0, SmallerCode, ZeroPrefixed),
    add_bit_to_all(1, ReversedCode, OnePrefixed),
    my_append(ZeroPrefixed, OnePrefixed, Code).

% Example queries:
% ?- gray([0], Code).
% Code = [[0], [1]].
%
% ?- gray([0,0], Code).
% Code = [[0,0], [0,1], [1,1], [1,0]].
%
% ?- gray([x,x,x], Code).
% Code = [[0,0,0], [0,0,1], [0,1,1], [0,1,0],
%         [1,1,0], [1,1,1], [1,0,1], [1,0,0]].

:- begin_tests(lab6_task5).

test(gray_for_zero_bits,
     true(Code == [[]])) :-
    gray([], Code).

test(gray_for_one_bit,
     true(Code == [[0], [1]])) :-
    gray([0], Code).

test(gray_for_two_bits,
     true(Code == [[0,0], [0,1], [1,1], [1,0]])) :-
    gray([0,0], Code).

test(gray_for_three_bits,
     true(Code == [[0,0,0], [0,0,1], [0,1,1], [0,1,0],
                    [1,1,0], [1,1,1], [1,0,1], [1,0,0]])) :-
    gray([x,x,x], Code).

:- end_tests(lab6_task5).
