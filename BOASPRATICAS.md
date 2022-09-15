USE UMA CLÁUSULA WHERE PARA FILTRAR LINHAS

-- RUIM (recupera todas as linhas da tabela customers)
SELECT *
FROM customers;
CUSTOMER_ID FIRST_NAME LAST_NAME DOB PHONE
----------------------------------------------------
 1 John Brown 01-JAN-65 800-555-1211
 2 Cynthia Green 05-FEB-68 800-555-1212
 3 Steve White 16-MAR-71 800-555-1213
 4 Gail Black 800-555-1214
 5 Doreen Blue 20-MAY-70

-- BOM (usa uma cláusula WHERE para limitar as linhas recuperadas)
SELECT *
FROM customers
WHERE customer_id IN (1, 2);

CUSTOMER_ID FIRST_NAME LAST_NAME DOB PHONE
----------------------------------------------------
 1 John Brown 01-JAN-65 800-555-1211
 2 Cynthia Green 05-FEB-68 800-555-1212

USE JOINS DE TABELA EM VEZ DE VÁRIAS CONSULTAS
-- RUIM (duas consultas separadas, quando uma seria suficiente)
SELECT name, product_type_id
FROM products
WHERE product_id = 1;
NAME PRODUCT_TYPE_ID
---------------------------------------------
Modern Science 1
SELECT name
FROM product_types
WHERE product_type_id = 1;
NAME
----------
Book

-- BOM (uma única consulta com um join)
SELECT p.name, pt.name
FROM products p, product_types pt
WHERE p.product_type_id = pt.product_type_id
AND p.product_id = 1;
NAME NAME
----------------------------------------
Modern Science Book

USE REFERÊNCIAS DE COLUNA TOTALMENTE
QUALIFICADAS AO FAZER JOINS

-- RUIM (as colunas description e price não estão totalmente qualificadas)
SELECT p.name, pt.name, description, price
FROM products p, product_types pt
WHERE p.product_type_id = pt.product_type_id
AND p.product_id = 1;
NAME NAME
----------------------------------------
DESCRIPTION PRICE
------------------------------------------------------------
Modern Science Book
A description of modern science 19.95

-- BOM (todas as colunas estão totalmente qualificadas)
SELECT p.name, pt.name, p.description, p.price
FROM products p, product_types pt
WHERE p.product_type_id = pt.product_type_id
AND p.product_id = 1;
NAME NAME
----------------------------------------
DESCRIPTION PRICE
------------------------------------------------------------
Modern Science Book
A description of modern science 19.95

USE EXPRESSÕES CASE EM VEZ DE VÁRIAS CONSULTAS

-- RUIM (três consultas separadas, quando uma única instrução CASE
funcionaria)
SELECT COUNT(*)
FROM products
WHERE price < 13;
 COUNT(*)
------------------
 2
SELECT COUNT(*)
FROM products
WHERE price BETWEEN 13 AND 15;
 COUNT(*)
----------
 5

-- RUIM (usa HAVING em vez de WHERE)
SELECT product_type_id, AVG(price)
FROM products
GROUP BY product_type_id
HAVING product_type_id IN (1, 2);
CAPÍTULO 16 AJUSTE DE SQL 613
PRODUCT_TYPE_ID AVG(PRICE)
-------------------------
 1 24.975
 2 26.22
