# Projeto de Sinais e Sistemas

## Como funciona o projeto

* O programa recebe o tipo de circuito desejado e os valores dos parâmetros.
* É criado um objeto (herda de Circuit) que representa o circuito e pode responder à entradas.
* Cria-se um solver que recebe o circuito.
* O solver realiza testes no circuito e identifica o tipo do circuito e seus parâmetros.

## system.py

Esse arquivo define os circuitos, simula suas saídas e define métodos para facilitar o entendimento do sistema. ( Plot das saídas, diagrama de bode, etc)

# Estratégia Usada

A idéia inicial era a seguinte: aplicar a transformada de fourier(fft) na saída ao impulso do sistema e tentar fazer um fitting com todas as funções de transferência, escolhendo a função com menor erro quadrático.

Seguindo essa metodologia, conseguiríamos encontrar qual o circuito em questão e os seguintes parâmetros, para cada sistema.

* RC: R*C
* RL: R/L
* RLC ( três casos): R/L e 1/L*C

Apesar de inúmeras tentativas, não foi possível casar as funções de transferências com a transformada da saída ao impulso unitário e tivemos que simplificar nossa abordagem.

Decidimos então fazer o fitting diretamente na saída esperada por cada circuito. Isso funcionou perfeitamente para os casos RL e RC. Para os casos RLC, o fitting não convergiu.