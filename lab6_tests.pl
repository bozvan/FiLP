% Common test runner for all Lab 6 tasks.
% Usage:
%   ?- [lab6_tests].
%   ?- test.
%
% or from the command line:
%   swipl -q -s lab6_tests.pl -g test -t halt

:- use_module(library(plunit)).
:- use_module(library(apply)).

lab6_test_file(lab6_task1, 'lab6_1.pl').
lab6_test_file(lab6_task2, 'lab6_2.pl').
lab6_test_file(lab6_task3, 'lab6_3.pl').
lab6_test_file(lab6_task4, 'lab6_4.pl').
lab6_test_file(lab6_task5, 'lab6_5.pl').

run_lab6_test_file(Unit, RelativeFile, Passed) :-
    absolute_file_name(RelativeFile, File),
    load_files(File, [if(changed)]),
    (   run_tests([Unit])
    ->  Passed = true
    ;   Passed = false
    ),
    unload_file(File).

test :-
    findall(
        Passed,
        (   lab6_test_file(Unit, RelativeFile),
            run_lab6_test_file(Unit, RelativeFile, Passed)
        ),
        Results
    ),
    maplist(=(true), Results).
