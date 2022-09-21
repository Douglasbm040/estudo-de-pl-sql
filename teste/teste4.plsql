-- Select rows from a Table

SELECT *
FROM TB_PRODUTOS;


CREATE OR REPLACE FUNCTION CONSULTA_1 (
    P_CATEGORIA IN VARCHAR2
    )RETURN VARCHAR2 IS
        RESPOSTA VARCHAR2(30);
        QNT_POR_CATEGORIA INTEGER;
BEGIN
    SELECT COUNT(CATEGORIA) INTO QNT_POR_CATEGORIA FROM TB_PRODUTOS WHERE CATEGORIA = P_CATEGORIA;
    
    IF QNT_POR_CATEGORIA <> 0 THEN 
        RESPOSTA :='CATEGORIA '||P_CATEGORIA||', total de itens: '||QNT_POR_CATEGORIA ;
        RETURN RESPOSTA ;
    ELSE
        RESPOSTA := 'Categoria inexistente';
        RETURN RESPOSTA;
    END IF ;
END CONSULTA_1;
/

SET SERVEROUTPUT ON ;
SELECT * FROM TB_PRODUTOS ;
BEGIN
    DBMS_OUTPUT.PUT_LINE(CONSULTA_2('A'));
END;

CREATE OR REPLACE PROCEDURE CONSULTA_2 (
    P_CATEGORIA IN VARCHAR2
    )IS
        NOME_PRODUTO_MAX TB_PRODUTOS.NOME%TYPE;
        NOME_PRODUTO_MIN TB_PRODUTOS.NOME%TYPE;
BEGIN
    SELECT NOME INTO  NOME_PRODUTO_MIN FROM TB_PRODUTOS   
        WHERE PRECO = (SELECT MIN(PRECO) FROM TB_PRODUTOS WHERE CATEGORIA = P_CATEGORIA ) ;
    SELECT NOME INTO  NOME_PRODUTO_MAX FROM TB_PRODUTOS  
        WHERE PRECO = (SELECT MAX(PRECO) FROM TB_PRODUTOS WHERE CATEGORIA = P_CATEGORIA ) ;
    

    DBMS_OUTPUT.PUT_LINE(' Categoria '||P_CATEGORIA||' , produto de maior valor: '|| NOME_PRODUTO_MAX);
    DBMS_OUTPUT.PUT_LINE(' Categoria '||P_CATEGORIA||' , produto de menor valor: '|| NOME_PRODUTO_MIN);
 
    
    EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('Categoria inexistente');
END CONSULTA_2;
/
DROP FUNCTION CONSULTA_2

BEGIN
    CONSULTA_2('Z');
END;

--! 3ª etapa: Agora vamos verificar a média de preços por categoria. 
--! O programa deverá receber  a categoria e calcular a média dos preços dos produtos da categoria informada. 
--! O programa deverá retornar a mensagem “A média dos produtos desta categoria é: resultado da média”.
--!  Caso seja informada uma categoria inexistente deverá ser retornada a mensagem “Categoria inexistente”.



CREATE OR REPLACE FUNCTION CONSULTA_3 (
    P_CATEGORIA IN VARCHAR2
    )RETURN VARCHAR2 IS
        RESPOSTA VARCHAR2(30);
        MEDIA_POR_CATEGORIA FLOAT;
BEGIN
    SELECT ROUND(AVG(PRECO),2) INTO MEDIA_POR_CATEGORIA FROM TB_PRODUTOS WHERE CATEGORIA = P_CATEGORIA;
    
    IF MEDIA_POR_CATEGORIA <> 0 THEN 
        RESPOSTA :='CATEGORIA '||P_CATEGORIA||', MEDIA '||MEDIA_POR_CATEGORIA ;
        RETURN RESPOSTA ;
    ELSE
        RESPOSTA := 'Categoria inexistente';
        RETURN RESPOSTA;
    END IF ;
END CONSULTA_3;
/
BEGIN
    DBMS_OUTPUT.PUT_LINE(CONSULTA_3('A') );
END ;


SELECT * FROM TB_PRODUTOS
SELECT AVG(PRECO) FROM TB_PRODUTOS WHERE CATEGORIA = 'A';

--! 4ª etapa: Agora vamos aplicar o reajuste no preço dos produtos de acordo com a categoria.
--! O programa deverá receber  a categoria e o percentual de reajuste e aplicar o reajuste em todos os itens da categoria.
--! Após realizar o reajuste o programa deverá retornar a mensagem “Reajuste Realizado com sucesso”.
--! Caso seja informada uma categoria inexistente deverá ser retornada a mensagem “Categoria inexistente”.

--Create a new Procedure

CREATE OR REPLACE PROCEDURE REAJUSTAPRECO_CATEGORIA (
  P_CATEGORIA IN VARCHAR2,
  P_PORCENTAUMENTO IN FLOAT
  ) IS
    ID_REAJUSTE INTEGER;
    VALOR_AJUSTADO TB_PRODUTOS.PRECO%TYPE;
    CURSOR CURSO_ID IS SELECT PRECO INTO ID_REAJUSTE FROM TB_PRODUTOS WHERE CATEGORIA = P_CATEGORIA ;
BEGIN
    FOR ITEM IN CURSO_ID LOOP
        VALOR_AJUSTADO := ITEM.PRECO + (ITEM.PRECO * (P_PORCENTAUMENTO / 100));
        UPDATE TB_PRODUTOS SET PRECO = VALOR_AJUSTADO  WHERE PRECO = ITEM.PRECO;
    END LOOP;
        DBMS_OUTPUT.PUT_LINE('Reajuste Realizado com sucesso');
    EXCEPTION
        WHEN no_data_found THEN 
            DBMS_OUTPUT.PUT_LINE('Categoria inexistente'); 
END;
/
ROLLBACK
EXECUTE REAJUSTAPRECO_CATEGORIA('A',0)
SELECT * FROM TB_PRODUTOS

SELECT PRECO FROM TB_PRODUTOS WHERE CATEGORIA = 'A';


