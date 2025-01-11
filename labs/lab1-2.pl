% Consider atoms (items) one two three four five six seven eight
% write Prolog code for the successor/2 predicate which is true for pairs of these items where
% the first argument names a number that is exactly one larger than the second argument. This predicate represents a relation that includes seven tuples, so you’re expecting this predicate to take seven lines of code, although this depends on formatting.
% When you have the successor/2 predicate written and consulted, then
% ?- successor(two,one). would be true because two is exactly one greater than one, and
% ?-successor(three,four). would be false because three is not exactly one greater than four.

successor(two, one).
successor(three, two).
successor(four, three).
successor(five, four).
successor(six, five).
successor(seven, six).
successor(eight,seven).

% implement a recursive greater/2 predicate such that greater(Y,X) is true of Y and X when
% Y is the successor of X , or if Y is greater than the successor of X. You are expecting to need two clauses that involve the :- symbol, 
% pronounced “if”. The second clause will use the comma symbol , pronounced “and”. That is, a:-b,c. would be read “a is true if b and c are
% both true.

greater(X,Y) :- successor(X,Y).
greater(X,Z) :- successor(X,Y),greater(Y,Z).



