/*
 * Бозванов Иван
 * ПИН - 33
 * Лабораторная работа №1
 * Вариант 4
 */

% 1. Функция num_roots(A, B, C) - определение числа корней квадратного уравнения
% ax^2 + bx + c = 0
num_roots(A, B, C, Roots) :-
    D is B*B - 4*A*C,
    (   A =:= 0 -> 
        (   B =:= 0 -> 
            (   C =:= 0 -> Roots = infinite  % oo
            ;   Roots = 0 )
        ;   Roots = 1 )
    ;
        (   D > 0 -> Roots = 2
        ;   D =:= 0 -> Roots = 1
        ;   Roots = 0
        )
    ).

% 2. Функция init(List) - список без последнего элемента
init([_], []).
init([H|T], [H|Result]) :-
    init(T, Result).

% 3. Функция split(List, N) - делит список на две части
split(List, 0, [], List).
split([H|T], N, [H|First], Rest) :-
    N > 0,
    N1 is N - 1,
    split(T, N1, First, Rest).

% 4. Функция binary_to_int(Bin) - перевод двоичной строки в число
binary_to_int(Bin, Result) :-
    atom_chars(Bin, Chars),
    (   Chars = ['-'|Rest] ->
        binary_to_int_positive(Rest, 0, Positive),
        Result is -Positive
    ;   binary_to_int_positive(Chars, 0, Result)
    ).
binary_to_int_positive([], Acc, Acc).
binary_to_int_positive([H|T], Acc, Result) :-
    atom_number(H, Digit),
    NewAcc is Acc * 2 + Digit,
    binary_to_int_positive(T, NewAcc, Result).

% 5. Функция sliding_average(List, WindowSize) - среднее
sliding_average(List, WindowSize, Averages) :-
    sliding_average_helper(List, WindowSize, Averages).
sliding_average_helper(List, WindowSize, [Avg|RestAverages]) :-
    length(List, Len),
    WindowSize =< Len, 
    sum_first_n(List, WindowSize, Sum),
    Avg is Sum / WindowSize,
    [_|T] = List,
    sliding_average_helper(T, WindowSize, RestAverages).
sliding_average_helper(_, _, []).

% Вспомогательная функция для суммы первых N элементов списка
sum_first_n(_, 0, 0) :- !.
sum_first_n([], _, 0) :- !.
sum_first_n([H|T], N, Sum) :-
    N > 0,
    N1 is N - 1,
    sum_first_n(T, N1, RestSum),
    Sum is H + RestSum.



% ДОПОЛНИТЕЛЬНОЕ ЗАДАНИЕ
% 6. Функция intersect(List1, List2) - нахождение общих элементов двух списков
intersect(List1, List2, Result) :-
    intersect_helper(List1, List2, [], Result).

intersect_helper([], _, Acc, Acc).                    
intersect_helper([H|T], List2, Acc, Result) :-
    (   member(H, List2) ->                          
        intersect_helper(T, List2, [H|Acc], Result)   
    ;   intersect_helper(T, List2, Acc, Result)
    ).


/*
 * (1)
 * num_roots(1, 0, -2, Roots).               % Ожидается: 2
 * num_roots(1, -6, 9, Roots).               % Ожидается: 1
 * num_roots(1, 0, 1, Roots).                % Ожидается: 0
 * num_roots(0, 2, -4, Roots).               % Ожидается: 1
 * num_roots(0, 0, 0, Roots).                % Ожидается: infinite
 * num_roots(0, 0, 5, Roots).                % Ожидается: 0
 * 
 * (2)
 * init([1, 2, 3, 4], Result).               % Ожидается: [1, 2, 3]
 * init([5], Result).                        % Ожидается: []
 * init([], Result).                         % Ожидается: false (или ошибка)
 * init(["a", "b", "c"], Result).            % Ожидается: ["a", "b"]
 * 
 * (3)
 * split([1, 3, 4, 5], 2, First, Rest).       % Ожидается: First=[1,3], Rest=[4,5]
 * split([1, 2, 3], 0, First, Rest).          % Ожидается: First=[], Rest=[1,2,3]
 * split([1, 2], 5, First, Rest).             % Ожидается: First=[1,2], Rest=[]
 * split([], 2, First, Rest).                 % Ожидается: First=[], Rest=[]
 *
 * (4)
 * binary_to_int("100", Result).              % Ожидается: 4
 * binary_to_int("-101", Result).             % Ожидается: -5
 * binary_to_int("0", Result).                % Ожидается: 0
 *
 * (5)
 * sliding_average([1, 2, 3, 4, 5, 6], 3, Averages).  % Ожидается: [2.0, 3.0, 4.0, 5.0]
 * sliding_average([1, 2, 3, 4], 2, Averages).        % Ожидается: [1.5, 2.5, 3.5]
 * sliding_average([10, 20, 30], 3, Averages).        % Ожидается: [20.0]
 *
 * (6)
 * intersect([1, 3, 2, 5], [2, 3, 4], Result).        % Ожидается: [2, 3]
 * intersect([1, 6, 5], [2, 3, 4], Result).           % Ожидается: []
 * intersect([1, 2, 3], [3, 2, 1], Result).           % Ожидается: [1, 2, 3] 
 * intersect([a, с, b], [b, c, d], Result).           % Ожидается: [b, c]
 */
