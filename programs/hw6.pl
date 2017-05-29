%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%My solution to the magic square puzzle
%ms(Square, N) will find a magic square of order N
%my solution isn't all that efficient, so it will take 30 minutes to find an order 3
%a better program can be found on the ECLiPSe website
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- lib(ic).

ms(Square, N) :-

  dim(Square, [N,N]),
  %numbers are from 1 to N*N
  Nsq #= N*N,
  (foreachelem(E, Square), param(Nsq) do E :: [1..Nsq]),

  generateConstraints(Square),
  msSearch(Square)
  .


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generateConstraints(Square)
% Constructs the constraints for the magic square puzzle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
generateConstraints(Square) :-

  %numbers are from 1 to N*N
  %Nsq #= N*N,
  %(foreachelem(E, Square), param(Nsq) do E :: [1..Nsq]),


  %all rows must sum to magic number,
  row_sum(Square),

  %all columns must sum to magic number
  column_sum(Square),

  %both diagonals must sum to magic number
  diagonal_sum(Square),

  %all must be different
  all_unique(Square)
.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% search(Square)
% checks all the rows to see if they sum to the magic number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
msSearch(Square):-

  dim(Square, [N,N]),

  (
  foreachelem(E, Square)

  do

  indomain(E)

  )
.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% row_sum(Square)
% checks all the rows to see if they sum to the magic number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
row_sum(Square):-
  %get dimension
  dim(Square, [N,N]),
  %calculate magic number
  S #= (N*((N*N)+1))/2,
  (
  for(I, 1, N),
  param(Square, S)
  do
  %select row
  subscript(Square, [I], E),

  %get the sum of that row

  sum_array(E, T),
  % I really don't know why this is needed,
  % it gives me a type error in "arg(...)" if I pass S to sum_array
  T = S

  ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% column_sum(Square)
% checks all the columns to see if they sum to the magic number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

column_sum(Square):-

  %get dimensions
  dim(Square, [N,N]),

  %select column
  (
  for(I, 1, N),
  param(Square, N)

  do

    %go down column and sum
    (
      for(K, 1, N),
      fromto(0, In, Out, S),
      param(I, Square)

      do

      subscript(Square, [K,I], Q),
      Out #= In+Q
    ),

    S #= (N*((N*N)+1))/2

  ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% diagonal_sum(Square)
% checks the 2  diagonals to see if they sum to the magic number
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
diagonal_sum(Square):-

  dim(Square, [N,N]),


  %the easy one
  (
  for(I, 1, N),
  fromto(0, In, Out, S1),
  param(Square)
  do

    subscript(Square, [I,I], Q),
    Out #= In+Q
  ),

  %the harder one
  (
  for(I, 1, N),
  fromto(0, In, Out, S2),
  param(Square, N)
  do
    % get the other index
    K #= (N-I)+1,
    subscript(Square, [I,K], Q),
    Out #= In+Q
  ),

  S1 = S2,
  S1 #= (N*((N*N)+1))/2
.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sum-array(Arr)
% Gets the sum of the elements of an array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sum_array(Arr, Sum):-

  (
  foreachelem(E, Arr),
  fromto(0, In, Out, Sum)
  do
  Out #= In+E
  )
.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% all_unique(Square)
% checks if all elements of a square are unique
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
all_unique(Square):-

  %convert to list
  sqrToList(Square, L),
  (
   foreach(E, L),
   param(L)
   do
   pop(L, E, Pl),
   (
    foreach(I, Pl),
    param(E)
    do
    I #\= E
   )
  ).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sqrToList(Square, SqList)
% converts the NxN array into a list for unique checking
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sqrToList(Square, SqList):-

  (
  foreachelem(E, Square),
  fromto([], In, Out, SqList)
  do
  Out = [E|In]
  ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% select_val(Min, Max, Val) :-
%     Min, Max are gaes and Val is an integer
%     between Min and Max inclusive.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

select_val(Min, Max, Val) :- Min =< Max, Val is Min.
select_val(Min, Max, Val) :-
    Min #< Max, Min1 is Min+1,
    select_val(Min1, Max, Val).

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% app(Xs, Ys, Zs) :- Zs is the result of
%     concatenating the lists Xs and Ys.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
app([], Ys, Ys).
app([X | Xs], Ys, [X | Zs]) :- app(Xs, Ys, Zs).
