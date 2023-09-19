---
title: Onde eu começo?
published: true
description: Os primeiros passos para escrever para web
tags: web development, personal,
cover_image: https://dev-to-uploads.s3.amazonaws.com/i/thzz4wxw2v8c992ncij4.png
---

[This is in portuguese, wanna know why? Click here!](https://dev.to/shinspiegel/this-is-my-first-post-3d1)

### Antes de tudo, vamos preparar o básico!

Vamos por partes, para essa receita você vai precisar de:

- Um editor de texto
- Um navegador moderno

Mas calma aí, isso é muito vago, então vamos colocar algo mais definitivo, você vai precisar de:

- [Desse editor de Texto](http://brackets.io/)
- [Desse navegador](https://www.google.com/chrome/)

Beleza, então vamos para a próxima etapa, precisamos de um lugar para fazer isso. Então cria uma pasta nova no sua área de trabalho e escolhe um nome legal como: "Minha Super Pagina".

Escolheu a pasta?
Beleza, então bora a próxima etapa, precisamos instalar o que foi baixado, então instala o [Brackets](http://brackets.io/) e o [Chrome](https://www.google.com/chrome/). Eu acredito que você está vendo isso pelo chrome, então tá beleza.

Abre o [Brackets](http://brackets.io/), ignora tudo o que ele estiver exibindo, e vamos direto para "Arquivo -> Abrir Pasta" (se tiver em inglês é "File -> Open Folder"), e escolhe a tua pasta com nome legal. Clicou na pasta e clicou em "Abrir" e pronto, tudo vai estar em branco.

Isso é um bom sinal, vamos começar limpos nisso aqui.
Então é isso aqui o que você tem:
![Ponto Inicial](https://dev-to-uploads.s3.amazonaws.com/i/thzz4wxw2v8c992ncij4.png)

### Legal, legal, mas e agora?

Tá vendo que existe uma area em cinza na lateral esquerda e em cima tá escrito o nome super legal da sua pasta?

Beleza, isso quer dizer que ali é sua pasta, e você pode ver os arquivos que estão dentro dela. Toda essa área é um local onde você pode usar para criar arquivos, então dentro dessa área cinza (_mas não em cima do nome da pasta_), clica com o botão direito e coloca para criar um "Novo Arquivo" (ou "New File" em inglês).

Qual o nome desse arquivo?

**index.html**

Opa, coisas mudaram!
Agora eu tenho uma area dos arquivos que estou editando, e tem também um numero 1 na tela em branco!

![Mudou!](https://dev-to-uploads.s3.amazonaws.com/i/6f6y8pzxbnqc4i5177uv.png)

### Beleza, mas o que é o "index" e o que é o "html" ?

Vamos lá, "index" significa que este é o arquivo de entrada, é o "índice" da sua página, como padrão é o local de entrada de qualquer página na internet.

E o "html" é a extensão do arquivo _[Linguagem de Marcação de Hipertexto](https://pt.wikipedia.org/wiki/HTML)_.

Wooooow! Hypertexto, tem hyper no nome, então é legal!

Certo, mas o que é isso? É uma linguagem para escrever textos que tenham coisas diferentes, que tenham interações e que possam ser lidos pelo navegador e sejam iguais não importa se a pessoa usa um navegador no Brasil ou na China.

### Mas como se escreve uma página?

A primeira coisa é quemos que falar que essa página é um texto em HTML, e para isso precisamos escrever isso.

```html
html
```

Mas como um navegador vai entender que isso é html e não um arquivo de texto do TXT ou do Word?

Para isso é preciso colocar algo para o navegador entender que isso é uma página de internet, para isso vamos colocar [tags](<https://pt.wikipedia.org/wiki/Tag_(linguagens_de_marca%C3%A7%C3%A3o)>), e nossa primeira tag vai ser:

```html
<html></html>
```

**Pera aí!!!!** Tá escrito duas vezes!

A primeira `<html>` é para abrir essa tag, a segunda é para fechar, `</html>`. Ou seja tudo que estiver escrito no meio dessa tag será um texto html.

Então vamos colocar isso em prática, bora escrever nossa primeira página.

```html
<html>
  Minha primeira página
</html>
```

Tudo o que estiver dentro vai ser escrito no navegador. Mas cadê o navegador não é mesmo?

Agora que tu escreveu isso, então clica no razio que tem do lado, aquele raiozinho ali.

![Esse raio](https://dev-to-uploads.s3.amazonaws.com/i/1427vka40zsbrw0ql9jq.png)

Ele vai dar uma mensagem, aceita ela por enquanto, depois vamos ler ela melhor, por enquanto é colocar isso num navegador.

E o [Chrome](https://www.google.com/chrome/) vai abrir. Ele abriu? Ele tá mostrando a mensagem?

![Minha primeira página](https://dev-to-uploads.s3.amazonaws.com/i/ktot80xehbh0b2l9po54.png)

Apareceu?

Feio né, na verdade tá bem _xôxo_. Não desanima, a gente escreveu 3 linhas e temos uma página rodando, isso é lindo, já é um feito maior do que muita gente consegue chegar, então fica feliz e fica orgulhoso!

Eu não irei entrar nos detalhes, mas isso está sendo executado apenas no seu computador, e apenas nele, não está ainda no mar da internet, vamos chegar nesse ponto no futuro, por enquanto, vamos primeiro ter algo bonito para mostrar para o mundo.

Beleza, agora que fazemos?

Vamos colocar isso lado a lado para ficar fácil de ver, esse é um bom ponto.

![Lado a lado](https://dev-to-uploads.s3.amazonaws.com/i/poov07quztrv0myej3pm.png)

Bonito né? Tá parecendo um profissional fazendo isso.

### E como eu deixo isso bonito?

Ahhhh garoto! Agora que começamos a deixar isso bonito.

Vamos começar que não tem graça isso, vamos fazer algo mais elaborado, então vamos entender algo, `<html>` não é a unica tag que existe, tem várias na verdade, mas vamos por partes.

Vamos colocar um título e vamos colocar uma descrição para o que estamos fazendo aqui, e para isso vamos precisar de uma tag para título e uma para texto.

Existem vários tipos de títulos, mas vamos começar com o título que precisamos, a tag `<h1>`. H? Que? Então, esse `h` vem do inglês `heading`, em outras palavras, `título 1`, vamos lá, e para o texto temos o `<p>`, que é para parágrafos.

```html
<html>
  <h1>
    Minha primeira página!
  </h1>
  <p>
    Agora eu tenho um texto legal aqui!
  </p>
</html>
```

Tá vendo, abrimos a tag `<h1>` e fechamos ela, assim como o `<html>`, o mesmo a gente fez com o `<p>`. E para ver isso no navegador? Ele atualiza sozinho, mas se não atualizar, clica no botão para atualizar a página, e ele deve atualizar para mostrar agora isso.

Ainda não está bonito, porque ele está sem graça, o fundo é branco, as letras são pretas. Como eu altero isso?

Para isso precisamos adicionar estilo. Mas como adiciona estilo? Advinha? Tem uma tag para estilo, ela é o `<style>`!

```html
<html>
  <style>
    ?
  </style>
  <h1>
    Minha primeira página!
  </h1>
  <p>
    Agora eu tenho um texto legal aqui!
  </p>
</html>
```

Mas o que se coloca nessa tag? Isso não vai aparecer na minha página ou vai? Como eu faço?

Beleza, se acalma, sei que é muita emoção, mas o estilo não vai aparecer nada escrito, o navegador sabe que quando encontrar essa tag `<style>` você quer colocar estilo para as coisa e não escrever nada de texto na página.

Mas como se coloca um estilo?

A primeira coisa é que temos que escolher o que vamos colocar estilo, nesse caso vamos colocar uma cor de fundo, então temos que colocar uma cor no fundo da página. A nossa página esta tudo dentro do `<html>`, então iremos selecionar isso, e depois vamos colocar uma cor de fundo.

```html
<html>
  <style>
    html {
      background-color: orange;
    }
  </style>
  <h1>
    Minha primeira página!
  </h1>
  <p>
    Agora eu tenho um texto legal aqui!
  </p>
</html>
```

Eita! Calma lá, isso não parece HTML! Isso é outra coisa! E isso é mesmo, e porque é diferente? Porque o navegador tem que saber que isso é apenas de estilo, por isso que está escrito diferente do HTML.

Mas vamos com calma, vamos entender o que aconteceu ali:

```css
html {
  background-color: orange;
}
```

Tá vendo, agora que tá separado é bem mais fácil de entender, estamos escolhendo o `html`, e então abrimo as chaves `{}`, muito parecido com abrir e fechar as tags, e colocamos algo dentro disso, nesse caso colocamos `background-color: orange;`.

Fica atento numa coisa, tá vendo que tem um ponto e vírgula? Ele precisa estar ali, porque o navegador é meio tanso, ele não sabe quando termina a linha e precisa colocar esse ponto e vírgula para ele saber.

Isso já ficou legal, a página já tem um fundo laranja super dahora!

E agora? Vamos continuar então, vamos agora colocar o texto no centro da página, e advinha? Vamos selecionar o `h1`!

```html
<html>
  <style>
    html {
      background-color: orange;
    }

    h1 {
      color: white;
      text-align: center;
      font-size: 56px;
      margin-top: 100px;
    }
  </style>
  <h1>
    Minha primeira página!
  </h1>
  <p>
    Agora eu tenho um texto legal aqui!
  </p>
</html>
```

Percebeu? Você pode colocar mais do que uma estilização por seleção, nesse caso estamos alterando a cor do texto, alterando o alinhamento para o centro, o tamanho da fonte e por final colocando uma margin no topo.

Para o navegador, ele entender melhor a unidade de medida `pixel`, nesse caso está abreviado para `px`, então `56px` significa `56 pixel`. Beleza, legal, agora vamos colocar mais alteração no texto? E você já pegou a minha, vamos selecionar no `<p>`!

```html
<html>
  <style>
    html {
      background-color: orange;
    }

    h1 {
      color: white;
      text-align: center;
      font-size: 56px;
      margin-top: 100px;
    }
    p {
      text-align: center;
      color: red;
      font-size: 48px;
      font-family: sans-serif;
    }
  </style>
  <h1>
    Minha primeira página!
  </h1>
  <p>
    Agora eu tenho um texto legal aqui!
  </p>
</html>
```

Legal né? Tá vendo ali o `font-family`? É para alterar o tipo de fonte, nesse caso ficou o `sans-serif` que é para pegar uma fonte no estilo da `Arial` ou algo assim, o que tiver mais fácil para o navegador. Mais tarde vamos aprender a escolher a fonte que quisermos.

Mas tá bagunçado né? Ali temos o estilo, no meio do que é escrito, no meio de tudo, assim jogado. Isso não tá bonito. E para isso temos duas tags para organizar, `<body>` e `<head>`

Então, tudo que é configuração fica dentro do `<head>` da cabeça da página, sejam os estilo, _scripts_ e coisas assim, e o que é texto para ser mostrado fica no `<body>` no corpo da página.

```html
<html>
  <head>
    <style>
      html {
        background-color: orange;
      }

      h1 {
        color: white;
        text-align: center;
        font-size: 56px;
        margin-top: 100px;
      }
      p {
        text-align: center;
        color: red;
        font-size: 48px;
        font-family: sans-serif;
      }
    </style>
  </head>
  <body>
    <h1>
      Minha primeira página!
    </h1>
    <p>
      Agora eu tenho um texto legal aqui!
    </p>
  </body>
</html>
```

![Final](https://dev-to-uploads.s3.amazonaws.com/i/lfiw0ncyk9ops13qo5e1.png)

Legal né? Na próxima vamos elaborar mais isso!

(()=>{})()
