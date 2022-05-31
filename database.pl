%database

goal(um).

/*
%arco(inicio,fim)
arco(um,tres).
arco(um,cinco).
arco(um,seis).
arco(um,sete).
arco(um,oito).
arco(tres,quatro).
arco(quatro,dois).
arco(cinco,dois).
arco(seis,dois).
arco(sete,dois).
arco(sete,seis).
arco(oito,tres).
arco(oito,sete).

%dist(inicio,fim,distancia)
dist(um,tres,25).
dist(um,cinco,100).
dist(um,seis,55).
dist(um,sete,34).
dist(um,oito,55).
dist(tres,quatro,40).
dist(quatro,dois,20).
dist(cinco,dois,25).
dist(seis,dois,30).
dist(sete,dois,0).
dist(sete,seis,15).
dist(oito,tres,0).
dist(oito,sete,25).

%custo_aloj(local,custo)
custo_aloj(um,50).
custo_aloj(dois,0).
custo_aloj(tres,240).
custo_aloj(quatro,150).
custo_aloj(cinco,400).
custo_aloj(seis,70).
custo_aloj(sete,30).
custo_aloj(oito,100). */

%GRAFO INVERTIDO PARA RESOLVER O PROB DAS LISTAS AO CONTRARIO

%arco(fim,inicio)
arco(tres,um).
arco(cinco,um).
arco(seis,um).
arco(sete,um).
arco(oito,um).
arco(quatro,tres).
arco(dois,quatro).
arco(dois,cinco).
arco(dois,seis).
arco(dois,sete).
arco(seis,sete).
arco(tres,oito).
arco(sete,oito).

%dist(inicio,fim,distancia)
dist(tres,um,25).
dist(cinco,um,100).
dist(seis,um,55).
dist(sete,um,34).
dist(oito,um,55).
dist(quatro,tres,40).
dist(dois,quatro,20).
dist(dois,cinco,25).
dist(dois,seis,30).
dist(dois,sete,0).
dist(seis,sete,15).
dist(tres,oito,0).
dist(sete,oito,25).

%custo_aloj(local,custo)
custo_aloj(um,50).
custo_aloj(dois,0).
custo_aloj(tres,240).
custo_aloj(quatro,150).
custo_aloj(cinco,400).
custo_aloj(seis,70).
custo_aloj(sete,30).
custo_aloj(oito,100).