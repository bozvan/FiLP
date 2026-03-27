% Facts: fathers
father(nikolai, ivan).
father(nikolai, peter).
father(nikolai, alex).
father(ivan, sergey).
father(peter, anna).
father(peter, michael).
father(alex, kate).
father(alex, dima).

% Facts: married couples
married(nikolai, olga).
married(ivan, maria).
married(peter, elena).
married(alex, natalie).

% Facts: gender
male(nikolai).
male(ivan).
male(peter).
male(alex).
male(sergey).
male(michael).
male(dima).

female(olga).
female(maria).
female(elena).
female(natalie).
female(anna).
female(kate).

% Task 4:
mother(Wife, Child) :-
    father(Husband, Child),
    married(Husband, Wife).

parent(Parent, Child) :-
    father(Parent, Child).
parent(Parent, Child) :-
    mother(Parent, Child).

siblings(X, Y) :-
    father(Father, X),
    father(Father, Y),
    mother(Mother, X),
    mother(Mother, Y),
    X \= Y.

% Task 5:
cousin_brothers(X, Y) :-
    male(X),
    male(Y),
    parent(ParentX, X),
    parent(ParentY, Y),
    siblings(ParentX, ParentY),
    X \= Y.
