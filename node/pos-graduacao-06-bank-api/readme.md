# O que é isso?

Este é um mini projeto de um sábado para colocar em prática assunto relacionados as aulas da pós-graduação no IGTI.

## Porque teu javascript termina em TS ?

Este projeto eu decidi aplicar [Typescript](https://www.typescriptlang.org/) para realizar o projeto, e manter a prática, por isso que ele possui algumas características diferentes do Javascript tradicional.

# Quer testar?

### O que precisa?

- [ ] [`git` instalado](https://git-scm.com/)
- [ ] [`Node.js` instalado](https://nodejs.org/en/)
- [ ] [`NPM` instalado (se tem o Node, provavel que tenha o NPM)](https://nodejs.org/en/)

### Como faz?

- [ ] Clona o repositório
- [ ] Acessa a pasta com seu editor
- [ ] Crie um arquivo na raiz do projeto com o nome `.env`
- [ ] Adicione os valores `MONGO_URI` e `PORT` (conforme listado no arquivo de exemplo)
- [ ] Instale as depedências com `npm install`
- [ ] Inicia o desenvolvimento com `npm run dev`

> <small>Não sabe o que é um `MONGO_URI`, então nesse caso precisa entrar no site do [mongoDB](https://account.mongodb.com/account/register), registra sua conta, e cria um atlas gratuitamente para ter acesso a um database em mongo para poder brincar, se não souber fazer isso, entra em contato comigo que te ensino.</small>

**Está em um ambiente UNIX?**

Caso esteja usando um terminal em `bash` ou `zsh` os comandos abaixo devem funcionar:

```sh
# Este aqui clona o repositório e cria uma posta com nome
git clone https://github.com/shinspiegel/pos-graduacao-06-bank-api.git bank-api-shin;

# Acessa a pasta
cd grades-shin;

# Cria arquivo com nome ".env"
touch .env;

# Instala as depedências do node
npm install;

# Abre com o VSCode
code .
```

# Entendendo esta estrutura de projeto

**Pastas:**

- `public`: Esta pasta é a pasta que será disponibilizada para quem entrar em acesso dentro do `root` da aplicação, em outras palavras acessar o `localhost:PORT/`
- `src`: Esta pasta é onde está o código fonte da aplicação, ele está em Typescript.
- `dist`: Aqui é onde fica o código transpilado do typescript para javascript.

**Estrutura do Projeto:**

- `index.ts`: Aqui é onde a aplicação acontece. Este é o arquivo de entrada do nodejs.
- `routes.ts`: Aqui estão listadas as rotas da aplicação. E.g.: `/api/bank`
- `insomnia.json`: Importe este arquivo no insomnia para ter uma estrutura básica para poder testar manualmente a API.
- `models`: Como está sendo utilizado um banco de dados não relacional, neste caso precisa de modelos sendo controlados pelo backend (e não pelo lado do banco de dados), aqui serão listados todos os modelos.
- `controllers`: Estes são controladores para informações e serão os arquivos de entrada das rotas para serem executadas.
- `utils`: Funções adicionais para suporte ou apoio da aplicação.
