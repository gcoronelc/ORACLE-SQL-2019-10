/*
Ejemplo 2
Desarrollar una sentencia SELECT para consultar los empleados de contabilidad 
cuyo sueldo e mayor a 10,000.00. Esquema HR. 
*/

-- Paso 1
select * from recursos.departamento;
-- Código de contabilidad: 101

-- Paso 2
select * from recursos.empleado
where iddepartamento = 101
and   sueldo > 10000;


/*
Ejemplo 3
Desarrollar una sentencia SELECT para obtener un listado 
de los empleados que su nombre tiene en la segunda 
posición la letra "A" o la letra "O". Esquemas SCOTT y HR.
*/

select * 
from recursos.empleado
where nombre like '_a%'
or    nombre like '_o%';

select * 
from recursos.empleado
where upper(substr(nombre,2,1)) in ('A', 'O');


/* Ejemplo 4
Desarrollar una sentencia SELECT para obtener un listado de los productos de la 
categoría "LINEA BLANCA" y que su precio sea mayor a 1000.00. Esquema 
VENTAS.
Por: Jhenifer
*/

-- Código de Linea Blanca= 501

Select * 
From ventas.producto
Where IDCAT = 501 and PRECIO >1000;


-- BETWEEN
-- Sintaxis: COLUMNA [NOT] BETWEEN VALOR1 AND VALOR2


SELECT * 
FROM RECURSOS.EMPLEADO
WHERE NOMBRE BETWEEN 'C' AND 'L'
ORDER BY 3;

SELECT * 
FROM RECURSOS.EMPLEADO
WHERE SUBSTR(NOMBRE,1,1) BETWEEN 'C' AND 'L'
ORDER BY 3;

SELECT *
FROM EUREKA.MOVIMIENTO
WHERE DTT_MOVIFECHA BETWEEN TO_DATE('11/01/2008','DD/MM/YYYY') 
                    AND     TO_DATE('20/01/2008 23:59:59','DD/MM/YYYY HH24:MI:SS') 
ORDER BY DTT_MOVIFECHA;


/*
Ejemplo 8
Desarrollar una sentencia SELECT que permita consultar los empleados que su 
nombre finaliza con la letra "O". Esquema HR.
Por: Rojas
*/

-- ESQUEMA RECURSOS
SELECT * FROM RECURSOS.EMPLEADO
WHERE NOMBRE LIKE '%o';

SELECT * FROM RECURSOS.EMPLEADO
WHERE substr(NOMBRE,-1) = 'o';


-- ESQUEMA SCOTT
SELECT * FROM SCOTT.EMP
WHERE ENAME LIKE '%N';



/*
Ejemplo 12
Consultar los empleados del departamento de ventas que no tienen comisión. 
Esquemas SCOTT y HR. 
Por: Rojas Y Osorio
*/

-- ESQUEMA RECURSOS
SELECT * FROM RECURSOS.EMPLEADO
WHERE COMISION IS NULL;

-- ESQUEMA SCOTT
SELECT * FROM SCOTT.EMP
WHERE COMM IS NULL
OR COMM = 0;


-- Los valores NULL son un dolor de cabeza.
-- Aprende a tratarlos como debe ser.

select e.*, sal + nvl(comm,0) "total"
from scott.emp e;

select nvl2(10,20,30) valor from dual;



/* 
Ejemplo 17
Desarrollar una sentencia SELECT para consultar los empleados cuyos ingresos 
totales es menor a 8,000.00. Esquema HR. 
*/





/*
Ejemplo 8
Consultar los empleados cuyo ingreso (salario + comisión) supera los 3500.00. 
Esquema SCOTT y HR. 
*/








