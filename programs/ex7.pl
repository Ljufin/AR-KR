%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%These are my solutions for the chapter 7 exercises

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%7.1
% Count the number of non-variable elements in a list with out using recursion

countNonVarList(List, N):-

  (
  foreach(E, List),
  fromto(0, In, Out, N)
  do
  (nonvar(E) -> Out is In+1; Out=In)
  ).

%7.2
% Count the number of non-variable elements in an array without using recursion.

countNonVarArr(Arr, N) :-

  (
  foreachelem(E, Arr),
  fromto(0, In, Out, N)
  do
  (nonvar(E) -> Out is In+1; Out=In)
  ).

%7.3
% Write a non-recursive version of the select_val/3 predicate from
%figure 3.2 on page 46.

selectVal(Min, Max, Val) :-

  (
  count(E, Min, Val),
  fromto(go, In, Out, stop),
  param(Max)
  do
  (Out=stop; E < Max, Out=go)
  ).


%7.4
% Suggest an implementations of the ( count(I,K,L) do Body ) iterator
% using the fromto/4 iterator.

%M is L+1, (fromto(K, In, Out, M) do Body, Out is In+1)
