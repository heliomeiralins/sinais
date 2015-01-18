# Projeto de Sinais e Sistemas

## Como funciona o projeto

* O programa recebe o tipo de circuito desejado e os valores dos parâmetros.
* É criado um objeto (herda de Circuit) que representa o circuito e pode responder à entradas.
* Cria-se um solver que recebe o circuito.
* O solver testa o circuito com entradas ( que podem variar dependendo de como o circuito responde à entradas anteriores) e processa as saídas. As entradas serão criadas usando o sympy.
* Após testar o circuito com as entradas, o solver deve identificar o tipo do circuito e seus parâmetros.