/*
NATURAL JOIN
*/

SELECT * FROM VENTAS.categoria;

SELECT * FROM VENTAS.producto;

SELECT * 
FROM VENTAS.categoria C
NATURAL JOIN VENTAS.producto P;



/*
NATURAL JOIN
*/

SELECT * FROM VENTAS.categoria;

SELECT * FROM VENTAS.producto;

SELECT * 
FROM VENTAS.categoria C
JOIN VENTAS.producto P USING ( IDCAT );



/*
JOIN - ON
*/

SELECT * FROM VENTAS.categoria;

SELECT * FROM VENTAS.producto;

SELECT * 
FROM VENTAS.categoria C
JOIN VENTAS.producto P ON ( C.IDCAT = P.IDCAT );




/*
WHERE FOR JOIN
*/

SELECT * FROM VENTAS.categoria;

SELECT * FROM VENTAS.producto;

SELECT * 
FROM VENTAS.categoria C,  VENTAS.producto P 
WHERE ( C.IDCAT = P.IDCAT );