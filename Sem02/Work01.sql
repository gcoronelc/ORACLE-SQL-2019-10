/*
Ejemplo 01
Desarrolle una sentencia SELECT para consultar el id, nombre, apellido y email de 
todos los empleados. Esquema RECURSOS. 
*/

select IDEMPLEADO, NOMBRE, APELLIDO, EMAIL 
from RECURSOS.EMPLEADO;

select  IDEMPLEADO, NOMBRE || ', ' || APELLIDO "NOMBRE TOTAL", EMAIL 
from RECURSOS.EMPLEADO;

/*
Ejemplo 02
Desarrolle una sentencia SELECT para consultar el id, nombre, dirección y email 
de todos los alumnos. Esquema EDUCA.
Sol. Jhenifer Crisoles
*/
Select ALU_ID, ALU_NOMBRE, ALU_DIRECCION, ALU_EMAIL
From EDUCA.ALUMNO;



/*
Ejemplo 03
Desarrolle una sentencia SELECT para consultar el id, nombre, precio y profesor 
de cada curso. Esquema EDUCA. 
Sol. Jaime Rojas
*/
SELECT CUR_ID, CUR_NOMBRE, CUR_PRECIO, CUR_PROFESOR
FROM EDUCA.CURSO;


/*
Ejemplo 06
Desarrollar una sentencia SELECT que permita obtener la cantidad y porcentaje de 
matriculados por cada curso. Esquema EDUCA. 
Sol. Yo
*/
select 
    cur_id, cur_nombre, cur_vacantes, cur_matriculados,
    round(cur_matriculados / cur_vacantes * 100,2) "porc_mat"
from educa.curso;


/*
Ejemplo 9
Desarrolle una sentencia SELECT que permita obtener el importe que se obtendría 
por cada producto si se venden todas las unidades que hay en stock. Esquema VENTAS.
Sol. Yo
*/

select idprod, nombre, precio, stock, precio * stock "importe chevere"
from ventas.producto;


/*
Ejemplo 10
Desarrollar una sentencia SELECT que permita consultar el salario, y el salario 
proyectado con un aumento del 15% de cada empleado. Esquema HR. 
Sol. 
*/

SELECT 
    IDEMPLEADO, NOMBRE || ', ' || APELLIDO "NOMBRE TOTAL",
    SUELDO, SUELDO * 1.15 "SUELDO PROYECTADO"
FROM RECURSOS.EMPLEADO;



