%gerartestar

%CustoCaminho
custoCaminho([],0).
custoCaminho([X|R],Soma) :- custo_aloj(X,CustoX), 
custoCaminho(R,CustoR), Soma is CustoX + CustoR.

guardarCustoCaminho(Caminho):- custoCaminho(Caminho, Valor), 
assertz(custo(Caminho, Valor)).

gerarCustoCaminhos([]).
gerarCustoCaminhos([C1|R1]):- guardarCustoCaminho(C1), gerarCustoCaminhos(R1).

%DistanciaCaminho
calcularDistancia(_,[],0).
calcularDistancia(P1,[P2|R2], Soma):- dist(P2,P1,Distancia), 
calcularDistancia(P2, R2, DistanciaPercorrida), Soma is Distancia + DistanciaPercorrida.

guardarDistancia([]).
guardarDistancia([P1|R1]):- calcularDistancia(P1,R1,Valor), assertz(comprimento([P1|R1], Valor)).

gerarDistanciasCaminhos([]).
gerarDistanciasCaminhos([C1|R1]):- guardarDistancia(C1), gerarDistanciasCaminhos(R1).

distanciaCaminho([P1|R1], Valor):-  calcularDistancia(P1,R1,Valor).

%CustoKM
calcularCustoKM(Caminho):- guardarDistancia(Caminho), guardarCustoCaminho(Caminho), 
custo(Caminho, CustoCaminho), comprimento(Caminho, DistanciaCaminho), 
assertz(custoKM(Caminho, CustoCaminho / DistanciaCaminho)).

gerarCustoKM([]).
gerarCustoKM([C1|R1]):- calcularCustoKM(C1), gerarCustoKM(R1).

custoKMCaminho(Caminho, Indice):- guardarDistancia(Caminho), guardarCustoCaminho(Caminho), 
custo(Caminho, CustoCaminho), comprimento(Caminho, DistanciaCaminho), Indice is CustoCaminho / DistanciaCaminho.

%CaminhosDisponiveis
caminho(X,Z,Caminho):- caminho(X,Z,[X],Caminho).
caminho(X,X,Caminho,Caminho):- custoCaminho(Caminho,Soma), Soma =< 450.
caminho(X,Z,Visitado,Caminho):- dist(X,Y,_), \+ member(Y,Visitado), 
caminho(Y,Z,[Y | Visitado],Caminho).

%GerarListaCaminhos
listaCaminhos(X,Y,Lista):- findall(C,caminho(X,Y,C),Lista).

%questoes

%CaminhoMaisCurto
caminhoMaisCurto(Y,X,Caminho):- retractall(comprimento(_,_)), listaCaminhos(X,Y,Lista), 
gerarDistanciasCaminhos(Lista), maisCurto(Caminho).

maisCurto(Caminho):- comprimento(Caminho, V), \+ (comprimento(_, V1), V > V1),
write('Distancia: '),print(V).

%CaminhoMaisLongo
caminhoMaisLongo(Y,X,Caminho):- retractall(comprimento(_,_)), listaCaminhos(X,Y,Lista), 
gerarDistanciasCaminhos(Lista), maisLongo(Caminho).

maisLongo(Caminho):- comprimento(Caminho, V), \+ (comprimento(_, V1), V1 > V),
write('Distancia: '),print(V).

%CaminhoMenorCusto
caminhoMenorCusto(Y,X,Caminho):- retractall(custo(_,_)), listaCaminhos(X,Y,Lista), 
gerarCustoCaminhos(Lista), menorCusto(Caminho).

menorCusto(Caminho):- custo(Caminho, V), \+ (custo(_, V1), V > V1),
write('Custo: '),print(V).

%CaminhoMaiorCusto
caminhoMaiorCusto(Y,X,Caminho):- retractall(custo(_,_)), listaCaminhos(X,Y,Lista), 
gerarCustoCaminhos(Lista), maiorCusto(Caminho).

maiorCusto(Caminho):- custo(Caminho, V), \+ (custo(_, V1), V1 > V),
write('Custo: '),print(V).

%CaminhoMaisVantajoso
caminhoMaisVantajoso(Y,X,Caminho):- retractall(custoKM(_,_)), listaCaminhos(X,Y,Lista), 
gerarCustoKM(Lista),!, maisVantajoso(Caminho).

maisVantajoso(Caminho):- custoKM(Caminho, V), \+ (custoKM(_, V1), V1 > V),
write('Custo/km: '),print(V).
