natural(zero).
natural(s(X)):- natural(X).

xPlusYisZ(X, zero, X):- natural(X).
xPlusYisZ(zero, X, X):- natural(X).
xPlusYisZ(X, Y, s(s(Z1))):- 
natural(X), natural(Y), s(X1)=X, s(Y1)=Y, xPlusYisZ(X1, Y1, Z1).

xTimesYisZ(X, zero, zero):- natural(X).
xTimesYisZ(zero, X, zero):- natural(X).
xTimesYisZ(X, s(zero), X):- natural(X).
xTimesYisZ(s(zero), X, X):- natural(X).

xTimesYisZ(X, Y, Z):- 
natural(X), natural(Y), s(X1)=X, 
xTimesYisZ(X1, Y, Z1), xPlusYisZ(Z1, Y, Z).

xMinusYisZ(X, Y, Z):- xPlusYisZ(Y, Z, X).
xDivdedByYisZ(X, Y, Z):- xTimesYisZ(Y, Z, X).