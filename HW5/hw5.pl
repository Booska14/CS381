
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
schedule(X,Y,Z) :- when(C,Z), where(C,Y), enroll(X,C).

/* (B) */
usage(X,Y) :- when(C,Y), where(C,X).

/* (C) */
conflict(X,Y) :- where(X,Z), where(Y,Z), when(X,T), when(Y,T), X\=Y.

/* (D) */
meet(X,Y) :- 


/* Exercise 2 */


