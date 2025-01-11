
% There are three blocks named a, b, and c.
% There are four positions where the three blocks can be placed.
% A position or block is considered clear if it has no block on top of it.
% Initially, Block a is on Position 1, Block b is on Position 3, and Block c is on Block a.
% The robot has the ability to move a clear block from its current position to a new clear position or a new clear block

% 1. determine predicate and fluents to describe complete state of world

% block(B) means that B is a block
% position(X) means that X is a position
% on(B,X,S) means block B is on top of position or block X in situation S

% clear(A,S) defines the condition when a block or position is clear
clear(A,S) :- \+ on(_,A,S).

% 2. define the actions that can be done

% move(B,X1,X2) means moving block B from X1 to X2

% 3. write precondition axiom for each action

% poss(move(B,X1,X2),S) defines the condition when move action is possible
poss([move(B,X1,X2)|S]) :-
			block(B),					% B is a block
			(block(X2); position(X2)),	% X2 is either block or position
			on(B,X1,S),					% B is on X1 in S
			clear(X2,S),				% X2 must be clear in S			
			clear(B,S).					% B is clear in S
			%dif(X1,X2).				% X1 and X2 must not be the same


% 4. write successor state axiom

on(B,X,[A|S]) :- 
			poss([A|S]),
			(
				A = move(B,_,X) 				% becomes true
				;				
				on(B,X,S),						% was true and stays true
				dif(A,move(B,X,_))).
				
			
% 5. Initial state of the world
block(a).
block(b).
block(c).

position(p1).
position(p2).
position(p3).
position(p4).

on(a,p1,[]).
on(b,p3,[]).
on(c,a,[]).

% 6. Planning predicate

%plan(g(S),S) is true when g(S) is a formula (the goal state depending on S) that is true, and S is an action history (the plan)
plan(Goal,Plan):-bposs(Plan),Goal.

% bposs(S) is true when S is a sequence of possible actions considering shortest sequences first
bposs(S) :- tryposs([],S).

% tryposs(S,S) is true when S is a sequence of possible actions considering shortest sequences first (breadth first search for possible action sequences)
tryposs(S,S) :- poss(S).
tryposs(X,S) :- tryposs([_|X],S).