# AGENTS.md

## Tecnologias

- **Runtime:** Node.js (CommonJS, `require`/`module.exports`)
- **Backend:** Express 4 (`express.Router`, `express.json`, `express.static`, `cors`)
- **Banco de dados:** MySQL (MySQL Server) via driver `mysql2`
- **Configuração de ambiente:** `dotenv` com arquivos `.env` (produção) e `.env.dev` (desenvolvimento), alternados no topo de `app.js`
- **Front-end:** HTML5 + CSS3 puros (sem framework), JavaScript vanilla embutido em `<script>` nos HTMLs; bibliotecas via CDN (Chart.js, Font Awesome)
- **Outras libs:** `path`, `nodemon` (dev)
- **Banco de dados do projeto:** `aquatech` (script em `src/database/script-tabelas.sql`)

## Comandos

```
npm i            # instalar dependências
npm start        # iniciar servidor (node app.js)
npm run dev      # iniciar com nodemon (reload automático)
```

A aplicação sobe na porta/host definidos em `.env`/`.env.dev` (`APP_PORT`, `APP_HOST`). O front-end é servido estaticamente a partir de `public/`.

## Arquitetura

Padrão em camadas **front-end → routes → controllers → models → banco**:

```
app.js                     # ponto de entrada: carrega .env/.env.dev, monta middlewares e routers
src/
  routes/                  # endpoints HTTP (verbo + caminho), apenas delegam para o controller
    index.js               # GET /
    usuarios.js            # /usuarios/cadastrar, /usuarios/autenticar
    avisos.js              # CRUD completo de avisos (GET/POST/PUT/DELETE)
    medidas.js             # medidas dos sensores
    aquarios.js            # aquários por empresa
    empresas.js            # empresas (cadastrar/buscar/listar)
  controllers/             # regras de validação, status HTTP e orquestração dos models
    usuarioController.js, avisoController.js, medidaController.js,
    aquarioController.js, empresaController.js
  models/                  # montam a instrução SQL e chamam database.executar()
    usuarioModel.js, avisoModel.js, medidaModel.js,
    aquarioModel.js, empresaModel.js
  database/
    config.js              # conexão MySQL (mysql2) via variáveis de ambiente, exporta executar(instrucao)
    script-tabelas.sql     # DDL das tabelas: empresa, usuario, aviso, aquario, medida
public/                    # front-end estático servido pelo express.static
  index.html, login.html, cadastro.html, simulador.html
  dashboard/               # páginas do painel: dashboard.html, cards.html, mural.html, edicao-aviso.html
  css/                     # estilo.css, dashboards.css
  js/                      # sessao.js (validarSessão/limparSessão/loading), alerta.js
  assets/                  # imagens, ícones e gifs
DOCUMENTOS_DE_APOIO/       # exemplos e passo a passo (criar rota, upload de imagem, gráfico estático)
```

**Fluxo de uma requisição:** o front-end chama a rota (ex.: `fetch("/avisos/listar")`) → o arquivo em `src/routes` direciona para a função do controller → o controller valida dados e chama a função do model → o model monta o SQL e chama `database.executar()` → o controller responde com JSON e status HTTP (200/204/400/403/500).

**Como adicionar um novo recurso** (ex.: carro):
1. Criar a tabela em `src/database/script-tabelas.sql` (e no banco).
2. Criar `src/models/<recurso>Model.js` com funções que montam SQL e usam `database.executar()`.
3. Criar `src/controllers/<recurso>Controller.js` com funções `(req, res)` que validam e chamam o model.
4. Criar `src/routes/<recurso>s.js` com um `express.Router()` mapeando verbos HTTP para o controller.
5. Registrar em `app.js`: `require` da rota + `app.use("/<recurso>s", router)`.
6. Criar/consumir as páginas em `public/` correspondentes.

## Padrões de desenvolvimento

- **Estilo de código:** o projeto usa majoritariamente `var` e `function` declarations (CommonJS). Seguir o padrão já existente nos arquivos ao editar; não migrar o código para `const`/`let`/arrow functions de forma global.
- **Nomenclatura:**
  - Arquivos de rota: plural, minúsculas, sem hífen (`avisos.js`, `empresas.js`).
  - Controllers: `<recurso>Controller.js`; models: `<recurso>Model.js`.
  - Variáveis vindas do body: sufixo `Server` (ex.: `emailServer`, `senhaServer`).
  - Campos de retorno do banco com alias em camelCase (ex.: `fk_empresa AS empresaId`).
  - Funções de rota/controller/model: verbos em português (`cadastrar`, `listar`, `autenticar`, `publicar`, `editar`, `deletar`, `buscarPorCnpj`).
- **Códigos HTTP:** 200 (ok), 204 (sem resultados), 201 (criado), 400 (campo undefined), 403 (credencial/autorização inválida), 500 (erro de servidor, retornar `erro.sqlMessage`).
- **SQL:** escrever em template strings com `\n` e indentação legível; usar aliases em camelCase nos SELECTs; fazer `console.log` da instrução SQL nos models.
- **Front-end:** HTML/CSS/JS vanilla, com scripts compartilhados em `public/js` e funções utilitárias (`validarSessao`, `aguardar`, `finalizarAguardar`).
- **Commits — Conventional Commits (obrigatório):**

  ```
  <tipo>(<escopo>): <descrição curta no imperative, sem ponto final>
  ```

  Tipos aceitos: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`.
  Escopo opcional, mas recomendado (ex.: `api`, `dashboard`, `db`, `routes`).

  Exemplos:
  - `feat(api): adiciona cadastro de empresa`
  - `fix(dashboard): corrige exibição do gráfico de temperatura`
  - `docs: atualiza README com passo a passo de novo recurso`

  Um commit deve conter apenas uma mudança lógica; não misturar refactor com feat.

## Cuidados e restrições

- **Não** alterar `node_modules/` nem commitá-lo (já está no `.gitignore`).
- **Não** commitar `.env`/`.env.dev` preenchidos com credenciais reais ou alterações locais de ambiente.
- **Não** alterar `package.json` de forma desnecessária (instalação de libs novas só quando realmente necessário).
- **Não** expor senhas em logs ou responses (o código atual faz isso em alguns pontos — não replicar em código novo).
- SQL é montado por interpolação de string (risco de SQL injection); ao adicionar código novo, preferir validação de entrada e evitar concatenar valores sem sanitização.
- Seguir o fluxo camada a camada (routes → controllers → models) ao criar funcionalidades; nunca colocar regra de negócio ou SQL direto em routes ou HTML.
- Antes de implementar uma alteração, seguir as tecnologias, arquitetura, convenções e restrições descritas neste documento. Caso alguma informação esteja ausente, analisar o código existente e seguir os padrões já adotados no projeto.
