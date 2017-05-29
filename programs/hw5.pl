%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%My solutions for homework #5.

%recSum and iterSum both find the sum of all the elements of a list

%recMax and iterMax both find the maximum of a list

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%recursive implementation
recSum([],0).
recSum([E], E):- number(E).
recSum([H|T], Sum):- recSum(T,TailSum), Sum is H + TailSum.


%iterative implementation
iterSum(List, Sum):-
  (
  foreach(E, List),
  fromto(0, In, Out, Sum)
  do
  Out is In+E
  ).

%recursive implementation
recMax([E],E).
recMax([H|T], Max):-
  recMax(T, TMax),
  (H > TMax -> Max = H; Max = TMax).

%iterative implementation
iterMax(List, Max):-
  List = [H|T],
  (
  foreach(E, List),
  fromto(H, In, Out, Max)
  do
  (E > In -> Out=E; Out=In)
  ).
