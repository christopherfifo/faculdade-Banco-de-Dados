-- 1. Criar o banco de dados
CREATE DATABASE Bd_Turma;

-- 2. Abrir o banco de dados
USE Bd_Turma;
-- 3. Criar as tabelas
CREATE TABLE Depto (
    DEPTO CHAR(3) PRIMARY KEY,
    DESC_DEPTO VARCHAR(20) NOT NULL
);

CREATE TABLE Funcionario (
    NUM_FUNC CHAR(6) PRIMARY KEY,
    NOME VARCHAR(12),
    SOBRENOME VARCHAR(25) NOT NULL,
    DEPT CHAR(3),
    FONE CHAR(14),
    DTADIM DATE DEFAULT (CURRENT_DATE),
    NIVEL INT,
    SEXO CHAR(1),
    DATANAS DATE,
    SALARIO DECIMAL(10,2),
    BONUS DECIMAL(10,2) DEFAULT 0,
    COMIS DECIMAL(10,2),
    FOREIGN KEY (DEPT) REFERENCES Depto(DEPTO)
);

-- 4. Inserir os dados na tabela Depto
INSERT INTO Depto (DEPTO, DESC_DEPTO) VALUES
('001', 'DIRETORIA'),
('002', 'GERÊNCIA'),
('003', 'ENGENHARIA'),
('004', 'PRODUÇÃO'),
('005', 'INFORMATICA'),
('006', 'GERÊNCIA INFORMÁTICA');

-- 5. Inserir os dados na tabela Funcionario
-- Exemplo de inserção de funcionários (os dados reais devem ser inseridos conforme especificado)
INSERT INTO Funcionario (NUM_FUNC, NOME, SOBRENOME, DEPT, FONE, NIVEL, SEXO, DATANAS, SALARIO, COMIS) VALUES
('F001', 'João', 'Silva', '001', '1234-5678', 1, 'M', '1980-01-01', 50000, 5000);
INSERT INTO Funcionario (NUM_FUNC, NOME, SOBRENOME, DEPT, FONE, NIVEL, SEXO, DATANAS, SALARIO, COMIS) VALUES
('F002', 'Maria', 'Oliveira', '002', '1234-5679', 2, 'F', '1985-02-02', 60000, 6000);
INSERT INTO Funcionario (NUM_FUNC, NOME, SOBRENOME, DEPT, FONE, NIVEL, SEXO, DATANAS, SALARIO, COMIS) VALUES
('F003', 'José', 'Santos', '003', '9876-5432', 3, 'M', '1990-05-15', 55000, 5000);
INSERT INTO Funcionario (NUM_FUNC, NOME, SOBRENOME, DEPT, FONE, NIVEL, SEXO, DATANAS, SALARIO, COMIS) VALUES
('F004', 'Ana', 'Pereira', '004', '3456-7890', 4, 'F', '1988-11-22', 70000, 7000);
INSERT INTO Funcionario (NUM_FUNC, NOME, SOBRENOME, DEPT, FONE, NIVEL, SEXO, DATANAS, SALARIO, COMIS) VALUES
('F005', 'Carlos', 'Almeida', '005', '4567-8901', 5, 'M', '1992-03-30', 62000, 6200);


select * from Funcionario;
select * from Depto;
-- 6. Realizar as operações de atualização e exclusão
-- Alterar o Depto de um dos funcionários do Depto de Informática para Depto de Engenharia
UPDATE Funcionario SET DEPT = '003' WHERE NUM_FUNC = 'F002';

-- Alterar o depto de INFORMATICA para INFORMÁTICA
UPDATE Depto SET DESC_DEPTO = 'INFORMÁTICA' WHERE DEPTO = '005';

-- Aumentar o Salário dos funcionários em 17%
UPDATE Funcionario SET SALARIO = SALARIO * 1.17;

-- Alterar o campo Bonus com 5% de Salário para todos os funcionários
UPDATE Funcionario SET BONUS = SALARIO * 0.05;

-- Alterar o campo Bonus com 15% de Salário para todos os funcionários de Engenharia
UPDATE Funcionario SET BONUS = SALARIO * 0.15 WHERE DEPT = '003';

-- Aumentar em 5% todos os Salários
UPDATE Funcionario SET SALARIO = SALARIO * 1.05 ;

-- Aumentar em 6% o Salário dos funcionários do Depto da Gerência
UPDATE Funcionario SET SALARIO = SALARIO * 1.06 WHERE DEPT = '002';

-- Diminuir em 2% o Salário dos funcionários de Engenharia
UPDATE Funcionario SET SALARIO = SALARIO * 0.98 WHERE DEPT = '003';

-- Alterar o fone do Funcionário com código “F004”, para “3643-4576”
UPDATE Funcionario SET FONE = '3643-4576' WHERE NUM_FUNC = 'F004';

-- Excluir todos os registros de Depto (não é possível devido à restrição de chave estrangeira)
-- DELETE FROM Depto;

-- Excluir o registro do Depto “GERÊNCIA INFORMÁTICA”
DELETE FROM Depto WHERE DEPTO = '006';

-- Excluir todos os registros de funcionários
DELETE FROM Funcionario; -- quando esta com o modo safe não da

--      Incluir todos  os registros do Depto e Funcionários (Novamente ?)

INSERT INTO Funcionario (NUM_FUNC, NOME, SOBRENOME, DEPT, FONE, NIVEL, SEXO, DATANAS, SALARIO, COMIS) VALUES
('F001', 'João', 'Silva', '001', '1234-5678', 1, 'M', '1980-01-01', 50000, 5000);
INSERT INTO Funcionario (NUM_FUNC, NOME, SOBRENOME, DEPT, FONE, NIVEL, SEXO, DATANAS, SALARIO, COMIS) VALUES
('F002', 'Maria', 'Oliveira', '002', '1234-5679', 2, 'F', '1985-02-02', 60000, 6000);
INSERT INTO Funcionario (NUM_FUNC, NOME, SOBRENOME, DEPT, FONE, NIVEL, SEXO, DATANAS, SALARIO, COMIS) VALUES
('F003', 'José', 'Santos', '003', '9876-5432', 3, 'M', '1990-05-15', 55000, 5000);
INSERT INTO Funcionario (NUM_FUNC, NOME, SOBRENOME, DEPT, FONE, NIVEL, SEXO, DATANAS, SALARIO, COMIS) VALUES
('F004', 'Ana', 'Pereira', '004', '3456-7890', 4, 'F', '1988-11-22', 70000, 7000);
INSERT INTO Funcionario (NUM_FUNC, NOME, SOBRENOME, DEPT, FONE, NIVEL, SEXO, DATANAS, SALARIO, COMIS) VALUES
('F005', 'Carlos', 'Almeida', '005', '4567-8901', 5, 'M', '1992-03-30', 62000, 6200);

-- Excluir os registros dos funcionários do departamento de INFORMÁTICA
DELETE FROM Funcionario WHERE DEPT = '005';

-- Excluir o registro do Depto de GERÊNCIA INFORMÁTICA
DELETE FROM Depto WHERE DEPTO = '006';

-- 7. Executar as consultas SQL conforme as especificações
-- Listar todos os campos de todos os funcionários
SELECT * FROM Funcionario;

-- Listar todos os campos de todos os Departamentos
SELECT * FROM Depto;

-- Listar os campos Numero e Nome e Salário (Colocar um Alias para cada campo) de todos funcionários
SELECT NUM_FUNC AS Numero, NOME AS Nome, SALARIO AS Salário FROM Funcionario;

-- Listar os campos Numero e Nome e Salário de todos funcionários do Departamento de informática
SELECT NUM_FUNC AS Numero, NOME AS Nome, SALARIO AS Salário FROM Funcionario WHERE DEPT = '005';

-- Listar os campos Numero e Nome e Salário de todos funcionários do Departamento de Produção com salário maior que R$ 2.000,00
SELECT NUM_FUNC AS Numero, NOME AS Nome, SALARIO AS Salário FROM Funcionario WHERE DEPT = '004' AND SALARIO > 2000;

-- Listar os campos Numero e Nome e Salário de todos funcionários do Departamento de Produção com salário menor que R$ 20.000,00
SELECT NUM_FUNC AS Numero, NOME AS Nome, SALARIO AS Salário FROM Funcionario WHERE DEPT = '004' AND SALARIO < 20000;

-- Listar os campos Numero e Nome e Salário de todos funcionários do Departamento de Informática com salário menor ou igual a R$ 7.000,00
SELECT NUM_FUNC AS Numero, NOME AS Nome, SALARIO AS Salário FROM Funcionario WHERE DEPT = '005' AND SALARIO <= 7000;


-- Listar os campos Numero e Nome e Salário de todos funcionários do Departamento de Produção com salário entre R$ 600,00 e R$ 2.000,00
SELECT NUM_FUNC AS Numero, NOME AS Nome, SALARIO AS Salário FROM Funcionario WHERE DEPT = '004' AND SALARIO BETWEEN 600 AND 2000;

-- Listar os campos Numero e Nome e Salário de todos funcionários do Departamento de Produção
SELECT NUM_FUNC AS Numero, NOME AS Nome, SALARIO AS Salário FROM Funcionario WHERE DEPT = '004';

-- Listar os campos Número, Nome, Salário em ordem crescente de salário
SELECT NUM_FUNC AS Numero, NOME AS Nome, SALARIO AS Salário FROM Funcionario ORDER BY SALARIO ASC;

-- Listar os campos Número, Nome, Salário do Departamento de produção em ordem decrescente de salário
SELECT NUM_FUNC AS Numero, NOME AS Nome, SALARIO AS Salário FROM Funcionario WHERE DEPT = '004' ORDER BY SALARIO DESC;

-- Listar os campos Número, Nome, Data de Nascimento e Bonus dos funcionários de Informática
SELECT NUM_FUNC AS Numero, NOME AS Nome, DATANAS AS Data_de_Nascimento, BONUS AS Bonus FROM Funcionario WHERE DEPT = '005';

-- Listar todos os dados dos funcionários com curso Superior (Graduação) em ordem alfabética de nome (Colocar um apelido para campo)
SELECT NUM_FUNC AS Numero, NOME AS Nome, SOBRENOME AS Sobrenome, DEPT AS Departamento, FONE AS Telefone, DTADIM AS Data_de_Admissao, NIVEL AS Nivel, SEXO AS Sexo, DATANAS AS Data_de_Nascimento, SALARIO AS Salario, BONUS AS Bonus, COMIS AS Comissao FROM Funcionario WHERE NIVEL = 3 ORDER BY NOME ASC;

-- Listar todos dados dos funcionários com curso Pós-Graduação em ordem decrescente de nome
SELECT * FROM Funcionario WHERE NIVEL = 4 ORDER BY NOME DESC;

-- Listar os campos dos funcionários do Departamento de Informática com salário entre R$ 5.600,00 e R$ 8.000,00
SELECT NUM_FUNC AS Numero, NOME AS Nome, SALARIO AS Salário FROM Funcionario WHERE DEPT = '005' AND SALARIO BETWEEN 5600 AND 8000;
--