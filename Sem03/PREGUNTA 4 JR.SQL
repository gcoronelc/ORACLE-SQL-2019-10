Desarrolle una sentencia SELECT que muestre el nombre del departamento y el importe de su planilla. Base de datos RH.
SELECT D.NOMBRE DEPARTAMENTO, SUM(E.SUELDO) PLANILLA FROM RECURSOS.DEPARTAMENTO D
         JOIN RECURSOS.UBICACION U
           ON D.IDUBICACION = U.IDUBICACION
         JOIN RECURSOS.EMPLEADO E
           ON E.IDDEPARTAMENTO = D.IDDEPARTAMENTO
           GROUP BY D.NOMBRE, E.SUELDO;