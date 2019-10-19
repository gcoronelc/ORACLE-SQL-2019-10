/*
Ejemplo 1
Consultar los empleados que ingresaron a  trabajar  el primer trimestre del año 2003. 
Esquema SCOTT y HR.
*/

select * 
from recursos.empleado
where extract( month from fecingreso ) in (1,2,3)
and extract(year from fecingreso) = 2003;

/*
Ejemplo 3
Desarrolle una sentencia SELECT para consultar los cursos que no tienen alumnos 
matriculados. Esquema EDUCA. 
Por Jhen Crisoles
*/
Select *
From EDUCA.CURSO
Where CUR_MATRICULADOS=0;

/*
Ejemplo 4
Desarrollar una sentencia SELECT para consultar los productos que 
su precio sea mayor a 500 Soles. Esquema VENTAS. 
*/

select * 
from ventas.producto
where precio > 500;

/*
Ejemplo 5
Desarrollar una sentencia SELECT para consultar los empleados que su salario en 
mayor a 3000.00. Esquema HR. 
Por Paucar.
*/
SELECT *
FROM RECURSOS.EMPLEADO
WHERE SUELDO > 3000;



