---
title: Api de Contexto em REACT é muito doido!
published: true
description: Como usar a API de contexto e fazer algo genial com hooks
tags: web, webdev, react, javascript
cover_image: https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fe27.co%2Fwp-content%2Fuploads%2F2016%2F02%2FMindblown-Image.png&f=1&nofb=1
---

[This is in portuguese, wanna know why? Click here!](https://dev.to/shinspiegel/this-is-my-first-post-3d1)

Deixa eu explicar primeiro para dar um _contexto_ no que vamos tratar... Pegou? Contexto? Essa foi a única, prometo.

# Mas então...

O que é contexto? E porque eu tenho que me importar com ele? E para onde ele vai?

Beleza, vamos imaginar que você tem a seguinte estrutura:

```jsx
/* App.js */
const App = () => {
  // Faz algo muito loco aqui e cria uma array para os menus

  return (
    <div>
      <Menu lista={arrayDeMenus} />
      {/*resto da sua aplicação*/}
    </div>
  );
};
```

```jsx
/* Menu.js */
const Menu = (props) => (
  <ul>
    {props.arrayDeMenus.map((menu) => (
      <MenuItem icon={menu.icon}>{menu.nome}</MenuItem>
    ))}
  </ul>
);
```

```jsx
/* MenuItem.js */
const MenuItem = (props) => (
  <li>
    <i>{props.icon} </i>
    <p>{props.children}</p>
  </li>
);
```

Beleza, sacou o código né? Sabe o nome disso? **Props Hell**, ou traduzindo daquele jeito, **Inferno de Propriedades**, e aí? Como resolve isso? Vamos ficar parado e deixar para o próximo resolver isso?

Claro que não, já temos uma solução para isso, e ela se chama **contexto**, dessa forma a aplicação inteira pode se beneficiar dessa estrutura e somente quem precisa de algo acessa somente o que precisa.

Mas toma cuidado lindo, porque tu sabe né? Só coloca no contexto o que precisa, porque o contexto com 10mb de informação não ajuda o dispositivo do guri ali que tem um celular _low end_, então só usa o que precisa, deixa o mais liso possível.

Então vamos resolver o problema, mas agora usando o contexto?
Beleza então!

```jsx
/* index.js */
export const ContextAPI = createContext();

const menu = [
  { nome: "Perfil", icon: "😀" },
  { nome: "Configurações", icon: "💻" },
  { nome: "Sair", icon: "🔴" },
];

reactDom.render(
  <ContextAPI.Provider value={menu}>
    <App />
  </ContextAPI.Provider>,
  document.getElementById("root")
);
```

```jsx
/* App.js */
const App = () => {
  // Tua aplicação faz o que precisa e esquece do menu, porque ele já existe no index.js!

  return (
    <div>
      <Menu />
      {/*resto da sua aplicação*/}
    </div>
  );
};
```

```jsx
/* Menu.js */
const Menu = (props) => {
  const contexto = useContext(ContextAPI);

  return (
    <ul>
      {contexto.map((menu) => (
        <MenuItem icon={menu.icon}>{menu.nome}</MenuItem>
      ))}
    </ul>
  );
};
```

```jsx
/* MenuItem.js */
const MenuItem = (props) => (
  <li>
    <i>{props.icon} </i>
    <p>{props.children}</p>
  </li>
);
```

Como funciona, primeiro de tudo se cria um contexto, ali tá no index.js, tem um contexto criado, e veja só, esse contexto está lindão... Mas ele não tem **NADA**, isso mesmo **NADA**.

Mas o contexto então vai dar coisas para o resto da aplicação, ao renderizar o `<App/>` passamos o _provedor_ e esse lindo aí do _provider_ que irá ter um `value`, e nesse _value_ é que colocamos o que o contexto vai deixar disponível.

No menu usamos um _hook_ ali bonitão, e esse `useContext` vai receber um contexto, que está no `index` e vai colocar como a referência de qual contexto receber a informação. Como o contexto tem uma array, já pode sair usando ela.

Então, viu? O App passa completamente despercebido pelo **contexto**, então, basicamente a informação pulou do `index` para o `Menu`, isso é lindo? Eu sei, eu sei. Mas calma, isso é só o começo.

Beleza, quer algo mais legal? Bora fazer um _hook_ de contexto _custom_? Bora fazer esse contexto ficar ainda mais dinâmico e brincar com um ~~wanna be~~ **redux** no meio caminho?

Saca esse aqui então:

```jsx
/* index.js */
reactDom.render(
  <CustomContext>
    <App />
  </CustomContext>,
  document.getElementById("root")
);
```

```jsx
/* context.js */
const InitialState = {
  menu: [
    { nome: "Perfil", icon: "😀" },
    { nome: "Configurações", icon: "💻" },
    { nome: "Sair", icon: "🔴" },
  ],
};

const AppContext = createContext(InitialState);

const CustomContext = ({ children }) => {
  const [state, dispatch] = useReducer(reducer, InitialState);

  return (
    <AppContext.Provider value={{ state, dispatch }}>
      {children}
    </AppContext.Provider>
  );
};
```

```jsx
/* reducer.js */
const reducer = (state, { type, payload }) => {
  switch (type) {
    case "MENU":
      return {
        ...state,
        menu: [...state.menu, payload],
      };

    default:
      return state;
  }
};
```

```jsx
/* useActions.js */
const useActions = () => {
  const { state, dispatch } = useContext(AppContext);

  const anotherMenu = async (menu) => {
    dispatch({ type: "MENU", payload: { menu, icon: "🤯" } });
    return;
  };

  return {
    state,
    anotherMenu,
  };
};
```

```jsx
/* App.js */
const App = () => {
  const { anotherMenu } = useActions();

  // Se tua cabeça não explodir eu não sei o que vai fazer!

  return (
    <div>
      <Menu />
      <button onClick={() => anotherMenu("Cooontexto")}>Novo Menu</button>
      {/*resto da sua aplicação*/}
    </div>
  );
};
```

```jsx
/* Menu.js */
const Menu = (props) => {
  const { state } = useActions();

  return (
    <ul>
      {state.menu.map((menu) => (
        <MenuItem icon={menu.icon}>{menu.nome}</MenuItem>
      ))}
    </ul>
  );
};
```

```jsx
/* MenuItem.js */
const MenuItem = (props) => (
  <li>
    <i>{props.icon} </i>
    <p>{props.children}</p>
  </li>
);
```

Tá beleza, duplica essa aba aqui e coloca o código lado a lado que a pancada na mente é forte! Bora então e vamos com cuidado e por partes, beleza?

Primeira coisa, temos o contexto, ele vai ser apenas um preparação de campo, ele vai dar o início nesse trem aqui. Ele é responsável por dar o estado inicial da aplicação, então coloca ali tudo o que não precisa carregar de forma externa.

Ele também vai envelopar o `index` da aplicação para poder passar o contexto.

Agora vem a segunda parte, o `reducer`, esse aqui é perigoso, mas tu precisa entender o que ele faz direito, senão **dá ruim**. Certo então, vamos lá entender o que isso aqui faz.

_Mimimimi, tem um switch case aqui!_

Tem sim e vai ficar, eu também reclamei, tu vai reclamar, e vai engolir essa calado. Estamos entendidos? Beleza, mais pra frente tu vai entender porque precisa do `switch` aqui. Mas ele é para saber qual alteração de estado deve ser feita.

No momento tem apenas o `"MENU"`, mas pode (e provável que vá) ter várias, algumas dezenas de alterações de estado.

Mas o que ele altera? Ele vai mudar a informação de maneira **síncrona** com o estado da aplicação. Então NADA DE FAZER FETCH AQUI! Pensou no `async await`, também não rola isso é só _açúcar sintático_ para operações assíncronas. Ficou claro? Certo, se precisar usar o `reducer` para limar informação, alterar ela, converter de _string_ para _number_, faz tudo aqui. Ele é responsável por atualizar o estado da aplicação.

Repara que ele sempre TEM que retornar o estado, beleza, se retornar null toda a aplicação quebra. Então olha o que faz no `reducer`!

Ok, vamos a parte legal, o nosso _hook_. Reparou no nome? Tem o _use_ na frente não tem? Baaaah tchê garoto, primeiro _hook_ custom que coloca para frente, chega a dar um orgulho que só!

Então, o que o `useActions` faz? Ele vai conceder ações para a aplicação. Ou seja, se quer alterar o contexto da aplicação usa uma ação para alterar esse estado. Essa função do `useActions` vai retornar várias funções para o usuário brincar, ele também retorna o estado, vai que precisa receber o estado não é mesmo?

Então é aqui que o mundo **assíncrono** acontece, aqui pode usar FETCH, pode usar `await`, pode fazer _promise_, faz o câmbal aqui, pode dar o louco forte e sair girando. Mas entenda uma coisa: usa o `dispatch` para atualizar o estado da aplicação.

Então já entendeu né. Fez o _fetch_, recebeu informação do _backend_, larga um `dispatch` para atualizar o estado. Mas repara, o `dispatch` precisa receber sempre um object com duas coisas (_pode ter mais, só que aí tu se complica fazendo isso_). Quais coisas?

**type** e **payload**, então já sabe, usa o **type** para passar para o que vai bater no `switch`, e quando o `reducer` pegar o `switch` certo ele vai colocar a informação do `payload` dentro do estado. Belezura, mas como vamos usar?

Olha que lindo, no `App` e `Menu` já usamos isso. Manja essa, no `App` rodamos o `useActions()` para receber a função que altera o estado, e no `Menu` rodamos novamente para receber o contexto da aplicação.

Fala sério, tu nunca pensou que iria fazer um **redux** em tão pouco né? E manja mais essa, tudo em _hooks_ porque somos tudo fino e elegante nesse **Javascript**.

Por hoje é isso, tem aí material até não aguentar mais o buxo. Ficou com vontade de copiar tudo isso? Beleza, pega esse _snippet_ aqui e guarda a mansa.

{% codesandbox gracious-haze-3k43z %}

Curtiu né, achou que tava brincando né!

(()=>{})()
