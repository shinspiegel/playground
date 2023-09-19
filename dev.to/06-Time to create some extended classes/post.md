---
title: Time to create some extended classes
published: false
description:
tags:
cover_image: https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fm1.behance.net%2Frendition%2Fmodules%2F54602019%2Fdisp%2F04680c5a1920491e33c5b0791f55390f.jpg
---

Ok, I'll try to write this post in both [portuguese](#pt) and [english](#en).

### <a name="en"></a> English

I'm a guy who thinks about functional programming before thinking about object oriented programming, however I know the value of extending classes.

But then I ask about: **Have you thought about extending the basic classes of javascript?**

Maybe not, right?

Come on, think you need an array that has some very specific methods for your application. For example, returning a boolean if the array has zero elements.

You can go to the **prototype** of the array and add that. Which is not cool, since you can change something that future browsers can use. Or you can extend the array class for this, as seen below:

```js
class ExtArray extends Array {
  isEmpty() {
    return this.length === 0;
  }
}
```

That way you can keep all the syntactic sugar from using an `array` and at the same time add specific methods to your`extended array`, as seen below:

```js
var exArray = new ExtArray(0, 1, 2, 3, 4);

exArray[1]; // Should return '1'
exArray.filter((i) => i !== 3); // Should return [0, 1, 2, 4]
exArray.isEmpty(); // Should return false
```

Now let's go to the mind blow: "You can extend the base class `Error`"

![MindBlow](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.2dLybCZHYZdoIZ56t8Il4AHaEK%26pid%3DApi&f=1)

That's it!

(() => {}) ()

### <a name="pt"></a> Português

Eu sou um cara que pensa em programação funcional antes de pensar na programação parentada a objeto, entretanto sei o valor de extender classes.

Mas aí eu questiono a respeito de: **Você já pensou em extender as classes básicas do javascript?**

Talvez não, né?

Vamos lá, pensa que você precisa de uma array que tenha alguns métodos bem específicos pra sua aplicação. Como por exemplo, retornar um boleano caso a array tenha zero elementos.

Você pode ir no **prototype** da array e adicionar isso. O que não é legal, já que você pode alterar algo que os navegadores do futuros podem utilizar. Ou você pode extender a classe array para isso, como pode ser visto abaixo:

```js
class ExtArray extends Array {
  isEmpty() {
    return this.length === 0;
  }
}
```

Dessa forma você pode manter todo o açucar sintático de usar uma `array` e ao mesmo tempo adicionar métodos específicos para sua `array extendida`, como pode ser visto abaixo:

```js
var exArray = new ExtArray(0, 1, 2, 3, 4);

exArray[1]; // Should return '1'
exArray.filter((i) => i !== 3); // Should return [0, 1, 2, 4]
exArray.isEmpty(); // Should return false
```

Agora vamos a explosão de cabeças: "Você pode extender a classe base `Error` "

![MindBlow](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.2dLybCZHYZdoIZ56t8Il4AHaEK%26pid%3DApi&f=1)

É isso aí, comecem a usar!

(()=>{})()
