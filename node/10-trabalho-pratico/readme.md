# O que é isso?

Este é um projeto para ser avaliado na disciplina do curso de Desenvolvimento Frontend na IGTI.

Para este projeto estou usando uma idea para aplicar o modelo MVC (Model, View, Controller) utilizando Express e uma Aplicação React, tudo no mesmo projeto. Eu sei, parece estranho, mas é um experimento para ver como isso funciona.

## O que precisa para rodar essa aplicação?

- [ ] [git](https://git-scm.com/) para versionamento (e também baixar do repositório)
- [ ] [node](https://nodejs.org/en/) como ambiente javascript de backend
- [ ] [npm](https://nodejs.org/en/) para instalar dependências

## Como rodar?

**Clonou o repositório pra usa máquina local?** Beleza, então vamos para os próximos passos.

- [ ] cria um arquivo na raiz desse projeto com o nome `.env`, siga o exemplo sugerido no `.env.exemple`
- [ ] no seu terminal usa um `npm install` para as dependências do node
- [ ] depois usa um `npm run dev` para iniciar o ambiente de desenvolvimento

Quer os comandos para pegar isso?

```sh
git clone https://github.com/shinspiegel/10-trabalho-pratico.git jeferson-leite-borges;
cd jeferson-leite-borges;
npm install;
touch .env
echo "MONGO_URI= \nPORT=9000" >> .env
npm run dev;
```

### Windows (ou Ruindows 😜)

Todos os comandos nos `package.json` dentro de scrips estão para o meio do unix, ou seja as barras estão todas para `/` e não para `\`. Talvez tenha que alterar isso para rodar, eu acho.

Mais fácil colocar um Ubuntu e largar fora o Windows, sinceramente.

### Pastas criadas

Abaixo a descrição das pastas criadas.

```sh
|-- .cache              # Cache para hot-reload do parceljs
|-- dist                # Compilado dos arquivos da aplicação express
|-- node_modules        # Precisa explicar?
|-- public              # Estáticos para serem distribuídos publicamente
|-- src                 # Código fonte da aplicação completa
  |-- controller        # Controlador para as rotas
  |-- models            # Modelos do mongoose para a aplicação
  |-- functions         # Qualquer função, seja utilitária e/ou helper, fica tudo aqui
  |-- view              # Aplicação react
     |-- components     # Componentes react
         |-- index.js   # Todo componente é instanciado pela sua pasta
         |-- index.scss # Todo componente possui seu próprio arquivo de scss
     |-- context        # Contexto da aplicação
     |-- functions      # Qualquer função, seja utilitária e/ou helper, fica tudo aqui
     |-- pages          # Páginas da aplicação react
     |-- index.html     # Html raiz que será depois processado e disponibilizado na pasta pública
     |-- index.js       # Arquivo JS de entrada da aplicação react
     |-- main.scss      # Arquivo base de scss, também irá conter o reset de csss
     |-- manifest.json  # Arquivos de manifesto para PWA
     |-- routes.js      # Rotas da aplicação React
  |-- index.ts          # Ponto de entrada da aplicação express
  |-- insomnia.json     # Referência para insomnia
  |-- routes.ts         # Rotas da aplicação express
```
