---
title: Optional Chaining in JS
published: true
description: Optional chaining can be very hard to deal in javascript, the new syntax tries to solve this issue.
cover_image: https://media.giphy.com/media/12NUbkX6p4xOO4/giphy.gif
tags: javascript, es20, web development
---

Ok, I'll try to write this post in both [portuguese](#pt) and [english](#en).

### <a name="en"></a> English

Optional Chaining tries to resolve a very common pattern in Javascript, the pattern to check before using a complex object.

The `&&` operator is usually used before performing any checks to ensure that the object has the elements, but this can be very strange, if not, hard to read.

```js
const vehicle = {
  car: {
    impala: "Red and has a mirror just for combing",
    brasilia: "Yellow with open doors",
  },
};

// What does and gives error
const jipe = vehicle.carro.jipe; // Error

// What you do to avoid the error
const jipe = vehicle && vehicle.carro && vehicle.carro.jipe; // Undefined

// New syntax that will help a lot
const jipe = vehicle?.carro?.jipe; // Undefined
```

The new syntax as well as lean will reduce the number of errors and make the code easier to read. In many cases, the trigger is long enough to enforce the use of secondary functions just to validate the information.

That's it, start using!

![This is magic!](https://media.giphy.com/media/12NUbkX6p4xOO4/giphy.gif)

### <a name="pt"></a>Portuguese

O Optional Chaining tenta resolver um padrão muito comum em Javascript, o padrão de verificar antes de utilizar um objeto complexo.

Geralmente se utiliza o operador `&&` antes de realizar qualquer verificação para garantir que o objeto possui os elementos, mas isso pode ser muito estranho, senão, pesado de ler.

```js
const veiculo = {
  carro: {
    opala: "Vermelho e tem espelho apenas para pentear",
    brasilia: "Amarela de portas abertas",
  },
};

// O que faz e dá erro
const jipe = veiculo.carro.jipe; // Error

// O que faz para evitar o erro
const jipe = veiculo && veiculo.carro && veiculo.carro.jipe; // Undefined

// Nova sintaxe que irá ajudar um monte
const jipe = veiculo?.carro?.jipe; // Undefined
```

A nova sintaxe além de enxuta irá reduzir a quantidade de erros e deixar o código mais fácil de ler. Em muitos casos, o desencadeamento é longo ao bastante para se fazer valer o uso de funções secundárias somente para validar as informações.

É isso aí, comecem a usar!

![This is magic!](https://media.giphy.com/media/12NUbkX6p4xOO4/giphy.gif)

(()=>{})()
