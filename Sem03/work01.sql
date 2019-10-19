/*
Ejercicio 1
Desarrolle una sentencia SELECT para obtener un listado que incluya el nombre del 
curso con sus respectivos nombres de alumnos. Base de datos EDUCA. 
*/

select c.cur_nombre, a.alu_nombre
from EDUCA.curso c
join EDUCA.matricula m on c.cur_id = m.cur_id 
join EDUCA.alumno a on m.alu_id = a.alu_id
order by 1;


/*
Ejercicio 2
Desarrolle una sentencia SELECT que muestre el nombre del alumno y la suma de 
todos sus pagos. Base de datos EDUCA. 
*/


select a.alu_nombre, sum(p.pag_importe) pagos
from educa.alumno a
join educa.pago p on a.alu_id = p.alu_id
group by a.alu_nombre
order by 1;



/*
Ejercicio 4
Desarrolle una sentencia SELECT que muestre el nombre del departamento y el 
importe de su planilla. Base de datos RH. 
*/




/*
Ejercicio 5
Desarrolle una sentencia SELECT para encontrar la cantidad de trabajadores en cada 
ciudad. Base de datos RH. 
*/
-- Rpta de JR
SELECT  U.CIUDAD, COUNT(1) EMPLEADOS
FROM RECURSOS.DEPARTAMENTO D
JOIN RECURSOS.UBICACION U ON D.IDUBICACION = U.IDUBICACION
JOIN RECURSOS.EMPLEADO E ON E.IDDEPARTAMENTO = D.IDDEPARTAMENTO
GROUP BY U.CIUDAD;




/*
Ejercicio 6
Desarrolle una sentencia SELECT para obtener un listado de todos los departamentos 
y la cantidad de trabajadores en cada uno de ellos. Base de datos RH. 
*/

select d.nombre, count(e.idempleado) empleados
from RECURSOS.departamento d
left join RECURSOS.empleado e on d.iddepartamento = e.iddepartamento
group by d.nombre;


-- Sintaxis ORACLE
select d.nombre, count(e.idempleado) empleados
from RECURSOS.departamento d, RECURSOS.empleado e 
where d.iddepartamento = e.iddepartamento (+)
group by d.nombre;




/*
Ejercicio 7
Desarrolle una sentencia SELECT para encontrar la cantidad de alumnos matriculados 
en cada curso, debe incluir en el listado todos los cursos. Base de datos EDUCA. 
*/


/*
Ejercicio 10
Desarrolle una sentencia SELECT para obtener un listado de los empleados con el 
respectivo nombre de su superior inmediato. Base de datos RH. 
*/

select * from recursos.empleado;

select 
    emp.idempleado, emp.nombre, emp.apellido, 
    jefe.nombre || ', ' || jefe.apellido "JEFE"
from RECURSOS.empleado emp
join recursos.empleado jefe on emp.jefe = jefe.idempleado;

