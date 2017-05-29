%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PREDICATE LIST:

%The "A" predicates relate to solving SEND+MORE=MONEY problems
%The specific problems should be easy to work out by looking at the main constraint

%solveA1(X)

%solveA2(X)

%solveA3(X)

%The "B" predicates are for finding the minimum number of coins in oder to make
%change up to .99 with a given currecy system
%The original problems should be easy to work out by looking at the domains of the variables

%solveB1(X)

%solveB2(X)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- lib(ic).
:- lib(branch_and_bound).

%SEND + MORE = MONEY


%A1

solveA1([A,E,H,I,K,N,S,T]) :-

  %set the domains of the variables
  [A,E,H,I,K,N,S,T] :: [0..9],

  %K is not zero
  K #\= 0,

  %S is 1
  S #= 1,

  %main constraint
  E + (N*10) + (I*100) + (H*1000) + (S*10000)
  - N - (A*10) - (H*100) - (T*1000)
  #= T + (I*10) + (N*100) + (K*1000),

  %make all different
  all_unique([A,E,H,I,K,N,S,T]),

  %search
  labeling([A,E,H,I,K,N,S,T]).

%A2


solveA2([E,H,I,K,N,T]) :-

  %set the domains of the variables
  [E,H,I,K,N,T] :: [0..9],

  %K is not zero
  K #\= 0,

  %S is 1
  T #= 1,

  %main constraint
  K + (N*10) + (I*100) + (H*1000) + (T*10000)
  - N - (E*10) - (H*100) - (T*1000)
  #= T + (I*10) + (N*100) + (K*1000),

  %make all different
  all_unique([E,H,I,K,N,T]),

  %search
  labeling([E,H,I,K,N,T]).


%A3

solveA3([A,E,H,G,K,N,R,T]) :-

  %set the domains of the variables
  [A,E,H,G,K,N,R,T] :: [0..9],

  %G is not zero
  G #\= 0,

  %T is 1
  T #= 1,

  %main constraint
  K + (N*10) + (A*100) + (H*1000) + (T*10000)
  - N - (E*10) - (H*100) - (T*1000)
  #= R + (A*10) + (N*100) + (G*1000),

  %make all different
  all_unique([A,E,H,G,K,N,R,T]),

  %search
  labeling([A,E,H,G,K,N,R,T]).

%B1
solveB1([C1, C5, C10, C25]) :-

  %domains
  CoinNumbers = [C1, C5,C10,C25],
  CoinNumbers :: 1..99,
  Values = [1,5,10,25],

  %cost function
  NumberOfCoins #= sum(CoinNumbers),

  %constraints
  %for each price get a possible solution and then add store all of these in a list
  (
  for(P, 1, 99),
  foreach(S, Solutions),
  param(CoinNumbers, Values)

  do

    generatePriceCons(CoinNumbers, Values, P, S)
  ),

  %search
  minimize((labeling(CoinNumbers), searchCurrency( Solutions)), NumberOfCoins).


%B2

solveB2([C1, C2, C3, C6, C12, C25]) :-

  %domains
  CoinNumbers = [C1, C2, C3, C6, C12, C25],
  CoinNumbers :: 1..99,
  Values = [1,2,3,6,12,25],

  %cost function
  NumberOfCoins #= sum(CoinNumbers),

  %constraints
  %for each price get a possible solution and then add store all of these in a list
  (
  for(P, 1, 99),
  foreach(S, Solutions),
  param(CoinNumbers, Values)

  do

    generatePriceCons(CoinNumbers, Values, P, S)
  ),

  %search
  minimize((labeling(CoinNumbers), searchCurrency( Solutions)), NumberOfCoins).





%Generates list that represents the linear equation for a given list of coins,
%values, price, and the solution for the number of each coin for given price
generatePriceCons(CoinNumbers, Values, Price, Solution) :-

  (
  foreach(CN, CoinNumbers),
  foreach(V, Values),
  foreach(S, Solution),
  foreach(P, Products)

  do

  S #>= 0,
  P #= V*S,
  CN #>= S

  ),
  sum(Products) #= Price.

%searches for solutions that meet the constraints
searchCurrency(Solutions) :-

  (
  foreach(S, Solutions)
  do
  once(labeling(S))
  ).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pop(Ls, E, Ps)
%E is the element to be popped
%Ls is the original list
%Ps is the original list minus the element
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pop([X|[]], X, []).
pop(Ls, E, Ps) :-
  Ls = [X|Y],
  X=E,
  Ps = Y.
pop(Ls, E, Ps) :-
  Ls = [X|Ys],
  pop(Ys, E, Zs),
  app([X], Zs, Ps).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% all_unique(List)
% checks if all elements of a list are unique
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
all_unique(List):-


  (
    foreach(E, List),
    param(List)
    do
   pop(List, E, Pl),
    (
    foreach(I, Pl),
    param(E)
    do
    I #\= E
    )
  ).
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % app(Xs, Ys, Zs) :- Zs is the result of
  %     concatenating the lists Xs and Ys.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  app([], Ys, Ys).
  app([X | Xs], Ys, [X | Zs]) :- app(Xs, Ys, Zs).
