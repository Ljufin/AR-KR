female(shelley).
female(mary).
male(jake).
male(bill).
father(bill, jake).
father(bill, shelley).
mother(mary, jake).
mother(mary, shelly).

parent(X, Y):- mother(X, Y).
parent(X, Y):- father(X, Y).
grandparent(X, Z):- parent(X,Y), parent(Y, Z).
sibling(X, Y):- parent(P, X), parent(P,Y).

/*  Try the following queries seperately.

sibling(shelly, jake).

mother(shelly, jake).

parent(X, jake).

sibling(X, jake).

*/