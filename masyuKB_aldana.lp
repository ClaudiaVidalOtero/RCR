
% Definición del tamaño del grid y puntos en el grid
% --------------------------------------------------

#const size = 3.  % Define el tamaño del grid
point(1..size,1..size).  % Define los puntos en el grid

% Define los puntos en las esquinas del grid
corner(1,1).
corner(1,size).
corner(size,1).
corner(size,size).


% Definición de los círculos blanco y negro
% -----------------------------------------

% Los puntos blanco y negro equivalen a los puntos blancos y negros del problema original
negro((P/n, P\n)):- black(P).
blanco((P/n, P\n)):- white(P).


% Definición de las aristas y segmentos
% --------------------------------------

% Los segmentos del problema original equivalen a nuestras aristas.
arista((X,Y),(X',Y')) :- seg(X*n+Y, X'*n+Y').

% Define las aristas del camino
arista((X,Y),(X',Y')) :- point(X,Y), point(X',Y'), adjacent((X,Y),(X',Y')).

% Las aristas de un nodo a otro son iguales, sin importar su dirección.
arista(X,Y) :- arista(Y,X).


% Restricciones del camino
% ------------------------

% Define el camino basado en las aristas
path(X,Y) :- arista((X,Y),(X',Y')).
path(X,Y) :- arista((X',Y'),(X,Y)).

% Cada círculo blanco debe ser atravesado en línea recta
:- blanco(X,Y), not straight(X,Y).

% Debe haber un giro en el punto anterior o siguiente de cada círculo blanco
:- blanco(X,Y), not turn_before(X,Y), not turn_after(X,Y).

% Cada círculo negro debe estar en la esquina de un giro
:- negro(X,Y), not turn(X,Y).


% Definición de la conectividad del grid
% ---------------------------------------

% Define la adyacencia para el grid
adjacent((X,Y),(X+1,Y)) :- point(X,Y), point(X+1,Y), X < size.
adjacent((X,Y),(X-1,Y)) :- point(X,Y), point(X-1,Y), X > 1.
adjacent((X,Y),(X,Y+1)) :- point(X,Y), point(X,Y+1), Y < size.
adjacent((X,Y),(X,Y-1)) :- point(X,Y), point(X,Y-1), Y > 1.


% Restricciones adicionales del camino
% -------------------------------------

% Cada punto debe ser parte de exactamente dos aristas (excepto los puntos en las esquinas)
:- point(X,Y), #count{ (X',Y'): arista((X,Y),(X',Y')) } != 2.

% Verifica si el punto de inicio y fin están conectados para formar un bucle cerrado
:- not path(1,1), not path(1,1).




