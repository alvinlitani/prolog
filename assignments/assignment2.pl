/* 
There is a monkey, a single bunch of bananas (or one banana, if you prefer), and a box
• The monkey, box, and bananas are each at different locations to start
• The bananas are hanging too high for the monkey to reach, but if the monkey climbs on
top of the box, the monkey can grab the bananas
• The monkey is analogous to a robot with the following basic functionality:
o The monkey can go to a specific location
o The monkey can push the box to a specific location
o The monkey can climb onto and climb off the box
o If the conditions are right, the monkey can grab the bananas
• The monkey needs to plan a sequence of actions that will result in achieving the goal:
the monkey having the bananas 
*/

/*
Predicates and Fluents to describe the world

% near_box(y/n,S) describes whether the monkey is near the box or not in situation S
near_box(y/n,S).

% on_box(y/n,S) describes whether the monkey is on the box or not in situation S
on_box(y/n,S).

% box_below_banana(y/n,S) describes whether the box is below the banana or not in situation S
box_below_banana(y/n,S).

% has_banana(y/n,S) describes whether the monkey has the banana or not in situation S
has_banana(y/n,S).

% satisfied(y/n,S) describes whether the monkey has eaten the banana after which it becomes satisfied in situation S 
satisfied(y/n,S).
*/

/* Possible Actions 

% go_box() means the monkey goes to the box
go_box()

% push_box() means the monkey pushes the box to position below the banana
push_box()

% climb_box() means the monkey climbs the box
climb_box()

% climb_off() means the monkey climbs off the box
climb_off()

% grab_banana() means the monkey grabs the banana
grab_banana()

% eat_banana() means the monkey eats the banana
eat_banana()
*/

% Initial State of the World
% The monkey is not near or on the box. 
near_box(n,[]).
on_box(n,[]).

% The box is not below the banana
box_below_banana(n,[]).

% The monkey does not have the banana and is not satisfied because he has not eaten the banana
has_banana(n,[]).
satisfied(n,[]).

% Possible Actions
% Action go_box() is possible when monkey is not near the box
poss([go_box()|S]) :-
		near_box(n,S).

% Action push_box() is possible when the monkey is near the box and not on the box while the box is not below the banana
poss([push_box()|S]) :-
		near_box(y,S),
		on_box(n,S),
		box_below_banana(n,S).
		
% Action climb_box() is possible when the monkey is near the box and not on the box
poss([climb_box()|S]) :-
		near_box(y,S),
		on_box(n,S).
	
% Action grab_banana() is possible when the monkey is on the box and does not have the banana while the box is below the banana
poss([grab_banana()|S]) :-
		on_box(y,S),
		box_below_banana(y,S),
		has_banana(n,S).

% Action climb_off() is possible when the monkey is on the box		
poss([climb_off()|S]) :-
		on_box(y,S).

% Action eat_banana() is possible when the monkey is not on the box and has the banana
poss([eat_banana()|S]) :-
		on_box(n,S),
		has_banana(y,S).
		

		
% Successor State Axioms
near_box(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = go_box(),			% if the last action is go_box 
				Y = y 					% the monkey is now near the box
				;				
				dif(A,go_box()),		% if the last action is anything except go_box
				near_box(Y,S)			% the state of monkey being near the box does not change
			).


on_box(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = climb_box(), 		% if the last action is climb_box
				Y = y					% the monkey is now on the box
				;	
				A = climb_off(),		% if the last action is climb_off
				Y = n					% the monkey is now not on the box
				;
				A \= climb_box(),		% if the last action is anything except climb_box/climb_off
				A \= climb_off(),
				on_box(Y,S)				% the state of monkey being on the box does not change
			).


box_below_banana(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = push_box(),			% if the last action is push_box
				Y = y 					% the box is now below the banana
				;				
				dif(A,push_box()),		% if the last action is anything except push_box
				box_below_banana(Y,S)	% the state of the box being below the banana does not change
			).
			

has_banana(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = grab_banana(),		% if the last action is grab_banana
				Y = y 					% the monkey now has the banana
				;				
				dif(A,grab_banana()),	% if the last action is anything except grab_banana
				has_banana(Y,S)			% the state of the monkey having the banana does not change
			).
		
		
satisfied(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = eat_banana(),		% if the last action is eat_banana
				Y = y 					% the monkey is now satisfied
				;				
				dif(A,eat_banana()),	% if the last action is anything except eat_banana
				satisfied(Y,S)			% the state of the monkey being satisfied does not change
			).
			
% Planning Predicates

%plan(g(S),S) is true when g(S) is a formula (the goal state depending on S) that is true, and S is an action history (the plan)
plan(Goal,Plan):-bposs(Plan),Goal.

%bposs(S) is true when S is a sequence of possible actions considering shortest sequences first
bposs(S) :- tryposs([],S).

% tryposs(S,S) is true when S is a sequence of possible actions considering shortest sequences first (breadth first search for possible action sequences)
tryposs(S,S) :- poss(S).
tryposs(X,S) :- tryposs([_|X],S).