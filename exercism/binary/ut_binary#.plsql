set SERVEROUTPUT on ;
create or  replace package binario as 
function to_decimal(
  p_binario in varchar2 
) return NUMBER;
end;
 
create or  replace package body binario as 
function to_decimal(
  p_binario in varchar2 
) return NUMBER
is 
  n_binari number ;
  passo1 number;
  i number ;
  x number := 0 ;
  base_dec number := 0;
  


BEGIN
  i := LENGTH(p_binario);
  WHILE x < i  LOOP
   n_binari := TO_NUMBER(SUBSTR(p_binario,
           i-x,
           1));


  IF n_binari <= 1 then
   passo1 := POWER(2,x)*n_binari ;
   base_dec := base_dec + passo1;
   /*DBMS_OUTPUT.PUT_LINE('valor de loop numero     ' || x || '  soma final    ' ||
                         base_dec || ' corte do binario      ' || n_binari || ' valor da variavel passo1 ' || passo1);

   */
   else 
   RETURN 0 ;
   END IF ;


   x := x + 1;
  END LOOP;

   return base_dec ;
  

  
  


  EXCEPTION 
   WHEN value_error
  THEN
    RETURN 0;
   
END;
end;


select binario.to_decimal('0') from dual;



create or replace package ut_binary#
is
  procedure run;
end ut_binary#;
/
 
create or replace package body ut_binary#
is
  procedure test (
    i_descn                                       varchar2
   ,i_exp                                         pls_integer
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
 /*procedure test */
  procedure run
  is
  begin
    test(i_descn => 'test_binary_1_is_decimal_1'              , i_exp => 1   , i_act => binario.to_decimal('1'          ));
    test(i_descn => 'test_binary_10_is_decimal_2'             , i_exp => 2   , i_act => binario.to_decimal('10'         ));
    test(i_descn => 'test_binary_11_is_decimal_3'             , i_exp => 3   , i_act => binario.to_decimal('11'         ));
    test(i_descn => 'test_binary_100_is_decimal_4'            , i_exp => 4   , i_act => binario.to_decimal('100'        ));
    test(i_descn => 'test_binary_1001_is_decimal_9'           , i_exp => 9   , i_act => binario.to_decimal('1001'       ));
    test(i_descn => 'test_binary_11010_is_decimal_26'         , i_exp => 26  , i_act => binario.to_decimal('11010'      ));
    test(i_descn => 'test_binary_10001101000_is_decimal_1128' , i_exp => 1128, i_act => binario.to_decimal('10001101000'));
    test(i_descn => 'test_invalid_binary_postfix_is_decimal_0', i_exp => 0   , i_act => binario.to_decimal('10110a'     ));
    test(i_descn => 'test_invalid_binary_prefix_is_decimal_0' , i_exp => 0   , i_act => binario.to_decimal('a10110'     ));
    test(i_descn => 'test_invalid_binary_infix_is_decimal_0'  , i_exp => 0   , i_act => binario.to_decimal('101a10'     ));
    test(i_descn => 'test_invalid_binary_is_decimal_0'        , i_exp => 0   , i_act => binario.to_decimal('101210'     ));
  end run;
end ut_binary#;
/
/*teste da solucao */
begin
  ut_binary#.run;
end;
/
