# Projeto de Sinais e Sistemas

## Como funciona o projeto

* O programa recebe o tipo de circuito desejado e os valores dos parâmetros.
* É criado um objeto (herda de Circuit) que representa o circuito e pode responder à entradas.
* Cria-se um solver que recebe o circuito.
* O solver testa o circuito com entradas ( que podem variar dependendo de como o circuito responde à entradas anteriores) e processa as saídas. As entradas serão criadas usando o sympy.
* Após testar o circuito com as entradas, o solver deve identificar o tipo do circuito e seus parâmetros.

## Simulação de Circuitos

Implementado com numpy, scipy, sympy e python 3.4.
Alguns detalhes:

* A entrada é definida como uma função simbólica do sympy. ( por exemplo: t = sympy.Symbol('t'); entrada = sympy.sin(2*t); )
* A saída é calculada após integrar a corrente usando o scipy.integrate.odeint.
* Uma classe abstrata ( Circuit) contém toda a lógica de gerar a saída.
* Uma classe será criada para cada circuito do problema. Basta implementar os métodos  abstratos corretamente.
* O método 'f' representa o sistema de equações diferenciais para a corrente. Nos casos do RC e RL, f() é simplesmente a derivada da corrente. No caso RLC, é um vetor cujo primeiro atributo é a derivada da corrente e o segundo atributo sua segunda derivada. ( posso explicar melhor sobre como esse sistema é formado) ( isso foi feito pq o numpy só integra assim..)
* O método 'initial' representa as condições iniciais do circuito.
* O método '_output' calcula a saída do circuito dada a corrente.
* O método 'natural_time' dá um período suficiente para capturar a dinâmica transiente do circuito. Pode parecer que esse método é um pouquinho de "roubo", mas seria trivial integrar o circuito com uma entrada constante, esperar ele estabilizar ( por exemplo, i < 0.0001) e pegar o tempo necessário para isso acontecer.

### Exemplo de uso

    from sympy import Symbol, sin
    from circuit import RLCCircuit1
    t = Symbol('t')
    V = sin(t)
    c = RLCCircuit1(R=1,L=1,C=1)
    c.output(v, save=True, f='saida.txt')
