
CREATE OR REPLACE PACKAGE series# 
IS
 FUNCTION square_of_sums(
  NUMERO NUMBER
 )RETURN NUMBER ;

  FUNCTION sum_of_squares(
  NUMERO NUMBER
 )RETURN NUMBER ;
  FUNCTION diff_of_squares(
  NUMERO NUMBER
 )RETURN NUMBER ;

END ;

/*poderia subtraiar as duas funcoes mais e a mais performatica ?*/
CREATE OR REPLACE PACKAGE BODY series# 
AS 
  FUNCTION square_of_sums (
  NUMERO NUMBER
) RETURN NUMBER
IS 
  i number ;
  sums number :=0;
BEGIN

  FOR i IN 1..numero LOOP
    sums := sums + i;
  END LOOP;

    sums := POWER(sums,2);


  
  RETURN sums ;
  end;

  FUNCTION sum_of_squares (
  NUMERO NUMBER
) RETURN NUMBER
IS 
  i number ;
  parcelas number ;
  sums number :=0;
BEGIN

  FOR i IN 1..numero LOOP
    parcelas := POWER(i,2);
    sums := sums + parcelas;
  END LOOP;

    


  
  RETURN sums ;
  end;

  FUNCTION diff_of_squares (
  NUMERO NUMBER,
) RETURN NUMBER
IS 
  i number ;
  parcelas number ;
  sums number :=0;
BEGIN

  FOR i IN 1..numero LOOP
    parcelas := POWER(i,2);
    sums := sums + parcelas;
  END LOOP;

    


  
  RETURN sums ;
  end;

END ;









create or replace package ut_series#
is
  procedure run;
end ut_series#;
/
 
create or replace package body ut_series#
is
  procedure test (
    i_descn                                       varchar2
   ,i_exp                                         number
   ,i_act                                         number
  )
  is
  begin
    if i_exp = i_act then
      dbms_output.put_line('SUCCESS: ' || i_descn);
    else
      dbms_output.put_line('FAILURE: ' || i_descn || ' - expected ' || nvl('' || i_exp, 'null') || ', but received ' || nvl('' || i_act, 'null'));
    end if;
  end test;
 
  procedure run
  is
  begin
    test(i_descn => 'test_square_of_sums_to_5'      , i_exp => 225     , i_act => series#.square_of_sums(5)   );
    test(i_descn => 'test_sum_of_squares_to_5'      , i_exp => 55      , i_act => series#.sum_of_squares(5)   );
    test(i_descn => 'test_difference_of_sums_to_5'  , i_exp => 170     , i_act => series#.diff_of_squares(5)  );
    /*test(i_descn => 'test_square_of_sums_to_10'     , i_exp => 3025    , i_act => series#.square_of_sums(10)  );
    test(i_descn => 'test_sum_of_squares_to_10'     , i_exp => 385     , i_act => series#.sum_of_squares(10)  );
    test(i_descn => 'test_difference_of_sums_to_10' , i_exp => 2640    , i_act => series#.diff_of_squares(10) );
    test(i_descn => 'test_square_of_sums_to_100'    , i_exp => 25502500, i_act => series#.square_of_sums(100) );
    test(i_descn => 'test_sum_of_squares_to_100'    , i_exp => 338350  , i_act => series#.sum_of_squares(100) );
    test(i_descn => 'test_difference_of_sums_to_100', i_exp => 25164150, i_act => series#.diff_of_squares(100));
  */end run;
end ut_series#;
/
 
begin
  ut_series#.run;
end;
/
