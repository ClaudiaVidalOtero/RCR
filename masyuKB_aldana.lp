
#const n = 6.
black(0;12;26).
white(10;13;22;23;31;34).

% Define puntos individuales en el tablero
point(P) :- P = 0..n*n-1.

% Define los círculos negros en términos de puntos individuales
black(P) :- point(P).
black_point(X, Y) :- black(P), X = (P - 1) / (n + 1), Y = (P - 1) \ n + 1.

% Define los círculos blancos en términos de puntos individuales
white(P) :- point(P).
white_point(X, Y) :- white(P), X = (P - 1) / (n + 1), Y = (P - 1) \ n + 1.

#show white_point/2.




%los segmentos del problema original equivalen a nuestras aristas
seg(X*n+Y, X'*n+Y'):- arista((X,Y),(X',Y')).

% A blanco circle can be at any empty point except the corners
blanco(X,Y) :- point(X,Y), not corner(X,Y).
% A negro circle can be at any empty point
negro(X,Y) :- point(X,Y).
% A point cannot be both blanco and negro
:- blanco(X,Y), negro(X,Y).

% Define the aristas of the path
arista((X,Y),(X',Y')) :- point(X,Y), point(X',Y'), adjacent((X,Y),(X',Y')).
%Las aristas de un nodo a otro son iguales, da igual su dirección.
arista(X,Y) :- arista(Y,X).
% Define the path based on the aristas
path(X,Y) :- arista((X,Y),(X',Y')).
path(X,Y) :- arista((X',Y'),(X,Y)).

% Each blanco circle must be passed through in a straight line
:- blanco(X,Y), not straight(X,Y).
% There must be a edge in the previous or next point of each blanco circle
:- blanco(X,Y), not edge_before(X,Y), not edge_after(X,Y).
% Each negro circle must be in the corner of a edge
:- negro(X,Y), not edge(X,Y).

% Define adjacency for a grid
adjacent((X,Y),(X+1,Y)) :- point(X,Y), point(X+1,Y), X < size.
adjacent((X,Y),(X-1,Y)) :- point(X,Y), point(X-1,Y), X > 1.
adjacent((X,Y),(X,Y+1)) :- point(X,Y), point(X,Y+1), Y < size.
adjacent((X,Y),(X,Y-1)) :- point(X,Y), point(X,Y-1), Y > 1.

% Define what it means for a point to be "straight"
straight(X,Y) :- point(X,Y), #count{ (X',Y'): arista((X,Y),(X',Y')) } = 2, 
#count{ (X',Y'): arista((X',Y'),(X,Y)) } = 2.

% Define what it means for a point to be a "edge"
edge(X,Y) :- point(X,Y), #count{ (X',Y'): arista((X,Y),(X',Y')) } = 2, 
#count{ (X',Y'): arista((X',Y'),(X,Y)) } != 2.

% Define what it means for a point to be a "edge before"
edge_before(X,Y) :- point(X,Y), #count{ (X',Y'): arista((X,Y),(X',Y')) } = 2,
#count{ (X',Y'): arista((X',Y'),(X,Y)) } = 1.  

% Define what it means for a point to be a "edge after"
edge_after(X,Y) :- point(X,Y), #count{ (X',Y'): arista((X,Y),(X',Y')) } = 1,
#count{ (X',Y'): arista((X',Y'),(X,Y)) } = 2.

% The path must form a closed loop
:- point(X,Y), #count{ (X',Y'): arista((X,Y),(X',Y')) } != 2.

% Check if the starting and ending points are connected to form a closed loop
:- not path(1,1), not path(1,1).
