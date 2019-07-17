-- ORGANIZACAO DE CHAVES - CONSTRAINT (REGRA)

CREATE TABLE JOGADOR(
		IDJOG INT PRIMARY KEY AUTO_INCREMENT,
		NOME VARCHAR (30) NOT NULL,
		SEXO ENUM('M','F') NOT NULL
);

CREATE TABLE TIME(
		IDTIM INT PRIMARY KEY AUTO_INCREMENT,
		NOME VARCHAR(30),
		ID_JOG INT,
		FOREIGN KEY(ID_JOG) REFERENCES JOGADOR(IDJOG)
);

INSERT INTO JOGADOR(NOME,SEXO) VALUES ('Messi','M');
INSERT INTO TIME(NOME,ID_JOG) VALUES('Barcelona', 1);

-- CONSTRAINTS

SHOW TABLES;

+----------------+
| Tables_in_loja |
+----------------+
| cliente        |
| curso          |
| endereco       |
| jogador        |
| pessoa         |
| telefone       |
| time           |
| vendedor       |
+----------------+

DROP TABLE ENDERECO;
DROP TABLE TELEFONE;
DROP TABLE CLIENTE;

-- BOAS PRATICAS

CREATE TABLE CLIENTE(
	IDCLI INT,
	NOME VARCHAR(30) NOT NULL
);

CREATE TABLE TELEFONE(
	IDTEL INT,
	TIPO CHAR(3) NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLI INT
);

ALTER TABLE CLIENTE ADD CONSTRAINT PK_CLI
PRIMARY KEY (IDCLI);

ALTER TABLE TELEFONE ADD CONSTRAINT FK_TEL_CLI
FOREIGN KEY (ID_CLI) REFERENCES CLIENTE(IDCLI);

SHOW CREATE TABLE TELEFONE;

-- DICIONARIO DE DADOS

SHOW DATABASES;

USE INFORMATION_SCHEMA;

STATUS

SHOW TABLES;

DESC TABLE_CONSTRAINTS;

SELECT CONSTRAINT_SCHEMA AS "BANCO",
		TABLE_NAME AS "TABELA",
		CONSTRAINT_TYPE AS "TIPO"
FROM TABLE_CONSTRAINTS;

-- ESPECIFICAMENTE O BANCO DE DADOS LOJA

SELECT CONSTRAINT_SCHEMA AS "BANCO",
		CONSTRAINT_NAME AS "NOME DA REGRA",
		CONSTRAINT_TYPE AS "TIPO"
FROM TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = "LOJA";

--DELETANDO CONSTRAINT

USE COMERCIO;

ALTER TABLE TELEFONE
DROP FOREIGN KEY FK_TEL_CLI;