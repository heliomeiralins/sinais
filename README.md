# Projeto de Sinais e Sistemas

## Como funciona o projeto

* O programa recebe o tipo de circuito desejado e os valores dos parâmetros.
* É criado um objeto (herda de Circuit) que representa o circuito e pode responder à entradas.
* Cria-se um solver que recebe o circuito.
* O solver testa o circuito com entradas ( que podem variar dependendo de como o circuito responde à entradas anteriores) e processa as saídas. As entradas serão criadas usando o sympy.
* Após testar o circuito com as entradas, o solver deve identificar o tipo do circuito e seus parâmetros.

## Simulação de Circuitos

(hélio) Estou implementando essa parte em Python. Usando numpy, scipy, sympy e python 3.4. Atualmente não estou salvando a saída em nenhum lugar, mas já dá pra ver os gráficos.
Alguns detalhes:

* A entrada é definida como uma função simbólica do sympy. ( por exemplo: t = Symbol('t'); entrada = 2*t; )
* A saída é calculada após integrar a corrente usando o scipy.integrate.odeint.
* Uma classe abstrata ( Circuit) contém toda a lógica de gerar a saída.
* Uma classe será criada para cada circuito do problema. Basta instanciar os métodos corretamente.
* O método 'f' representa o sistema de equações diferenciais para a corrente. Nos casos do RC e RL, f() é simplesmente a derivada da corrente. No caso RLC, é um vetor cujo primeiro atributo é a derivada da corrente e o segundo atributo sua segunda derivada. ( posso explicar melhor sobre como esse sistema é formado) ( isso foi feito pq o numpy só integra assim..)
* O método 'initial' representa as condições iniciais do circuito.
* O método '_output' cálcula a saída do circuito dada a corrente.
