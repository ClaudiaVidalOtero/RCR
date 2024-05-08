#const n=6.

black(P).
white(P).

negro((P/n, P\n)):- black(P).
blanco((P/n, P\n)):- white(P).

arista((X,Y), (X', Y')).
seg(X*n+Y, X'*n+Y'):- arista((X,Y),(X',Y')).

%Las aristas de un nodo a otro son iguales, da igual su dirección.
arista(X,Y) :- arista(Y,X).


%llegas si hay una arista que vaya allí: in(1,Y).
reach(X,Y) :- arista((1,1), (X,Y)).
reach(W, Z) :- reach(X,Y), arista((1,1),(Y,Z)).


%Todos los nodos son alcanzables desde el mínimo:
%cambiar mínimo......
:- vtx(Y), not reach(Y).



long(L) :- #count{A,B: arista(A,B):AcB} = L

3 {black(X,Y), edge(X,Y)} 3 :- X=!X, Y=!Y.

:- visitados(A), #count{B:arista(A,B)}, L = 2.