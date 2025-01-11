% point(X,Y) represents cartesian coordinate of (X,Y)
point(2,2).
point(2,4).
point(3,5).
point(4,6).
point(5,7).

% seg(X,Y) will be true if 
% both points exist
% point X is not equal to point Y

seg(X,Y) :- point(_,_) = X, X, point(_,_) = Y, Y, dif(X,Y).

% triangle(X,Y,Z) will be true if 
% the points are all segments
% all three points exist
triangle(X,Y,Z) :- seg(X,Y),seg(X,Z),seg(Y,Z),X,Y,Z.

% vertical(seg) will be true if both points have the same X value 
vertical(seg(point(X,_), point(X,_))).

% vertical_length(seg,Result) will store the vertical length of a segment in Result
vertical_length(seg(point(X,Y1), point(X,Y2)),Result) :- Result is abs(Y1 - Y2).  

% bottom_point(seg,Result) will store the Y value of the lowest point of a segment in Result
bottom_point(seg(X,Y),Result) :- 
				point(_,A) = X, point(_,B) = Y, 
				vertical(seg(X,Y)),
				(A < B -> Result = A; Result = B).

% rectangle(X,Y) will be true if 
% both X and Y segments exist
% X and Y segments are both vertical
% X and Y segments are the same length
% The bottom point of X is at the same level as the bottom point of Y
rectangle(X,Y) :- 
				seg(A,B) = X, X, vertical(seg(A,B)), 
				seg(C,D) = Y, Y, vertical(seg(C,D)),	
				vertical_length(X,Length), vertical_length(Y,Length),
				bottom_point(X,Bottom), bottom_point(Y,Bottom).
				




