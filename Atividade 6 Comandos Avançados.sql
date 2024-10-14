-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS atividade6;

-- Abrir o banco de dados
USE atividade6;

-- Criar a tabela Forma_Pagto, se ainda não existir
CREATE TABLE IF NOT EXISTS Forma_Pagto (
    FormaPagto VARCHAR(1),
    Descricao_Pagto VARCHAR(20),
    PRIMARY KEY (FormaPagto)
);

-- Inserir dados na tabela Forma_Pagto, se ainda não existirem
INSERT INTO Forma_Pagto (FormaPagto, Descricao_Pagto) 
VALUES 
('1', 'A vista Dinheiro'), 
('2', 'Débito no Cartão'), 
('3', 'Crédito no Cartão');

-- Criar a tabela Compras, se ainda não existir
CREATE TABLE IF NOT EXISTS Compras (
    cod_cliente VARCHAR(4),
    Forma_Pagto VARCHAR(1),
    comprador VARCHAR(30),
    Data_Compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
    Vl_compra DECIMAL(13, 2),
    CONSTRAINT FK_Cliente_Compra FOREIGN KEY (Forma_Pagto)
    REFERENCES Forma_Pagto(FormaPagto)
);

-- Inserir registros na tabela Compras
INSERT INTO Compras (cod_cliente, Forma_Pagto, comprador, Data_Compra, Vl_compra)
VALUES 
('C01', '1', 'Ana Maria da Cruz', STR_TO_DATE('23/03/2024', '%d/%m/%Y'), 500),
('C01', '2', 'Ana Maria da Cruz', STR_TO_DATE('24/03/2024', '%d/%m/%Y'), 1500),
('C02', '1', 'Carlos Pereira', STR_TO_DATE('25/03/2024', '%d/%m/%Y'), 3200),
('C03', '3', 'Joana Silva', STR_TO_DATE('26/03/2024', '%d/%m/%Y'), 4500),
('C04', '2', 'Marcos Santos', STR_TO_DATE('27/03/2024', '%d/%m/%Y'), 7000),
('C05', '1', 'Julia Costa', STR_TO_DATE('28/03/2024', '%d/%m/%Y'), 8500),
('C06', '3', 'Pedro Oliveira', STR_TO_DATE('29/03/2024', '%d/%m/%Y'), 5300),
('C07', '2', 'Fernanda Souza', STR_TO_DATE('30/03/2024', '%d/%m/%Y'), 12000),
('C08', '1', 'Ricardo Lima', STR_TO_DATE('31/03/2024', '%d/%m/%Y'), 4800),
('C09', '1', 'Amanda Lopes', STR_TO_DATE('01/04/2024', '%d/%m/%Y'), 600),
('C10', '2', 'Alice Santos', STR_TO_DATE('02/04/2024', '%d/%m/%Y'), 7200),
('C11', '3', 'Adriana Silva', STR_TO_DATE('03/04/2024', '%d/%m/%Y'), 3000),
('C12', '1', 'Eduardo Fernandes', STR_TO_DATE('04/04/2024', '%d/%m/%Y'), 450),
('C13', '2', 'Bianca Souza', STR_TO_DATE('05/04/2024', '%d/%m/%Y'), 9000),
('C14', '3', 'Caio Andrade', STR_TO_DATE('06/04/2024', '%d/%m/%Y'), 5800),
('C15', '1', 'Diego Costa', STR_TO_DATE('07/04/2024', '%d/%m/%Y'), 3900),
('C16', '1', 'Amélia Nascimento', STR_TO_DATE('08/04/2024', '%d/%m/%Y'), 3500),
('C17', '2', 'Amaro Silva', STR_TO_DATE('09/04/2024', '%d/%m/%Y'), 2200);


-- 1) Selecionar código, nome, data da compra, descrição do pagto e valor da compra com valores entre R$ 3000.00 e R$ 5500.00, ordem crescente de nome
SELECT cod_cliente, comprador, Descricao_Pagto, Vl_compra 
FROM Compras
INNER JOIN Forma_Pagto ON Compras.Forma_Pagto = Forma_Pagto.FormaPagto
WHERE Vl_compra BETWEEN 3000.00 AND 5500.00
ORDER BY comprador;

-- 2) Selecionar código, nome, data da compra, descrição do pagto e valor da compra com valores entre R$ 6000.00 e R$ 15000.00, ordem crescente de valores de compra
SELECT cod_cliente, comprador, Descricao_Pagto, Vl_compra 
FROM Compras
INNER JOIN Forma_Pagto ON Compras.Forma_Pagto = Forma_Pagto.FormaPagto
WHERE Vl_compra BETWEEN 6000.00 AND 15000.00
ORDER BY Vl_compra;

-- 3) Selecionar os registros com Compras à "vista Dinheiro"
SELECT * 
FROM Compras
INNER JOIN Forma_Pagto ON Compras.Forma_Pagto = Forma_Pagto.FormaPagto
WHERE Descricao_Pagto = 'A vista Dinheiro';

-- 4) Selecionar os registros das Compras à "vista Dinheiro" e "Débito no Cartão"
SELECT * 
FROM Compras
INNER JOIN Forma_Pagto ON Compras.Forma_Pagto = Forma_Pagto.FormaPagto
WHERE Descricao_Pagto IN ('A vista Dinheiro', 'Débito no Cartão');

-- 5) Selecionar Total de Compra, descrição do pagto agrupando por tipo de pagto
SELECT Descricao_Pagto, SUM(Vl_compra) AS Total_Compra
FROM Compras
INNER JOIN Forma_Pagto ON Compras.Forma_Pagto = Forma_Pagto.FormaPagto
GROUP BY Descricao_Pagto;

-- 6) Selecionar todos os dados dos compradores cujo nome iniciam com 'A'
SELECT * 
FROM Compras
WHERE comprador LIKE 'A%';

-- 7) Selecionar todos os dados dos compradores cujo nome terminam com 'A' em ordem decrescente
SELECT * 
FROM Compras
WHERE comprador LIKE '%A'
ORDER BY comprador DESC;

-- 8) Selecionar todos os dados dos compradores cujo nome começam com 'Am' em ordem decrescente de compras
SELECT * 
FROM Compras
WHERE comprador LIKE 'Am%'
ORDER BY Vl_compra DESC;

-- 9) Selecionar todos os dados dos compradores cujo nome começam com 'Am', tenham qualquer caracter na 3ª posição e 'l' na 4ª posição
SELECT * 
FROM Compras
WHERE comprador LIKE 'Am_l%';

-- 10) Selecionar todos os dados dos compradores que tenham a letra 'D' no nome
SELECT * 
FROM Compras
WHERE comprador LIKE '%D%';

-- 11) Selecionar todos os dados dos compradores que iniciam com 'A' OU 'E' em ordem alfabética
SELECT * 
FROM Compras
WHERE comprador LIKE 'A%' OR comprador LIKE 'E%'
ORDER BY comprador;

-- 12) Selecionar todos os dados dos compradores que iniciam com 'A', 'B', 'C', 'D' OU 'E'
SELECT * 
FROM Compras
WHERE comprador REGEXP '^[ABCDE]';

-- 13) Selecionar todos os dados dos compradores que iniciam com 'A', 'C', OU 'E' e tenham compras acima de R$ 5000.00
SELECT * 
FROM Compras
WHERE (comprador LIKE 'A%' OR comprador LIKE 'C%' OR comprador LIKE 'E%') 
AND Vl_compra > 5000.00;

-- 14) Selecionar a quantidade de compras
SELECT COUNT(*) AS Quantidade_Compras
FROM Compras;

-- 15) Selecionar o total das compras
SELECT SUM(Vl_compra) AS Total_Compras
FROM Compras;

-- 16) Selecionar o valor da maior compra
SELECT MAX(Vl_compra) AS Maior_Compra
FROM Compras;

-- 17) Selecionar o valor da menor compra
SELECT MIN(Vl_compra) AS Menor_Compra
FROM Compras;

-- 18) Selecionar a média das compras
SELECT AVG(Vl_compra) AS Media_Compras
FROM Compras;

-- 19) Selecionar o valor da maior compra do cliente 'C02'
SELECT MAX(Vl_compra) AS Maior_Compra_C02
FROM Compras
WHERE cod_cliente = 'C02';

-- 20) Selecionar o código e valor da maior compra de cada cliente
SELECT cod_cliente, MAX(Vl_compra) AS Maior_Compra
FROM Compras
GROUP BY cod_cliente;

-- 21) Selecionar o código, nome e valor da maior compra de cada cliente
SELECT cod_cliente, comprador, MAX(Vl_compra) AS Maior_Compra
FROM Compras
GROUP BY cod_cliente, comprador;

-- 22) Selecionar o código, nome, quantidade de compras e total de compras de cada cliente em ordem crescente de comprador
SELECT cod_cliente, comprador, COUNT(*) AS Quantidade_Compras, SUM(Vl_compra) AS Total_Compras
FROM Compras
GROUP BY cod_cliente, comprador
ORDER BY comprador;

-- 23) Selecionar o código, nome, quantidade, maior, menor, total e média de compras de cada cliente em ordem crescente de código do comprador
SELECT cod_cliente, comprador, COUNT(*) AS Quantidade_Compras, 
       MAX(Vl_compra) AS Maior_Compra, 
       MIN(Vl_compra) AS Menor_Compra, 
       SUM(Vl_compra) AS Total_Compras, 
       AVG(Vl_compra) AS Media_Compras
FROM Compras
GROUP BY cod_cliente, comprador
ORDER BY cod_cliente;

-- 24) Selecionar o tipo e total de compras por tipo de compra
SELECT Forma_Pagto, SUM(Vl_compra) AS Total_Compras
FROM Compras
GROUP BY Forma_Pagto;

-- 25) Selecionar o tipo, descrição de compras e total de compras por tipo de compra do comprador 'C03'
SELECT Forma_Pagto, Descricao_Pagto, SUM(Vl_compra) AS Total_Compras
FROM Compras
INNER JOIN Forma_Pagto ON Compras.Forma_Pagto = Forma_Pagto.FormaPagto
WHERE cod_cliente = 'C03'
GROUP BY Forma_Pagto, Descricao_Pagto;

-- 26) Selecionar o tipo, descrição da compra e total de compras para as compras com cartão (débito e crédito)
SELECT Forma_Pagto, Descricao_Pagto, SUM(Vl_compra) AS Total_Compras
FROM Compras
INNER JOIN Forma_Pagto ON Compras.Forma_Pagto = Forma_Pagto.FormaPagto
WHERE Forma_Pagto IN ('2', '3') -- '2' para débito e '3' para crédito
GROUP BY Forma_Pagto, Descricao_Pagto;

-- 26.5) Selecionar a quantidade de compras e Total de compras a Débito no cartão
SELECT COUNT(*) AS Quantidade_Compras, SUM(Vl_compra) AS Total_Compras
FROM Compras
WHERE Forma_Pagto = '2'; -- '2' para débito

-- 27) Selecionar a quantidade de clientes e Total de compras que compraram a crédito no cartão
SELECT COUNT(DISTINCT cod_cliente) AS Quantidade_Clientes, SUM(Vl_compra) AS Total_Compras
FROM Compras
WHERE Forma_Pagto = '3'; -- '3' para crédito

-- 28) Selecionar a quantidade de compras, média e total de valores das compras crédito no cartão por cliente
SELECT cod_cliente, COUNT(*) AS Quantidade_Compras, 
       SUM(Vl_compra) AS Total_Compras, 
       AVG(Vl_compra) AS Media_Compras
FROM Compras
WHERE Forma_Pagto = '3' -- '3' para crédito
GROUP BY cod_cliente;

-- 29) Selecionar a maior e a menor compra de cada cliente
SELECT cod_cliente, MAX(Vl_compra) AS Maior_Compra, MIN(Vl_compra) AS Menor_Compra
FROM Compras
GROUP BY cod_cliente;

-- 30) Selecionar o código, maior e a menor compra de cada cliente
SELECT cod_cliente, MAX(Vl_compra) AS Maior_Compra, MIN(Vl_compra) AS Menor_Compra
FROM Compras
GROUP BY cod_cliente;

-- 31) Selecionar todos os dados dos compradores com sobrenome Souza ou Sousa
SELECT * 
FROM Compras
WHERE comprador LIKE '%Souza' OR comprador LIKE '%Sousa';

