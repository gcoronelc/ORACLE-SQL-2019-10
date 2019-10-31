/*
 *
 * DBMS           :  Oracle Database
 * Esquema        :  LICORERIA
 * Descripción    :  Base de Datos de lICORERIA
 * Script         :  Crea la Base de Datos
 * Responsable    :  ROBERTO AYALA CCASA
 * Email          :  robertocarlosacc@hotmail.com
 * Fecha          :  24-OCT-2019
 *
*/


-- =============================================
-- CREACIÓN DEL USUARIO
-- =============================================
DECLARE
	N INT;
	COMMAND VARCHAR2(200);
BEGIN
	COMMAND := 'DROP USER licoreria CASCADE';
	SELECT COUNT(*) INTO N
	FROM DBA_USERS
	WHERE USERNAME = 'licoreria';
	IF ( N = 1 ) THEN
		EXECUTE IMMEDIATE COMMAND;
	END IF;
END;
/


CREATE USER EDUCA IDENTIFIED BY admin;
GRANT CONNECT, RESOURCE TO licoreria;

ALTER USER licoreria
QUOTA UNLIMITED ON USERS;

GRANT CREATE VIEW TO licoreria;
-- =============================================
-- CONECTARSE A LA APLICACIÓN
-- =============================================
CONNECT licoreria/admin

--      CREACIÓN DE LOS OBJETOS DE LA BASE DE DATOS
-- ======================================================
-- TABLA1 TIENDAS
-- ======================================================
CREATE TABLE tienda (
  codigo_tienda VARCHAR(10) NOT NULL,
  distrito VARCHAR(30) NOT NULL,
  provincia VARCHAR(50) NOT NULL,
  departamento VARCHAR(50) NOT NULL,
  codigo_postal VARCHAR(10) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  tienda_direccion VARCHAR(50) NOT NULL,
  PRIMARY KEY (codigo_tienda)
);
-- ======================================================
-- TABLA2 EMPLEADO 
-- ======================================================
CREATE TABLE empleado (
  codigo_empleado CHAR(10) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  codigo_tienda VARCHAR(10) NOT NULL,
  puesto VARCHAR(50) NOT NULL,
  PRIMARY KEY (codigo_empleado),
  FOREIGN KEY (codigo_tienda) REFERENCES tienda (codigo_tienda)
);

-- ======================================================
-- TABLA3 CLIENTE 
-- ======================================================
CREATE TABLE cliente (
  codigo_cliente VARCHAR(10) NOT NULL,
  nombre_cliente VARCHAR(50) NOT NULL,
  nombre_contacto VARCHAR(30) NOT NULL,
  apellido_contacto VARCHAR(30) NOT NULL,
  telefono VARCHAR(15) NOT NULL,
  cliente_direccion VARCHAR(50) NOT NULL,
  distrito VARCHAR(50) NOT NULL,
  provincia VARCHAR(50) NOT NULL,
  departamento VARCHAR(50) NOT NULL,
  PRIMARY KEY (codigo_cliente)
);

-- ======================================================
-- TABLA4 PRODUCTO 
-- ======================================================
CREATE TABLE producto (
  codigo_producto VARCHAR(15) NOT NULL,
  categoria VARCHAR(50) NOT NULL,
  marca VARCHAR(50) NOT NULL,
  proveedor VARCHAR(50) NOT NULL,
  cantidad_stock SMALLINT NOT NULL,
  precio_venta decimal(10,2) NOT NULL,
  precio_proveedor decimal(10,2) NOT NULL,
  PRIMARY KEY (codigo_producto)
);

-- ======================================================
-- TABLA5 PEDIDO 
-- ======================================================
CREATE TABLE pedido (
  codigo_pedido VARCHAR(10) NOT NULL,
  fecha_pedido DATE NOT NULL,
  fecha_esperada DATE NOT NULL,
  fecha_entrega DATE NOT NULL,
  estado VARCHAR(15) NOT NULL,
  codigo_cliente VARCHAR(10) NOT NULL,
  PRIMARY KEY (codigo_pedido)
);

-- ======================================================
-- TABLA6 DETALLE PEDIDO
-- ======================================================
CREATE TABLE detalle_pedido (
  codigo_pedido VARCHAR(10) NOT NULL,
  codigo_producto VARCHAR(15) NOT NULL,
  cantidad VARCHAR(10) NOT NULL,
  precio_unidad DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (codigo_pedido, codigo_producto),
  FOREIGN KEY (codigo_pedido) REFERENCES pedido (codigo_pedido),
  FOREIGN KEY (codigo_producto) REFERENCES producto (codigo_producto)
);

-- ======================================================
-- TABLA7 PAGO
-- ======================================================
CREATE TABLE pago (
  codigo_cliente VARCHAR(10) NOT NULL,
  forma_pago VARCHAR(40) NOT NULL,
  id_transaccion VARCHAR(50) NOT NULL,
  fecha_pago date NOT NULL,
  pago_importe DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (codigo_cliente, id_transaccion),
  FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo_cliente)
);


-- ==========================================================
-- Cargar datos a la tabla: TIENDA
-- ==========================================================
--INSERT INTO tienda (CODIGO_TIENDA,DISTRITO,PROVINCIA,DEPARTAMENTO,CODIGO_POSTAL,TELEFONO,TIENDA_DIRECCION)                      
INSERT INTO tienda VALUES ('CH-LIM','Chorrillos','Lima','Lima','Lima09','933561182','Av. Chorrillos 11');
INSERT INTO tienda VALUES ('SU-LIM','Surco','Lima','Lima','Lima33','933878872','Av. Surco 51');
INSERT INTO tienda VALUES ('SI-LIM','San Isidro','Lima','Lima','Lima27','933561182','Av. San Isidro 47');
INSERT INTO tienda VALUES ('MI-LIM','Miraflores','Lima','Lima','Lima18','933561182','Av. Miraflores 555');
INSERT INTO tienda VALUES ('BE-CAL','Bellavista','Callao','Callao','Callao02','933561182','Av. Bellavista 112');
INSERT INTO tienda VALUES ('LP-CAL','La Perla','Callao','Callao','Callao04','933561182','Av. La Perla 890');
INSERT INTO tienda VALUES ('AS-ARE','Alto Selva Alegre','Arequipa','Arequipa','04003','933561182','Av. Selva Alegre 667');
INSERT INTO tienda VALUES ('YA-ARE','Yanahuara','Arequipa','Arequipa','04014','933561182','Av. Yanahuara 52');
INSERT INTO tienda VALUES ('MI-ARE','Miraflores','Arequipa','Arequipa','04004','933561182','Av. Colonial 339');
INSERT INTO tienda VALUES ('SC-HUA','San Carlos','Huancayo','Junin','12001','933561182','Av. San Carlos 221');
INSERT INTO tienda VALUES ('BI-CAJ','Baños del Inca','Cajamarca','Cajamarca','06004','933561182','Av. El Inca 1304');
INSERT INTO tienda VALUES ('CH-CUS','Centro Historico','Cusco','Cusco','08000','933561182','Av. El Sol 111');
INSERT INTO tienda VALUES ('PI-ICA','Pisco','Pisco','Ica','11600','933561182','Av. Pisco 11');
INSERT INTO tienda VALUES ('PA-ICA','Paracas','Pisco','Ica','11550','933561182','Av. Paracas 10');

-- ==========================================================
-- Cargar datos a la tabla: EMPLEADO
-- ==========================================================
--INSERT INTO empleado VALUES (CODIGO_EMPLEADO,NOMBRE,APELLIDO1,APELLIDO2,EMAIL,CODIGO_TIENDA,PUESTO);
INSERT INTO empleado VALUES ('0001','Marcos','Magaña','Perez','marcos@licoreria.pe','CH-LIM','Gerente Ventas');
INSERT INTO empleado VALUES ('0002','Ruben','López','Martinez','rlopez@licoreria.pe','SU-LIM','Representante Ventas');
INSERT INTO empleado VALUES ('0003','Alberto','Soria','Carrasco','asoria@licoreria.pe','SI-LIM','Sub-Gerente Ventas');
INSERT INTO empleado VALUES ('0004','Maria','Solís','Jerez','msolis@licoreria.pe','MI-LIM','Asistente Ventas');
INSERT INTO empleado VALUES ('0005','Felipe','Rosas','Marquez','frosas@licoreria.pe','BE-CAL','Asistente Ventas');
INSERT INTO empleado VALUES ('0006','Juan Carlos','Ortiz','Serrano','cortiz@licoreria.pe','LP-CAL','Asistente Ventas');
INSERT INTO empleado VALUES ('0007','Carlos','Soria','Jimenez','csoria@licoreria.pe','AS-ARE','Asistente Ventas');
INSERT INTO empleado VALUES ('0008','Mariano','López','Murcia','mlopez@licoreria.pe','YA-ARE','Asistente Ventas');
INSERT INTO empleado VALUES ('0009','Lucio','Campomar','Martín','lcampomar@licoreria.pe','MI-ARE','Asistente Ventas');
INSERT INTO empleado VALUES ('0010','Hilario','Rodriguez','Huertas','hrodriguez@licoreria.pe','SC-HUA','Asistente Ventas');
INSERT INTO empleado VALUES ('0011','Emmanuel','Magaña','Perez','manu@licoreria.pe','BI-CAJ','Representante Ventas');
INSERT INTO empleado VALUES ('0012','José Manuel','Martinez','De la Osa','jmmart@licoreria.pe','CH-CUS','Representante Ventas');
INSERT INTO empleado VALUES ('0013','David','Palma','Aceituno','dpalma@licoreria.pe','PI-ICA','Representante Ventas');
INSERT INTO empleado VALUES ('0014','Oscar','Palma','Aceituno','opalma@licoreria.pe','PA-ICA','Asistente Ventas');

-- ==========================================================
-- Cargar datos a la tabla: CLIENTE
-- ==========================================================
--INSERT INTO cliente VALUES (CODIGO_CLIENTE,NOMBRE_CLIENTE,NOMBRE_CONTACTO,APELLIDO_CONTACTO,TELEFONO,CLIENTE_DIRECION,DISTRITO,PROVINCIA,DEPARTAMENTO);
INSERT INTO cliente VALUES (1,'Garcia S.A.C.','Daniel','Garcia','956901745','C/Paracas 945','Paracas','Ica','Ica');
INSERT INTO cliente VALUES (2,'AnahiGu E.I.R.L. ','Anahi','Gutierrez','957666646','C/Volcan Misti 26','La Joya','Arequipa','Arequipa');
INSERT INTO cliente VALUES (3,'Anita E.I.R.L. ','Ana','Gomez','957410346','C/Joya 946','La Joya','Arequipa','Arequipa');
INSERT INTO cliente VALUES (4,'Linaf S.R.L.','Lina','Flores','992323129','Calle 2 - 929','Paracas','Ica','Ica');
INSERT INTO cliente VALUES (5,'Annie S.A.C.','Annie','Tello','991233210','C/Hipolito 210','Alto Selva Alegre','Arequipa','Arequipa');
INSERT INTO cliente VALUES (6,'Antonio S.A.','Antonio','Lasas','916540145','C/Ica 110','Chincha','Ica','Ica');
INSERT INTO cliente VALUES (7,'Jose E.I.R.L.','Jose','Bermejo','954987321','Calle 8 - 555','Nazca','Ica','Ica');
INSERT INTO cliente VALUES (8,'Paco S.R.L.','Paco','Lopez','962456810','Av. Callao 665','La Punta','Callao','Callao');
INSERT INTO cliente VALUES (9,'Guillermo S.R.L.','Guillermo','Rengifo','916428956','Av. Lurin 991','Lurin','Lima','Lima');
INSERT INTO cliente VALUES (10,'David S.A.','David','Serrano','905598001','C/azores 26','Huancayo','Huancayo','Junin');
INSERT INTO cliente VALUES (11,'Tacaño S.A.','Jose','Tacaño','959830405','C/Lanas 204','Santiago','Cusco','Cusco');
INSERT INTO cliente VALUES (12,'Antony S.A.','Antony','Casas','916540145','Calle Real 26','Huancayo','Huancayo','Junin');
INSERT INTO cliente VALUES (13,'Pedro S.R.L.','Pedro','Camunas','914873241','Calle Peru 110','San Jeronimo','Cusco','Cusco');
INSERT INTO cliente VALUES (14,'Rodri S.A.C..','Juan','Rodriguez','912453217','C/Jaen 305','Jaen','Cajamarca','Cajamarca');
INSERT INTO cliente VALUES (15,'Villar E.I.R.L.','Javier','Villar','954865643','Calle 5 - 22','Chilca','Huancayo','Junin');
INSERT INTO cliente VALUES (16,'Marivi E.I.R.L.','Maria','Rodriguez','966555444','Av. Ignacio 59','San Ignacio','Cajamarca','Cajamarca');
INSERT INTO cliente VALUES (17,'Fernandez E.I.R.L.','Beatriz','Fernandez','998754159','Calle 10 - 69','Paracas','Ica','Ica');
INSERT INTO cliente VALUES (18,'Cruz S.R.L. ','Victoria','Cruz','916548735','C/Chota 12','Chota','Cajamarca','Cajamarca');
INSERT INTO cliente VALUES (19,'Luis S.A.','Luis','Martinez','916458762','Av. Molina 10','La Molina','Lima','Lima');
INSERT INTO cliente VALUES (20,'Suarez S.R.L.','Mario','Suarez','964493072','C/Loreto 79','Surquillo','Lima','Lima');
INSERT INTO cliente VALUES (21,'CriRod S.A.','Cristian','Rodrigez','916485852','C/Roma 3 - 30','Los Olivos','Lima','Lima');
INSERT INTO cliente VALUES (22,'FranCA S.A','Francisco','Camacho','916882323','Avenida Grau 23','Miraflorez','Lima','Lima');
INSERT INTO cliente VALUES (23,'Santillana E.I.R.L.','Maria','Santillana','914825645','C/El Inti 1','San Borja','Lima','Lima');
INSERT INTO cliente VALUES (24,'Gomez S.A.','Federico','Gomez','994987690','C/Junin 4','Jesus Maria','Lima','Lima');
INSERT INTO cliente VALUES (25,'Muñoz S.A.','Tony','Muñoz Mena','995842139','C/Callo 52 L3','Magdalena','Lima','Lima');
INSERT INTO cliente VALUES (26,'Eva S.R.L','Eva María','Sánchez','916877445','C/Industrial H14','Lince','Lima','Lima');
INSERT INTO cliente VALUES (27,'Matias S.R.L','Matías','San Martín','916544147','C/Francisco Arce 55','Barranco','Lima','Lima');
INSERT INTO cliente VALUES (28,'opez S.A.','Benito','Lopez','954329260','C/Mar Carpio 55','Cayma','Arequipa','Arequipa');
INSERT INTO cliente VALUES (29,'JLuis S.R.L','Joseluis','Sanchez','957465120','C/España 32','Cerro colorado','Arequipa','Arequipa');
INSERT INTO cliente VALUES (30,'Marquez S.A.','Sara','Marquez','951245370','C/Lima G22','Chorrillos','Lima','Lima');

-- ==========================================================
-- Cargar datos a la tabla: PRODUCTO
-- ==========================================================
--INSERT INTO producto VALUES (CODIGO_PRODUCTO,CATEGORIA,MARCA,PROVEEDOR,CANTIDAD_STOCK,PRECIO_VENTA,PRECIO_PROVEEDOR);
INSERT INTO producto VALUES ('V-01','Vodka','Smirnoff','Smirnoff S.A',50,44,40);
INSERT INTO producto VALUES ('V-02','Vodka','Belvedere','Belvedere S.A',50,103,90);
INSERT INTO producto VALUES ('W-01','Whisky','Chivas Regal','Chivas Regal S.A',50,209,190);
INSERT INTO producto VALUES ('W-02','Whisky','Johnnie Walker Double Black','Johnnie Walker S.A',50,180,160);
INSERT INTO producto VALUES ('W-03','Whisky','Cardhu','Cardhu S.A',50,98,93);
INSERT INTO producto VALUES ('W-04','Whisky','Ballantine´s','Ballantine´s S.A',50,60,54);
INSERT INTO producto VALUES ('W-05','Whisky','Lagabulin','Lagabulin S.A',50,192,187);
INSERT INTO producto VALUES ('R-01','Ron','Palido Montero','Palido Montero S.A.',50,59,51);
INSERT INTO producto VALUES ('R-02','Ron','Habana Club','Habana Club S.A.',50,159,147);
INSERT INTO producto VALUES ('R-03','Ron','Bacardi','Bacardi S.A.',50,80,72);
INSERT INTO producto VALUES ('R-04','Ron','Cartavio','Cartavio S.A.',50,34,28);
INSERT INTO producto VALUES ('R-05','Ron','Appleton State Lambs','Appleton S.A.',50,64,57);
INSERT INTO producto VALUES ('R-06','Ron','Malibu','Malibu S.A.',50,48,39);
INSERT INTO producto VALUES ('C-01','Cerveza','Cusqueña','Backus S.A.',50,6,5);
INSERT INTO producto VALUES ('C-02','Cerveza','Pilsen','Backus S.A.',50,5,4);
INSERT INTO producto VALUES ('C-03','Cerveza','Crital','Backus S.A.',50,5,4);
INSERT INTO producto VALUES ('C-04','Cerveza','San Juan','Backus S.A.',50,5,4);
INSERT INTO producto VALUES ('P-01','Pisco','Macchu Pisco','Macchu Pisco S.A.',50,57,47);
INSERT INTO producto VALUES ('P-02','Pisco','Tabernero','Tabernero S.A.',50,48,35);
INSERT INTO producto VALUES ('P-03','Pisco','Santiago Queirolo','Santiago Queirolo S.A.',50,37,30);
INSERT INTO producto VALUES ('P-04','Pisco','La Diablada','La Diablada S.A.',50,70,59);

-- ==========================================================
-- Cargar datos a la tabla: PEDIDO
-- ==========================================================
--INSERT INTO pedido VALUES (CODIGO_PEDIDO,FECHA_PEDIDO,FECHA_ESPERADA,FECHA_ENTREGA,ESTADO,CODIGO_CLIENTE);
INSERT INTO pedido VALUES (1,to_date('20160117','YYYYMMDD'),to_date('20160122','YYYYMMDD'),to_date('20160120','YYYYMMDD'),'Entregado',2);
INSERT INTO pedido VALUES (2,to_date('20160223','YYYYMMDD'),to_date('20170228','YYYYMMDD'),to_date('20160226','YYYYMMDD'),'Entregado',5);
INSERT INTO pedido VALUES (3,to_date('20180120','YYYYMMDD'),to_date('20180125','YYYYMMDD'),to_date('20180123','YYYYMMDD'),'Anulado',3);
INSERT INTO pedido VALUES (4,to_date('20180121','YYYYMMDD'),to_date('20180126','YYYYMMDD'),to_date('20180124','YYYYMMDD'),'Anulado',18);
INSERT INTO pedido VALUES (5,to_date('20180125','YYYYMMDD'),to_date('20180130','YYYYMMDD'),to_date('20180128','YYYYMMDD'),'Entregado',9);
INSERT INTO pedido VALUES (6,to_date('20180127','YYYYMMDD'),to_date('20180202','YYYYMMDD'),to_date('20180130','YYYYMMDD'),'Entregado',19);
INSERT INTO pedido VALUES (7,to_date('20180228','YYYYMMDD'),to_date('20180305','YYYYMMDD'),to_date('20180303','YYYYMMDD'),'Anulado',20);
INSERT INTO pedido VALUES (8,to_date('20180309','YYYYMMDD'),to_date('20180314','YYYYMMDD'),to_date('20180312','YYYYMMDD'),'Entregado',4);
INSERT INTO pedido VALUES (9,to_date('20180422','YYYYMMDD'),to_date('20180427','YYYYMMDD'),to_date('20180425','YYYYMMDD'),'Entregado',6);
INSERT INTO pedido VALUES (10,to_date('20190115','YYYYMMDD'),to_date('20190120','YYYYMMDD'),to_date('20190118','YYYYMMDD'),'Anulado',17);
INSERT INTO pedido VALUES (11,to_date('20190120','YYYYMMDD'),to_date('20190125','YYYYMMDD'),to_date('20190123','YYYYMMDD'),'Entregado',7);
INSERT INTO pedido VALUES (12,to_date('20190122','YYYYMMDD'),to_date('20190127','YYYYMMDD'),to_date('20190125','YYYYMMDD'),'Entregado',1);
INSERT INTO pedido VALUES (13,to_date('20190212','YYYYMMDD'),to_date('20190217','YYYYMMDD'),to_date('20190215','YYYYMMDD'),'Entregado',8);
INSERT INTO pedido VALUES (14,to_date('20190202','YYYYMMDD'),to_date('20190207','YYYYMMDD'),to_date('20190205','YYYYMMDD'),'Entregado',15);
INSERT INTO pedido VALUES (15,to_date('20190309','YYYYMMDD'),to_date('20190314','YYYYMMDD'),to_date('20190314','YYYYMMDD'),'Anulado',16);
INSERT INTO pedido VALUES (16,to_date('20190406','YYYYMMDD'),to_date('20190411','YYYYMMDD'),to_date('20190409','YYYYMMDD'),'Entregado',11);
INSERT INTO pedido VALUES (17,to_date('20190408','YYYYMMDD'),to_date('20190413','YYYYMMDD'),to_date('20190411','YYYYMMDD'),'Entregado',10);
INSERT INTO pedido VALUES (18,to_date('20190505','YYYYMMDD'),to_date('20190508','YYYYMMDD'),to_date('20190508','YYYYMMDD'),'Entregado',12);
INSERT INTO pedido VALUES (19,to_date('20190618','YYYYMMDD'),to_date('20190623','YYYYMMDD'),to_date('20190621','YYYYMMDD'),'Pendiente',13);
INSERT INTO pedido VALUES (20,to_date('20190620','YYYYMMDD'),to_date('20190625','YYYYMMDD'),to_date('20190623','YYYYMMDD'),'Pendiente',14);

-- ==========================================================
-- Cargar datos a la tabla: DETALLE PEDIDO ok
-- ==========================================================
--INSERT INTO detalle_pedido VALUES (CODIGO_PEDIDO,CODIGO_PRODUCTO,CANTIDAD,PRECIO_UNIDAD);
INSERT INTO detalle_pedido VALUES (1,'V-02',10,103);
INSERT INTO detalle_pedido VALUES (1,'W-01',10,209);
INSERT INTO detalle_pedido VALUES (1,'W-02',10,190);
INSERT INTO detalle_pedido VALUES (1,'C-04',10,5);
INSERT INTO detalle_pedido VALUES (1,'P-01',10,57);
INSERT INTO detalle_pedido VALUES (2,'W-05',5,192);
INSERT INTO detalle_pedido VALUES (2,'R-01',5,59);
INSERT INTO detalle_pedido VALUES (2,'C-04',5,5);
INSERT INTO detalle_pedido VALUES (2,'P-01',5,57);
INSERT INTO detalle_pedido VALUES (2,'R-04',5,34);
INSERT INTO detalle_pedido VALUES (2,'R-05',5,64);
INSERT INTO detalle_pedido VALUES (2,'R-06',5,48);               
INSERT INTO detalle_pedido VALUES (3,'R-03',20,80);
INSERT INTO detalle_pedido VALUES (3,'C-01',20,6);
INSERT INTO detalle_pedido VALUES (3,'C-04',20,5);
INSERT INTO detalle_pedido VALUES (3,'P-01',20,57);
INSERT INTO detalle_pedido VALUES (4,'P-02',10,48);
INSERT INTO detalle_pedido VALUES (4,'V-01',10,6);
INSERT INTO detalle_pedido VALUES (4,'P-03',10,37);
INSERT INTO detalle_pedido VALUES (4,'P-04',10,70);
INSERT INTO detalle_pedido VALUES (5,'C-03',4,5);
INSERT INTO detalle_pedido VALUES (5,'V-01',4,4);
INSERT INTO detalle_pedido VALUES (5,'W-05',4,192);
INSERT INTO detalle_pedido VALUES (5,'W-03',4,98);
INSERT INTO detalle_pedido VALUES (5,'W-04',4,60);                       
INSERT INTO detalle_pedido VALUES (6,'R-02',10,159);
INSERT INTO detalle_pedido VALUES (6,'R-03',10,80);
INSERT INTO detalle_pedido VALUES (6,'C-02',10,5);
INSERT INTO detalle_pedido VALUES (6,'C-03',10,5);                           
INSERT INTO detalle_pedido VALUES (7,'W-02',3,190);
INSERT INTO detalle_pedido VALUES (7,'W-05',3,192);                        
INSERT INTO detalle_pedido VALUES (8,'W-02',2,190);
INSERT INTO detalle_pedido VALUES (8,'C-03',2,5);
INSERT INTO detalle_pedido VALUES (9,'W-02',6,190);
INSERT INTO detalle_pedido VALUES (9,'W-01',6,209);
INSERT INTO detalle_pedido VALUES (10,'W-01',4,209);
INSERT INTO detalle_pedido VALUES (10,'P-04',4,70);
INSERT INTO detalle_pedido VALUES (11,'W-02',10,190);
INSERT INTO detalle_pedido VALUES (12,'R-02',10,159);
INSERT INTO detalle_pedido VALUES (13,'W-01',4,209);
INSERT INTO detalle_pedido VALUES (13,'R-02',4,159);
INSERT INTO detalle_pedido VALUES (14,'W-01',8,209);
INSERT INTO detalle_pedido VALUES (14,'P-04',8,70);
INSERT INTO detalle_pedido VALUES (15,'P-04',5,70);
INSERT INTO detalle_pedido VALUES (15,'W-02',5,190);
INSERT INTO detalle_pedido VALUES (16,'W-01',6,209);
INSERT INTO detalle_pedido VALUES (16,'W-04',6,60);
INSERT INTO detalle_pedido VALUES (17,'R-02',10,159);
INSERT INTO detalle_pedido VALUES (17,'W-05',10,192);
INSERT INTO detalle_pedido VALUES (18,'W-05',3,192);
INSERT INTO detalle_pedido VALUES (18,'W-01',3,209);
INSERT INTO detalle_pedido VALUES (19,'W-04',2,60);
INSERT INTO detalle_pedido VALUES (19,'W-01',2,209);
INSERT INTO detalle_pedido VALUES (20,'W-01',20,209);
INSERT INTO detalle_pedido VALUES (20,'W-04',20,60);
                                                          
-- ==========================================================
-- Cargar datos a la tabla: PAGO
-- ==========================================================
--INSERT INTO pago VALUES (CODIGO_CLIENTE,FORMA_PAGO,ID_TRANSACCION,FECHA DE PAGO,PAGO_IMPORTE);
INSERT INTO pago VALUES (2,'Visa','B-tsf-000001',to_date('20160117','YYYYMMDD'),5640);
INSERT INTO pago VALUES (5,'Visa','B-tsf-000002',to_date('20160223','YYYYMMDD'),2295);
INSERT INTO pago VALUES (3,'Visa','B-tsf-000003',to_date('20180123','YYYYMMDD'),2960);
INSERT INTO pago VALUES (18,'Visa','B-tsf-000004',to_date('20180124','YYYYMMDD'),1436);
INSERT INTO pago VALUES (9,'Visa','B-tsf-000005',to_date('20180125','YYYYMMDD'),2490);
INSERT INTO pago VALUES (19,'Visa','B-tsf-000006',to_date('20180127','YYYYMMDD'),2490);
INSERT INTO pago VALUES (20,'Visa','B-tsf-000007',to_date('20180303','YYYYMMDD'),1146);
INSERT INTO pago VALUES (4,'Visa','B-tsf-000008',to_date('20180312','YYYYMMDD'),390);
INSERT INTO pago VALUES (6,'Visa','B-tsf-000009',to_date('20180422','YYYYMMDD'),2394);
INSERT INTO pago VALUES (17,'Visa','B-tsf-000010',to_date('20190115','YYYYMMDD'),1116);
INSERT INTO pago VALUES (7,'Transferencia','B-tsf-000011',to_date('20190120','YYYYMMDD'),1900);
INSERT INTO pago VALUES (1,'Visa','B-tsf-000012',to_date('20190122','YYYYMMDD'),1590);
INSERT INTO pago VALUES (8,'Visa','B-tsf-000014',to_date('20190212','YYYYMMDD'),1472);
INSERT INTO pago VALUES (15,'Visa','B-tsf-000015',to_date('20190202','YYYYMMDD'),2232);
INSERT INTO pago VALUES (16,'Visa','B-tsf-000016',to_date('20190309','YYYYMMDD'),1300);
INSERT INTO pago VALUES (11,'Visa','B-tsf-000017',to_date('20190409','YYYYMMDD'),1614);
INSERT INTO pago VALUES (10,'Visa','B-tsf-000018',to_date('20190411','YYYYMMDD'),3510);
INSERT INTO pago VALUES (12,'Visa','B-tsf-000019',to_date('20190508','YYYYMMDD'),1203);
INSERT INTO pago VALUES (13,'Visa','B-tsf-000020',to_date('20190621','YYYYMMDD'),538);
INSERT INTO pago VALUES (14,'Visa','B-tsf-000021',to_date('20190623','YYYYMMDD'),5380);

commit;