:- dynamic xPlusYisZ/2.
natural(zero).
natural(X):- X=s(X1), natural(X1).

xPlusYisZ(X, Y, Z):- Y=zero, Z=X, natural(X).
xPlusYisZ(X, Y, Z):- X=zero, Z=Y, natural(Y).
xPlusYisZ(X, Y, Z):-
s(X1)=X, s(Y1)=Y, Z=s(s(Z1)), xPlusYisZ(X1, Y1, Z1), natural(X), natural(Y).

xTimesYisZ(X, Y, Z):- Y=zero, Z=zero, natural(X).
xTimesYisZ(X, Y, Z):- X=zero, Z=zero, natural(Y).
xTimesYisZ(X, Y, Z):- Y=s(zero), Z=X, natural(X).
xTimesYisZ(X, Y, Z):- X=s(zero), Z=Y, natural(Y).

xTimesYisZ(X, Y, Z):-
s(X1)=X,  xTimesYisZ(X1, Y, Z1), xPlusYisZ(Z1, Y, Z),
natural(X), natural(Y).


xMinusYisZ(X, Y, Z):- xPlusYisZ(Y, Z, X).

xDivdedByYisZ(X, Y, Z):- xTimesYisZ(Y, Z, X).
