create or replace package math
as
  function sum(
     numero number,
     valor number
  ) return NUMBER;
    PROCEDURE MULTIPLE(
        NUMERO NUMBER,
        VALOR NUMBER 
    );
   function constructormath(
      NUMERO in NUMBER,
      VALOR IN NUMBER
   ) return OBJECT;

   
end math;   

CREATE OR REPLACE PACKAGE BODY math aS
 FUNCTION sum(
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




