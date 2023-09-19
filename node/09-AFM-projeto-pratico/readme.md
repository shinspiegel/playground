### TR;DL

- Entre na pasta `backend`
- Crie o arquivo `.env`
- Adicione os campos `MONGO_URI`, `PORT` e `SECRET_KEY`
- Rode com `yarn` e então `yarn dev`
- Entre na pasta `react_native`
- Altere o arquivo `config.js` modificando o valor de `baseApiURL`
- Rode com `yarn` e então `yarn start`
- Por final inicie o emulador com `yarn android`

# Atividade Prévia - Arquitetura Frontend para Mobile

Esta é um exercício para atividade prévia de pos graduação no IGTI.

## Backend

Backend é uma aplicação express escrita em typescript. Sua estrutura segue da seguinte forma:

- `index.ts`: Arquivo de entrada da aplicação
- `routes.ts`: Definição das rotas da aplicação
- `insomnia.json`: arquivo de Insomnia, para facilitar testes e amostras da API
- `controllers`: Pasta dos controladores. Cada controlador terá no máximo 4 entradas (create, index, update e destroy)
- `models`: modelos da aplicação para serem usados no `mongoose`
- `utils`: funções de suporte ou redução de código
- `validations`: validadores para entradas dos controllers, quando for necessário

Para usar este backend é preciso adicionar variáveis ambiente em um arquivo `.env`.

Este arquivo deve possuir:

- `MONGO_URI`: Url para o banco mongo
- `PORT`: Porta em que a aplicação irá estar rodando
- `SECRET_KEY`: Key para ser usada em tokens de JWT

E.g.

```
MONGO_URI="URL STRING"
PORT=9000
SECRET_KEY="MY_SECRET_HERE"
```

## Mobile (React Native)

Esta é uma aplicação criada com o `react-native` CLI, e foi alterada a partir desde projeto boilerplate. Para este projeot estar funcionando é preciso alterar o arquivo `config.js` e modificar o `baseApiURL` para possuir o endereço de IP da aplicação de backend.

O projeto se dá pela seguinte estrutura:

- `index.js`: Entrada da aplicação, foi alterado par recebeer o contexto
- `router.js`: Gerenciador de rotas e telas da aplicação
- `componentes`: Componentes que serão reutilizados. Estes componentes deves ser agnósticos a seus pais
- `context`: Contexto da aplicação utilizando `contextAPI` do React e o hook `useReducer`
- `utils`: Pasta de funções de suporte ou factories de objetos
- `views`: Telas da aplicação

## Para iniciar a aplicação:

Você irá precisar de cada rodar cada um dos grupos de códigos abaixo:

```sh
# Iniciar aplicação backend
cd backend;
yarn;
yarn dev;

# Iniciar aplicação mobile
cd react_native
yarn;
yarn start;

# Iniciar emulador mobile
cd react_native
yarn;
yarn android;
```
