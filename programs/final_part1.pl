%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PREDICATE LIST:

%recNotMemberOfList(Item, List)
%iterNotMemberOfList(Item, List)
%both return true if the Item is not a member of List


%recDisjoint(Xs, Ys)
%iterDisjoint(Xs, Ys)
%both return true if Xs and Ys are disjoint lists

%recSetIntersect(Xs, Ys, Zs)
%iterSetIntersect(Xs, Ys, Zs)
%both find the intersection of the lits, Xs and Ys, and outputs the result in Zs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%1


%base case: nothing can be in an empty list
recNotMemberOfList(_, []).


recNotMemberOfList(Item, [H|T]) :-

  H \= Item,
  recNotMemberOfList(Item, T).


iterNotMemberOfList(Item, Ls) :-

  (
  foreach(E, Ls),
  param(Item)

  do

    E \= Item
  ).


%2


%base cases
recDisjoint([], []).
recDisjoint(_, []).
recDisjoint([], _).

recDisjoint([H|T], Ys) :-

  recNotMemberOfList(H, Ys),
  recDisjoint(T, Ys).


iterDisjoint(Xs, Ys) :-

  (
  foreach(E, Xs),
  param(Ys)

  do

    iterNotMemberOfList(E, Ys)
  ).


%3


%base cases
%empty set intersect with anything is empty
recSetIntersect([], _, []).
recSetIntersect(_, [], []).
%singleton lists are the intersection if they are in the other set
recSetIntersect([X], Ys, [X]) :- member(X, Ys).
recSetIntersect(Xs, [Y], [Y]) :- member(Y, Xs).

recSetIntersect([H|T], Ys, Zs) :-

  recSetIntersect(T, Ys, Ts),
  (
  ( recNotMemberOfList(H, Ts), member(H, Ys) )
   ->
   Zs=[H|Ts]
   ;
   Zs=Ts
   ).


iterSetIntersect(Xs, Ys, Zs) :-

  (
  foreach(E, Xs),
  fromto([], In, Out, Zs),
  param(Ys)

  do

    ((member(E, Ys), iterNotMemberOfList(E, In)) -> Out = [E|In]; Out = In)
  ).
