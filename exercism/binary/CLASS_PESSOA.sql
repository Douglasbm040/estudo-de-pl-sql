create or replace package PESSOA
as
CREATE TYPE PERSON AS OBJECT (
 NOME VARCHAR2(15),
 SOBRENOME VARCHAR2(15)
 
);
  function INSERINOME(
     PERSON.NOME IN VARCHAR2,
     PERSON.SOBRENOME IN VARCHAR2
    
  ) return VARCHAR2;

    PROCEDURE GETPESSOA(
         SOBRENOME IN VARCHAR2
    );

   function constructormath(
      NUMERO in NUMBER,
      VALOR IN NUMBER
   ) return PERSON;

   
end PESSOA;   

CREATE OR REPLACE PACKAGE BODY math aS
 FUNCTION INSERINOME(
    numero number,
    valor number
 )return NUMBER 
 IS
 valorf number ;
 BEGIN
    return numero + valor ;
    END;

    PROCEDURE MULTIPLE(
        NUMERO NUMBER,
        VALOR NUMBER
    )IS
        
    BEGIN
    DBMS_OUTPUT.PUT_LINE(NUMERO * VALOR);
    
    END ;
 END;




