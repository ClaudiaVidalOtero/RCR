% Define the size of the grid
#const size = 3.
% Define the points in the grid
point(1..size,1..size).
% Define the corners of the grid
corner(1,1).
corner(1,size).
corner(size,1).
corner(size,size).
% A white circle can be at any empty point except the corners
white(X,Y) :- point(X,Y), not corner(X,Y).
% A black circle can be at any empty point
black(X,Y) :- point(X,Y).
% A point cannot be both white and black
:- white(X,Y), black(X,Y).

% Define the segments of the path
seg((X,Y),(X',Y')) :- point(X,Y), point(X',Y'), adjacent((X,Y),(X',Y')).
% Define the path based on the segments
path(X,Y) :- seg((X,Y),(X',Y')).
path(X,Y) :- seg((X',Y'),(X,Y)).

% Each white circle must be passed through in a straight line
:- white(X,Y), not straight(X,Y).
% There must be a turn in the previous or next point of each white circle
:- white(X,Y), not turn_before(X,Y), not turn_after(X,Y).
% Each black circle must be in the corner of a turn
:- black(X,Y), not turn(X,Y).

% Define adjacency for a grid
adjacent((X,Y),(X+1,Y)) :- point(X,Y), point(X+1,Y), X < size.
adjacent((X,Y),(X-1,Y)) :- point(X,Y), point(X-1,Y), X > 1.
adjacent((X,Y),(X,Y+1)) :- point(X,Y), point(X,Y+1), Y < size.
adjacent((X,Y),(X,Y-1)) :- point(X,Y), point(X,Y-1), Y > 1.

% Define what it means for a point to be "straight"
straight(X,Y) :- point(X,Y), #count{ (X',Y'): seg((X,Y),(X',Y')) } = 2, 
#count{ (X',Y'): seg((X',Y'),(X,Y)) } = 2.

% Define what it means for a point to be a "turn"
turn(X,Y) :- point(X,Y), #count{ (X',Y'): seg((X,Y),(X',Y')) } = 2, 
#count{ (X',Y'): seg((X',Y'),(X,Y)) } != 2.

% Define what it means for a point to be a "turn before"
turn_before(X,Y) :- point(X,Y), #count{ (X',Y'): seg((X,Y),(X',Y')) } = 2,
#count{ (X',Y'): seg((X',Y'),(X,Y)) } = 1.  

% Define what it means for a point to be a "turn after"
turn_after(X,Y) :- point(X,Y), #count{ (X',Y'): seg((X,Y),(X',Y')) } = 1,
#count{ (X',Y'): seg((X',Y'),(X,Y)) } = 2.

% The path must form a closed loop
:- point(X,Y), #count{ (X',Y'): seg((X,Y),(X',Y')) } != 2.

% Check if the starting and ending points are connected to form a closed loop
:- not path(1,1), not path(1,1).
