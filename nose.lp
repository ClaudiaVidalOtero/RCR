#const n = 6.
black(0;12;26).
white(10;13;22;23;31;34).

% Define puntos individuales en el tablero
point(P) :- P = 0..n*n-1.
border(P) :- P = X*n-1, X = 1..n.

seg(P1, P2) :- point(P1), point(P2), P2 = P1+1, not border(P1).
seg(P1, P2) :- point(P1), point(P2), P2 = P1-1, not border(P2).
seg(P1, P2) :- point(P1), point(P2), P2 = P1 + n.
seg(P1, P2) :- point(P1), point(P2), P2 = P1 - n.

seg(P1, P2) :- seg(P2, P1).

white(P) :- point(P), white(P).
black(P) :- point(P), black(P).
empty(P) :- point(P), not white(P), not black(P).

% Define turn. If we have an edge (2,3) with BLACK point, 
% the possible options on the path are (2+n, 3), i.e., turn up or down from the black point.

straight(P1, P2, P3) :- seg(P1, P2), seg(P2, P3), white(P2), P3 = P2 + 1.

turn(P1, P2, P3) :- seg(P1, P2), black(P2), P3 = P2 + 1, path(P2, P3).

blanco(X, Y) :- white(X), point(Y), seg(X, Y).
negro(X, Y) :- black(X), point(Y), seg(X, Y).

% Define un camino que cumpla con las reglas de los puntos blancos y negros

% Define un camino que cumpla con las reglas de los puntos blancos y negros
% Define un camino que cumpla con las reglas de los puntos blancos y negros
path(P1, P2) :- seg(P1, P2), blanco(P1), not white(P2).
path(P1, P2) :- seg(P1, P2), black(P1), not black(P2).
path(P1, P2) :- seg(P1, P2), path(P2, P3).


% Define a path as an edge
path(P1, P2) :- seg(P1, P2).


% Define reach. If we have an edge (X,Y) with WHITE point, 
% the possible options on the path are (X, Y+1), i.e., move up or down from the white point.
reach(Y) :- white(Y).
reach(Z) :- reach(Y), blanco(Y, Z).
reach(Z) :- path(Y, Z).

reachreach(Z) :- path(Y, Z).

% No puedes salir a dos nodos distintos, no puede bifurcar.
:- seg(X, Y), seg(X, Z), Y != Z.
% También no puedes entrar a dos nodos distintos.
:- seg(X, Y), seg(Z, Y), X != Z.


#show path/2.
#show blanco/2.
#show turn/3.

#show seg/2.