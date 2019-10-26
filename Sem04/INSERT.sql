-- Ejemplo 1

insert into scott.emp
values( 8888, 'Gustavo', 5467 );

/*
Error que empieza en la línea: 3 del comando -
insert into scott.emp
values( 8888, 'Gustavo', 5467 )
Error en la línea de comandos : 3 Columna : 19
Informe de error -
Error SQL: ORA-00947: no hay suficientes valores
00947. 00000 -  "not enough values"
*Cause:    
*Action:
*/


-- Solución

insert into scott.emp(empno, ename, sal)
values( 8888, 'Gustavo', 5467 );

COMMIT;

/*
1 fila insertadas.
*/


-- Ejemplo 2

ALTER TABLE SCOTT.EMP  
MODIFY (SAL NOT NULL);

insert into scott.emp(empno, ename)
values( 8889, 'Gustavo 2' );

/*
Error que empieza en la línea: 36 del comando :
insert into scott.emp(empno, ename)
values( 8889, 'Gustavo 2' )
Informe de error -
ORA-01400: no se puede realizar una inserción NULL en ("SCOTT"."EMP"."SAL")
*/

-- Solución 1
-- Agregar la columna salario en el INSERT

-- Solución 2
-- Agregar un valor por defecto a la columna salario

ALTER TABLE SCOTT.EMP  
MODIFY (SAL DEFAULT 0 );

insert into scott.emp(empno, ename)
values( 8889, 'Gustavo 2' );

COMMIT;

/*
Table SCOTT.EMP alterado.

1 fila insertadas.
*/

SELECT EMPNO, ENAME, SAL FROM SCOTT.EMP;


/*

     EMPNO ENAME             SAL
---------- ---------- ----------
      . . . . . . 
      7934 MILLER           1300
      8888 Gustavo          5467
      8889 Gustavo 2           0

16 filas seleccionadas.
*/

-- INSERTAR DATOS EN UNA TABLA, DESDE OTRA TABLA

SELECT * FROM RECURSOS.EMPLEADO;

INSERT INTO SCOTT.EMP(EMPNO,ENAME,SAL)
SELECT 
    TO_NUMBER(SUBSTR(IDEMPLEADO,-4),'9999') ID,
    NOMBRE, SUELDO
FROM RECURSOS.EMPLEADO;

SELECT * FROM SCOTT.EMP;

COMMIT;


-- Crear una tabla con una sentencia SELECT

create table scott.emp2
as (
    SELECT 
        TO_NUMBER(SUBSTR(IDEMPLEADO,-4),'9999') ID,
        NOMBRE, SUELDO
    FROM RECURSOS.EMPLEADO
);

/*
Table SCOTT.EMP2 creado.
*/

select * from scott.emp2;
commit;

/*
        ID NOMBRE                   SUELDO
---------- -------------------- ----------
         1 Gustavo                   25000
         2 Claudia                    8000
         3 Sergio                    15000
         4 Mariela                    1800
         5 Roberto                    7000
         6 Miguel                     7500
         7 Vanessa                    7000
         8 Julio                      3500
         9 Ricardo                   15000
        10 Guisella                   8000
        11 Lucy                       2000
        12 Hugo                      15000
        13 Fortunato                  6000
        14 Octavio                    3000
        15 Cesar                      2500
        16 Nora                      15000
        17 Alejandra                  7500
        18 Jennifer                   2000
        19 Omar                       3500
        20 Victor                     3000
        21 Ronald                     3000
        22 Luis                       3000

22 filas seleccionadas. 
*/




