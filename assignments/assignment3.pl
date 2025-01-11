/*
The robot will need to do the following things:
• Open a cupboard, take a cup from the cupboard, and place it on the counter
• Fill a kettle with water, and plug it in
• After the robot waits for the water to boil, it will pour hot water into the cup
• Add instant coffee to the cup
• With the hot water and coffee in the cup, the robot can stir the coffee to complete the process 
*/

/*
Predicates and Fluents to describe the world	

% cupboard_open(y/n,S) describes whether the cupboard is open in situation S
cupboard_open(y/n,[]).

% cup(location,[]) describes the location of the cup
cup(cupboard/hand/counter,[]).

% kettle_filled(y/n,[]) describes whether the kettle is filled with water in situation S
kettle_filled(y/n,[]).

% kettle_plugged(y/n,[]) describes whether the kettle is plugged in situation S
kettle_plugged(y/n,[]).

% water_boiled(y/n,[]) describes whether the water is boiled in situation S
water_boiled(y/n,[]).

% water_in_cup(y/n,[]) describes whether there is water inside the cup in situation S
water_in_cup(y/n,[]).

% coffee_in_cup(y/n,[]) describes whether there is coffee inside the cup in situation S
coffee_in_cup(y/n,[]).

% coffee_ready(y/n,[]) describes whether the coffee is ready in situation S
coffee_ready(y/n,[]).
*/

/*
Possible actions

% open_cupboard() means the robot opens the cupboard
open_cupboard()

% take_cup() means the robot takes the cup from the cupboard onto its hand
take_cup()

% place_cup() means the robot places the cup from its hand to the counter
place_cup()

% fill_kettle() means the robot fills the kettle with water
fill_kettle()

% plug_kettle() means the robot plugs in the kettle
plug_kettle()

% wait_boil() means the robot waits for the water to boil 
wait_boil()

% pour_water() means the robot pours the hot water from kettle to cup
pour_water()

% add_coffee() means the robot add instant coffee to the cup
add_coffee()

% stir_coffee() means the robot stirs the instant coffee and water inside the cup
stir_coffee()
*/



% Precondition axioms

% action stir_coffee is possible when there is water and coffee in the cup, and the coffee is not ready
poss([stir_coffee()|S]) :-
		water_in_cup(y,S),
		coffee_in_cup(y,S),
		coffee_ready(n,S).

% action pour_water is possible when the water is boiled, the cup is on the counter, and there is no water in the cup
poss([pour_water()|S]) :-
		water_boiled(y,S),
		cup(counter,S),
		water_in_cup(n,S).

% action add_coffee is possible when the cup is on the counter and there is no coffee in the cup
poss([add_coffee()|S]) :-
		cup(counter,S),
		coffee_in_cup(n,S).

% action wait_boil is possible when the kettle is plugged and filled with the water not boiled
poss([wait_boil()|S]) :-
		kettle_plugged(y,S),
		kettle_filled(y,S),
		water_boiled(n,S).
		
% action plug_kettle is possible when the kettle is filled and not plugged in
poss([plug_kettle()|S]) :-
		kettle_plugged(n,S),
		kettle_filled(y,S).

% action fill_kettle is possible when the kettle is not filled 
poss([fill_kettle()|S]) :-
		kettle_filled(n,S).
	
% action take_cup is possible when the cupboard is open and the cup is inside the cupboard
poss([take_cup()|S]) :-
		cupboard_open(y,S),
		cup(cupboard,S).
	
% action place_cup is possible when the cup is in the robot's hand
poss([place_cup()|S]) :-
		cup(hand,S).

% action open_cupboard is possible when the cupboard is not open
poss([open_cupboard()|S]) :-
		cupboard_open(n,S).

% Successor state axioms
% cupboard_open(Y,[A|S]) represents the state of the cupboard being open after action A is taken
cupboard_open(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = open_cupboard(),			% if the last action is open_cupboard
				Y = y 							% the cupboard is now open
				;				
				A \= open_cupboard(),			% if the last action is anything except open_cupboard
				cupboard_open(Y,S)				% the state of cupboard being open does not change
			).		
			
% cup(Y,[A|S]) represents the location of the cup after action A is taken
cup(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = take_cup(),					% if the last action is take_cup
				Y = hand						% the cup is on the robot's hand
				;
				A = place_cup(),				% if the last action is place_cup
				Y = counter						% the cup is on the counter
				;
				A \= take_cup(),				% if the last action is not take_cup or place_cup
				A \= place_cup(),				
				cup(Y,S)						% the location of the cup does not change
			). 
	
% kettle_filled(Y,[A|S]) represents the state of the kettle being filled after action A is taken
kettle_filled(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = fill_kettle(),				% if the last action is fill_kettle
				Y = y 							% the kettle is now filled
				;
				A = pour_water(),				% if the last action is pour_water
				Y = n							% the kettle is now empty
				;				
				A \= fill_kettle(),				% if the last action is not fill_kettle or pour_water
				A \= pour_water(),
				kettle_filled(Y,S)				% the state of kettle being filled does not change
			).	

% kettle_plugged(Y,[A|S]) represents the state of the kettle being plugged after action A is taken
kettle_plugged(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = plug_kettle(),				% if the last action is plug_kettle
				Y = y 							% the kettle is now plugged
				;
				A = wait_boil(),				% if the last action is wait_boil
				Y = n							% the kettle is now unplugged
				;				
				A \= plug_kettle(),				% if the last action is anything except plug_kettle
				kettle_plugged(Y,S)				% the state of kettle being plugged does not change
			).	
			
% water_boiled(Y,[A|S]) represents the state of the water being boiled after action A is taken
water_boiled(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = wait_boil(),				% if the last action is wait_boil
				Y = y 							% the water is now boiled
				;				
				A \= wait_boil(),				% if the last action is anything except wait_boil
				water_boiled(Y,S)				% the state of water being boiled does not change
			).	

% water_in_cup(Y,[A|S]) represents the state of the cup having water after action A is taken
water_in_cup(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = pour_water(),				% if the last action is pour_water
				Y = y 							% there is water in the cup
				;				
				A \= pour_water(),				% if the last action is anything except pour_water
				water_in_cup(Y,S)				% the state of water being in the cup does not change
			).	
			
% coffee_in_cup(Y,[A|S]) represents the state of the cup having coffee after action A is taken			
coffee_in_cup(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = add_coffee(),				% if the last action is add_coffee
				Y = y 							% there is coffee in the cup
				;				
				A \= add_coffee(),				% if the last action is anything except add_coffee
				coffee_in_cup(Y,S)				% the state of coffee being in the cup does not change
			).			

% coffee_ready(Y,[A|S]) represents the state of the coffee being ready after action A is taken
coffee_ready(Y,[A|S]) :- 
			poss([A|S]),
			(
				A = stir_coffee(),				% if the last action is stir_coffee
				Y = y 							% the coffee is ready
				;
				A \= stir_coffee(),				% if the last action is anything except stir_coffee
				coffee_ready(Y,S)				% the state of coffee being ready does not change
			).	


% Initial state of the world
% cupboard is not open
cupboard_open(n,[]).

% cup is in the cupboard
cup(cupboard,[]).

% kettle is not filled
kettle_filled(n,[]).

% kettle is not plugged
kettle_plugged(n,[]).

% water is not boiled
water_boiled(n,[]).

% there is no water in the cup
water_in_cup(n,[]).

% there is no coffee in the cup
coffee_in_cup(n,[]).

% coffee is not ready
coffee_ready(n,[]).


% Planning Predicates

%plan(g(S),S) is true when g(S) is a formula (the goal state depending on S) that is true, and S is an action history (the plan)
plan(Goal,Plan):-bposs(Plan),Goal.

%bposs(S) is true when S is a sequence of possible actions considering shortest sequences first
bposs(S) :- tryposs([],S).

% tryposs(S,S) is true when S is a sequence of possible actions considering shortest sequences first (breadth first search for possible action sequences)
tryposs(S,S) :- poss(S).
tryposs(X,S) :- tryposs([_|X],S).