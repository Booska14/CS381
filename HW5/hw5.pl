/*
Conway Tang
CS381
Homework 5
*/

/* Exercise 1 */

when(275,10).
when(261,12).
when(381,11).
when(398,12).
when(399,12).

where(275,owen102).
where(261,dear118).
where(381,cov216).
where(398,dear118).
where(399,cov216).

enroll(mary,275).
enroll(john,275).
enroll(mary,261).
enroll(john,381).
enroll(jim,399).

/* (A) */
schedule(X,Y,Z) :- when(A,Z), where(A,Y), enroll(X,A).

/* (B) */
usage(X,Y) :- when(A,Y), where(A,X).

/* (C) */
conflict(X,Y) :- where(X,Z), where(Y,Z), when(X,A), when(Y,A), X\=Y.

/* (D) */
meet(X,Y) :- enroll(X,Z), enroll(Y,Z), X\=Y.
meet(X,Y) :- enroll(X,A), enroll(Y,B), where(A,C), where(B,C), when(A,D), when(B,E), D-E=:=1.
meet(X,Y) :- enroll(X,A), enroll(Y,B), where(A,C), where(B,C), when(A,D), when(B,E), E-D=:=1.


/* Exercise 2 */

/* (A) */
rdup([],[]).
rdup([H|T],Out) :- member(H,T), rdup(T,Out).
rdup([H|T],[H|Out]) :- not(member(H,T)), rdup(T,Out).

/* (B) */
flat([],[]).
flat([H|T],Out) :- flat(H,Out1), flat(T,Out2), append(Out1,Out2,Out).
flat(H,[H]).

/* (C) */
project([],[],[]) :- !.
project([H|T],[A|B],Out) :- H-1=\=0, decrement([H|T],X), project(X,B,Out).
project([H|T],[A|B],[A|Out]) :- H-1=:=0, decrement(T,X), project(X,B,Out).
project([],In,[]).

decrement([],[]) :- !.
decrement([X|Y],[A|Out]) :- A is X-1, decrement(Y,Out).
