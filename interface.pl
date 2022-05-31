:- [database, gerartestar, dfs, bfs, hc].

:- initialization(manual).

manual :- nl,
    write('Manual de Utilizacao:'),nl,
    write('  menu.  - Consultar os algoritmos de pesquisa disponiveis'),nl,
    write('  info.   - Informacao sobre o programa'),nl,
    write('  manual. - Manual de utilizacao'),nl,
    write('  cls.    - Limpar consola'),nl,nl.

cls :- write('\e[H\e[2J').

info :- nl,
    write('Projeto desenvolvido no ambito da UC Tecnicas de Inteligencia Artificial'),nl,
    write('Engenharia e Gestao de Sistemas de Informacao'),nl,
    write('Universidade do Minho'),nl,
    write('2021/2022'),nl,nl,
    write('  Projeto 2 - Itinerario'),nl,nl.

menu :- nl,nl,nl,
    write('Bem-vindo ao seu ajudante de escolha de itinerario.'),nl,nl,
    write('Por favor escolha o metodo de resolucao: '),nl,
    write('  1. Gerar&Testar'),nl,
    write('  2. Hill-Climbing '),nl,
    write('  3. Depth-First'),nl,
    write('  4. Breadth-First'),nl,
    write('  5. Sair'),nl,
    write('Introduza a sua escolha: '),
    read(X),
    escolhaMenu(X).

escolhaMenu(1) :- gerartestar.
escolhaMenu(2) :- hillclimbing.
escolhaMenu(3) :- depthfirst.
escolhaMenu(4) :- breadthfirst.
escolhaMenu(5) :- write('Obrigado por utilizar o nosso servico.'), halt.
escolhaMenu(other) :- write('Por favor introduza uma opcao valida.'), menu.

gerartestar :- nl,nl,nl,
    write('Predicados disponiveis: (numeros por extenso)'),nl,
    write('  caminhoMaisCurto(inicio,fim,Caminho).      - Caminho de menor distancia'),nl,
    write('  caminhoMaisLongo(inicio,fim,Caminho).      - Caminho de maior distancia'),nl,
    write('  caminhoMenorCusto(inicio,fim,Caminho).     - Caminho de menor custo'),nl,
    write('  caminhoMaiorCusto(inicio,fim,Caminho).     - Caminho de maior custo'),nl,
    write('  caminhoMaisVantajoso(inicio,fim,Caminho).  - Caminho com melhor relacao custo/distancia'),nl.

hillclimbing :- nl,nl,nl,
    write('Predicado disponivel: (numeros por extenso)'),nl,
    write('  hc(inicio,fim).  - Caminho de menor distancia'),nl.

depthfirst :- nl,nl,nl,
    write('Predicados disponiveis: (numeros por extenso)'),nl,
    write('Assume inicio do itinerario no L1'),nl,
    write('  todos_dfs(objetivo, Solucao, Length, Custo).   - Todos os caminhos'),nl,
    write('  shortest_dfs(objetivo, Solucao, Length).       - Caminho de menor distancia'),nl,
    write('  cheapest_dfs(objetivo, Solucao, Custo).        - Caminho de menor custo'),nl,
    write('  best_dfs(objetivo, Solucao, Length, Custo).    - Caminho com menor distancia e custo'),nl.

breadthfirst :- nl,nl,nl,
    write('Predicados disponiveis: (numeros por extenso)'),nl,
    write('Assume inicio do itinerario no L1'),nl,
    write('  todos_bfs(objetivo, Solucao).    - Todos os caminhos'),nl.
