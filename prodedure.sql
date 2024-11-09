DROP DATABASE IF EXISTS Livraria;

CREATE DATABASE Livraria;

USE Livraria;

CREATE TABLE Editoras (
    id_editora INT PRIMARY KEY,
    Editora VARCHAR(70)
);

CREATE TABLE Livros (
    id_livro INT PRIMARY KEY,
    nome_livro VARCHAR(70),
    id_editora INT,
    valor_livro DECIMAL(15,2),
    CONSTRAINT fk_editora_livro FOREIGN KEY (id_editora) REFERENCES Editoras(id_editora)
);

INSERT INTO Editoras (id_editora, Editora) VALUES
    (1, 'EVALDO DO ROSARIO WOLKERS'),
    (2, 'SciELO - Editora UNESP');

INSERT INTO Livros (id_livro, nome_livro, id_editora, valor_livro) VALUES
    (1, 'Python para Todos', 1, 45.00);

SELECT * FROM Editoras;
SELECT * FROM Livros;

DELIMITER $$

CREATE PROCEDURE SP_Inserir_Livro(IN Id INT, IN Nome VARCHAR(70), IN Valor DECIMAL(15,2))
BEGIN
    INSERT INTO Livros (id_livro, nome_livro, valor_livro) VALUES (Id, Nome, Valor);
END $$

DELIMITER ;

CALL SP_Inserir_Livro(2, 'Big Data: Continuidade ou Revolução?', 65.00);

SELECT * FROM Livros;

DELIMITER $$

CREATE PROCEDURE SP_AumentaValor(IN Id INT, IN Taxa DECIMAL(10,2))
BEGIN
    UPDATE Livros
    SET valor_livro = valor_livro + valor_livro * Taxa / 100
    WHERE id_livro = Id;
END $$

DELIMITER ;

SET @livro = 1;
SET @aumento = 20;
CALL SP_AumentaValor(@livro, @aumento);

SELECT * FROM Livros WHERE id_livro = 1;

DELIMITER $$

CREATE PROCEDURE SP_TESTE_OUT(IN Id INT, OUT livro VARCHAR(70))
BEGIN
    SELECT nome_livro INTO livro FROM Livros WHERE id_livro = Id;
END $$

DELIMITER ;

CALL SP_TESTE_OUT(2, @LIVRO);
SELECT @LIVRO;

DELIMITER $$

CREATE PROCEDURE Aumento(INOUT valor DECIMAL(15,2), IN taxa DECIMAL(10,2))
BEGIN
    SET valor = valor + valor * taxa / 100;
END $$

DELIMITER ;

SET @valorinicial = 20.00;
SELECT @valorinicial;

CALL Aumento(@valorinicial, 15.00);
SELECT @valorinicial;

DELIMITER $$

CREATE PROCEDURE SP_VerValor(IN Id INT)
BEGIN
    SELECT CONCAT('O preço do livro é ', valor_livro) AS Valor
    FROM Livros
    WHERE id_livro = Id;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS SP_Aumento;

DELIMITER $$

CREATE PROCEDURE SP_Aumento(IN Id INT, IN Taxa DECIMAL(10,2), INOUT novovalor DECIMAL(15,2))
BEGIN
    SELECT valor_livro INTO novovalor FROM Livros WHERE id_livro = Id;
    SET novovalor = novovalor + novovalor * Taxa / 100;
    UPDATE Livros SET valor_livro = novovalor WHERE id_livro = Id;
    COMMIT;
END $$

DELIMITER ;

SET @livro = 2;
SET @aumento = 20;
SET @novo = 0;
CALL SP_Aumento(@livro, @aumento, @novo);

SELECT @novo;

SELECT * FROM Livros WHERE id_livro = 2;