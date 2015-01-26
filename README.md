# Projeto de Sinais e Sistemas

## Como funciona o projeto

* O programa recebe o tipo de circuito desejado e os valores dos parâmetros.
* É criado um objeto (herda de Circuit) que representa o circuito e pode responder à entradas.
* Cria-se um solver que recebe o circuito.
* O solver realiza testes no circuito e identifica o tipo do circuito e seus parâmetros.

## system.py

Esse arquivo define os circuitos, simula suas saídas e define métodos para facilitar o entendimento do sistema. ( Plot das saídas, diagrama de bode, etc)

# Estratégia Usada

Como a resposta ao impulso determina o sistema, a idéia inicial era a seguinte: aplicar a transformada de fourier(fft) na saída ao impulso do sistema e tentar fazer um fitting com todas as funções de transferência, escolhendo a que acarreta um menor erro quadrático.

Seguindo essa metodologia, conseguiríamos encontrar qual o circuito em questão e os seguintes parâmetros, para cada sistema.

* RC: R*C
* RL: L/R
* RLC ( três casos): R/L e 1/L*C

Apesar de inúmeras tentativas, não foi possível casar as funções de transferências com a transformada da saída ao impulso unitário e tivemos que simplificar nossa abordagem. Apesar dos gráficos das transformadas serem semelhantes aos gráficos esperados, os valores não batiam com o esperado e o fitting simplesmente não convergia.

Decidimos então fazer o fitting diretamente na saída esperada por cada circuito no domínio do timpo. Isso funcionou perfeitamente para os casos RL e RC. Para os casos RLC, o fitting não convergiu e decidimos apelar para a voltagem de saída logo após o impulso. O sinal da voltagem determina o tipo de circuito RLC, e para os casos de RLC1 e RLC2, seu módulo determina o valor de R/L.

Resumindo, para cada circuito dado, nós tentamos fazer o fitting com a saída esperada do RC e do RL. Caso o circuito seja identificado, i.e. o erro do fitting é 'desprezível', temos também a constante de tempo.
Em seguida, analisamos diretamente o valor da voltagem logo após o impulso. Esse valor nos diz de qual circuito RLC se trata, e nós dá o valor de R/L para os circuitos RLC1 e RLC2.

Todas essas tentativas foram implementadas em Python 3.4, usando as bibliotecas numpy, scipy e matplotlib. Infelizmente, por motivos de tempo a documentação do software ficou precária mas resumindo temos dois arquivos:

* system.py. Neste arquivo, definimos os 5 circuitos através de suas funções de transferência e implementamos vários métodos para ajudar a visualizar as saídas e entender os circuitos ( ex. diagrama de Bode.).
* solver.py. Neste arquivo, há uma interface para o usuário escolher o tipo de circuito e os parâmetros e, dentro das limitações do nosso projeto, ele identifica o circuito e imprime seus parâmetros.
<<<<<<< HEAD

## Observações da parte Prática

O arquivo sinais.cpp não é exatamente o que foi usado nas simulações. A versão final ficou no computador do Grad de hardware, mas as alterações feitas foram replicadas por minha memória e infelizmente, sem testar depois. O algoritmo para calcular a constante de tempo está evidente.

A entrada foi uma senóide de OFFSET 2v e Vpp 10mv, de modo que a função oscila entre 1.95 e 2.05V, simulando assim um tensão DC.
=======
>>>>>>> ba441233710ade516e8b02fe7191785b1bb31b56
