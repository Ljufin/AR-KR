%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This is the source code for the final part of my take-home final
%
%This is a slight modification of the code in Fig. 12.3 of the book
%It designs an 8 coin currency where one of coins must be worth 5 and minimizes
%the number of coins to be carried in order to make change for amounts up to .99
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- lib(ic).
:- lib(branch_and_bound).

design_currency(Values, Coins) :-
  init_vars(Values, Coins),
  coin_cons(Values, Coins, Pockets),
  clever_cons(Values, Coins),
  Min #= sum(Coins),
  %Min #= 8,

  % variable ordering heuristic
  reverse(Coins, RCoins),

  minimize(
  (labeling(Values),
  labeling(RCoins),
  check(Pockets)),
  Min).

init_vars(Values, Coins):-

  length(Values, 8),
  Values :: 1..99,
  increasing(Values),
  member(5, Values),
  length(Coins, 8),
  Coins :: 1..99.

increasing(List):-

  (fromto(List, [This,Next|Rest],[Next|Rest],[_])
  do
    This #< Next
  ).

clever_cons(Values, Coins):-

  (
  fromto(Values, [V1|NV],NV,[]),
  fromto(Coins,[N1|NN],NN,[])
  do
    (NV = [V2|_] -> N1*V1 #< V2; N1*V1 #< 100)
  ).

coin_cons(Values, Coins, Pockets):-

  (
  for(Price, 1,99),
  foreach(CoinsforPrice, Pockets),
  param(Coins, Values)
  do
    price_cons(Price, Coins, Values, CoinsforPrice)
  ).

price_cons(Price, Coins, Values, CoinsforPrice):-

  (
  foreach(V, Values),
  foreach(C, CoinsforPrice),
  foreach(Coin, Coins),
  foreach(P, ProdList)
  do
    P = V*C,
    0 #=< C,
    C #=< Coin
  ),
  Price #= sum(ProdList).

check(Pockets):-

  (
  foreach(CoinsforPrice,Pockets)
  do
    once(labeling(CoinsforPrice))
  ).
