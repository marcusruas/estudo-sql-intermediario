/* TRIGGERS */

CREATE TABLE PRODUTO(
IDPRO INT IDENTITY PRIMARY KEY,
NOME VARCHAR(50) NOT NULL,
CATEGORIA VARCHAR(30) NOT NULL,
PRECO NUMERIC(10,2) NOT NULL
);
GO

CREATE TABLE HISTORICO(
IDHIS INT IDENTITY PRIMARY KEY,
IDPRO INT,
NOME VARCHAR(50),
CATEGORIA VARCHAR(30),
PRECOANTIGO NUMERIC(10,2),
PRECONOVO NUMERIC(10,2),
DATA DATETIME,
USUARIO VARCHAR(30),
MENSAGEM VARCHAR(100)
);
GO

INSERT INTO PRODUTO VALUES('Livro SQL Server','Livros',123.54)
INSERT INTO PRODUTO VALUES('Livro MYSQL Simples e Descomplicado','Livros',100.54)
INSERT INTO PRODUTO VALUES('Licen�a PowerPoint 2013','Softwares',10000.25)
INSERT INTO PRODUTO VALUES('Notebook Asus 2013','Computadores',3000.00)
INSERT INTO PRODUTO VALUES('Livro Oracle SQL','Livros',89.90)

SELECT * FROM PRODUTO;
GO

SELECT * FROM HISTORICO;
GO


/* VENDO USUARIO DO SQL */

SELECT SUSER_NAME();

/* CRIANDO AS TRIGGERS */

CREATE TRIGGER UPD_PRODUTO
ON DBO.PRODUTO
FOR UPDATE
AS
	DECLARE @IDPRO INT
	DECLARE @NOME VARCHAR(50)
	DECLARE @CATEGORIA VARCHAR(30)
	DECLARE @PRECO NUMERIC(10,2)
	DECLARE @PRECONOVO NUMERIC(10,2)
	DECLARE @DATA DATETIME
	DECLARE @USUARIO VARCHAR(30)
	DECLARE @ACAO VARCHAR(100)

	--PRIMEIRO BLOCO, VALORES DE TABELAS = SELECT
	SELECT @IDPRO = IDPRO FROM inserted
	SELECT @NOME = NOME FROM inserted
	SELECT @CATEGORIA = CATEGORIA FROM inserted
	SELECT @PRECO = PRECO FROM deleted
	SELECT @PRECONOVO = PRECO FROM inserted

	--SEGUNDO BLOCO, VALORES DE FUNCOES = SET
	SET @DATA = GETDATE()
	SET @USUARIO = SUSER_NAME()
	SET @ACAO = 'VALOR INSERIDO PELA TRIGGER UPD_PRODUTO'

	INSERT INTO HISTORICO (IDPRO, NOME, CATEGORIA, PRECOANTIGO, PRECONOVO, DATA, USUARIO, MENSAGEM)
	VALUES
	(@IDPRO, @NOME, @CATEGORIA, @PRECO, @PRECONOVO, @DATA, @USUARIO, @ACAO)
	
	PRINT 'TRIGGER EXECUTADA COM SUCESSO!'
	GO

	/* EXECUTANDO A TRIGGER */

	UPDATE PRODUTO SET PRECO = 59.99 WHERE IDPRO = 1;

	SELECT * FROM HISTORICO;

	/* PROGRAMANDO TRIGGER EM UMA COLUNA */

	DROP TRIGGER UPD_PRODUTO;

	CREATE TRIGGER UPD_PRODUTO_PRECO
	ON DBO.PRODUTO
	FOR UPDATE AS

	IF UPDATE(PRECO) 
	BEGIN
	DECLARE @IDPRO INT
	DECLARE @NOME VARCHAR(50)
	DECLARE @CATEGORIA VARCHAR(30)
	DECLARE @PRECO NUMERIC(10,2)
	DECLARE @PRECONOVO NUMERIC(10,2)
	DECLARE @DATA DATETIME
	DECLARE @USUARIO VARCHAR(30)
	DECLARE @ACAO VARCHAR(100)

	--PRIMEIRO BLOCO, VALORES DE TABELAS = SELECT
	SELECT @IDPRO = IDPRO FROM inserted
	SELECT @NOME = NOME FROM inserted
	SELECT @CATEGORIA = CATEGORIA FROM inserted
	SELECT @PRECO = PRECO FROM deleted
	SELECT @PRECONOVO = PRECO FROM inserted

	--SEGUNDO BLOCO, VALORES DE FUNCOES = SET
	SET @DATA = GETDATE()
	SET @USUARIO = SUSER_NAME()
	SET @ACAO = 'VALOR INSERIDO PELA TRIGGER UPD_PRODUTO'

	INSERT INTO HISTORICO (IDPRO, NOME, CATEGORIA, PRECOANTIGO, PRECONOVO, DATA, USUARIO, MENSAGEM)
	VALUES
	(@IDPRO, @NOME, @CATEGORIA, @PRECO, @PRECONOVO, @DATA, @USUARIO, @ACAO)
	
	PRINT 'TRIGGER EXECUTADA COM SUCESSO!'
	END
	GO

	/* TESTANDO */

	UPDATE PRODUTO SET PRECO = 69.99 WHERE IDPRO = 1;

	SELECT * FROM HISTORICO;

	UPDATE PRODUTO SET NOME = 'Livro do ABC' WHERE IDPRO = 1;

	SELECT * FROM HISTORICO;

	SELECT * FROM PRODUTO;

	/* ATRIBUINDO SELECTS AS VARIAVEIS - ANONIMO */

	CREATE TABLE RESULTADO (
		IDRES INT PRIMARY KEY IDENTITY,
		RESULTADO INT
	)
	GO

	DECLARE
			@RESULTADO INT
			SET @RESULTADO = (SELECT 10 + 10)
			INSERT INTO RESULTADO VALUES(@RESULTADO)
			PRINT 'VALOR INSERIDO NA TABELA: ' + CAST(@RESULTADO AS VARCHAR)
			GO

SELECT * FROM RESULTADO
GO

/* TRIGGER UPDATE SIMPLIFICADA */

CREATE TABLE EMPREGADO(
	IDEMP INT PRIMARY KEY,
	NOME VARCHAR(30),
	SALARIO MONEY,
	IDGER INT
);
GO

ALTER TABLE EMPREGADO ADD CONSTRAINT FK_GERENTE
FOREIGN KEY (IDGER) REFERENCES EMPREGADO(IDEMP)
GO

INSERT INTO EMPREGADO VALUES(1, 'CLARA', 5000.00, null)
INSERT INTO EMPREGADO VALUES(2, 'CELIA', 3000.00, 1)
INSERT INTO EMPREGADO VALUES(3, 'JOAO', 3000.00, 1)
GO

CREATE TABLE HIST_SALARIO(
	ID_EMP INT,
	ANTIGOSAL MONEY,
	NOVOSAL MONEY,
	DATA DATETIME
)
GO

CREATE TRIGGER EMP_SAL
ON DBO.EMPREGADO
FOR UPDATE AS
IF UPDATE(SALARIO)
BEGIN
	INSERT INTO HIST_SALARIO
	(ID_EMP, ANTIGOSAL, NOVOSAL, DATA)
	SELECT D.IDEMP, D.SALARIO, I.SALARIO, GETDATE()
	FROM DELETED D, inserted I
	WHERE D.IDEMP = I.IDEMP
END
GO

UPDATE EMPREGADO SET SALARIO = SALARIO * 1.1
GO

SELECT * FROM EMPREGADO
GO

SELECT * FROM HIST_SALARIO
GO

/* TRAZER SALARIO ANTIGO, SALARIO NOVO, DATA E NOME DO EMPREGADO */

SELECT H.ANTIGOSAL, H.NOVOSAL, H.DATA, E.NOME FROM HIST_SALARIO H INNER JOIN EMPREGADO E ON E.SALARIO = H.NOVOSAL
GO

/* COMO FAZER UM RANGE PARA VALORES */

CREATE TABLE RGSALARIO(
	MINSAL MONEY,
	MAXSAL MONEY
)
GO

INSERT INTO RGSALARIO VALUES(1000.00, 6000.00);
GO

CREATE TRIGGER TG_RGSALARIO
ON DBO.EMPREGADO
FOR INSERT, UPDATE
AS
	DECLARE
		@MINSAL MONEY,
	    @MAXSAL MONEY,
		@ATUALSAL MONEY

	SELECT @MINSAL = MINSAL, @MAXSAL = MAXSAL FROM RGSALARIO

	SELECT @ATUALSAL = I.SALARIO
	FROM INSERTED I

	IF (@ATUALSAL < @MINSAL) 
	BEGIN
		RAISERROR ('SALARIO MENOR QUE O PISO',16,1)
		ROLLBACK TRANSACTION
	END

	IF (@ATUALSAL > @MAXSAL) 
	BEGIN
		RAISERROR ('SALARIO MAIOR QUE O TETO',16,1)
		ROLLBACK TRANSACTION
	END
GO

UPDATE EMPREGADO SET SALARIO = 9000.00
WHERE IDEMP = 1
GO

/* VER TRIGGER */

SP_HELPTEXT TG_RGSALARIO
GO