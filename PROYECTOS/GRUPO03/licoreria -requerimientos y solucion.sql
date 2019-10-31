/************************************************************
Proponer 10 requerimientos de información (consultas) simples 
con su respectiva solución.
*************************************************************
*/

/*
EJERCICIO 1: Muestra el codigo postal de las tiendas de Lima.
*/
select codigo_postal 
  from licoreria.tienda
  where departamento = 'Lima';
/*
EJERCICIO 2: Numero de clientes, nombre, telefono del depratamento de Cusco.
*/
select nombre_cliente, telefono
  from Licoreria.cliente
  where departamento = 'Cusco';
  
/*
EJERCICIO 3: Obtener un listado de los clientes  que su nombre (razon social) empiece con la letra J o A.
*/  
select nombre_cliente
  from Licoreria.cliente
  where nombre_cliente like 'J%'
  or nombre_cliente like 'A%';
/*
EJERCICIO 4: Saber el codigo de cliente y la fecha de pedido de los 3 primeros meses del año 2018.
*/
select codigo_cliente, fecha_pedido
  from licoreria.pedido
  where extract( month from fecha_pedido ) in (1,2,3)
  and extract( year from fecha_pedido ) = 2018;

/*
EJERCICIO 5: Saber el precio de venta maximo, precio de venta minimo por categorias de los licores.
*/
select categoria, max(precio_venta), min(precio_venta)
  from licoreria.producto
  group by categoria;
/*
EJERCICIO 6: saber el precio de venta, el precio de proveedor y la ganancia en la venta de Pisco por marca.
*/
select categoria, marca, precio_venta, precio_proveedor, (precio_venta - precio_proveedor)"GANANCIA"
  from licoreria.producto
  where categoria = 'Pisco';

/*
EJERCICIO 7: Obtener en una columna el nombre y apellido de contacto de clientes del distrito empiece con la letra C.
*/
select nombre_cliente , nombre_contacto|| ', ' ||apellido_contacto"Personal de contacto", departamento
  from licoreria.cliente
  where departamento like 'C%';

/*
EJERCICIO 8: Consultar el codigo de producto, categoria, marca donde el precio sea mayor 60 soles.
*/
select codigo_producto, categoria, marca, precio_venta 
  from licoreria.producto
  where precio_venta > 60;

/*
EJERCICIO 9: Consultar la categoria,el numero de productos y el precio de venta total que posee la licoreria a nivel nacional.
*/
select categoria, count(*) as "Num productos", sum(precio_venta) as "precio de venta total"
from licoreria.producto
group by categoria;

/*
EJERCICIO 10: Consultar la cantidad de clientes por cada departamento.
*/
select departamento, count(*) as "CANTIDAD DE CLIENTES"
from licoreria.cliente
group by departamento;

/************************************************************
Proponer 10 requerimientos de información (consultas) complejas 
con su respectiva solución.
*************************************************************
PD: Las consultas complejas deben ser multitablas, 
con subconsultas, grupos, with, etc.
*/

/*
EJERCICIO 1: Muestra el codigo de pedido, el nombre del cliente, la fecha de pedido, 
la fecha de entrega y el estado  de los pedidos.
*/
select p.codigo_pedido, c.nombre_cliente, p.fecha_esperada, p.fecha_entrega, p.estado
  from pedido p, cliente c
  where p.codigo_cliente = c.codigo_cliente;

/*
  EJERCICIO 2: Saber el codigo de cliente, fecha de entrega en los meses de enero y febrero del 2016. 
*/
select codigo_cliente, fecha_entrega
  from licoreria.pedido
  where extract( month from fecha_pedido ) in (1,2)
  and extract( year from fecha_pedido ) = 2016;

/*
EJERCICIO 3:averiguar que clientes de Lima realizaron el pago.
*/
select nombre_cliente from licoreria.cliente cl
  where exists
  (select * from licoreria.pago pa
    where cl.codigo_cliente = pa.codigo_cliente
    and departamento = 'Lima');

/*
EJERCICIO 4:averiguar el telefono y el nombre de cliente(s) que relizaron pedido en el mes de Marzo del 2018.
*/
select nombre_cliente, telefono from licoreria.cliente cl
  where exists
  (select * from licoreria.pedido pe
    where cl.codigo_cliente = pe.codigo_cliente
    and extract(month from fecha_pedido) in (3)
    and extract(year from fecha_pedido)=2018);

/*
EJERCICIO 5: averiguar las ventas realizadas en el mes de mayo del 2018 ordenado por departamento y codigo de cliente.
*/
select cl.departamento, pa.codigo_cliente, pa.forma_pago, pa.pago_importe
  from pago pa, cliente cl
  where cl.codigo_cliente = pa.codigo_cliente
  order by departamento;

/*
EJERCICIO 6: averiguar los codigos de los clientes que realizaron los pagos en la misma fecha de los pedidos.
*/
select pe.codigo_cliente, pe.fecha_pedido, pa.fecha_pago from pedido pe
  join pago pa on (pe.fecha_pedido = pa.fecha_pago);

/*
EJERCICIO 7: averiguar los codigos de los clientes que realizaron los pedidos y el pago en fechas distintas.
*/
select pe.codigo_cliente, pe.fecha_pedido, pa.fecha_pago from pedido pe
  join pago pa on (pe.fecha_pedido <> pa.fecha_pago);

/*
EJERCICIO 8: Averiguar la direccion y el nombre de cliente(s) que relizaron pedido en el mes de Enero del 2016.
*/
select nombre_cliente, cliente_direccion from licoreria.cliente cl
  where exists
  (select * from licoreria.pedido pe
    where cl.codigo_cliente = pe.codigo_cliente
    and extract(month from fecha_pedido) in (1)
    and extract(year from fecha_pedido)=2016);


/*
EJERCICIO 9:averiguar el nombre y apellido de contacto, el telefono, direccion de los clientes de Cusco que realizaron el pago.
*/
select nombre_cliente, nombre_contacto|| ', ' ||apellido_contacto"Persona de Contacto", telefono, cliente_direccion from licoreria.cliente cl
  where exists
  (select * from licoreria.pago pa
    where cl.codigo_cliente = pa.codigo_cliente
    and provincia = 'Cusco');

/*
EJERCICIO 10: Averiguar el codigo, el nombre de cliente(s) que no relizaron pedido en los meses de Enero y Junio del 2019.
*/
select nombre_cliente, cliente_direccion from licoreria.cliente cl
  where exists
  (select * from licoreria.pedido pe
    where cl.codigo_cliente = pe.codigo_cliente
    and extract(month from fecha_pedido) in (1,6)
    and extract(year from fecha_pedido) = 2019);
    
