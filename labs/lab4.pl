
% mycount([], 0) means that it will return true if 
% 1st argument is an empty list and
% 2nd argument is 0 
mycount([], 0).

% mycount([_|Tail], N) means that it will return true if N is the number of items of the 1st argument list
mycount([_|Tail], N) :-
    mycount(Tail, N0),
    N is N0 + 1.

% nth(1,[Item|_], Item) means that it will return true if 
% 1st argument is 1 and
% element Item is at the head of the 2nd argument list 
nth(1,[Item|_], Item).

% nth(N,List,Item) means that it will return true if Item is the Nth item in list List.
nth(N,[_|T],Item):-
	nth(N0,T,Item),
	N is N0 + 1.

/**
nth(N, List, Item) :-
	append(L1, [Item|_], List),
	length(L1, N0),
	N is N0 + 1.
*/

% myinsert(Item, List, 1, [Item|Tail]) means that it will return true if 
% 1st argument is at the head of 4th argument list, 
% 2nd argument list is the tail of the 4th argument list and
% 3rd argument is 1  
myinsert(Item, Tail, 1, [Item|Tail]). 

% myinsert(Item, [Head|Tail], Position, [Head|Result]) means that it will return true if 
% 4th argument list is similar to 2nd argument list after Item has been inserted at position
myinsert(Item, [Head|Tail], Position, [Head|Result]) :-  
    NewPosition is Position - 1,        							% Decrease position by 1
    myinsert(Item, Tail, NewPosition, Result).  					% Recursive call with position decreased by 1 and remove head from both lists

% mydelete(1, [_|Tail], Tail) means that it will return true if 
% 1st argument is 1 and 
% tail of 2nd argument list is same with 3rd argument list
mydelete(1, [_|Tail], Tail).  

% mydelete(Position, [Head|Tail], [Head|Result]) means that it will return true if
% 3rd argument list is similar to 2nd argument list after element at Position is removed 
mydelete(Position, [Head|Tail], [Head|Result]) :-  
    NewPosition is Position - 1,                 					% Decrease position by 1
    mydelete(NewPosition, Tail, Result).   							% Recursive call with position decreased by 1 and remove head from both lists


