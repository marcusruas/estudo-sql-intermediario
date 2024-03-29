CREATE TABLE CLIENTE (
NOME VARCHAR(40) NOT NULL,
SEXO CHAR(1) NOT NULL,
CPF VARCHAR(14) NOT NULL,
EMAIL VARCHAR(30),
TELEFONE VARCHAR(20),
CIDADE VARCHAR (20) NOT NULL,
ESTADO CHAR(3) NOT NULL,
RUA VARCHAR(50)
);

INSERT INTO CLIENTE(NOME,SEXO,CPF,CIDADE,ESTADO) VALUES('Marcus','M','857.380.000-30','Gravatai','RS');
INSERT INTO CLIENTE(NOME,SEXO,CPF,CIDADE,ESTADO) VALUES('Valdomiro','M','123.456.789-10','Taubate','SP');
INSERT INTO CLIENTE(NOME,SEXO,CPF,CIDADE,ESTADO) VALUES('Gian','M','987.654.321-01','Cachoeirinha','RS');
INSERT INTO CLIENTE(NOME,SEXO,CPF,CIDADE,ESTADO) VALUES('Mario','M','654.132.786-12','Maranhao','MG');
INSERT INTO CLIENTE(NOME,SEXO,CPF,CIDADE,ESTADO) VALUES('Fagner','M','098.498.154-30','ITUI','SP');
INSERT INTO CLIENTE(NOME,SEXO,CPF,CIDADE,ESTADO) VALUES('Linda','F','857.380.000-30','Gravatai','RS');
INSERT INTO CLIENTE(NOME,SEXO,CPF,CIDADE,ESTADO) VALUES('Morgana','F','123.456.789-10','Taubate','SP');
INSERT INTO CLIENTE(NOME,SEXO,CPF,CIDADE,ESTADO) VALUES('Acacia','F','987.654.321-01','Cachoeirinha','RS');
INSERT INTO CLIENTE(NOME,SEXO,CPF,CIDADE,ESTADO) VALUES('Carina','F','654.132.786-12','Maranhao','MG');
INSERT INTO CLIENTE(NOME,SEXO,CPF,CIDADE,ESTADO) VALUES('Ellen','F','098.498.154-30','ITUI','SP');

/* FUNCAO UPDATE SERVE PRA MUDAR ATRIBUTOS DE UM REGISTRO */
UPDATE CLIENTE
SET EMAIL = 'marcus.ruas@hotmail.com'
WHERE NOME='Marcus';

UPDATE CLIENTE
SET EMAIL = 'valdomiro@hotmail.com'
WHERE NOME='Valdomiro';

UPDATE CLIENTE
SET EMAIL = 'gian@hotmail.com'
WHERE NOME='Gian';

UPDATE CLIENTE
SET EMAIL = 'fabio@hotmail.com'
WHERE NOME='Mario';

UPDATE CLIENTE
SET EMAIL = 'fagner@hotmail.com'
WHERE NOME='Fagner';

UPDATE CLIENTE
SET EMAIL = 'linda@hotmail.com'
WHERE NOME='Linda';

UPDATE CLIENTE
SET EMAIL = 'morgana@hotmail.com'
WHERE NOME='Morgana';

UPDATE CLIENTE
SET EMAIL = 'acacia@hotmail.com'
WHERE NOME='Acacia';

UPDATE CLIENTE
SET EMAIL = 'carina@hotmail.com'
WHERE NOME='Carina';

UPDATE CLIENTE
SET EMAIL = 'ellen@hotmail.com'
WHERE NOME='Ellen';
/* NAO UTILIZAR O UPDATE SEM WHERE */

/* DELETE SERVE PARA REMOVER REGISTROS */
DELETE FROM CLIENTE
WHERE NOME = 'valdomiro';
/* NAO UTILIZAR O DELETE SEM WHERE */
