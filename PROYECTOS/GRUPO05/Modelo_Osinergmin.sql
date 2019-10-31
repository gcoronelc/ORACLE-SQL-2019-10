/*
 * DBMS           :  Oracle Database
 * Esquema        :  OSIGERMIN
 * Descripción    :  Base de Datos de Compañias de eclectricidad
 * Script         :  Crea la Base de Datos
 * Responsable    :  Elvis Arroyo Rojas
 */

-- ==========================================================
-- Inicio de Proceso
-- ==========================================================

SET TERMOUT ON
SET ECHO OFF
SET SERVEROUTPUT ON
BEGIN
	DBMS_OUTPUT.PUT_LINE('Inicio del proceso...');
END ;

SET TERMOUT OFF

-- Valido para la versión 12 o mas
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- ==========================================================
-- CREACIÓN DEL ESQUEMA
-- ==========================================================

-- Verificar Cuenta

declare
  n number(3);
begin
  select count(*) into n from dba_users where username = 'OSINERGMIN';
  if(n = 1) then
    execute immediate 'drop user osinergmin cascade';
  end if;
  execute immediate 'create user osinergmin identified by admin';  
end;

-- Asigna privilegios

grant connect, resource to osinergmin;
grant UNLIMITED TABLESPACE to osinergmin;

-- Conexión con la base de datos

connect osinergmin/admin

-- ==========================================================
-- Crear la Tabla de referencia de las empresas: EMPRESA
-- ==========================================================

CREATE TABLE EMPRESA (
    empresa     VARCHAR2(5) NOT NULL,
    name_empresa      VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_empresa PRIMARY KEY ( empresa )
   );
   
-- ==========================================================
-- Crear la Tabla sobre el tipo de tarifa de consumo: TARIFA
-- ==========================================================
connect osinergmin/admin

CREATE TABLE TARIFA (
    tipotarifa  NUMBER(3) NOT NULL,
    descripcion      VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_tipotarifa PRIMARY KEY ( tipotarifa )
   );      
   
   
-- ==========================================================
-- Crear la Tabla sobre la ubicacion geografica: UBIGEO
-- ==========================================================
connect osinergmin/admin

CREATE TABLE UBIGEO (
    ubigeo     CHAR(6) NOT NULL,
    departamento      VARCHAR2(40) NOT NULL,
    provincia  VARCHAR2(40) NOT NULL,
    distrito      VARCHAR(40) NOT NULL,
    CONSTRAINT pk_ubigeo PRIMARY KEY ( ubigeo )
   );
   
-- ==========================================================
-- Crear la Tabla sobre los datos del cliente: CLIENTE
-- ==========================================================
connect osinergmin/admin
CREATE TABLE CLIENTE (
    dni      CHAR(8) NOT NULL,
    cliente  VARCHAR2(60) NOT NULL,
    fcolectivo  NUMBER(3) NOT NULL,
    CONSTRAINT pk_dni PRIMARY KEY ( dni )
   );   
   
-- ==========================================================
-- Crear la Tabla sobre los  del Sistema electrico: SISTEMA
-- ==========================================================
connect osinergmin/admin
CREATE TABLE SISTEMA (
    sistema      VARCHAR2(7) NOT NULL,
    name_sistema  VARCHAR2(40) NOT NULL,
    area  VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_sistema PRIMARY KEY ( sistema )
   );     
   
-- ==========================================================
-- Crear la Tabla de Consumo del suministro electrico suministro: CONSUMO
-- ==========================================================
connect osinergmin/admin
CREATE TABLE CONSUMO (
    suministro     CHAR(5) NOT NULL,
    empresa      VARCHAR2(10) NOT NULL,
    tipotarifa  NUMBER(3) NOT NULL,
    sistema      VARCHAR2(7) NOT NULL,
    consumo  NUMBER(8,2) NOT NULL,
    ubigeo  CHAR(6) NOT NULL,
    dni      CHAR(8) NOT NULL,
    CONSTRAINT pk_suministro PRIMARY KEY ( suministro ),
    CONSTRAINT fk_empresa FOREIGN KEY(empresa) REFERENCES EMPRESA (empresa),
    CONSTRAINT fk_tipotarifa FOREIGN KEY(tipotarifa) REFERENCES TARIFA (tipotarifa),
    CONSTRAINT fk_ubigeo FOREIGN KEY(ubigeo) REFERENCES UBIGEO (ubigeo) ,
    CONSTRAINT fk_dni FOREIGN KEY(dni) REFERENCES CLIENTE (dni) ,
    CONSTRAINT fk_sistema FOREIGN KEY(sistema) REFERENCES SISTEMA (sistema)  
);

-- ==========================================================
-- Cargar datos a la tabla: EMPRESA
-- ==========================================================
connect osinergmin/admin
INSERT INTO 	EMPRESA	(empresa, name_empresa)	VALUES	('EDLN','EDELNOR');
INSERT INTO 	EMPRESA	(empresa, name_empresa)	VALUES	('LDS','LUZ DEL SUR');
INSERT INTO 	EMPRESA	(empresa, name_empresa)	VALUES	('ELN','ELECTRONORTE');
INSERT INTO 	EMPRESA	(empresa, name_empresa)	VALUES	('ELPU','ELECTROPUNO');
INSERT INTO 	EMPRESA	(empresa, name_empresa)	VALUES	('SEAL','SEAL');
COMMIT;

-- ==========================================================
-- Cargar datos a la tabla: TARIFA
-- ==========================================================
connect osinergmin/admin
INSERT INTO 	TARIFA	(tipotarifa, descripcion)	VALUES	('14','RESIDENCIAL DE 1 A 30 KW');
INSERT INTO 	TARIFA	(tipotarifa, descripcion)	VALUES	('15','RESIDENCIAL DE 31 A 100 KW');
INSERT INTO 	TARIFA	(tipotarifa, descripcion)	VALUES	('16','RESIDENCIAL DE 101 A 150 KW');
INSERT INTO 	TARIFA	(tipotarifa, descripcion)	VALUES	('17','RESIDENCIAL DE 151 A 300 KW');
INSERT INTO 	TARIFA	(tipotarifa, descripcion)	VALUES	('18','RESIDENCIAL DE 301 A 500 KW');
INSERT INTO 	TARIFA	(tipotarifa, descripcion)	VALUES	('19','RESIDENCIAL DE 501 A 750 KW');
INSERT INTO 	TARIFA	(tipotarifa, descripcion)	VALUES	('20','RESIDENCIAL DE 751 A 100 KW');
INSERT INTO 	TARIFA	(tipotarifa, descripcion)	VALUES	('21','RESIDENCIAL MAS DE 1000 KW');
COMMIT;

-- ==========================================================
-- Cargar datos a la tabla: UBIGEO
-- ==========================================================
connect osinergmin/admin
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('150132','LIMA','LIMA','SAN JUAN DE LURIGANCHO');
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('150135','LIMA','LIMA','SAN MARTIN DE PORRES');
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('140101','LAMBAYEQUE','CHICLAYO','CHICLAYO');
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('210101','PUNO','PUNO','PUNO');
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('150104','LIMA','LIMA','BARRANCO');
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('150115','LIMA','LIMA','LA VICTORIA');
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('040102','AREQUIPA','AREQUIPA','ALTO SELVA ALEGRE');
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('040101','AREQUIPA','AREQUIPA','AREQUIPA');
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('040129','AREQUIPA','AREQUIPA','JOSE LUIS BUSTAMANTE Y RIVERO');
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('040103','AREQUIPA','AREQUIPA','CAYMA');
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('040110','AREQUIPA','ARERQUIPA','MIRAFLORES');
INSERT INTO 	UBIGEO	(ubigeo, departamento,provincia,distrito)	VALUES	('150141','LIMA','LIMA','SURQUILLO');
COMMIT;

-- ==========================================================
-- Cargar datos a la tabla: CLIENTE
-- ==========================================================
connect osinergmin/admin
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('DNI','CLIENTE','NSUMINSITROS')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000001','MAMANI MARCELINO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000002','BENITES ODILIO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000003','MAMANI CAHUANA GREGORIA','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000004','MAGUIÑA VICTOR','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000005','NELSON ALEJANDRO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000006','YEPEZ LUISA','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000007','RAMIREZ CIRILO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000008','CUEVA HIRACHE CATALINA  SENA','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000009','YOLANDA  DEL SOCORRO CESPEDES PAIS','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000010','SEMAFORO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000011','SOCIEDAD DE BENEFICENCIA DE CHICLAYO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000012','PLAZA CARDENAS MIGUEL','2')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000013','RUIZ ROMERO, CARLOS GIOVANNI','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000014','WOYKE CUGLIEVAN, ENRIQUE PABLO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000015','DELGADO MENDOZA, INES','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000016','AGUILAR U. LUIS','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000017','MANZANO VELASQUEZ FLORA','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000018','SANDOVAL SANTOS ALFREDO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000019','SILVA T. A.','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000020','SEGURA LIMACHI, OZKARD JHONATAN','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000021','ANCHAPURI CHOQUE ALBERTO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000022','CORNEJO DURAN HILDA','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000023','GONZALEZ VALERO JORGE','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000024','FUNDACION PEDRO Y ANGELICA DE OSMA GILDE','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000025','DAVILA VASQUEZ JULIAN A','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000026','MORLA KONGFOOK LYDIA','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000027','MARTINEZ S MARIA','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000028','ALFARO RIGOBERTO .','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000029','MENESES BENITES JUAN  ','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000030','RODRIGUEZ AMAT DIANA','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000031','SUCESION BELLIDO ARAGON JORGE','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000032','CORDOVA LAQUIHUANACO MAXIMO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000033','PACHECO  ROMULO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000034','ZIRENA MARCA LIZBHET STEFANNY','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000035','MOSCOSO SALLO RUPERTO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000036','LLERENA DE TAPIA EVA','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000037','JARA ARMEJO CLIMACO','1')	;
INSERT INTO 	CLIENTE	(dni,cliente,fcolectivo)	VALUES	('00000038','ARROSPIDE ROLDAN MAYTE ESOERANZA','2')	;
COMMIT;

-- ==========================================================
-- Cargar datos a la tabla: SISTEMA
-- ==========================================================
connect osinergmin/admin
INSERT INTO 	SISTEMA	(sistema,name_sistema,area)	VALUES	('SE005','LIMA NORTE','URBANO')	;
INSERT INTO 	SISTEMA	(sistema,name_sistema,area)	VALUES	('SR1094','SISTEMA ELECTRICO RURAL CHICLAYO','RURAL')	;
INSERT INTO 	SISTEMA	(sistema,name_sistema,area)	VALUES	('SR1095','SISTEMA ELECTRICO RURAL CHICLAYO2','RURAL')	;
INSERT INTO 	SISTEMA	(sistema,name_sistema,area)	VALUES	('SR1096','JAEN','RURAL')	;
INSERT INTO 	SISTEMA	(sistema,name_sistema,area)	VALUES	('SR1097','SAN IGNACIO','RURAL')	;
INSERT INTO 	SISTEMA	(sistema,name_sistema,area)	VALUES	('SR0227','CHICLAYO BAJA DENSIDAD RURAL','RURAL')	;
INSERT INTO 	SISTEMA	(sistema,name_sistema,area)	VALUES	('SR0125','SISTEMA ELECTRICO RURAL PUNO','RURAL')	;
INSERT INTO 	SISTEMA	(sistema,name_sistema,area)	VALUES	('SE0239','PUNO BAJA DENSIDAD','RURAL')	;
INSERT INTO 	SISTEMA	(sistema,name_sistema,area)	VALUES	('SE0134','AREQUIPA','URBANO')	;
INSERT INTO 	SISTEMA	(sistema,name_sistema,area)	VALUES	('SE0250','MAJES SIGUAS','RURAL')	;
COMMIT;

-- ==========================================================
-- Cargar datos a la tabla: CONSUMO
-- ==========================================================
connect osinergmin/admin
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('A0001','EDLN','14','SE005',6.36,'150132','00000001')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('A0002','EDLN','15','SE005',35.42,'150132','00000002')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('A0003','EDLN','16','SE005',61.87,'150132','00000003')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('A0004','EDLN','17','SE005',103.1,'150132','00000004')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('A0005','EDLN','18','SE005',182.2,'150132','00000005')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('A0006','EDLN','19','SE005',286.54,'150135','00000006')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('A0007','EDLN','20','SE005',409.76,'150132','00000007')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('A0008','EDLN','21','SE005',953.57,'150132','00000008')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('B0001','ELN','14','SR0227',7.63,'140101','00000009')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('B0002','ELN','15','SR0227',32.49,'140101','00000010')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('B0003','ELN','16','SR0227',70.19,'140101','00000011')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('B0004','ELN','17','SR1094',114.05,'140101','00000012')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('B0005','ELN','18','SR1095',206.41,'140101','00000012')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('B0006','ELN','19','SR1096',328.44,'140101','00000013')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('B0007','ELN','20','SR1097',472.45,'140101','00000014')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('B0008','ELN','21','SR1097',1040.62,'140101','00000015')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('C0001','ELPU','14','SR0125',6.34,'210101','00000016')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('C0002','ELPU','15','SR0125',29.7,'210101','00000017')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('C0003','ELPU','16','SE0239',73.28,'210101','00000018')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('C0004','ELPU','17','SE0239',119.44,'210101','00000019')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('C0005','ELPU','18','SE0239',220.92,'210101','00000020')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('C0006','ELPU','19','SE0239',351.23,'210101','00000021')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('C0007','ELPU','20','SE0239',499.18,'210101','00000022')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('C0008','ELPU','21','SE0239',1014.77,'210101','00000023')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('D0001','LDS','14','SE005',5.14,'150104','00000024')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('D0002','LDS','15','SE005',30.72,'150104','00000025')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('D0003','LDS','16','SE005',61.65,'150104','00000026')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('D0004','LDS','17','SE005',104.72,'150104','00000027')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('D0005','LDS','18','SE005',183.24,'150115','00000028')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('D0006','LDS','19','SE005',286.13,'150104','00000029')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('D0007','LDS','20','SE005',406.16,'150104','00000030')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('D0008','LDS','21','SE005',803.25,'150141','00000031')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('E0001','SEAL','14','SE0134',6.74,'040102','00000032')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('E0002','SEAL','15','SE0134',33.59,'040101','00000033')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('E0003','SEAL','16','SE0134',70.27,'040129','00000034')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('E0004','SEAL','17','SE0134',113.37,'040101','00000035')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('E0005','SEAL','18','SE0250',206.07,'040102','00000036')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('E0006','SEAL','19','SE0134',334.06,'040103','00000037')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('E0007','SEAL','20','SE0134',479.78,'040101','00000038')	;
INSERT INTO 	CONSUMO	(suministro, empresa,tipotarifa,sistema,consumo,ubigeo,dni)	VALUES	('E0008','SEAL','21','SE0134',1025.28,'040110','00000038')	;
COMMIT;



SELECT * FROM OSINERGMIN.CONSUMO;