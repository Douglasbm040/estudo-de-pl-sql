--* CRAICAO DE TABELAS ATRAVEZ DE OBJETOS

CREATE OR REPLACE TYPE CLIENTE AS OBJECT (
    ID INTEGER,
    NOME VARCHAR2(15),
    IDADE INTEGER 
);

CREATE  TABLE TAB_CLIENTES OF CLIENTE;
/
ALTER TABLE TAB_CLIENTES ADD CONSTRAINT ID PRIMARY KEY(ID);
/
ALTER TABLE TAB_CLIENTES MODIFY (ID NOT NULL);
/
--! DROP TABLE TAB_CLIENTES
DESCRIBE TAB_CLIENTES
--* CRIACAO DE TABELAS COM SQL PURO
CREATE TABLE TABELA_CLIENTES (
    ID INTEGER NOT NULL,
    NOME VARCHAR2(15),
    IDADE INTEGER,
    PRIMARY KEY(ID)
);


DESCRIBE TABELA_CLIENTES

--* INSERT DADOS COM OBJETOS 

CREATE OR REPLACE TYPE ID AS VARRAY(5) OF INTEGER;
CREATE OR REPLACE TYPE NOME AS VARRAY(5) OF VARCHAR2(15);
CREATE OR REPLACE TYPE IDADE AS VARRAY(5) OF INTEGER;

DECLARE 
    V_ID ID := ID(1,2,3,4,5);
    V_NOME NOME := NOME('JULIANA SILVA','PAULO COSTA','FERNANDA PIRES','FÁBIO ALVES','ANTÔNIO CARLOS');
    V_IDADE IDADE := IDADE(16,45,18,25,17);
BEGIN
   FOR ITEM IN 1.. 5 LOOP 
        INSERT INTO TAB_CLIENTES VALUES
        (
          CLIENTE('        '||V_ID(ITEM) ,V_NOME(ITEM),V_IDADE(ITEM))
        );
   END LOOP ;
END ;

SELECT * FROM TAB_CLIENTES

--* INSERT COM SQL PURO 

DECLARE 
    V_ID ID := ID(1,2,3,4,5);
    V_NOME NOME := NOME('JULIANA SILVA','PAULO COSTA','FERNANDA PIRES','FÁBIO ALVES','ANTÔNIO CARLOS');
    V_IDADE IDADE := IDADE(16,45,18,25,17);
BEGIN
   FOR ITEM IN 1.. 5 LOOP 
        INSERT INTO  TABELA_CLIENTES(
            ID,NOME,IDADE
        ) VALUES (
           V_ID(ITEM) ,V_NOME(ITEM),V_IDADE(ITEM));
   END LOOP ;
END ;

SELECT * FROM TABELA_CLIENTES ;



--* CRIAR PROC_PEGARNOMECLIENTES
SET SERVEROUTPUT ON ;
CREATE OR REPLACE PROCEDURE PROC_PEGARNOMECLIENTES (
  P_ID IN INTEGER) IS
  REPOSTA TAB_CLIENTES.NOME%TYPE;
BEGIN
    SELECT NOME INTO REPOSTA FROM TAB_CLIENTES
        WHERE ID = P_ID ;

    DBMS_OUTPUT.PUT_LINE('======>'||REPOSTA);

    EXCEPTION 
        WHEN no_data_found
        THEN 
        REPOSTA := 'cliente nao encontrado';
        DBMS_OUTPUT.PUT_LINE('======>'||REPOSTA);
END PROC_PEGARNOMECLIENTES;
/

EXECUTE PROC_PEGARNOMECLIENTES(2);
EXECUTE PROC_PEGARNOMECLIENTES(8);
EXECUTE PROC_PEGARNOMECLIENTES(NULL);

--* TESTE DE PROCEDURE PROC_PEGARNOMECLIENTES
CREATE OR REPLACE PROCEDURE TESTE_PROC_PEGARNOMECLIENTES (
  DESCR_TEST IN VARCHAR2,
  EXPECTATIVA IN VARCHAR2,
  RECEBIDO  IN INTEGER
  ) IS
  
BEGIN
    DBMS_OUTPUT.PUT_LINE('TEST NUMERO '|| DESCR_TEST);
    IF EXPECTATIVA = TO_CHAR(RECEBIDO) THEN
        DBMS_OUTPUT.PUT_LINE('SUCESSO !');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('REJEITADO ! -- ESPERADO '||EXPECTATIVA||' RECEBIDO : '||RECEBIDO);
    END IF ;
END TESTE_PROC_PEGARNOMECLIENTES;
/

CREATE OR REPLACE TYPE V_EXP_PEGARNOMECLIENTES AS VARRAY(3) OF VARCHAR(30);
CREATE OR REPLACE TYPE V_REC_PEGARNOMECLIENTES AS VARRAY(3) OF INTEGER(10);

DECLARE 
    V_RECEBE V_REC_PEGARNOMECLIENTES := V_REC_PEGARNOMECLIENTES(2,8,NULL);
    V_EXP V_EXP_PEGARNOMECLIENTES := V_EXP_PEGARNOMECLIENTES('PAULO COSTA','0','0');
BEGIN
    DBMS_OUTPUT.PUT_LINE('#############################');
    FOR ITEM IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE('VALOR ESPERADO ');
        DBMS_OUTPUT.PUT_LINE('======>'||V_EXP(ITEM));
        DBMS_OUTPUT.PUT_LINE('----------------------------');
        DBMS_OUTPUT.PUT_LINE('VALOR RECEBIDO');
        PROC_PEGARNOMECLIENTES(V_RECEBE(ITEM));
        DBMS_OUTPUT.PUT_LINE('#############################');
    END LOOP ;

END;

CREATE OR REPLACE PROCEDURE PROC_RETORNAMAIORIDADE (
  P_ID IN INTEGER) IS
  REP_NOME  TAB_CLIENTES.NOME%TYPE;
  REP_IDADE TAB_CLIENTES.NOME%TYPE;
BEGIN
    SELECT NOME,IDADE INTO REP_NOME , REP_IDADE FROM TAB_CLIENTES
        WHERE ID = P_ID ;
    IF REP_IDADE >= 18 THEN
        DBMS_OUTPUT.PUT_LINE(' Maior de idade : '||REP_NOME);
    ELSE 
        DBMS_OUTPUT.PUT_LINE(' Menor de Idade : '||REP_NOME);
    END IF;

    EXCEPTION 
        WHEN no_data_found
        THEN 
        DBMS_OUTPUT.PUT_LINE('Cliente não encontrado ');
END PROC_RETORNAMAIORIDADE;


EXECUTE PROC_RETORNAMAIORIDADE(1)


DECLARE 
    V_RECEBE V_REC_PEGARNOMECLIENTES := V_REC_PEGARNOMECLIENTES(1,2,3);
    V_EXP V_EXP_PEGARNOMECLIENTES := V_EXP_PEGARNOMECLIENTES('PAULO COSTA','0','0');
BEGIN
    DBMS_OUTPUT.PUT_LINE('#############################');
    FOR ITEM IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE('VALOR ESPERADO ');
        DBMS_OUTPUT.PUT_LINE('======>'||V_EXP(ITEM));
        DBMS_OUTPUT.PUT_LINE('----------------------------');
        DBMS_OUTPUT.PUT_LINE('VALOR RECEBIDO');
        PROC_RETORNAMAIORIDADE(V_RECEBE(ITEM));
        DBMS_OUTPUT.PUT_LINE('#############################');
    END LOOP ;
     PROC_RETORNAMAIORIDADE(NULL);

END;

EXECUTE PROC_RETORNAMAIORIDADE(1);
EXECUTE PROC_RETORNAMAIORIDADE(2);
EXECUTE PROC_RETORNAMAIORIDADE(3);
EXECUTE PROC_RETORNAMAIORIDADE(NULL);
