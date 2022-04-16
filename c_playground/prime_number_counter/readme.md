# Oi! 🤭

Tudo bem?

Vamos por partes, essa é uma aplicação em C e precisa ser compilada para funcionar no seu computador.

# Mas não se assuste! 🙊

Tentarei ser o mais sucinto para você poder rodar essa aplicação, entender o que fiz e porque fiz as coisas do jeito que está aqui.

## Ambiente

Você precisa ter um ambiente de desenvolvimento, e irei supor que você não tenha, se tiver pode ir para a próxima etapa.

- [ ] Baixa esse código e coloca numa pasta
  - Ali no cantinho tem um botão verde escrito "Code" ou "Código"
  - Clica nele e então escolhe a opção "Download as zip" ou "Baixar como Zip"
  - Baixou? Então descompacta em uma pasta para trabalhar
  - Tá com tudo descompactado, então bora pro próximo item
- [ ] Você precisa de um compilador em C para rodar
  - **Linux**: Você já tem ele instalado, sério já vem de fábrica.
  - **Mac**: Só adicionar o [developer tools](http://developer.apple.com/) e você ganha essa ferramenta.
  - **Windows**: Deu ruim pra tí. O windows não gosta de desenvolvedor e tu vai ficar chupando dedo... Então, não é isso, mas é bem perto disso, leia isso aqui e tenta se virar como consegue, a verdade é que se tu está desenvolvendo, é hora de ir para o Linux. [Instalando o GCC do jeito fácil (inglês)](https://dev.to/gamegods3/how-to-install-gcc-in-windows-10-the-easier-way-422j)
- [ ] Você vai precisar rodar um programa chamado `make` para compilar
  - **Linux**: Já vem de fábrica na maioria das distro, se tua não tem você não deveria estar lendo isso, afinal tu usa uma distro _hardcore_.
  - **Mac**: Se instalou as [ferramentas de desenvolvedor](http://developer.apple.com/) ali em cima você ganhou o `make` de brinde.
  - **Windows**: Mais outra dor de cabeça, o windows não tem suporte direito ao `make`, então talvez esteja no hora de ir para o Linux... Acho que é um excelente momento. Inclusive o [Linux Mint](https://linuxmint.com/) é muito bom pra quem está vindo do Windows, e é a melhor porta de entrada para quem quer entrar no meio. (Ps.: A página de download dele é feia, mas o sistema operacional é bem bonito, confia em mim)
- [ ] Terminal
  - **Linux**: Na maioria das distros é apertar `super + t` ou `super + alt + t` ou alguma variante disso. Caso contrário abre teus app e escreve terminal, ele deve aparecer.
  - **Mac**: `command + space` e então digita `terminal`, abre ele.
  - **cmd**: `windows + r` e então escreve `cmd`, e tens o PIOR terminal do mundo rodando. Sério, windows é bem ruim para desenvolver.
- [ ] Você vai precisar de um editor de texto, o bloco de notas funciona, mas se quiser algo melhor tem algumas opções, baixa e instala.
  - [**VS Code**](https://code.visualstudio.com/)
  - [**Sublime Text**](https://www.sublimetext.com/)
  - [**Atom**](https://atom.io/)

## Abre o projeto no editor de texto

Se pegou um editor para programar, bora usar ele, caso contrário abre as coisas no bloco de notas e bora ser feliz! No caso dos editores, você abre a pasta onde estão os arquivos e não os arquivos em sí.

Assim que tu abrir tens algumas pastas, vamos dar uma olhada nelas:

- **src**: É uma convenção chamar a pasta onde estão teus arquivos de código fonte de "source", ou "fonte" em inglês. Nesse caso abreviando para "src". Aqui tem todos os arquivos que fazem a aplicação rodar.
  - **main.c**: Este é o coração da aplicação. Toda aplicação em C precisa de um cara que vai ser a entrada do aplicativo, nesse caso o arquivo "main.c", ou "principal" em tradução literal.
  - **demais arquivos**: São os arquivos de suporte para o principal, apenas possuem funções para me ajudar a fazer a aplicação acontecer.
- **obj**: Como C é uma linguagem compilada, precisa transformar o código escrito em C em linguagem de máquina, em "zeros e uns" que o computador vai ler. Esses arquivos são chamados de "objects" ou "objetos", nesse caso apenas ficam com a extensão ".o", e ficam guardados aqui.

Agora vamos olhar os arquivos que estão soltos:

- **.gitignore**: Apenas para uso do github, ignore esse cara
- **Makefile**: Esse é o configurador para automatizar o processo de compilação, ele faz algumas coisas por trás dos panos, mas no geral ele vai ser lido pelo comando `make` e vai transformar os arquivos C na pasta **src** em um só cara para ser executado na pasta raiz.

# Compilando e Rodando

Se você tem o **gcc** e o **make** instalado na sua máquina, precisa apenas abrir o terminal (tem como abrir uns tópicos acima), e navegar até a pasta (vou ajudar aqui, usa o comando `cd` para navegar), e então uma vez na pasta onde existe o arquivo **Makefile**, basta rodar o comando `make` no terminal e a magia acontece.

Uma vez que rode comando `make`, deve ter um resultado como abaixo:

```
gcc -std=c11 -Wall -o obj/is_prime.o -c src/is_prime.c
gcc -std=c11 -Wall -o obj/ask_int.o -c src/ask_int.c
gcc -std=c11 -Wall -o obj/main.o -c src/main.c
gcc -std=c11 -Wall -o primes_number obj/is_prime.o obj/ask_int.o obj/main.o
```

Isso quer dizer que foi gerado os arquivos de objetos e por final foi gerado um arquivo na mesma pasta que está o **Makefile** chamado `primes_number`.

Agora é só digitar no terminal o comando `/primes_number` e pronto, vai estar executando um programa que você mesmo compilou.

# Endentando o código

Agora irei entrar nos detalhes do que está acontecendo aqui, primeiro qual é a intenção desse código?

**O que esse aplicativo faz?**

Porque estou falando isso? Porque tenha em mente que aplicativos de qualquer natureza tem que resolver algum problema, se não resolver um problema, você não precisa dele, simples assim.

Nesse caso esse aplicativo recebe dois números e então ele verifica quais números entre os que foram dados são números primos. E ele retorna uma lista com os números primos. Ressalto que rodar isso em números grandes pode travar o computador pelo esforço computacional para calcular se é um número primo ou não.

**Porque escrevi esse código?**

Escrevi esse código porque estou querendo aprender melhor como usar o `Makefile` e como trabalhar em C com múltiplos arquivos, entender as peculiaridades, e os detalhes que são impostos ao trabalhar com esse tipo dinâmico de importação.

### Main.c

Este é o arquivo coração da aplicação, irei tentar passar nos principais do arquivo.

Primeiro de tudo os `includes` são para adicionar recursos ao aplicativo de C que está escrevendo, nesse caso trazendo funcionalidades que não estão por padrão a aplicação C, nesse caso estou importando uma biblioteca padrão `<stdio.h>` e duas funções que escrevi para me ajudar.

```c
#include <stdio.h>    // Importa ferramentas básicas para serem usadas, como por exemplo a função 'printf'
#include "ask_int.h"  // Importa a função que fiz para perguntar ao usuário qual é o numero, mais dela abaixo
#include "is_prime.h" // Importa a função que fiz para calcular se um numero é primo ou não, mais dela abaixo
```

Em C é preciso declarar todas as funções que você escreve antes da função `main()`, dessa maneira é declarado a função aqui:

```c
void loop_throught(int, int);
```

E por final o corpo da função, o _principal_,

```cpp
int main()              // Nome da função tem que ser 'main' senão o compilador não sabe por onde começar
{
  int x = 0;            // Declaração de variável com o valor de zero
  int y = 0;            // Outra declaração, poderia ter feito na mesma linha

  x = ask_int();        // Aqui é chamada a função de suporte que foi declarada antes
  y = ask_int();        // Novamente

  loop_through(x, y);   // Aqui é chamada outra função mais abaixo no documento

  return 0;             // Encerrado a aplicação C, ela sempre retorna 0
}
```

Perceba que a aplicação **main.c** não faz nada sozinha, ela apenas chama os outros códigos que estão espalhados, fiz isso propositalmente, porque estou praticando como separar o código em vários arquivos e separar ele em várias etapas.

```cpp
void loop_through(int start, int end)    // Nome da função, perceba que ela recebe dois argumentos, start e end
{
  for (size_t i = start; i < end; i++)   // Essa é uma estrutura de loop, basicamente ela vai contar do 'start' até o 'end' em cada passagem ela vai ter um valor chamado 'i', eu irei usar esse valor 'i' para saber se ele é ou não um numero primo
  {
    if (is_prime(i))                      // Aqui é chamada a função que foi importada no inicio desse arquivo, ela verifica se é um número primo ou não, se for um número primo ele então executa o que está dentro desse condicional
    {
      printf("%ld \t", i);                // Se o número for primo, então ele vai escrever na tela e dar um "tab" marcado ali como \t
    }
  }

  printf("\n");                           // Por final insere uma linha nova, para os próximos comandos com o \n
}
```

### ask_int.c e ask_int.h

Não irei entrar nos detalhes do `ask_int.h`, mas ele é um arquivo de header, um cabeçalho para poder importar os outros arquivos de C, basicamente é isso, ignora ele e vamos no arquivo `ask_int.c`

Assim como no arquivo `main.c`, nesse arquivo também é importado a biblioteca padrão do C

```cpp
#include <stdio.h>
```

Essa função tem o objetivo de perguntar ao usuário para digitar um número, e então colocar esse número numa variável, e por final retornar a variável a quem chamou essa função.

```cpp
int ask_int()                 // Nome da função
{
  int number = 0;             // Inicializada a variável, e aplicado o valor 0
  printf("Type a number: ");  // Escreve na tela a pergunta
  scanf("%d", &number);       // Abre o prompt (cursor piscando) para digitar, e coloca o valor na variável

  return number;              // Retorna o valor para quem chamou a função
}
```

### is_prime.c e is_prime.h

Denovo, bora focar no arquivo C e não no header, então vamos olhar o arquivo `is_prime.c`.

Assim como nos outros arquivos, aqui também fazemos importações, nesse caso tem uma biblioteca especial, para adicionar o tipo `bool` que não é parte da linguagem C (sim, o C é bem velho e isso não é um tipo básico)

```cpp
#include <stdio.h>
#include <stdbool.h>
```

Agora ao corpo dessa função, ela basicamente faz validações e então passa por uma estrutura de repetição para verificar se o numero é primo ou não.

```cpp
bool is_prime(int value)              // Nome da função, ela recebe um numero como argumento
{
  if (value == 1 || value == 2)       // Se o numero for 1 ou 2, ela retorna verdadeiro, nem precisa calcular, isso acelera o processo
  {
    return true;                      // Encerra a função prematuramente retornado o valor verdadeiro
  }

  for (size_t i = 2; i < value; i++)  // Estrutura de repetição, começa no valor 2 e vai contando até o numero que entregamos como argumento da função
  {
    if ((int)value % (int)i == 0)      // Aqui dividimos o valor pelo numero de repetição 'i', se o restante da operação, ou em outras palavras, o módulo for igual a zero, então o numero tem um divisor que retorna ele inteiro, e assim não é um primo.
    {
      return false;                    // Encerra a função retornando o valor falso
    }
  }

  return true;                         // Se a função chegou até aqui é porque ela passou por toda a estrutura de repetição, dividiu o valor inicial por todos os valores até chegar nele mesmo e em nenhum momento era um numero não-primo, então pode retornar verdadeiro
}

```

### Conclusão

Divertido trabalhar em multiplos arquivos numa pequena aplicação em C, quero fazer mais alguns experimentos como esse, só não tenho certeza se irei escrever tanto assim, mas quero fazer mais testes e experimentos de aplicativos bobos como este aqui.

# Obrigado por ter lido até esse momento,

Se tiver dúvidas pode entrar em contato comigo, [aqui tem formas de contato](https://jeferson.me/)
