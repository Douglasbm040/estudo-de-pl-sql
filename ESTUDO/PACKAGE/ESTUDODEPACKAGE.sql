--Create a new Package

CREATE PACKAGE CONTEINER IS

  -- Add a procedure
  PROCEDURE PROCEDURE1 (
    PARAM1 IN NUMBER);

  -- Add a function
  FUNCTION FUNCTION1 (
    PARAM1 IN NUMBER) RETURN NUMBER;

END CONTEINER;
/
--Create a new Package Body

CREATE PACKAGE BODY CONTEINER IS

    


  -- Add procedure body
  PROCEDURE PROCEDURE1 (
    PARAM1 IN NUMBER) IS
    BEGIN
      NULL;
    END PROCEDURE1;

  -- Add function body
  FUNCTION FUNCTION1 (
    PARAM1 IN NUMBER) RETURN NUMBER IS
    BEGIN
      RETURN PARAM1;
    END FUNCTION1;

END CONTEINER;
/