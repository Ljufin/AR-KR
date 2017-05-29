%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
This is my implementation of merge sort in ECLiPSe
*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ms(Xs, Ys) :-
%     Ys is an =<-ordered permutation of the list Xs.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ms([], []).
ms([X|[]], [X|[]]).
ms(Xs, Ys) :-

   % part Xs into two parts
   part(Xs, Ls, Us),

   % ms either part
   ms(Ls, MsLs),
   ms(Us, MsUs),

   % merge both parts into Ys.
   merged(MsLs, MsUs, Ys), !. %I use cut here because the program produces infinite
                              %solutions and I can't find the generator that does that.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%partition
part([], [], []).

%even case
part(Xs, Ls, Us) :-

  %store length of Xs in N
  len(Xs, N),

  %check if Xs is even
  0 is N mod 2,

  %generate possible lists
  app(Ls, Us, Xs),

  %get length
  len(Ls, L), len(Us, U),

  %make sure length is N/2
  L is N div 2, U is N div 2.

%odd case
part(Xs, Ls, Us) :-

  %store length of Xs in N
  len(Xs, N),

  %generate possible lists
  app(Ls, Us, Xs),

  %get length
  len(Ls, L), len(Us, U),

  %Total length should be (N div 2) + ((N div 2)+1)
  L is N div 2, U is N div 2 +1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% merge(Ls, Us, MergedLUs) :-
%
%     Ls is a list of sorted elements
%     Us is a list of sorted elements
%     MergedLUs is the sorted list of all elements in Ls & Us
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
merged([], Us, Us).
merged(Ls, [], Ls).

%L >= U case
merged([L|Ls], [U|Us], [L | MergedLsUUs]) :-

  L < U,

  %put L at the front and merge the rest
  merged(Ls, [U|Us], MergedLsUUs).

%L >= U  case
merged([L|Ls], [U|Us], [U | MergedLLsUs]):-

  L >= U,

  %put U at front and merge the rest
  merged([L|Ls], Us, MergedLLsUs).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%"Libraries"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% app(Xs, Ys, Zs) :- Zs is the result of
%     concatenating the lists Xs and Ys.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
app([], Ys, Ys).
app([X | Xs], Ys, [X | Zs]) :- app(Xs, Ys, Zs).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% len(List, N) :- N is the length of the list List.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
len([], 0).
len([_ | Ts], N) :- len(Ts, M), N is M+1.
