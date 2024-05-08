% All points must be part of the path
:- point(X,Y), not path(X,Y).

% The path must pass through all circles
:- white(X,Y), not path(X,Y).
:- black(X,Y), not path(X,Y).

% Each white circle must be passed through in a straight line
:- white(X,Y), not straight(X,Y).

% There must be a turn in the previous or next point of each white circle
:- white(X,Y), not turn_before(X,Y), not turn_after(X,Y).

% Each black circle must be in the corner of a turn
:- black(X,Y), not turn(X,Y).

% The previous and next points of each black circle cannot contain turns
:- black(X,Y), seg((X,Y),(X',Y')), turn(X',Y').
:- black(X,Y), seg((X',Y'),(X,Y)), turn(X',Y').

% Define the segments of the path
seg((X,Y),(X',Y')) :- path(X,Y), path(X',Y'), adjacent((X,Y),(X',Y')).
% The path must be connected
:- seg((X,Y),(X',Y')), not path(X,Y), not path(X',Y').
:- seg((X,Y),(X',Y')), not path(X,Y), not path(X',Y').

% The path must form a closed loop
:- point(X,Y), #count{ (X',Y'): seg((X,Y),(X',Y')) } != 2.

% The path must pass through all points
reachable(X,Y,X',Y') :- seg((X,Y),(X',Y')).
reachable(X,Y,X',Y') :- reachable(X,Y,Z,W), seg((Z,W),(X',Y')), (X,Y) != (Z,W).
:- point(X,Y), point(X',Y'), X != X' ; Y != Y', not reachable(X,Y,X',Y').


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