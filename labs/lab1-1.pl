% define a vegetables/1 predicate that is true of the following: carrot cucumber
vegetables(carrot).
vegetables(cucumber).

% define a bread/1 predicate that is true of the following: rye wheat
bread(rye).
bread(wheat).

% define a cake predicate that is true of the following: carrot chocolate
cake(carrot).
cake(chocolate).

% define a tasty/1 predicate that is true of something if it is a type of vegetable and a type of cake

tasty(X) :- vegetables(X),cake(X).