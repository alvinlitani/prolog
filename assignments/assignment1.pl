% parent(X,Y) means that X is a parent of Y
parent(bill,joe).
parent(susan,joe).
parent(susan,sally).
parent(joe,chris).
parent(joe,jeff).
parent(jeff,jack).

% educated(Y):- parent(X,Y) means that Y is educated if Y have a parent 
educated(Y):- parent(_,Y).

% sibling(X,Y):- parent(A,X),parent(A,Y) means that X and Y are siblings if both X and Y have A as a parent
sibling(X,Y):- parent(A,X),parent(A,Y),dif(X,Y).

% poor(X):- parent(X,Y), sibling(Y,Z) means that X is poor if a child of X have a sibling
poor(X):- parent(X,Y), sibling(Y,_).

% grandparent(X,Z):-parent(X,Y),parent(Y,Z) means that X is a grandparent of Z if X is a parent of Y and Y is a parent of Z
grandparent(X,Z):- parent(X,Y),parent(Y,Z).

% grandchild(C,A):- parent(A,B),parent(B,C) means that C is a grandchild of A if A is a parent of B and B is a parent of C
grandchild(C,A):- parent(A,B),parent(B,C).

% male(X) means that X is a male person
male(bill).
male(joe).
male(chris).
male(jeff).

% female(X) means that X is a female person
female(susan).
female(sally).

% sister(X,Y) :- parent(Z,X),parent(Z,Y),female(X),dif(X,Y) means X is the sister of Y if Z is parent of X and Y, and X is female, and X is not the same as Y
sister(X,Y) :- parent(Z,X),parent(Z,Y),female(X),dif(X,Y).

% aunt(A,C):- parent(B,C),sister(A,B) means A is an aunt of C is B is a parent of C and A is a sister of B
aunt(X,Y):- parent(W,Y),sister(X,W).

% Two implementations of ancestor with one as comment block
% ancestor(X,Y):- parent(X,Y).
% ancestor(X,Z):- parent(X,Y), ancestor(Y,Z).

ancestor(X,Z):- parent(X,Z).
ancestor(X,Z):- parent(Y,Z), ancestor(X,Y).