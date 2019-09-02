
% CPSC 449 - T01 Assignment 1
% Shah Farzan Al-Hafiz
% 10162590


%1 and 2 are on the pdf file.


%3

odd(suc(zero)).
odd(suc(suc(X))) :-
    odd(X).




%4 (explanation on the text file)

ltReflexive(X, Y) :-
    lt(X, X).
ltSymmetric(X, Y) :-
    lt(X, Y), lt(Y, X).
ltTransitive(X, Z) :-
    lt(X, Y), lt(Y, Z).
ltAntisymmetric(X, Y) :-
    lt(X, Y), lt(Y, X), ltReflexive(X, Y).




%5

%5.1
app([], X, X).
app([H|L1], X, [H|L2]) :-
    app(L1, X, L2)

%5.2
reversed([],[]).
reversed([H|T], L1) :-
    reversed(T, L2), app(L2, [H], L1).

%5.3
palindromic(L) :-
    reversed(L, L).

%5.4
subset1(_,[]).
subset1([H|L],[H|LS]) :-
    subset1(L,LS).
subset(_,[]).
subset([H|L],[H|LS]) :-
    subset1(L,LS).
subset([_|L], LS) :-
    subset(L,LS).
subset2(L, LS):-
setof(X, subset(L, X), LS).

%5.5
permutationList([], []).
permutationList([X], [X]) :- !.
permutationList([T|H], X) :-
    permutationList(H, H1), app(L1, L2, H1), app(L1, [T], X1), app(X1, L2, X).
permutationList1(L, LS) :-
    setof(X, permutationList(L, X), LS).




%6

gcd(0, N, N).
gcd(M, M, M).
gcd(M, N, D) :-
    M > N, X is M - N, gcd(N, X, D).
gcd(M, N, D) :-
    M < N, X is N - M, gcd(X, M, D)

divisible(A, B) :-
    0 is A mod B.
divisible(A, B) :-
    B < A-1, divisible(B, Y+1).
prime(2) :- !.
prime(3) :- !.
prime(A) :-
    A > 3, not(divisible(A, 2)).



%7

%7.1
changeLabel(_, _, X, X).
changeLabel(X,Y, node(X, X1, X2),node(Y, Y1, Y2)) :-
    changeLabel(X,Y, X1, Y1), changeLabel(X, Y, X2, Y2).




%8

%PP09
%Take the element X and transfer to the output sublist. If X and Y are not equal then the 2
%intermediary elements has to have the same head. When there are no more Xs in the head of the
%first two sets you put X as the fourth argument. But if the element that is to be transferred is
%different than X, then transfer X.

%PP19
%If we want to rotate positive N numbers to the left, we first find the length and use the module
%to rotate. This guarantees that we are not going beyond the length of the list and actually 
%rotating back. If the numbers are negative, it rotates the list to the right and also makes sure
%the last element of the list is rotated back to the beginning of the list. The last two lines just
%splits the list into two sublists at some element N. Then appends them in the order.



%9.1, 9.2, 9.3, 9.4
parents(X, Y) :-
    mom(X, Y).
parents(X, Y) :-
    dad(X, Y).
married(X, Y) :-
    married(Y, Z), Z = X, !.
siblings(X, Y) :-
    parents(Z, X), parents(Z, Y), X \= Y.
grandparents(X, Y) :-
    parents(Z, Y), parents(X, Z).
uncleOrAunt(X, Y) :-
    parents(Z, Y), siblings(Z,X).
cousins(X,Y) :-
    uncleOrAunt(Z,X), parents(Z,Y).
descendents(X, Y):-
    parents(Y, X).
descendents(X, Y):-
    parents(Z, X),descendents(Z, Y).
ancestors(X, Y) :-
    descendents(Y, X).
relative_of(X, Y) :-
    ancestors(X, Y).
relative_of(X, Y) :-
    ancestors(Y, X).
relative_of(X, Y) :-
    (ancestors(Z, X), ancestors(Z, Y)), X \= Y.
extended_relative(X, Y) :-
    married(M, F), relative_of(X, M), relative_of(Y, F)
wealthy_relative(X, Y):-
    extended_relative(X,Y), wealthy(X).
