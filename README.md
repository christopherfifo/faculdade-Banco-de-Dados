# faculdade-Banco-de-Dados

Olá, meu nome é christopher willians, sou estudante do curso Análise e Desenvolvimento de Sistemas na faculdade IFSP, meu propósito com esse repositório é mostrar meus aprendizados na disciplina Banco de Dados

tags:: #data_science #nosql #host

# composição básica de uma tabela
## Criando o Banco de Dados e Usando-o

O primeiro passo é criar o banco de dados. Para isso, usamos o comando `CREATE DATABASE`, que permite criar o banco apenas se ele não existir, evitando duplicação.

**Sintaxe**:
```sql
CREATE DATABASE IF NOT EXISTS <nome_do_banco>;
```

Exemplo:
```sql
CREATE DATABASE IF NOT EXISTS loja;
```

Para usar o banco de dados criado, utilizamos o comando `USE <nome_do_banco>`:

```sql
USE loja;
```

## Criando a Tabela

Para criar uma tabela, usamos o comando `CREATE TABLE`, especificando o nome da tabela e, entre parênteses, os campos (ou colunas) que queremos definir para ela.

**Sintaxe**:
```sql
CREATE TABLE IF NOT EXISTS <nome_da_tabela> (
  <nome_da_coluna> <tipo_de_dado> [restrições],
  ...
);
```

Exemplo:
```sql
CREATE TABLE IF NOT EXISTS clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(250) NOT NULL,
  idade INT NOT NULL,
  email VARCHAR(250) NOT NULL UNIQUE
);
```

### 2. **Restrições de Dados**

Você pode aplicar restrições para especificar que tipo de valores são permitidos em cada coluna:

- **NOT NULL**: Garante que o campo não pode ser deixado vazio.
- **UNIQUE**: Garante que todos os valores na coluna são exclusivos (não há duplicatas).
- **DEFAULT**: Define um valor padrão que será usado se nenhum valor for especificado.
- **CHECK**: Restringe os valores que podem ser inseridos com base em uma condição.
- **FOREIGN KEY**: Garante que o valor na coluna corresponde a um valor em outra tabela (integridade referencial).

Exemplo de criação de uma tabela com restrições:
```sql
CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    idade INT CHECK (idade >= 18),  -- Apenas maiores de 18 anos
    email VARCHAR(255) UNIQUE,      -- Não permite emails duplicados
    data_cadastro DATE DEFAULT CURRENT_DATE -- Define data atual como padrão
);
```

### 1. **Tipos de Dados**

Cada coluna pode ser configurada para aceitar apenas um tipo específico de dados. Alguns exemplos de tipos de dados incluem:

- **INT**: Aceita apenas valores inteiros (números sem decimais).
- **VARCHAR(255)**: Aceita texto de comprimento variável, com limite máximo de caracteres.
- **DATE**: Aceita apenas valores de data no formato `YYYY-MM-DD`.
- **DECIMAL(10,2)**: Aceita números decimais com precisão (útil para valores monetários).

Exemplo de criação de uma tabela com diferentes tipos de dados:
```sql
CREATE TABLE produtos (
    id INT,
    nome VARCHAR(255),
    preco DECIMAL(10,2),
    data_entrada DATE
);
```

## Primary Key (Chave Primária)
A chave primária é uma coluna ou conjunto de colunas que identifica de forma única cada linha em uma tabela, ou seja, define não pode haver dados iguais naquela coluna.

**Sintaxe**:
```sql
PRIMARY KEY (nome_da_coluna);
```

## Foreign Key (Chave Estrangeira)
A chave estrangeira conecta dados de duas tabelas. Ela referencia a chave primária de outra tabela para estabelecer um relacionamento entre elas. De modo geral, temos que colocar ela na tabela que depende da outra para sua criação, na hora da criação da coluna na tabela que ela está obrigatoriamente tem que ter um dado igual na coluna da tabela referenciada. 

Por exemplo, se tiver uma tabela clientes e outra pedidos que referencia o campo id_clientes com o campo id da tabela clientes, na hora de criarmos um pedido com o id_clientes 1 tem que haver esse valor na coluna da tabela clientes, caso contrário retornara erro.  

**Sintaxe**:
```sql
FOREIGN KEY (nome_da_coluna) REFERENCES outra_tabela(nome_da_coluna_referenciada);
```

**Exemplo:**
```sql
CREATE TABLE IF NOT EXISTS produtos (

    id INT AUTO_INCREMENT PRIMARY KEY,

    nome_produto VARCHAR(250) UNIQUE,

    preco_produto FLOAT NOT NULL,

    estoque INT,

    reposto_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

);

CREATE TABLE IF NOT EXISTS clientes (

    id INT AUTO_INCREMENT PRIMARY KEY,

    nome VARCHAR(250) NOT NULL,

    email VARCHAR(250) UNIQUE,

    telefone VARCHAR(250) UNIQUE,

    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

);

CREATE TABLE IF NOT EXISTS pedidos (

    id INT AUTO_INCREMENT PRIMARY KEY,

    id_usuario INT NOT NULL,

    nome_usuario VARCHAR(250) NOT NULL,

    quant INT NOT NULL,

    total FLOAT NOT NULL,

    feito_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_usuario) REFERENCES clientes(id)

);

CREATE TABLE IF NOT EXISTS itens_pedido (

    id INT AUTO_INCREMENT PRIMARY KEY,

    id_pedido INT NOT NULL,

    id_cliente INT NOT NULL,

    nome_cliente VARCHAR(250) NOT NULL,

    id_produto INT NOT NULL,

    nome_produto VARCHAR(250),

    quant_produto INT NOT NULL,

    valor_total FLOAT NOT NULL,

    feito_em DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),

    FOREIGN KEY (id_cliente) REFERENCES clientes(id),

    FOREIGN KEY (id_produto) REFERENCES produtos(id)
);
```

# Comando de manipulação de tabelas
## SELECT
O comando `SELECT` é usado para consultar dados de uma tabela. O uso de `SELECT *` retorna todas as colunas.

**Exemplos**:
```sql
SELECT * FROM clientes;
SELECT nome, idade FROM clientes;
```

## INSERT
Usado para inserir dados em uma tabela.

**Sintaxe**:
```sql
INSERT INTO nome_da_tabela (coluna1, coluna2) VALUES (valor1, valor2);
```

Exemplo:
```sql
INSERT INTO clientes (nome, idade, email) VALUES ('Ana Silva', 30, 'ana@exemplo.com');
```

## UPDATE
Atualiza dados existentes em uma tabela.

**Sintaxe**:
```sql
UPDATE nome_da_tabela SET coluna = valor WHERE condição;
```

Exemplo:
```sql
UPDATE clientes SET idade = 31 WHERE nome = 'Ana Silva';
```

## DELETE
Remove registros de uma tabela.

**Sintaxe**:
```sql
DELETE FROM nome_da_tabela WHERE condição;
```

Exemplo:
```sql
DELETE FROM clientes WHERE idade < 18;
```

## WHERE
Filtra registros baseados em uma condição.

**Exemplo**:
```sql
SELECT * FROM clientes WHERE idade >= 18;
```

# comando entre tabelas e filtros
## INNER JOIN
Combina registros de duas tabelas com base em uma condição de correspondência. Quando usamos `inner join` colocamos uma condição entre duas tabelas na hora de exibição, ou seja, definimos as colunas que queremos trazer das tabelas, e com o `inner join` definimos que só trará essas linhas se em cada linha tiver uma especifica coluna dessa tabela com o valor corresponde ao valor de uma coluna especifica de outra tabela que queremos juntar

**Sintaxe**:
```sql
SELECT tabela1.coluna, tabela2.coluna FROM tabela1 INNER JOIN tabela2 ON tabela1.coluna = tabela2.coluna;
```

**Exemplo:**

tabela clientes
```paintext
id_cliente | nome
-----------|-----------
    1      | Ana
    2      | João
    3      | Maria
```

tabela pedidos
```paintext
id_pedido | id_cliente | valor
----------|------------|--------
    101   |     1      | 150.00
    102   |     2      | 200.00
    103   |     1      | 300.00
```

Para ver o nome dos clientes e o valor dos pedidos que fizeram, usamos o `INNER JOIN` entre `clientes` e `pedidos` na coluna `id_cliente`, que existe em ambas as tabelas e representa a relação entre elas.

```sql
SELECT clientes.nome, pedidos.valor
FROM clientes
INNER JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente;
```

```paintext
nome     |valor
---------|--------
Ana      |150.00
João     |200.00
Ana      |300.00
```

**Explicação**:

- O `INNER JOIN` une as tabelas `clientes` e `pedidos` comparando `clientes.id_cliente` com `pedidos.id_cliente`.
- Somente as linhas onde há correspondência entre `id_cliente` nas duas tabelas são incluídas no resultado.
- A saída mostra o nome do cliente e o valor de cada pedido associado a esse cliente.

## Between (entre)

O operador `BETWEEN` em SQL é usado para selecionar valores que estão dentro de um intervalo específico, incluindo os limites do intervalo. Esse operador facilita a busca de dados dentro de um intervalo numérico, de datas ou até mesmo de caracteres alfabéticos, tornando a consulta mais simples e direta.

```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela
WHERE coluna BETWEEN valor_inicial AND valor_final;
```
### Partes da Sintaxe:

- **`SELECT coluna1, coluna2, ...`**: Define as colunas que você deseja incluir na saída.
- **`FROM nome_da_tabela`**: Especifica a tabela onde a busca será realizada.
- **`WHERE coluna BETWEEN valor_inicial AND valor_final`**: Define a condição `BETWEEN`, que seleciona apenas os registros onde o valor na coluna está entre `valor_inicial` e `valor_final`, incluindo ambos os limites.
### Funcionamento do BETWEEN

O `BETWEEN` usa limites inclusivos, ou seja, ele inclui tanto o valor inicial quanto o valor final no resultado. Isso é particularmente útil quando você quer encontrar dados dentro de um intervalo, como um período de tempo, uma faixa de preços ou uma série de identificadores.

#### Exemplos de Uso

##### 1. Intervalo Numérico

Imagine que você tem uma tabela `produtos` com uma coluna `preco` e deseja selecionar produtos com preços entre 50 e 100.

```sql
SELECT nome, preco
FROM produtos
WHERE preco BETWEEN 50 AND 100;
```

**Resultado**: Essa consulta retorna apenas os produtos com preço igual ou superior a 50 e igual ou inferior a 100.
##### 2. Intervalo de Datas

Agora considere uma tabela `pedidos` com uma coluna `data_pedido`. Vamos buscar pedidos realizados entre 1º de janeiro e 31 de janeiro de 2024.

```sql
SELECT id_pedido, data_pedido, valor
FROM pedidos
WHERE data_pedido BETWEEN '2024-01-01' AND '2024-01-31';
```

**Resultado**: Essa consulta retorna todos os pedidos feitos durante o mês de janeiro de 2024. Ao usar o `BETWEEN` com datas, você precisa especificá-las no formato apropriado para o banco de dados, como `YYYY-MM-DD`.
##### 3. Intervalo Alfabético

Suponha que você tenha uma tabela `clientes` com uma coluna `nome`. Para selecionar clientes com nomes que começam com letras entre "A" e "M", você pode usar o `BETWEEN` em conjunto com valores alfabéticos.

```sql
SELECT nome
FROM clientes
WHERE nome BETWEEN 'A' AND 'M';
```

**Resultado**: Essa consulta retornará todos os nomes que começam com letras de "A" a "M".
#### Casos de Uso Comuns do BETWEEN

- **Filtragem de valores numéricos**: como preços, idades ou identificadores dentro de um intervalo.
- **Filtragem de datas**: para buscar registros dentro de um período específico (como de um mês ou ano).
- **Filtragem alfabética**: útil para consultas que exigem uma faixa de letras iniciais, comum em sistemas de relatórios ou categorizações alfabéticas.

#### Observação sobre o Uso do BETWEEN

1. **Inclusão dos Limites**: `BETWEEN` inclui o valor inicial e o valor final no resultado. Se você deseja excluir os limites, precisará combinar `> e <` com `AND`.

```sql
SELECT nome, preco
FROM produtos
WHERE preco > 50 AND preco < 100;
```

2. **Comparações Exclusivas**: `BETWEEN` pode ser combinado com `NOT` para excluir um intervalo.

```sql
SELECT nome, preco
FROM produtos
WHERE preco NOT BETWEEN 50 AND 100;
```

**Resultado**: Retorna produtos com preços abaixo de 50 ou acima de 100.
## in (lista)

O operador `IN` é usado em SQL para verificar se um valor de uma coluna pertence a uma lista de valores especificados. Isso facilita a seleção de registros que correspondem a qualquer valor de um conjunto específico, evitando o uso de múltiplas condições `OR`.

### Sintaxe do `IN`
```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela
WHERE coluna IN (valor1, valor2, valor3, ...);
```

#### Explicação dos Componentes:

1. **`SELECT coluna1, coluna2, ...`**: Define as colunas que serão exibidas no resultado.
2. **`FROM nome_da_tabela`**: Especifica a tabela onde os dados estão armazenados.
3. **`WHERE coluna IN (valor1, valor2, valor3, ...)`**: Define a condição para filtrar os registros, retornando apenas aqueles em que o valor da coluna corresponde a um dos valores listados entre parênteses.

### Exemplo de Uso do `IN`

Imagine uma tabela `produtos` com uma coluna `categoria`. Para selecionar todos os produtos que pertencem a categorias específicas, como "Eletrônicos", "Roupas" e "Móveis", podemos usar o `IN`.

```sql
SELECT nome, categoria, preco
FROM produtos
WHERE categoria IN ('Eletrônicos', 'Roupas', 'Móveis');
```

Essa consulta retorna todos os produtos que estão em uma dessas três categorias, como se estivéssemos usando a condição `categoria = 'Eletrônicos' OR categoria = 'Roupas' OR categoria = 'Móveis'`, mas de forma mais simplificada.
## LIKE
O operador `LIKE` em SQL é usado para buscar dados em colunas de texto que correspondem a um padrão específico. Ele é ideal para buscas onde você conhece parte do valor, mas não o valor completo. Para usar `LIKE`, você precisa de curingas (`%` e `_`) que ajudam a criar os padrões de busca.

### Curingas Usados com `LIKE`

1. **`%`**: Representa qualquer sequência de caracteres (inclusive nenhuma).
2. **`_`**: Representa um único caractere.

### Sintaxe do `LIKE`

```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela
WHERE coluna LIKE 'padrão';
```

#### Exemplos Práticos

Imagine que temos uma tabela `clientes` com uma coluna `email` e queremos buscar e-mails que contenham, comecem ou terminem com determinados padrões.

1. **Contém um Padrão Específico**
	Para encontrar todos os e-mails que contêm "hotmail" em qualquer posição, usamos o `LIKE` com `%` em ambos os lados:

```sql
SELECT email
FROM clientes
WHERE email LIKE '%hotmail%';
```

- **Explicação**: O `%` antes e depois de "hotmail" permite encontrar "hotmail" em qualquer posição (por exemplo, `exemplo@hotmail.com`, `outro@meuhotmail.com`).

2. **Começa com um Padrão Específico**
    Para encontrar todos os e-mails que começam com "joao":

```sql
SELECT email
FROM clientes
WHERE email LIKE 'joao%';
```

 **Explicação**: Aqui, `%` após "joao" indica que qualquer sequência de caracteres pode seguir "joao" (como `joao123@gmail.com`, `joao.silva@hotmail.com`).
    
3. **Termina com um Padrão Específico**
	Para encontrar todos os e-mails que terminam com "@gmail.com":

```sql
SELECT email
FROM clientes
WHERE email LIKE '%@gmail.com';
```

**Explicação**: O `%` antes de "@gmail.com" permite que qualquer sequência de caracteres venha antes de "@gmail.com".
    
4. **Um Caractere Específico com `_`**
    
    O sublinhado `_` permite buscar um único caractere em uma posição específica. Para encontrar e-mails que começam com "a" e têm exatamente cinco caracteres antes do "@"

```sql
SELECT email
FROM clientes
WHERE email LIKE 'a____@%';
```
## Funções Agregadas
São funções aplicadas a conjuntos de valores para retornar um único valor calculado.

- **MAX**: Retorna o valor máximo.
- **MIN**: Retorna o valor mínimo.
- **AVG**: Calcula a média.
- **SUM**: Calcula a soma.
- **COUNT( * ):** Conta quantas linhas tem em um grupo.
- **COUNT( EXPR):** Conta quantos valores existem da expressão dada dentro do   grupo (se expr for NULL para uma linha, a linha não é incluída na contagem).

Exemplo:
```sql
SELECT MAX(idade), MIN(idade), AVG(idade) FROM clientes;
```

### Contagem com `COUNT(expr)` no SQL

O `COUNT(expr)` é uma função agregadora em SQL que conta o número de valores (não nulos) em uma coluna específica dentro de um grupo. Essa função é útil para determinar quantas linhas atendem a um critério específico ou quantos valores estão presentes em uma coluna, ignorando aqueles que têm valor `NULL`.

#### Sintaxe

```sql
SELECT COUNT(expr)
FROM nome_da_tabela
WHERE condição;
```

- **`expr`**: A expressão que representa a coluna ou condição específica.
- **`nome_da_tabela`**: A tabela onde os dados estão armazenados.
- **`condição`** (opcional): Filtra as linhas antes de contar os valores de `expr`.

### Funcionamento do `COUNT(expr)`

1. **Conta apenas valores não nulos**: Se a coluna contiver valores `NULL`, essas linhas serão ignoradas na contagem.
2. **Utilizado em combinações com outras cláusulas**: O `COUNT(expr)` pode ser usado com `WHERE`, `GROUP BY`, e outras cláusulas para realizar contagens específicas em subconjuntos de dados.

### Exemplos Práticos

Suponha que temos uma tabela chamada `clientes` com as seguintes colunas e dados:

| id_cliente | nome       | email                | idade |
|------------|------------|----------------------|-------|
| 1          | João       | joao@gmail.com       | 30    |
| 2          | Maria      | maria@hotmail.com    | NULL  |
| 3          | Pedro      | NULL                 | 22    |
| 4          | Ana        | ana@outlook.com      | 28    |
| 5          | Carlos     | NULL                 | 35    |

#### Exemplo 1: Contar E-mails Cadastrados

Para contar apenas as linhas onde a coluna `email` tem um valor (não é `NULL`), usamos:

```sql
SELECT COUNT(email) AS total_emails
FROM clientes;
```

**Resultado**:

| total_emails |
|--------------|
| 3            |

Explicação:
- A função `COUNT(email)` conta apenas os valores não nulos na coluna `email`, resultando em `3` porque `Pedro` e `Carlos` não têm e-mails registrados.

#### Exemplo 2: Contar Clientes com Idade Conhecida

Para contar os clientes que possuem uma idade registrada:

```sql
SELECT COUNT(idade) AS total_com_idade
FROM clientes;
```

**Resultado**:

| total_com_idade |
|-----------------|
| 4               |

Explicação:
- A função `COUNT(idade)` ignora o valor `NULL` de Maria e retorna `4`, pois apenas um registro tem `NULL` na coluna `idade`.

#### Exemplo 3: Contagem com `WHERE` para Filtrar

Agora, se quisermos contar quantos clientes têm uma idade maior que 25:

```sql
SELECT COUNT(idade) AS acima_de_25
FROM clientes
WHERE idade > 25;
```

**Resultado**:

| acima_de_25 |
|-------------|
| 3           |

Explicação:
- A cláusula `WHERE` filtra as linhas com `idade > 25`, então `COUNT(idade)` retorna `3`, ignorando qualquer valor `NULL` na coluna `idade`.

#### Exemplo 4: Usando `COUNT(*)` vs. `COUNT(expr)`

É importante diferenciar `COUNT(*)` e `COUNT(expr)`:

- **`COUNT(*)`**: Conta todas as linhas, inclusive aquelas com valores `NULL` em qualquer coluna.
- **`COUNT(expr)`**: Conta apenas as linhas onde `expr` não é `NULL`.

#### Exemplo Comparativo

Para contar o total de linhas na tabela, incluindo as com valores `NULL`:

```sql
SELECT COUNT(*) AS total_linhas
FROM clientes;
```

**Resultado**:

| total_linhas |
|--------------|
| 5            |

Esse exemplo retorna `5`, pois conta todas as linhas na tabela `clientes`, ignorando os valores `NULL`.

O `COUNT(expr)` é ideal para contar apenas dados relevantes sem incluir valores nulos, o que o torna útil em análise de dados para métricas mais precisas e específicas.

## Funcionamento do ORDER BY

O `ORDER BY` é utilizado para ordenar os resultados de uma consulta com base em uma ou mais colunas, podendo ser em ordem ascendente (ASC) ou descendente (DESC). Por padrão, ele organiza em ordem crescente.
#### Exemplos de Uso

##### 1. Ordenação Crescente

Se você tem uma tabela chamada `clientes` e quer ordenar pelo campo `idade` em ordem crescente, pode usar:

```sql
SELECT * FROM clientes ORDER BY idade ASC;
```

**Resultado**: A consulta traz os registros da tabela `clientes` ordenados da menor para a maior idade. Para inverter a ordem, basta usar `DESC` no lugar de `ASC`.

##### 2. Ordenação por Várias Colunas

Caso queira ordenar por mais de uma coluna, como `cidade` e `idade`, use:

```sql
SELECT * FROM clientes ORDER BY cidade, idade;
```

**Resultado**: A consulta primeiro ordena os resultados por `cidade` e, dentro da mesma cidade, pela `idade` em ordem crescente.

---

## Funcionamento do GROUP BY

`GROUP BY` **agrupa todos os valores iguais em uma única linha para cada valor** da coluna especificada. No exemplo da tabela `vendas` com as colunas `ano` e `valor`, ao agrupar pelo `ano`, ele **junta todos os registros do mesmo ano** em uma linha, em vez de mostrar o ano repetidamente.

### Como Funciona o GROUP BY

Imagine uma tabela com diversas linhas onde algumas colunas têm valores repetidos, como uma tabela de vendas em que temos o ano e o valor das vendas. O `GROUP BY` ajuda a agrupar esses dados repetidos para facilitar análises, como totalizar vendas por ano.

#### Exemplos Práticos de Uso

#### 1. Contando Ocorrências em um Grupo

Vamos supor que temos uma tabela `clientes` com uma coluna `cidade`, onde cada cliente é registrado junto com sua cidade. Podemos usar o `GROUP BY` para contar quantos clientes temos em cada cidade:

```sql
SELECT cidade, COUNT(*) AS numero_de_clientes 
FROM clientes 
GROUP BY cidade;
```

**Explicação**:

- `GROUP BY cidade`: Agrupa todos os registros por cidade.
- `COUNT(*)`: Conta quantos clientes há em cada grupo de cidade.
- Resultado: Uma lista de cidades com o número de clientes em cada uma.

#### 2. Soma de Vendas por Ano

Se há uma tabela `vendas` com colunas `ano` e `valor`, podemos somar as vendas feitas em cada ano usando `GROUP BY`:

```sql
SELECT ano, SUM(valor) AS total_vendas 
FROM vendas 
GROUP BY ano;
```

**Explicação**:

- `GROUP BY ano`: Agrupa as linhas da tabela `vendas` por ano.
- `SUM(valor)`: Calcula a soma de `valor` para cada ano.
- Resultado: A soma das vendas para cada ano presente na tabela.

Por exemplo, imagine uma tabela `vendas` assim:

| ano  | valor |
| ---- | ----- |
| 2020 | 100   |
| 2020 | 150   |
| 2021 | 200   |
| 2021 | 250   |
| 2022 | 300   |

Ao executar a consulta:
```sql
SELECT ano, SUM(valor) AS total_vendas
FROM vendas
GROUP BY ano;
```

O `GROUP BY` agrupa todas as vendas pelo `ano` e calcula a soma para cada grupo. O resultado será algo assim:

|ano|total_vendas|
|---|---|
|2020|250|
|2021|450|
|2022|300|

O `GROUP BY` evita repetições e apresenta cada ano apenas uma vez, com a soma total dos valores de cada ano.

### Como Ordenar os Resultados

Se você deseja uma ordem específica, você pode combinar o `GROUP BY` com o `ORDER BY`. Por exemplo, para garantir que os anos apareçam em ordem crescente:

```sql
SELECT ano, SUM(valor) AS total_vendas
FROM vendas
GROUP BY ano
ORDER BY ano ASC;
```

Assim, o `ORDER BY` controla a ordem dos resultados agrupados (neste caso, do menor para o maior ano), enquanto o `GROUP BY` agrupa e evita repetições na tabela.
## Funcionamento do HAVING

O `HAVING` é um filtro para grupos de dados e é utilizado junto com o `GROUP BY`. Ele permite filtrar os resultados dos grupos formados.

#### Exemplos de Uso

##### 1. Filtrar Grupos com Condições

Com a tabela `clientes` agrupada por idade, podemos buscar apenas grupos que tenham mais de um cliente:

```sql
SELECT idade, COUNT(*) 
FROM clientes 
GROUP BY idade 
HAVING COUNT(*) > 1;
```

**Resultado**: A consulta mostra apenas as idades que aparecem mais de uma vez na tabela.

##### 2. Condição em Agregações

No caso da tabela `vendas`, podemos filtrar para exibir apenas os anos com uma soma de vendas maior que 1000:

```sql
SELECT ano, SUM(valor) 
FROM vendas 
GROUP BY ano 
HAVING SUM(valor) > 1000;
```

**Resultado**: A consulta mostra apenas os anos em que o total de vendas foi superior a 1000.

---
## Funcionamento do LIMIT

O `LIMIT` restringe o número de registros que uma consulta retorna. Ele é especialmente útil para limitar resultados em tabelas grandes.

#### Exemplos de Uso

##### 1. Retornar Apenas um Número Específico de Registros

Para retornar apenas os primeiros 10 registros de uma tabela `clientes`:

```sql
SELECT * 
FROM clientes 
LIMIT 10;
```

**Resultado**: A consulta retorna apenas os primeiros 10 registros da tabela `clientes`.

##### 2. Paginação de Resultados

O `LIMIT` pode ser usado com `OFFSET` para criar paginação. Por exemplo, para exibir a segunda página com 10 registros por página:

```sql
SELECT * 
FROM clientes 
LIMIT 10 OFFSET 10;
```

**Resultado**: A consulta retorna do 11º ao 20º registro.

---
## VIEW
Uma `VIEW` é uma tabela virtual que exibe dados de uma ou mais tabelas, usamos ela para que o usuário não tenha acesso aos dados de  outras tabelas ou para facilitar requisições pelo backend .

**Sintaxe**:
```sql
CREATE VIEW nome_da_view AS SELECT coluna1, coluna2 FROM tabela WHERE condição;
```

para exibirmos a `view` usamos o comando `select`: 

```sql
SELECT * FROM nome_da_view;
```

Exemplo:
```sql
CREATE VIEW view_clientes AS SELECT nome, idade FROM clientes WHERE idade >= 18;
```