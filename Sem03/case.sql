-- FUNCION CASE

/*
Ejemplo
Se necesita saber el saldo en dolares y soles por sucursal.

----------------------------------------------------
CODIGO   NOMBRE      SOLES        DOLARES
----------------------------------------------------
001      AAAAA       456.78       5467.87
002      BBBBB       456.78       5467.87
003      CCCCC       456.78       5467.87
----------------------------------------------------
*/


SELECT 
    s.chr_sucucodigo "CODIGO", 
    s.vch_sucunombre "NOMBRE",
    SUM(CASE C.CHR_MONECODIGO WHEN '01' THEN  c.dec_cuensaldo ELSE 0 END) "SALDO SOLES",
    SUM(CASE C.CHR_MONECODIGO WHEN '02' THEN  c.dec_cuensaldo ELSE 0 END) "SALDO DOLARES"
FROM EUREKA.sucursal S 
JOIN EUREKA.cuenta C ON s.chr_sucucodigo = c.chr_sucucodigo
GROUP BY s.chr_sucucodigo, s.vch_sucunombre;



SELECT 
    s.chr_sucucodigo "CODIGO", 
    s.vch_sucunombre "NOMBRE",
    ROUND(SUM(c.dec_cuensaldo / CASE C.CHR_MONECODIGO WHEN '01' THEN 3.3 ELSE 1 END),2) "SALDO TOTAL EN DOLARES"
FROM EUREKA.sucursal S 
JOIN EUREKA.cuenta C ON s.chr_sucucodigo = c.chr_sucucodigo
GROUP BY s.chr_sucucodigo, s.vch_sucunombre;






