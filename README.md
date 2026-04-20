# Projeto Delphi MVP (Portifolio)

Pequena aplicacao Delphi (Delphi 12 Community) com exemplos de:

1. `Gerador de SQL`: recebe `Colunas`, `Tabela` e `Condicoes` (tudo vindo de listas do TMemo) e monta um `SELECT ... FROM ... WHERE ...` usando `uspQuery`.
2. `Carregamento Paralelo`: inicia duas threads e atualiza duas `TProgressBar` em paralelo, simulando carregamentos com tempos diferentes.
3. `Projetos: Total e Divisoes`: cria uma lista de projetos aleatorios (em um `TClientDataSet`), exibe em `TDBGrid` e calcula `total` e uma `divisao` baseada na sequencia.
4. `Simulação API` de consumo da `https://viacep.com.br/ws/`, com tratamento e mapeamento do retorno JSON.

## Como usar rapidamente (telas)

- Abra `Principal` e escolha `Funcionalidades`.
- `Gerador de SQL`
  - Preencha `Colunas` (1 item por linha), `Tabela` e `Condicoes` (parte do `WHERE`).
  - Clique em `Gerar SQL` para ver o `SELECT` gerado.
- `Carregamento Paralelo`
  - Defina os tempos (ms) das duas progressbars e clique em `Iniciar Carregamento`.
  - As barras avancam em paralelo ate completar.
- `Projetos: Total e Divisoes`
  - A lista de projetos ja aparece no grid ao abrir a tela.
  - Use `Obter total` e `Obter total divisoes` para ver os calculos.
- `Simulação API`
  - O CEP já aparece com o campo preenchido.
  - Utilize `Buscar Endereço` para visualizar o retorno.

## Autor

- [@matheus-santos-tenorio](https://github.com/matheus-santos-tenorio)

