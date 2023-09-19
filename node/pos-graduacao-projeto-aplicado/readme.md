Portuguese text is below | Texto em portugues fica abaixo

# TL:DR

Personal project to be presented to graduate students. To run locally you need to:

```sh
# Clone the repositories
git clone https://github.com/shinspiegel/pos-graduacao-projeto-aplicado.git meumercado;

# Instala dependências
yarn;

# Install dependenciesComment and fill in all the information to create a .env...

# Starts http development
yarn start;
```

# About this project

This is a personal project and project applied to be evaluated by the [Information Technology Management Institute](https://www.igti.com.br/) which aims to help people in controlling their purchases in the grocery store with ease, economy and agility.

Grocery store can be more efficient and this needs to be addressed. That's why we organize your shopping list in a practical way, using machine learning to be able to predict what will be on your next list. And in the future we will still make your purchases 100% digital.

This solution will not only bring new people, as this solution already exists in parts, just analyzing the consumer market, you can see other applications that have done the same as Uber, iFood and Netflix.

By centralizing the solution on people, they will use it, because it will be a more convenient solution than going to the market.

## Information about this repository

This is a web application that uses as base [React](https://reactjs.org/), to bundle that application I am using [ParcelJS](https://parceljs.org/), in addition that application has some facilities and some basic requirements.

The entire application will use [Jest](https://jestjs.io/) to be tested using [React Testing Library](https://testing-library.com/docs/react-testing-library/intro) to test components more naturally to the user and reviewer of this code.

To ensure that the application will have a minimum test, I am using [Husky](https://github.com/typicode/husky) to perform tests before each _commit_.

## Standardization

In order to ensure that the codebase is adequate, I am using [ESLint](https://eslint.org/) together with the [VSCode](https://code.visualstudio.com/) extension which will ensure that the codes conform to the standard.

[CommitLint](http://commitlint.js.org/) will also be used to ensure that all _commits_ are in the same pattern, in addition all _commits_ related to a task must contain the _url-ID_ of the task within the [ora.pm](ora.pm)

In addition, [Prettier](https://prettier.io/) is also used to keep the code organization consistent throughout development. And it is configured in the IDE to format the code before saving any files. And before any _commit_ the [Prettier](https://prettier.io/) process will also be carried out so that all files receive this standardization.

## Task organization

For this project the task manager will be used within [Ora.pm](ora.pm), this simple manager will control the tasks and relationships between tasks. The current table of tasks can be found at the following link: [Kanban Table](https://ora.pm/project/196922/kanban/task/2898004)

### Before and after

Originally this application was divided into two repositories, as the application became more complex, I chose to make this application just a repository, the original repositories can still be found at:

- [Project FrontEnd](https://github.com/shinspiegel/pos-graduacao-frontend)
- [Project BackEnd](https://github.com/shinspiegel/pos-graduacao-backend)

## About the Project structure and its folders

The whole project will use the concept of [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller), so we will have 3 separate folders for each subject:

- **model**
- **view**
- **controller**

### Model

Here, the models to be used within the mongoose will be stored, and they are also the application data models.

### Controller

The wheel controls that will be used by the _express_ application. Each controller will have a maximum of **index**, **create**, **update** and **destroy**. If a controller needs more than that, a new controller will be made for this application object.

### View

This is the **react** application. Within this folder will have the following:

- **assets:** Has all static assets, such as images, fonts, vectors ...
- **components:** All reusable react components within the application.
- **context:** Context of the application, has a specific section to talk about it.
- **pages:** The pages that are found within the application's routes.
- **tests:** All support files for the tests.
- **utils:** All support utilities that will be reused.

Files within the `view` root:

- **image-192.png:** Base image for PWA
- **index.html:** Basic file for generating the application.
- **index.js:** Input file for the react application.
- **main.css:** CSS reset file for the application.
- **manifest.webmanifest:** Manifesto for the PWA
- **routes.js:** All routes that the application has.
- **service-worker.js:** The primary worker for PWA.

### Components

All react components will have three files, `index.js`, `index.css` and `index.test.js`.

- **index.js** - This is the component.
- **index.css** - The styling for this component.
- **index.test.js** - Testing this component.

### Application context

This is the application's context manager. It will keep the [Flux](https://facebook.github.io/flux/) standard, so it has a `context.js` that will pass the context information to the application's root, inside `index.js` inside the src root folder.

The initial state of the application, as well as the reference, will be stored inside the `initialContext.js`.

To receive the state of the application or to be able to use actions to change and/or modify the state `useActions.js` will be used, this function returns all the _state_ and the functions to change the state asynchronously.

`reducer.js` will make the state change synchronously, ensuring that the state is always up to date.

# Start the development environment

If you want to test the development environment, you will need to create a `.env` file and add the information as shown. Mainly there needs to be a backend application to ensure data persistence. In this case, follow the steps of the backend application.

You can start the application with the `start` script. To start the application in development mode use `dev`.

---

# TL:DR

Projeto pessoal para ser apresentado para pós-graduação. Para executar localmente você precisa:

```sh
# Clona os repositórios
git clone https://github.com/shinspiegel/pos-graduacao-projeto-aplicado.git meumercado;

# Instala dependências
yarn;

# Descomente e preencha todas as informações para criar um .env

# Inicia desenvolvimento em http
yarn start;
```

# Sobre esse projeto

Este é um projeto pessoal e projeto aplicado para ser avaliado pelo [Instituto de Gestão em Tecnologia da Informação](https://www.igti.com.br/) que tem como objetivo auxiliar as pessoas em controle suas compras no mercado com facilidade, economia e agilidade.

Os mercados podem ser mais eficientes e isso precisa ser solucionado. Para isso que organizamos de maneira prática sua lista de compra, utilizando machine learning para poder predizer o que estará na sua próxima lista. E no futuro iremos ainda realizar suas compras de maneira 100% digital.

Essa solução não apenas irá trazer novas pessoas, como essa solução já existe em partes, apenas analisando o mercado de consumo, pode-se perceber outras aplicações que fizeram o mesmo como Uber, iFood e Netflix.

Ao centralizar a solução nas pessoas, elas irão utilizar, porque esta será uma solução mais conveniente do que ir ao mercado.

## Informações sobre esse repositório

Esta é uma aplicação web que utiliza como base [React](https://reactjs.org/), para empacotar essa aplicação estou utilizando o [ParcelJS](https://parceljs.org/), além disso essa aplicação conta com algumas facilidades e alguns requisitos básicos.

Toda a aplicação utilizará [Jest](https://jestjs.io/) para ser testada usando [React Testing Library](https://testing-library.com/docs/react-testing-library/intro) para testar componentes de maneira mais natural ao usuário e revisor deste código.

Para garantir que a aplicação terá um teste ao mínimo, estou utilizando do [Husky](https://github.com/typicode/husky) para realizar testes antes de cada _commit_.

## Padronização

Afim de garantir que a codebase esteja adequada, estou utilizando o [ESLint](https://eslint.org/) junto com a extensão para o [VSCode](https://code.visualstudio.com/) que irá garantir que os códigos estão de acordo com o padrão.

Será utilizado também o [CommitLint](http://commitlint.js.org/) para garantir que todos os _commits_ estejam no mesmo padrão, além disso todas os _commits_ relacionados a uma tarefa devem conter o _url-ID_ da tarefa dentro do [Ora.pm](ora.pm)

Além disso, também é utilizado o [Prettier](https://prettier.io/) para manter a organização do código consisa em todo o desenvolvimento. E é configurado na IDE para formatar o código antes de salvar qualquer arquivo. E antes de qualquer _commit_ também será realizado o processo do [Prettier](https://prettier.io/) para que todos os arquivos recebam essa padronização.

## Organização de tarefas

Para este projeto será utilizado o gerenciador de tarefas dentro do [Ora.pm](ora.pm), este simples geranciador irá controlar as tarefas e relacionamentos entre tarefas. O quadro atual de tarefas se encontra no seguinte link: [Quadro de Pós-graduação](https://ora.pm/project/196922/kanban/task/2898004)

## Antes e depois

Originalmente esta aplicação estava dividida em dois repositórios, conforme a aplicação se tornou mais complexa, optei por tornar essa aplicação apenas repositório, os repositórios originais ainda podem ser encontrados em:

- [Projeto FrontEnd](https://github.com/shinspiegel/pos-graduacao-frontend)
- [Projeto BackEnd](https://github.com/shinspiegel/pos-graduacao-backend)

## Sobre a estrutura do Projeto e suas pastas

Todo o projeto irá utilizar o conceito de [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller), dessa forma teremos 3 pastas separadas para cada assunto:

- **model**
- **view**
- **controller**

### Model

Aqui será armazenado os modelos para serem usados dentro do mongoose, e também são os modelos de dados da aplicação.

### Controller

Os controlares de rodas que serão usados pela aplicação _express_. Cada controler terá no máximo **index**, **create**, **update** e **destroy**. Caso um controlador precise de mais do que isso, será feito um controlador novo para este objeto da aplicação.

### View

Esta é a aplicação **react**. Dentro dessa pasta terão os seguintes:

- **assets:** Possui todos os assets estáticos, como imagens, fontes, vetores...
- **components:** Todos os componentes react reutilizaveis dentro da aplicação.
- **context:** Contexto da aplicação, possui uma seção específica para falar dela.
- **pages:** As páginas que são encontradas dentro das rotas da aplicação.
- **tests:** Todos os arquivos de suporte para os teste.
- **utils:** Todos os utilitários para suporte que serão reaproveitados.

Arquivos dentro da raíz do `view`:

- **image-192.png:** Imagem base para o PWA
- **index.html:** Arquivo básico para geração da aplicação.
- **index.js:** Arquivo de entrada para a aplicação react.
- **main.css:** Arquivo de reset de CSS da aplicação.
- **manifest.webmanifest:** Manifesto para o PWA
- **routes.js:** Todas as rotas que a aplicação possui.
- **service-worker.js:** O worker principal para o PWA.

### Componentes

Todos os componentes react irão possui três arquivos, `index.js`, `index.css` e `index.test.js`.

- `index.js` - Este é o componente.
- `index.css` - A estilização para este componente.
- `index.test.js` - O teste deste componente.

### Contexto da aplicação

Este é o gerenciador de contexto da aplicação. Ele irá manter o padrão [Flux](https://facebook.github.io/flux/), dessa forma ele possui um `context.js` que irá repassar as informações de contexto para a rais da aplicação, dentro do `index.js` dentro da pasta raiz do `src`.

O estado inicial da aplicação, assim como referência, será armazenado dentro do `initialContext.js`.

Para receber o _state_ da aplicação ou poder utilizar a ações para alterar e/ou modificar o estado será utilizado o `useActions.js`, esta função retorna todas o _state_ e as funções para alterar o estado de maneira assincrona.

O `reducer.js` irá fazer a alteração do estado de maneira sincrona, garantindo que o estado está sempre atualizado.

# Iniciar o ambiente de desenvolvimento

Se você deseja testar o ambiente de desenvolvimento, será necessário criar um arquivo de `.env` e adicionar as informações conforme o exemplo. Em principal precisa existir uma aplicação de backend para garantir a persistência de dados. Neste caso siga os passos da aplicação de backend.

Você pode iniciar a aplicação com o script `start`. Para iniciar a aplicação em modo de desenvolvimento use `dev`.
