%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*

This is my implementation of selection sort in ECLiPSe

ss(Xs, Ys)
X is the unsorted list
Y is the sorted list
*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%base cases
ss([],[]).
ss([X|[]], [X|[]]).

ss(Xs, Ys) :-

  %find the lowest element of the list
  findLow(Xs, Low),

  %pop Low out of the list
  pop(Xs, Low, Ps),

  %now sort the remaining Ps
  ss(Ps, Zs),

  %append the singleton Low with the sorted Zs
  app([Low], Zs, Ys), !.


 %find the lowest
 %findLow(Ls, Low)
 %Low is the lowest element in a list
 %Ls is the list to be searched

%the lowest element of a singleton list is the only element in the list.
findLow([X|[]], X).

 %2 elements
findLow([X|[Y|[]]], Low) :-
  %compare X to Y
  X > Y -> Low=Y; Low=X.

%3 or more elements/general form
findLow([Xs|Ys], Low) :-

  %find the lowest of the tail/recursive step
  findLow(Ys, Tlow),

  %compare that element to the head of the list
  Xs > Tlow -> Low=Tlow; Low = Xs.

%pop the lowest element of a list
%i.e. find a list with the  element removed
%pop(Ls, E, Ps)
%E is the element to be popped
%Ls is the original list
%Ps is the original list minus the lowest element

pop([X|[]], X, []).



%first element is the one
pop(Ls, E, Ps) :-

  Ls = [X|Y],

  %test is X is the element
  X=E,

  %Ps is the tail of the list
  Ps = Y.

%the element is not at the head of the list
pop(Ls, E, Ps) :-

  Ls = [X|Ys],

  %find the popped list of the tail
  pop(Ys, E, Zs),

  %add the popped list together with the head
  app([X], Zs, Ps).

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %"Libraries"
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % app(Xs, Ys, Zs) :- Zs is the result of
  %     concatenating the lists Xs and Ys.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  app([], Ys, Ys).
  app([X | Xs], Ys, [X | Zs]) :- app(Xs, Ys, Zs).
