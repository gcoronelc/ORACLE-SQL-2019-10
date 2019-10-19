/*
Ejercicio 11
Desarrolle una consulta para averiguar quiénes son los empleados que tienen el menor 
sueldo. Base de datos RH. 
*/

select *
from recursos.empleado e;


-- Sol 1
select e.*, (select min(sueldo) from recursos.empleado) "sueldo menor"
from recursos.empleado e
where sueldo = (select min(sueldo) from recursos.empleado);


-- Sol 2
select e.*, t.sueldo_menor
from recursos.empleado e
join (select min(sueldo) sueldo_menor from recursos.empleado) t 
on e.sueldo = t.sueldo_menor;

-- Sol 3

WITH 
V1 AS (select min(sueldo) sueldo_menor from recursos.empleado)
select e.*, t.sueldo_menor
from recursos.empleado e
join V1 t 
on e.sueldo = t.sueldo_menor;


/*
Ejercicio 12
Desarrolle una consulta que muestre las siguientes columnas:   
 - Código del empleado   
 - Nombre del empleado   
 - Sueldo del empleado   
 - Sueldo promedio en la empresa   
 - Diferencia del sueldo del empleado y el sueldo promedio 
*/


WITH 
V1 AS (SELECT AVG(SUELDO) SUELDO_PROMEDIO FROM RECURSOS.EMPLEADO)
SELECT 
    E.IDEMPLEADO,
    E.NOMBRE,
    E.SUELDO,
    ROUND(V1.SUELDO_PROMEDIO,2) "SUELDO PROMEDIO",
    ROUND(E.SUELDO - V1.SUELDO_PROMEDIO,2) "DIFERENCIA"
FROM RECURSOS.empleado E CROSS JOIN V1
ORDER BY 3 DESC;


