% adapted from ivan bratko - chapter 12.1

todos_dfs(Objetivo, Solucao, Length, Custo) :-
  solve( Objetivo, Solucao, Length, Custo).

shortest_dfs(Objetivo, Solucao, Length) :-
  once(shortest( Objetivo, Solucao, Length)).

cheapest_dfs(Objetivo, Solucao, Custo) :-
  once(cheapest( Objetivo, Solucao, Custo)).

best_dfs(Objetivo, Solucao, Length, Custo) :-
  once(best( Objetivo, Solucao, Length, Custo)).

%--
solve( Node, Solution, Len, Cost)  :-
  depthfirst( [], Node, Solution, Len, Cost).

depthfirst( Path, Node, [Node | Path] , Len, Cost)  :-
   goal( Node),
   Len is 0,
   Cost is 50.

depthfirst( Path, Node, Sol, TotLen, TotCost)  :-
  custo_aloj(Node,C),
  dist( Node, Node1, L),
  \+ member( Node1, Path),                % Prevent a cycle
  depthfirst( [Node | Path], Node1, Sol, L1, C1),
  TotLen is L+L1,
  TotCost is C+C1.

% adapted code from https://www.cpp.edu/~jrfisher/www/prolog_tutorial/2_15.html

%SHORTEST
shortest(A,Path,Length) :-
   setof([P,L],solve(A,P,L,_),Set),
   Set = [_|_], % fail if empty
   minimal(Set,[Path,Length]).

minimal([F|R],M) :- min(R,F,M).

min([],M,M).
min([[P,L]|R],[_,M],Min) :- L < M, !, min(R,[P,L],Min). 
min([_|R],M,Min) :- min(R,M,Min).

%CHEAPEST
cheapest(Node,Path,Cost) :-
   setof([P,C],solve(Node,P,_,C),Set),
   Set = [_|_], % fail if empty
   minimalc(Set,[Path,Cost]).

minimalc([F|R],M) :- minc(R,F,M).

minc([],M,M).
minc([[P,C]|R],[_,M],Min) :- C < M, C < 450, !, minc(R,[P,C],Min). 
minc([_|R],M,Min) :- minc(R,M,Min).

%BEST
best(Node,Path,Length,Cost) :-
   setof([P,L,C],solve(Node,P,L,C),Set),
   Set = [_|_], % fail if empty
   minimalbest(Set,[Path,Length,Cost]).

minimalbest([F|R],M) :- minb(R,F,M).

minb([],M,M).
minb([[P,L,C]|R],[_,M,CM],Min) :- L < M, C < CM, C < 450, !, minb(R,[P,L,C],Min). 
minb([_|R],M,Min) :- minb(R,M,Min).
