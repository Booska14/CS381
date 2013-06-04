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
% define schedule(S,R,T)
schedule(S,R,T) :- enroll(S,X),when(X,T),where(X,R).
% define usage
usage(R,T) :- where(X,R), when(X,T).
% define conflict
conflict(X,Y) :- where(X,R) ,where(Y,R), when(X,T),when(Y,T),X\=Y.
% define meet
meet(X,Y) :- enroll(X,C), enroll(Y,C),X\=Y.
meet(X,Y) :- enroll(X,C1), enroll(Y,C2), where(C1,R), where(C2,R), when(C1,T1), when(C2,T2), (T1 is T2+1;T2 is T1+1).
% rdup
rdup([],[]).
rdup([X,X|Xs],Y) :- rdup([X|Xs],Y).
rdup([X,Y|Xs],[X|Zs]) :- X\=Y, rdup([Y|Xs], Zs).
rdup([X],[X]).
% flat
flat([],[]).
flat([X|Xs],Zs) :- flat(X,Y), flat(Xs,Ys), append(Y,Ys,Zs).
flat(X,[X]) :- X\=[_|_],X\=[].
% project
project(Xs,Ys,Zs) :- project(1,Xs,Ys,Zs).
project(C,[C|Xs],[Y|Ys], [Y|Zs]) :- C1 is C+1, project(C1,Xs,Ys,Zs),!.
project(C,[X|Xs],[_|Ys],Zs) :- C\=X, C1 is C+1, project(C1, [X|Xs],Ys,Zs),!.
project(_,[],_,[]).
project(_,_,[],[]).