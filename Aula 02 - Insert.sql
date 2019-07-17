USE PROJETOUM;

SHOW TABLES;

DESC CLIENTE;

/* Inserindo Linhas(Tuplas) */

/* Forma 01 - Excluindo as Colunas */
INSERT INTO CLIENTE VALUES('Marcus Vinicius Ruas','M','marcus.ruas@hotmail.com',857380000,'(51) 99393-9190','Gravatai');

/* Forma 02 */

/* Colocando as Colunas */
INSERT INTO CLIENTE(NOME,SEXO,EMAIL,CPF,TELEFONE,ENDERECO) VALUES('Cecilia Ramos','F','cecilia@hotmail.com',123456789,'(23) 8475-9190','Cachoeirinha');