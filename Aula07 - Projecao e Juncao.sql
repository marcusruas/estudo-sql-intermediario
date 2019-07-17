/* SELECAO PROJECAO E JUNCAO */

/* PROJECAO - TUDO QUE QUEREMOS PROJETAR NA TELA */
SELECT NOW() AS "DATA";

SELECT NOME, NOW() AS "DATA" FROM CLIENTE;

/* SELECAO - TEORIA DOS CONJUNTOS / WHERE E A CLAUSULA DE SELECAO */
SELECT NOME, SEXO 
FROM CLIENTE
WHERE SEXO = 'F';

UPDATE CLIENTE
SET EMAIL = 'Marcus.ruas@sql.com'
WHERE IDCLI = 1; /* SELECAO */

/* JUNCAO */

/* NOME, SEXO, BAIRRO, CIDADE, DATA */

SELECT NOME,SEXO,BAIRRO,CIDADE,NOW() AS "DATA"
FROM CLIENTE,ENDERECO
WHERE IDCLI = ID_CLI;	/* SELECAO */

SELECT NOME,SEXO,BAIRRO,CIDADE,NOW() AS "DATA"
FROM CLIENTE,ENDERECO
WHERE IDCLI = ID_CLI /* NAO FAZER, POIS SERA SEMPRE VERDADE*/
AND CIDADE = 'Gravatai';	/* SELECAO */

/* JOIN - JUNCAO */
SELECT NOME,SEXO,BAIRRO,CIDADE /* PROJECAO */
FROM CLIENTE
INNER JOIN ENDERECO /* JUNCAO */
ON IDCLI = ID_CLI /* O BANCO NAO IRA CHECAR (PERFORMANCE) */
WHERE CIDADE = 'Gravatai'; /* SELECAO */

/* PESQUISANDO DE DIFERENTES TABELAS */
SELECT CLIENTE.NOME,CLIENTE.SEXO,CLIENTE.CPF,
ENDERECO.CIDADE,ENDERECO.BAIRRO,ENDERECO.ESTADO,
TELEFONE.TIPO,TELEFONE.NUMERO
FROM CLIENTE
INNER JOIN ENDERECO
ON CLIENTE.IDCLI = ENDERECO.ID_CLI
INNER JOIN TELEFONE
ON CLIENTE.IDCLI = TELEFONE.ID_CLI;

/* PESQUISANDO DE DIFERENTES TABELAS (APELIDO) */
SELECT C.NOME,C.SEXO,C.CPF,
E.CIDADE,E.BAIRRO,E.ESTADO,
T.TIPO,T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E 
ON C.IDCLI = E.ID_CLI
INNER JOIN TELEFONE T
ON C.IDCLI = T.ID_CLI;