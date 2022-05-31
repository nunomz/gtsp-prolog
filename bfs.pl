% adapted from ivan bratko - chapter 12.2

todos_bfs(Objetivo, Solucao) :-
  solve( Objetivo, Solucao).

solve( Start, Solution)  :-
  breadthfirst( [ [Start] ], Solution).

% breadthfirst( [ Path1, Path2, ...], Solution):
%   Solution is an extension to a goal of one of paths

breadthfirst( [ [Node | Path] | _], [Node | Path])  :-
  goal( Node).

breadthfirst( [Path | Paths], Solution)  :-
  extend( Path, NewPaths),
  append( Paths, NewPaths, Paths1),
  breadthfirst( Paths1, Solution).

extend( [Node | Path], NewPaths)  :-
  bagof( [NewNode, Node | Path],
         ( arco( Node, NewNode), \+ member( NewNode, [Node | Path] ) ),
         NewPaths),
  !.

extend( _, [] ).              % bagof failed: Node has no successor