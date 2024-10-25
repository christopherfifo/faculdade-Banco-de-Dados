CREATE DATABASE IF NOT EXISTS dev_fifo;

USE dev_fifo;

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

-- Inserindo produtos
INSERT INTO produtos (nome_produto, preco_produto, estoque) VALUES
('Landing Page', 1200.00, 10),
('Blog', 2000.00, 20),
('Aplicativo Mobile', 3575.80, 5),
('E-commerce', 5000.00, 3),
('Consultoria de SEO', 2500.00, 1);

-- Inserindo clientes
INSERT INTO clientes (nome, email, telefone) VALUES
('João Silva', 'joao.silva@email.com', '1111-2222'),
('Maria Oliveira', 'maria.oliveira@email.com', '2222-3333'),
('Pedro Santos', 'pedro.santos@email.com', '3333-4444'),
('Ana Souza', 'ana.souza@email.com', '4444-5555'),
('Lucas Lima', 'lucas.lima@email.com', '5555-6666');

INSERT INTO pedidos (id_usuario, nome_usuario, quant, total) VALUES
(1, 'João Silva', 2, 3200.00),
(2, 'Maria Oliveira', 1, 3575.80),
(4, 'Ana Souza', 2, 6200.00);

INSERT INTO itens_pedido (id_pedido, id_cliente, nome_cliente, id_produto, nome_produto, quant_produto, valor_total) VALUES
(1, 1, 'João Silva', 1, 'Landing Page', 1, 1200.00),
(1, 1, 'João Silva', 2, 'Blog', 1, 2000.00),
(2, 2, 'Maria Oliveira', 3, 'Aplicativo Mobile', 1, 3575.80),
(3, 4, 'Ana Souza', 1, 'Landing Page', 1, 1200.00),
(3, 4, 'Ana Souza', 4, 'E-commerce', 1, 5000.00);

-- 1. Listar todos os clientes
CREATE VIEW view_clientes AS
SELECT id, nome, email, telefone, criado_em, alterado_em FROM clientes;

-- 2. Listar todos os produtos
CREATE VIEW view_produtos AS
SELECT id, nome_produto, preco_produto, estoque, reposto_em FROM produtos;

-- 3. Listar todos os pedidos
CREATE VIEW view_pedidos AS
SELECT id, nome_usuario, quant, total, feito_em FROM pedidos;

-- 4. Mostrar detalhes dos pedidos com nomes de clientes e produtos
CREATE VIEW view_detalhes_pedidos AS
SELECT pedidos.id AS id_pedido, pedidos.nome_usuario AS cliente, produtos.nome_produto, itens_pedido.quant_produto, itens_pedido.valor_total, pedidos.feito_em
FROM itens_pedido
JOIN pedidos ON itens_pedido.id_pedido = pedidos.id
JOIN produtos ON itens_pedido.id_produto = produtos.id;

-- 5. Listar estoque de produtos
CREATE VIEW view_estoque_produtos AS
SELECT id, nome_produto, estoque FROM produtos;

-- 6. Total de pedidos por cliente
CREATE VIEW view_total_pedidos_por_cliente AS
SELECT clientes.id, clientes.nome, COUNT(pedidos.id) AS total_pedidos
FROM clientes
JOIN pedidos ON clientes.id = pedidos.id_usuario
GROUP BY clientes.id, clientes.nome;

-- 7. Total de produtos vendidos
CREATE VIEW view_total_produtos_vendidos AS
SELECT produtos.id, produtos.nome_produto, SUM(itens_pedido.quant_produto) AS total_vendido
FROM produtos
JOIN itens_pedido ON produtos.id = itens_pedido.id_produto
GROUP BY produtos.id, produtos.nome_produto;

-- 8. Listar clientes que fizeram pedidos
CREATE VIEW view_clientes_com_pedidos AS
SELECT DISTINCT clientes.id, clientes.nome
FROM clientes
JOIN pedidos ON clientes.id = pedidos.id_usuario;

-- 9. Listar clientes que não fizeram pedidos
CREATE VIEW view_clientes_sem_pedidos AS
SELECT clientes.id, clientes.nome
FROM clientes
LEFT JOIN pedidos ON clientes.id = pedidos.id_usuario
WHERE pedidos.id IS NULL;

-- 10. Listar pedidos feitos em um determinado mês (Ex: outubro)
CREATE VIEW view_pedidos_por_mes AS
SELECT id, nome_usuario, quant, total, feito_em
FROM pedidos
WHERE MONTH(feito_em) = 10;

-- 11. Listar produtos com estoque menor que 30 unidades
CREATE VIEW view_produtos_baixo_estoque AS
SELECT id, nome_produto, estoque
FROM produtos
WHERE estoque < 30;

-- 12. Valor total dos pedidos por cliente
CREATE VIEW view_valor_total_pedidos_por_cliente AS
SELECT clientes.id, clientes.nome, SUM(pedidos.total) AS valor_total_pedidos
FROM clientes
JOIN pedidos ON clientes.id = pedidos.id_usuario
GROUP BY clientes.id, clientes.nome;

-- 13. Média de pedidos por cliente
CREATE VIEW view_media_pedidos_por_cliente AS
SELECT clientes.id, clientes.nome, AVG(pedidos.total) AS media_pedidos
FROM clientes
JOIN pedidos ON clientes.id = pedidos.id_usuario
GROUP BY clientes.id, clientes.nome;

-- 14. Produtos mais vendidos
CREATE VIEW view_produtos_mais_vendidos AS
SELECT produtos.id, produtos.nome_produto, SUM(itens_pedido.quant_produto) AS total_vendido
FROM produtos
JOIN itens_pedido ON produtos.id = itens_pedido.id_produto
GROUP BY produtos.id, produtos.nome_produto
ORDER BY total_vendido DESC;

-- 15. Clientes com maior valor de pedidos
CREATE VIEW view_clientes_maior_valor_pedidos AS
SELECT clientes.id, clientes.nome, SUM(pedidos.total) AS valor_total_pedidos
FROM clientes
JOIN pedidos ON clientes.id = pedidos.id_usuario
GROUP BY clientes.id, clientes.nome
ORDER BY valor_total_pedidos DESC;


-- 1. Listar todos os clientes
SELECT * FROM view_clientes;

-- 2. Listar todos os produtos
SELECT * FROM view_produtos;

-- 3. Listar todos os pedidos
SELECT * FROM view_pedidos;

-- 4. Mostrar detalhes dos pedidos com nomes de clientes e produtos
SELECT * FROM view_detalhes_pedidos;

-- 5. Listar estoque de produtos
SELECT * FROM view_estoque_produtos;

-- 6. Total de pedidos por cliente
SELECT * FROM view_total_pedidos_por_cliente;

-- 7. Total de produtos vendidos
SELECT * FROM view_total_produtos_vendidos;

-- 8. Listar clientes que fizeram pedidos
SELECT * FROM view_clientes_com_pedidos;

-- 9. Listar clientes que não fizeram pedidos
SELECT * FROM view_clientes_sem_pedidos;

-- 10. Listar pedidos feitos em um determinado mês (Ex: outubro)
SELECT * FROM view_pedidos_por_mes;

-- 11. Listar produtos com estoque menor que 30 unidades
SELECT * FROM view_produtos_baixo_estoque;

-- 12. Valor total dos pedidos por cliente
SELECT * FROM view_valor_total_pedidos_por_cliente;

-- 13. Média de pedidos por cliente
SELECT * FROM view_media_pedidos_por_cliente;

-- 14. Produtos mais vendidos
SELECT * FROM view_produtos_mais_vendidos;

-- 15. Clientes com maior valor de pedidos
SELECT * FROM view_clientes_maior_valor_pedidos;

