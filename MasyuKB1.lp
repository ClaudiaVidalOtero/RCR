% Define the size of the grid
#const n = 3.
% Define the points in the grid
point(P) :- P = 0..n-1.
black(P) :- point(P).
white(P) :- point(P).
%los puntos negro y blanco equivalen a los black y white del problema original
negro((P/n, P\n)):- black(P).
blanco((P/n, P\n)):- white(P).

%los segmentos del problema original equivalen a nuestras aristas
seg(X*n+Y, X'*n+Y'):- arista((X,Y),(X',Y')).

% A blanco circle can be at any empty point except the corners
blanco(X,Y) :- point(X,Y).
% A negro circle can be at any empty point
negro(X,Y) :- point(X,Y).
% A point cannot be both blanco and negro
:- blanco(X,Y), negro(X,Y).

% Define the aristas of the path
arista((X,Y),(X',Y')) :- point(X,Y), point(X',Y'), adjacent((X,Y),(X',Y')).
%Las aristas de un nodo a otro son iguales, da igual su dirección.
arista(X,Y) :- arista(Y,X).


% Each blanco circle must be passed through in a straight line
:- blanco(X,Y), not straight(X,Y).
% There must be a turn in the previous or next point of each blanco circle
:- blanco(X,Y), not has_turned(X,Y).
% Each negro circle must be in the corner of a turn
:- negro(X,Y), not turn(X,Y).

% Define adjacency for a grid
adjacent((X,Y),(X+1,Y)) :- point(X,Y), point(X+1,Y), X < n.
adjacent((X,Y),(X-1,Y)) :- point(X,Y), point(X-1,Y), X > 1.
adjacent((X,Y),(X,Y+1)) :- point(X,Y), point(X,Y+1), Y < n.
adjacent((X,Y),(X,Y-1)) :- point(X,Y), point(X,Y-1), Y > 1.


% Define what it means for a point to be a "turn"
turn(X,Y) :- arista((X',Y'),(X,Y)), arista((X,Y),(X+1,Y-1)), point(X+1,Y-1).
turn(X,Y) :- arista((X',Y'),(X,Y)), arista((X,Y),(X+1,Y+1)), point(X+1,Y+1).
turn(X,Y) :- arista((X',Y'),(X,Y)), arista((X,Y),(X-1,Y-1)), point(X-1,Y-1).
turn(X,Y) :- arista((X',Y'),(X,Y)), arista((X,Y),(X-1,Y+1)), point(X-1,Y+1).

straight(X,Y) :- arista((X,Y),(W,Z)), arista((W,Z),(X2,Y2)), |X-Y| = |X2-Y2|, (X,Y) != (X2,Y2).

has_turned(X,Y) :- arista((X,Y),(X1,Y1)), turn(X1,Y1).
has_turned(X,Y) :- arista((X1,Y1),(X,Y)), turn(X1,Y1).

% The path must form a closed loop
% Define the minimum point

min_point(X,Y) :- X = #min{ X1 : point(X1,Y1) }, Y = #min{ Y1 : point(X1,Y1) }.

:- point(X,Y), #count{ (X',Y'): arista((X,Y),(X',Y')) } != 2.
