-------------------------------------------------------
--PREGUNTAS Examen
--ALUMNO: Osorio Urrunaga
--PROFESOR: Ing. Eric Gustavo Coronel Castillo
-------------------------------------------------------

--------------------------------------------------
CONSULTAS SIMPLES
--------------------------------------------------

--EJERCICIO 1
/* Desarrollar una sentencia SELECT para consultar los productos cuyo precio 
de venta sea mayor a 225 Soles.*/

SELECT *
FROM TOPITOP.PRODUCTOS
WHERE PRECIOVENTA > 225;

--EJERCICIO 2
/* Desarrollar una sentencia SELECT para obtener un listado de los productos de la
línea "ROPA DE DAMAS" y de precio mayor a 200.00 soles*/

--Paso 1
SELECT *
FROM TOPITOP.LINEAS;

--idlinea = 4

--Paso 2
SELECT *
FROM TOPITOP.PRODUCTOS
WHERE PRECIOVENTA > 200 AND IDLINEA = 4 ;

--EJERCICIO 3
/* Desarrollar una sentencia SELECT para obtener un listado de los clientes cuyos
 nombres contengan una  letra "A" o la letra "I"*/

SELECT *
FROM TOPITOP.CLIENTES
WHERE UPPER(NOMBRE) LIKE '%A%' OR UPPER(NOMBRE) LIKE '%I%';

--EJERCICIO 4
/* Desarrollar una sentencia SELECT que permita consultar los empleados cuya
penúltima letra de su nombre es L */

SELECT *
FROM TOPITOP.EMPLEADOS
WHERE UPPER(NOMBRE) = '%L_';

--EJERCICIO 5
/*Desarrollar una sentencia SELECT que permita consultar el precio de venta 
promedio*/

SELECT  AVG(PRECIOVENTA) "PRECIO PROMEDIO PRODUCTOS"
FROM TOPITOP.PRODUCTOS; 

--EJERCICIO 6
/*Desarrollar una sentencia SELECT que permita consultar la ganancia neta,
si se vendiera todo el stock*/

SELECT SUM((PRECIOVENTA - PRECIOCOMPRA)*STOCK) "GANANCIA NETA"
FROM TOPITOP.PRODUCTOS;

--EJERCICIO 7
/*Desarrollar una sentencia SELECT para consultar las ventas realizadas 
en el mes de octubre*/

SELECT *
FROM TOPITOP.VENTAS
WHERE EXTRACT(MONTH FROM FECHA) IN 10;


--EJERCICIO 8
/*Desarrollar una sentencia SELECT para consultar los clientes que vivan en
 Lince*/

SELECT *
FROM TOPITOP.CLIENTES
WHERE UPPER(DIRECCION) LIKE '%LINCE%';


--EJERCICIO 9
/*Desarrollar una sentencia SELECT que permita consultar la venta total en 
octubre/*
 
SELECT SUM(TOTAL) "VENTA TOTAL"
FROM TOPITOP.VENTAS
WHERE EXTRACT(MONTH FROM FECHA) IN 10;


--EJERCICIO 10
/*Desarrollar una sentencia SELECT que permita consultar 
los productos mas baratos/*

SELECT MIN(PRECIOVENTA) "MENOR PRECIO"
FROM TOPITOP.PRODUCTOS;


--------------------------------------------------
CONSULTAS COMPLEJAS
--------------------------------------------------

--EJERCICIO 11
/* Desarrolle una sentencia SELECT para obtener un listado que incluya el nombre de
las líneas con sus respectivos productos. */

SELECT l.nombre LINEA, p.descripcion PRODUCTO
FROM topitop.lineas l 
JOIN topitop.productos p ON l.idlinea = p.idlinea;


--EJERCICIO 12
/* Desarrolle una sentencia SELECT que muestre el nombre de la línea y el precio de
venta de todos sus productos.*/

SELECT l.nombre LINEA, SUM(p.precioventa)
FROM topitop.lineas l 
JOIN topitop.productos p ON l.idlinea = p.idlinea
GROUP BY l.nombre
ORDER BY 1;


--EJERCICIO 13
/* Desarrolle una sentencia SELECT que muestre una lista de los productos que más se
 venden, ordenados del más vendido al menos vendido.*/

 SELECT p.descripcion PRODUCTO, SUM(d.cantidad) "VENDIDOS"
 FROM topitop.productos p
 JOIN topitop.detalleventa d ON p.idproducto = d.idproducto
 GROUP BY p.descripcion
 ORDER BY SUM(d.cantidad) DESC;


--EJERCICIO 14
/* Desarrolle una sentencia SELECT para obtener el total de ventas por cada línea.
Evite mostrar resultados NULL*/

SELECT l.nombre LINEA, NVL(SUM(d.importe),0) TOTAL
FROM topitop.lineas l
LEFT JOIN topitop.productos p ON l.idlinea = p.idlinea
LEFT JOIN topitop.detalleventa d ON p.idproducto = d.idproducto
GROUP BY l.nombre;


--EJERCICIO 15
/*Buscar al n-ésimo de la tabla PRODUCTOS cuyos nombres ordenados (asc)comienzan 
con cierta(s) letra(s). Por ejemplo buscaremos al quinto de la lista (n=5)
de los productos que tengan una "a" intermedia */

SELECT idproducto, descripcion, idlinea, preciocompra, precioventa, stock 
FROM(SELECT ROWNUM RN, idproducto, descripcion, idlinea, preciocompra, precioventa,
STOCK FROM (SELECT * FROM topitop.productos WHERE UPPER(descripcion) LIKE  UPPER('%a%') 
ORDER BY descripcion)) WHERE RN=5;


--EJERCICIO 16
/*Desarrolle una consulta para averiguar cuales son los productos con el menor 
precio de compra.*/

SELECT p.*
FROM topitop.productos p
WHERE preciocompra = (SELECT MIN(preciocompra) 
FROM topitop.productos);


--EJERCICIO 17
/* Desarrolle una consulta que muestre las siguientes columnas:
- Código del producto
- Nombre del producto
- Precio de venta del producto
- precio de venta promedio 
- Diferencia del precio de venta del producto y el precio venta promedio */

WITH 
V1 AS (SELECT AVG(precioventa) precio_promedio FROM topitop.productos)
SELECT 
    p.idproducto,
    p.descripcion,
    p.precioventa,
    ROUND(V1.precio_promedio,2) "PRECIO PROMEDIO",
    ROUND(p.precioventa - V1.precio_promedio,2) "DIFERENCIA"
FROM topitop.productos p CROSS JOIN V1
ORDER BY 3 DESC;


--EJERCICIO 18
/* Realice una consulta que califique una venta  según 
el siguiente cuadro:

[ 0, 100> Mala
[100, 600> Regular
[600, 900> Buena
[900, ?>  Excelente

*/

SELECT
  idventa,
  total,
  CASE
    WHEN total >= 0 AND total  < 100
        THEN 'Mala'
    WHEN total >= 100 AND total < 600
        THEN 'Regular'
    WHEN total >= 600 AND total < 900
        THEN 'Buena'
    ELSE 
        'Excelente'
  END CALIFICACION
FROM
  topitop.ventas
ORDER BY
  idventa;


--EJERCICIO 19
/*Realice una consulta que muestre la cantidad ventas de cada empleado, asi como
el total de ventas realizado*/

 
SELECT e.nombre, COUNT(v.idventa) "NUMERO DE VENTAS", SUM(v.total) TOTAL
FROM topitop.empleados e
LEFT JOIN topitop.ventas v ON e.idempleado = v.idempleado
GROUP BY e.nombre
ORDER BY "NUMERO DE VENTAS" DESC;


--EJERCICIO 20
/*En la tabla productos realice lo siguiente:

(a)Ingrese el siguiente producto
Código: A0025
Descripción: Zapatillas Nike Pegasus 35 - Tallas 40 - 45
Línea: 2
Precio de compra: 320.00
Precio de venta:  450.00
Stock: 18

(b)Actualice el precio de venta
Precio de venta: 480.00

(c)Elimine el producto*/

INSERT INTO topitop.productos
VALUES('A0025', 'Zapatillas Nike Pegasus 35 - Tallas 40 - 45', 2, 320, 450, 18 );

UPDATE topitop.productos
SET precioventa = 480 WHERE idproducto = 'A0025';

DELETE FROM topitop.productos
WHERE idproducto = 'A0025';