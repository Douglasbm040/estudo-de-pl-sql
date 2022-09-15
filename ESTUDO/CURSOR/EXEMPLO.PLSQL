--* USO DO CURSOR ?
--* DESCREVER O USO DO CURSOR 
--* Você usa um cursor para buscar as linhas retornadas por uma consulta.
--* Você recupera as linhas no cursor usando uma consulta e, então, 
--* busca as linhas do cursor, uma por vez
DECLARE
 CURSOR NOME_DO_CURSOR IS
 SELECT CAMPOS FROM products
 ORDER BY CAMPO;
BEGIN
 FOR I IN NOME_DO_CURSOR LOOP
 DBMS_OUTPUT.PUT_LINE(
 'CAMPO ' || NOME_DO_CURSOR.CAMPO ||
 ', CAMPO = ' || NOME_DO_CURSOR.CAMPO ||
 ', CAMPO = ' || NOME_DO_CURSOR.CAMPO
 );
 END LOOP;
END;