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


/* (B) */


/* (C) */
