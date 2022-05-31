% ligações entre nos
arcohc(um,tres).
arcohc(um,cinco).
arcohc(um,seis).
arcohc(um,sete).
arcohc(um,oito).
arcohc(tres,quatro).
arcohc(quatro,dois).
arcohc(cinco,dois).
arcohc(seis,dois).
arcohc(sete,dois).
arcohc(sete,seis).
arcohc(oito,tres).
arcohc(oito,sete).

% distancia entre os nos
distancia(um,tres,25).
distancia(um,cinco,100).
distancia(um,seis,55).
distancia(um,sete,34).
distancia(um,oito,55).
distancia(tres,quatro,40).
distancia(quatro,dois,20).
distancia(cinco,dois,25).
distancia(seis,dois,30).
distancia(sete,dois,0).
distancia(sete,seis,15).
distancia(oito,tres,0).
distancia(oito,sete,25).
consulta_distancia(X,Y,D):- distancia(X,Y,D);distancia(Y,X,D). % reverse distance

% custo de alojamento entre nos (apenas o custo do no de partida)
custo_aloj(um,tres,50).
custo_aloj(um,cinco,50).
custo_aloj(um,seis,50).
custo_aloj(um,sete,50).
custo_aloj(um,oito,50).
custo_aloj(tres,quatro,240).
custo_aloj(quatro,dois,150).
custo_aloj(cinco,dois,400).
custo_aloj(seis,dois,70).
custo_aloj(sete,dois,30).
custo_aloj(sete,seis,30).
custo_aloj(oito,tres,100).
custo_aloj(oito,sete,100).


%----------------
% utilizacao
hc(Inicio,Fim) :-
	once(hillclimbing(Inicio,Fim,Solucao)),
	totalD(Solucao,D),totalC(Solucao,C),
	write('\nSolucao otima: '),print(Solucao),
	write('\nDistancia total: '),print(D),
	write('\nCusto total: '),print(C).
%----------------


%----------------
%codigo adaptado de Grupo29 (SBC 19/20 MiEGSI) e hill_climbing_lugares do arquivo de TIA 21/22

%Caminho
hc_caminho(X,Z,Caminho):-
 hc_caminho(X,Z,[X],R),
 reverse(R,Caminho).
hc_caminho(X,X,Caminho,Caminho).
hc_caminho(X,Z,Visitado,Caminho):- arcohc(X,Y),
\+ member(Y,Visitado), %sempre que houver um novo estado, não pode pertencer à lista dos caminhos já visitados
hc_caminho(Y,Z,[Y|Visitado],Caminho).

%total de distância
totalD([_],0).
totalD([X,Y|Z],D):-
 consulta_distancia(Y,X,D1),
 totalD([Y|Z],D2),
 D is D1+D2.

%total de custos
totalC([_],0).
totalC([X,Y|Z],C):-
 custo_aloj(X,Y,C1),
 totalC([Y|Z],C2),
 C is C1+C2, C=<450.

%melhor solução
custo(X,Y,S) :-
 hc_caminho(X,Y,S),
 custootimo(X,Y,S).
 custootimo(X,Y,S) :-
 somar(S,NS), !,
 \+ maiorcusto(X,Y,NS).

maiorcusto(X,Y,NS) :-
 hc_caminho(X,Y,S1),
 somar(S1,NS1),
 NS1>NS.

somar(S1,NS1) :-
 totalC(S1,C),
 totalD(S1,D),
 NS1 is C+D. %soma do custo e distancia 

solucao(X,Y,S) :-
 hc_caminho(X,Y,S),
 totalC(S,_),
 totalD(S,_).

%----------------------------------

change([X|S], SNEW):-
 reverse(S,[Y|_]),
 caminho_aleatorio(X,Y,SNEW).

caminho_aleatorio(X,Y,Saleatorio):-
 findall(S,solucao(X,Y,S),L),
 random_member(Saleatorio,L).

hillclimbing(X,Y,S):-
 caminho_aleatorio(X,Y,S0),
 hill_climbing(S0,[20,0,min],S).


% return SR, the best value of S1 and S2: SR (solution) and ER (somar)
best(Prob,Opt,S1,E1,S2,E2,SR,ER):-
	somar(S2,E2),
	best_opt(Prob,Opt,S1,E1,S2,E2,SR,ER).

best_opt(Prob,_,_,_,S2,E2,S2,E2):-
	random(X), % random from 0 to 1,
	X< Prob. % accept new solution

best_opt(_,Opt,S1,E1,S2,E2,SR,ER):- % else, select the best one
    ( (Opt=max,max_list([E1,E2],ER));(Opt=min,min_list([E1,E2],ER)) ),
    ( (ER==E1,SR=S1); (ER==E2,SR=S2) ).

% show evolution:
show(final,S1,E1,_,_):-
	 write('final:'),write(' S:'),write(S1),write(' E:'),write(E1),nl.
show(0,S1,E1,_,_):-
	write('init:'),write(' S0:'),write(S1),write(' E0:'),write(E1),nl.
show(I,S1,E1,S2,E2):-
	write('iter:'),write(I),write(' S1:'),write(S1),write(' E1:'),
	write(E1),write(' S2:'),write(S2),write(' E2:'),write(E2),nl.
show(_,_,_,_,_,_).

% hill climbing
% Prob=0 is pure hill climbing, Prob>0 means Stochastic Hill Climbing
hill_climbing(S0,[MaxIter,Prob,Opt],S1):-
	somar(S0,E0),
    show(0,S0,E0,_,_),
	hill_climbing(S0,E0,0,MaxIter,Prob,Opt,S1).

hill_climbing(S,_,IterAtual,MaxIter,_,_,S):-
 IterAtual >= MaxIter.

hill_climbing(S1,E1,IterAtual,MaxIter,Prob,Opt,SFinal):-
	change(S1,SNew),
	best(Prob,Opt,S1,E1,SNew,_,S2,E2),
	NovoIterAtual is IterAtual+1,
    show(NovoIterAtual,S1,E1,S2,E2),
	hill_climbing(S2,E2,NovoIterAtual,MaxIter,Prob,Opt,SFinal).