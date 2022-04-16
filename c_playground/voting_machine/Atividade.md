As disputas para uma eleição de prefeitos e vereadores em uma cidade estavam muito acirradas, foi então que a imprensa local lançou a ideia de criar algumas urnas de pesquisa pela cidade para fazer uma pesquisa eleitoral sobre o panorama da votação. Você como funcionário de TI da imprensa responsável pela ideia foi designado para fazer um programa eleitoral em C para simular uma votação.

- Os vereadores que serão pesquisados são:
    111 - Vereador Joao do Frete
    222 - Vereador Maria da Pamonha
    333 - Vereador Ze da Farmacia
    444 - Voto Nulo

- Para prefeito:
    11 - Prefeito Dr. Zureta
    22 - Prefeito Senhor Gomes
    44 - Voto Nulo

O programa deve apresentar um menu com 3 opções, são elas:
    1 - Votar
    2 - Apuração dos votos
    3 - Sair

Na opção 1, os candidatos devem ser votados através do número, se o número digitado estiver fora dos números apontados, este voto deve ser invalidado.
Na opcao 2, será mostrado a soma de todos os votos computados
Na opcao 3, o programa se encerrará

A sua atividade deve ser entregue em um arquivo de código fonte para linguagem C (extensão .c).

Algumas funções que serão úteis durante o desenvolvimento do programa:
 
* system(“pause”) – chamada de sistema que “pausa” o programa e o faz aguardar pelo usuário;
* system(“cls”) – chamada de sistema que limpa os caracteres que foram impressos na tela anteriormente;
* fflush(stdin) – limpar o buffer do teclado. Essa função deve sempre ser utilizada após ter utilizado alguma função de entrada de dados como o scanf, gets, etc. Isso se dá pois em algumas situações o buffer do teclado mantém “lixo de memória”, prejudicando a próxima operação de entrada do programa;
* A função setlocale(LC_ALL, "Portuguese") da biblioteca locale.h pode ser útil, caso você queira que os acentos e pontuações da língua portuguesa sejam impressos corretamente.