---
title: Javascript types?
published: false
description: A quick way to get the basic types for given values on javascript
tags: Javascript, Types, Programming
//cover_image: https://lh3.googleusercontent.com/proxy/sXG-NEIijOwm_-uNYxJR5dCBIJmtG2YX6p8mVyifppJbuWn-A6uTHeRyeazMPAFlcy3ktCcrxVkg_9_AO-axfSXzfuljFPpzw8_TAndR-ruLTgvnh3gdchEt5x_-wTDFgiGApAq74JfnFJnmLBQ5IkDUMJxc
---

Ok, I'll try to write this post in both [portuguese](#pt) and [english](#en).

### <a name="en"></a> English

Come on, who never said that Javascript is chaos because it has no types? Even Microsoft put its foot in Javascript by adding types and making "TypeScript". And the cherry on top the `typeof` operator doesn't help as much.

For example, if you look at the example below we have the following:

```js
var object = { type: "object" };
var array = ["type", "array"];
var string = "string";
var number = 99;
var regex = /regex/g;
```

If for any reason we have to ensure that these values are exactly what they should be, the `typeof` operator will help us for primitives only, and it may not even be that efficient.

```js
typeof object; // object
typeof array; // object
typeof string; // string
typeof number; // number
typeof regex; // object
```

For these types of situations you can do a trick that may help, such as:

```js
Object.prototype.toString.call(object); // [object Object]
Object.prototype.toString.call(array); // [object Array]
Object.prototype.toString.call(string); // [object String]
Object.prototype.toString.call(number); // [object Number]
Object.prototype.toString.call(regex); // [object RegExp]
```

Notice how it returns something much more precise, and with a little bit of string manipulation it is possible to return a type much closer than expected from a typeof operator, now that you have this information prepare a util or support function (as we should love to do) and we have a function to be reused in several projects to get the type more efficiently.

That's it!

![Types](https://lh3.googleusercontent.com/proxy/sXG-NEIijOwm_-uNYxJR5dCBIJmtG2YX6p8mVyifppJbuWn-A6uTHeRyeazMPAFlcy3ktCcrxVkg_9_AO-axfSXzfuljFPpzw8_TAndR-ruLTgvnh3gdchEt5x_-wTDFgiGApAq74JfnFJnmLBQ5IkDUMJxc)

(()=>{})()

### <a name="pt"></a> Português

Vamos lá, quem nunca falou que Javascript é um caos porque não tem tipos? Até a Microsoft colocou seu pé no Javascript adicionando tipos e fazendo o "TipoScript". E para melhorar o operador `typeof` ajuda tanto quanto próximo a zero.

Por exemplo, se olhar o exemplo abaixo temos o seguinte:

```js
var object = { type: "object" };
var array = ["type", "array"];
var string = "string";
var number = 99;
var regex = /regex/g;
```

Se por qualquer motivo tivermos que garantir que esses valores são exatamente o que eles devem ser, o operador `typeof` vai nos ajudar apenas para primitivos, e talvez nem seja tão eficiente assim.

```js
typeof object; // object
typeof array; // object
typeof string; // string
typeof number; // number
typeof regex; // object
```

Para esses tipos de situações se pode fazer um truque que talvez ajude, como por exemplo:

```js
Object.prototype.toString.call(object); // [object Object]
Object.prototype.toString.call(array); // [object Array]
Object.prototype.toString.call(string); // [object String]
Object.prototype.toString.call(number); // [object Number]
Object.prototype.toString.call(regex); // [object RegExp]
```

Percebe como ele retorna algo muito mais preciso, e com um pouco de manipulação de string é possível retornar um tipo muito mais próximo do que se esperada de um operador de `typeof`, agora que você tem essa munição de informação prepare uma função de suporte ou utilitária (como nós dev adoramos fazer) e temos uma função para ser reutilizada em vários projetos para recuperar o tipo de maneira mais eficiênte.

É isso aí, comecem a usar!

![Types](https://lh3.googleusercontent.com/proxy/sXG-NEIijOwm_-uNYxJR5dCBIJmtG2YX6p8mVyifppJbuWn-A6uTHeRyeazMPAFlcy3ktCcrxVkg_9_AO-axfSXzfuljFPpzw8_TAndR-ruLTgvnh3gdchEt5x_-wTDFgiGApAq74JfnFJnmLBQ5IkDUMJxc)

(()=>{})()
