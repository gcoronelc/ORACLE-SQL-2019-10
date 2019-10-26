-- CASO: EMPRESA GLOBAL
-- Con operaciones en varias regiones del mundo.


----------------------------------
-- 1. CREACION DE TBS
----------------------------------

CREATE TABLESPACE TBSX_ASIA
DATAFILE 'I:\APP\TBS\XDF_COMPROBANTES_ASIA.DBF'
SIZE 10M;

CREATE TABLESPACE TBSX_EUROPA
DATAFILE 'I:\APP\TBS\XDF_COMPROBANTES_EUROPA.DBF'
SIZE 10M;

CREATE TABLESPACE TBSX_AL
DATAFILE 'I:\APP\TBS\XDF_COMPROBANTES_AL.DBF'
SIZE 10M;
  
CREATE TABLESPACE TBSX_OTROS
DATAFILE 'I:\APP\TBS\XDF_COMPROBANTES_OTROS.DBF'
SIZE 10M;


-- Tablespaces
SELECT TABLESPACE_NAME "TABLESPACE"	
FROM DBA_TABLESPACES 
WHERE TABLESPACE_NAME LIKE 'TBSX%'
ORDER BY 1;


-- Espacio Total en MB
SELECT 
	tablespace_name,
	round(sum(BYTES/1024/1024),0) ESPACIO_MB
FROM dba_data_files b
WHERE b.TABLESPACE_NAME LIKE 'TBSX%'
GROUP BY b.tablespace_name
ORDER BY 1;


-- Espacio libre en MB
SELECT 
	tablespace_name,
	ROUND(sum(BYTES/1024/1024),0) ESPACIO
FROM dba_free_space
WHERE TABLESPACE_NAME LIKE 'TBSX%'
GROUP BY tablespace_name
ORDER BY 1;



----------------------------------
-- 2. TABLA PARTICIONADA POR LISTA
----------------------------------

CREATE TABLE SCOTT.Ventas(
	ID NUMBER(10),
	ORIGEN VARCHAR2(20),
	FECHA DATE default sysdate 
)
PARTITION BY LIST( ORIGEN)
(
	PARTITION ventas_ASIA  VALUES('ASIA')     tablespace TBSX_ASIA,
	PARTITION ventas_EUROPA VALUES ('EUROPA') tablespace TBSX_EUROPA,
	PARTITION ventas_AL     VALUES ('AL')     tablespace TBSX_AL,
	PARTITION ventas_otros  VALUES(DEFAULT)   tablespace TBSX_OTROS 
);


-------------------------------------------------
-- 3 INSERTANDO DATOS EN TABLAS PARTICIONADAS
-------------------------------------------------

-- Espacio libre en MB
SELECT 
  tablespace_name,
  ROUND(sum(BYTES/1024/1024),0) ESPACIO
FROM dba_free_space
WHERE TABLESPACE_NAME LIKE 'TBSX%'
GROUP BY tablespace_name
ORDER BY 1;

-- Ventas de ASIA
INSERT INTO SCOTT.VENTAS
SELECT LEVEL, 'ASIA', SYSDATE
FROM DUAL CONNECT BY LEVEL <= 100000;

-- Ventas de EUROPA
INSERT INTO SCOTT.VENTAS
SELECT LEVEL, 'EUROPA', SYSDATE
FROM DUAL CONNECT BY LEVEL <= 100000;

COMMIT;

-------------------------------------------------
-- 4 QUERY DE TABLAS PARTICIONADAS
-------------------------------------------------

SELECT COUNT(*) FROM SCOTT.VENTAS;

SELECT COUNT(*) FROM SCOTT.VENTAS PARTITION ( ventas_ASIA );
 
SELECT COUNT(*) FROM SCOTT.VENTAS PARTITION (ventas_EUROPA);


----------------------------------
-- 5 CONSULTANDO TABLAS PARTICIONADAS
----------------------------------
SELECT TABLE_NAME, PARTITION_NAME, HIGH_VALUE
FROM DBA_TAB_PARTITIONS
WHERE TABLE_OWNER = 'SCOTT'
AND   TABLE_NAME = 'VENTAS' ;



----------------------------------
-- 6 COMPARANDO PLANES DE EJECUCION 
--   ENTRE TABLA PARTICIONADA Y REGULAR
----------------------------------

CREATE TABLE SCOTT.VENTASREGULAR(
	ID NUMBER(10),
	ORIGEN VARCHAR2(20),
	FECHA DATE default sysdate 
);

INSERT INTO SCOTT.VENTASREGULAR
SELECT LEVEL, 'ASIA', SYSDATE
FROM DUAL CONNECT BY LEVEL <= 100000;
 
INSERT INTO SCOTT.VENTASREGULAR
SELECT LEVEL, 'EUROPA', SYSDATE
FROM DUAL CONNECT BY LEVEL <= 100000;

COMMIT;



---- PLAN DE EJECUCION TABLA REGULAR
EXPLAIN PLAN 
FOR
SELECT * FROM SCOTT.VENTASREGULAR
WHERE ORIGEN = 'ASIA';

SELECT * FROM TABLE( DBMS_XPLAN.DISPLAY );
/*
Plan hash value: 2646100163
 
-----------------------------------------------------------------------------------
| Id  | Operation         | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |               | 97941 |  3251K|   206   (1)| 00:00:03 |
|*  1 |  TABLE ACCESS FULL| VENTASREGULAR | 97941 |  3251K|   206   (1)| 00:00:03 |
-----------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("ORIGEN"='ASIA')
 
Note
-----
   - dynamic sampling used for this statement
*/

---- PLAN DE EJECUCION TABLA PARTICIONADA


EXPLAIN PLAN 
FOR
SELECT * FROM SCOTT.VENTAS PARTITION ( VENTAS_ASIA )
WHERE ORIGEN = 'ASIA';

SELECT * FROM TABLE( DBMS_XPLAN.DISPLAY )

/*
Plan hash value: 4163961895
 
------------------------------------------------------------------------------------------------
| Id  | Operation             | Name   | Rows  | Bytes | Cost (%CPU)| Time     | Pstart| Pstop |
------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT      |        |   115K|  3823K|   103   (1)| 00:00:02 |       |       |
|   1 |  PARTITION LIST SINGLE|        |   115K|  3823K|   103   (1)| 00:00:02 |   KEY |   KEY |
|*  2 |   TABLE ACCESS FULL   | VENTAS |   115K|  3823K|   103   (1)| 00:00:02 |     1 |     1 |
------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - filter("ORIGEN"='ASIA')
 
Note
-----
   - dynamic sampling used for this statement
*/   

SELECT COUNT(*) FROM SCOTT.VENTAS;  

SELECT COUNT(*) FROM SCOTT.VENTASREGULAR; 


SELECT * FROM SCOTT.VENTAS;
