--! OBJECT VS PACKAGE
--? NESTE CODIGO ESTUDAREI AS APLICACOES DOS OBJETOS DO PL/SQL
set SERVEROUTPUT on ;
--* DIFERENCA ENTRE O PACKEGE E O OBJECT
--! OBJECT SAO ESTRUTURA DINAMICAS QUE PODEM SER INSTACIADAS PELO CODIGO E POSSUEM A PROPRIEDADE DE HERANCA;
--! PACKEGE SAO ESTRUTURA ESTATICAS ;

--* CLASS ABSTRACT PERSON 
CREATE OR REPLACE TYPE PERSON AS OBJECT (
    NOME VARCHAR2(15),
    ENDERECO VARCHAR2(15),
    IDADE INTEGER ,
    MEMBER FUNCTION FALAR(FALA VARCHAR2) RETURN VARCHAR2 
)not final;


--* CRIANDO O CORPO DA FUNCAO DE UM OBJECTO COM ACONTECE TBM NO PACKAGE
CREATE OR REPLACE TYPE BODY PERSON AS
MEMBER FUNCTION FALAR(FALA VARCHAR2) RETURN VARCHAR2
    IS
 BEGIN
 RETURN FALA;
 END;
END;

--* HERENDANDO A 'CLASS' PERSON 
CREATE OR REPLACE TYPE PROFISSION UNDER PERSON(
    PROFISSAO VARCHAR2(50)
);


--* PARAM1 É UMA INSTANCIA DO OBJECT PERSON
CREATE OR REPLACE PROCEDURE PROCEDURE1 (
  PARAM1 PERSON) IS

BEGIN
    --! CHAMANDO UMA FUNCAO DE PERSON ATRAVEZ DA INSTANCIA PARAM1
    DBMS_OUTPUT.PUT_LINE(PARAM1.FALAR(PARAM1.NOME));

END PROCEDURE1;
/

--* CHAMANDO O CONSTRUCTOR COMO PARAMENTRO DE UMA PROCEDURE TBM SE APLICA A FUNCOES
EXECUTE PROCEDURE1(PERSON('DOUGLAS','ALEGRE',10));

--* CRIAR TABELA ATRAVEZ DE OBJETOS 
create table profissionais of profission ; 

--* SELECIONANDO CAMPOS  
select * from profissionais ;


--* INSERINDO DADOS ATRAVEZ DE UM CONSTRUTOR  
insert into profissionais VALUES (PROFISSION('pedro','alegre',25,'programador') );