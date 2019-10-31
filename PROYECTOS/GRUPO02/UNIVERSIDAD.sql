
create user UNIVERSIDAD
identified by admin;


-- Paso 2: Privilegios para el usuario ALMACEN

grant connect, resource to UNIVERSIDAD;

ALTER USER UNIVERSIDAD 
DEFAULT TABLESPACE USERS 
QUOTA UNLIMITED ON USERS;


-- ======================================================
-- TABLA ALUMNO
-- ======================================================
CREATE TABLE UNIVERSIDAD.ALUMNO
( 
    alu_id               INT  NOT NULL ,
    alu_nombre           varchar2(100)  NOT NULL ,
    alu_apellido         varchar2(100)  NOT NULL ,
    alu_fecnacimiento    date  NOT NULL ,
    alu_direccion        varchar2(100)  NOT NULL ,
    alu_celular          varchar2(20)  NULL ,
    alu_email            varchar2(50)  NULL ,
    alu_genero           varchar2(20)  NULL ,
    CONSTRAINT PK_ALUMO PRIMARY KEY( alu_id )
);
-- ======================================================
-- TABLA CURSO
-- ======================================================
CREATE TABLE UNIVERSIDAD.CURSO
( 
	cur_id               INT NOT NULL ,
	cur_nombre           varchar2(100)  NOT NULL ,
	cur_vacantes         int  NOT NULL ,
	cur_matriculados     int  NOT NULL ,
	cur_profesor         varchar2(100)  NULL ,
	cur_precio           decimal(10,2)  NOT NULL ,
    CONSTRAINT PK_CURSO PRIMARY KEY( cur_id )
);


ALTER TABLE UNIVERSIDAD.CURSO
	ADD CONSTRAINT  chk_curso_vacantes
	CHECK  ( cur_vacantes > 0 ); 

ALTER TABLE UNIVERSIDAD.CURSO
	ADD CONSTRAINT  chk_curso_precio
	CHECK  ( cur_precio > 0 );
    
ALTER TABLE UNIVERSIDAD.CURSO
	ADD CONSTRAINT u_curso_nombre 
	UNIQUE (cur_nombre);

ALTER TABLE UNIVERSIDAD.CURSO
	ADD CONSTRAINT  chk_curso_matriculados
	CHECK  ( cur_matriculados >= 0 AND cur_matriculados <= cur_vacantes ) ;

ALTER TABLE UNIVERSIDAD.CURSO
  MODIFY cur_matriculados default 0;


commit;	





-- ======================================================
-- TABLA FACULTAD
-- ======================================================
CREATE TABLE UNIVERSIDAD.FACULTAD
( 
	fac_id               INT  NOT NULL ,
	fac_nombre           varchar2(100)  NOT NULL ,
    CONSTRAINT PK_FACULTAD PRIMARY KEY( fac_id )
);
-- ======================================================
-- TABLA MATRICULA
-- ======================================================
CREATE TABLE UNIVERSIDAD.MATRICULA
( 
	mat_id               INT NOT NULL ,
	mat_fecha            date not null,
    mat_precio           decimal(10,2)  NOT NULL ,
    mat_cuotas           decimal(10,2)  NOT NULL   ,
    CONSTRAINT PK_MATRICULA PRIMARY KEY( mat_id )  
);
-- ======================================================
-- TABLA PENSION
-- ======================================================
CREATE TABLE UNIVERSIDAD.PENSION
( 
	pen_id               INT NOT NULL ,
	pen_modalidad       varchar2(100)  NOT NULL ,
    CONSTRAINT PK_PENSION PRIMARY KEY( pen_id )  
);
-- ======================================================
-- TABLA PROFESOR
-- ======================================================

CREATE TABLE UNIVERSIDAD.PROFESOR
( 
	pro_id               INT  NOT NULL ,
	pro_nombre           varchar2(100)  NOT NULL ,
    pro_apellido         varchar2(100)  NOT NULL ,
    pro_fecnacimiento    date  NOT NULL ,
	pro_sueldo           number(10)  NULL ,
    pro_dni              varchar2(8)  NULL ,
    pro_celular          number(9)  NULL ,
    pro_email            varchar2(100)  NOT NULL,
    CONSTRAINT PK_PROFESOR PRIMARY KEY( pro_id ) 
);



-- ======================================================
-- RESTRICCIONES DE LA TABLA ALUMNO
-- ======================================================

ALTER TABLE UNIVERSIDAD.ALUMNO
	ADD CONSTRAINT PK_ALUMNO 
	PRIMARY KEY (alu_id);


ALTER TABLE UNIVERSIDAD.ALUMNO
	ADD CONSTRAINT U_ALUMNO_EMAIL 
	UNIQUE (alu_email);


ALTER TABLE UNIVERSIDAD.ALUMNO
	ADD CONSTRAINT U_ALUMNO_NOMBRE 
	UNIQUE (alu_nombre);





-- ============================================================================================================
--              INSERTANDO DATOS PARA           ALUMNO
-- ============================================================================================================

INSERT INTO UNIVERSIDAD.ALUMNO (alu_id, alu_nombre, alu_apellido, alu_fecnacimiento, alu_direccion, alu_celular, alu_email, alu_genero)
VALUES( 1,'ANTONIO','GARCIA', '10-5-91','PSJ. JOSE MELGAR 457', '958764128','ANTONIOGARCIA@GMAIL.COM', 'MASCULINO');

INSERT INTO UNIVERSIDAD.ALUMNO (alu_id, alu_nombre, alu_apellido, alu_fecnacimiento, alu_direccion, alu_celular, alu_email, alu_genero)
VALUES( 2,'JUAN','PEREA', '25-06-90','AV. PEDRO GALLO', '977856794','JUANPERA@GMAIL.COM', 'MASCULINO');

INSERT INTO UNIVERSIDAD.ALUMNO (alu_id, alu_nombre, alu_apellido, alu_fecnacimiento, alu_direccion, alu_celular, alu_email, alu_genero)
VALUES( 3,'GIAN','ARROYO', '15-11-95','CALLE VICTOR ALZAMORA', '999854632','GIANARROYO@GMAIL.COM', 'MASCULINO');

INSERT INTO UNIVERSIDAD.ALUMNO (alu_id, alu_nombre, alu_apellido, alu_fecnacimiento, alu_direccion, alu_celular, alu_email, alu_genero)
VALUES( 4,'YESENIA','DOMINGUEZ', '11-02-86','AV JOSE GRANDA', '988564279','YESENIADOMINGUEZ@GMAIL.COM', 'FEMENINO');

INSERT INTO UNIVERSIDAD.ALUMNO (alu_id, alu_nombre, alu_apellido, alu_fecnacimiento, alu_direccion, alu_celular, alu_email, alu_genero)
VALUES( 5,'JAIRO','PAUCAR', '10-11-93','PSJ. 20 DE AGOSTO', '987885553','JAIROPAUCARC@GMAIL.COM', 'MASCULINO');

INSERT INTO UNIVERSIDAD.ALUMNO (alu_id, alu_nombre, alu_apellido, alu_fecnacimiento, alu_direccion, alu_celular, alu_email, alu_genero)
VALUES (6, 'JHENIFER', 'CRISOLES', '12-8-95', 'CALLE LOS ABEDULES 189', '990782585', 'JHENIFERCRISOLES@GMAIL.COM', 'FEMENINO');

INSERT INTO UNIVERSIDAD.ALUMNO (alu_id, alu_nombre, alu_apellido, alu_fecnacimiento, alu_direccion, alu_celular, alu_email, alu_genero)
VALUES (7, 'ALDO', 'CRISOLES', '26-12-70', 'AV. LOS MANZANOS 18', '990152456', 'ALDOCRISOLES@GMAIL.COM', 'MASCULINO');

INSERT INTO UNIVERSIDAD.ALUMNO (alu_id, alu_nombre, alu_apellido, alu_fecnacimiento, alu_direccion, alu_celular, alu_email, alu_genero)
VALUES (8, 'ROCIO', 'RAMIREZ', '15-4-72', 'AV FRUTALES 150', '990524581', 'ROCIORAMIREZ@HOTMAIL.COM', 'FEMENINO');

INSERT INTO UNIVERSIDAD.ALUMNO (alu_id, alu_nombre, alu_apellido, alu_fecnacimiento, alu_direccion, alu_celular, alu_email, alu_genero)
VALUES (9, 'JAIME', 'URBINA', '10-8-95', 'CALLE SAN GERMAN 1524', '991245162', 'JAIMEURBINA@GMAIL.COM', 'MASCULINO');

INSERT INTO UNIVERSIDAD.ALUMNO (alu_id, alu_nombre, alu_apellido, alu_fecnacimiento, alu_direccion, alu_celular, alu_email, alu_genero)
VALUES (10, 'ERIK', 'AGUIRRE', '21-11-84', 'AV. VENTANILLA ALTA 1541', '990590512', 'ERIKAGUIRRE@HOTMAIL.COM', 'MASCULINO');


-- ============================================================================================================
--              INSERTANDO DATOS PARA           CURSO
-- ============================================================================================================
INSERT INTO UNIVERSIDAD.CURSO (cur_id, cur_nombre, cur_vacantes, cur_matriculados, cur_profesor, cur_precio)
VALUES( 1,'PROGRAMACION 1','30', '9', 'JULIO JAUREGUI','1000' );

INSERT INTO UNIVERSIDAD.CURSO (cur_id, cur_nombre, cur_vacantes, cur_matriculados, cur_profesor, cur_precio)
VALUES( 2,'ADMINISTRACION DE BASE DE DATOS','20', '20', 'GUSTAVO CORONEL','2500' );

INSERT INTO UNIVERSIDAD.CURSO (cur_id, cur_nombre, cur_vacantes, cur_matriculados, cur_profesor, cur_precio)
VALUES( 3,'GESTION DE LA INFORMACION','20', '6', 'PEDRO RUIZ','1200' );

INSERT INTO UNIVERSIDAD.CURSO (cur_id, cur_nombre, cur_vacantes, cur_matriculados, cur_profesor, cur_precio)
VALUES( 4,'INTRODUCCION A SQL SERVER','20', '5', 'JUAN ALMOGUER','1900' );

INSERT INTO UNIVERSIDAD.CURSO (cur_id, cur_nombre, cur_vacantes, cur_matriculados, cur_profesor, cur_precio)
VALUES( 5,'CENTOS','30', '9', 'SANTIAGO GONZALES','1400' );



-- ============================================================================================================
--              INSERTANDO DATOS PARA           FACULTAD
-- ============================================================================================================

INSERT INTO UNIVERSIDAD.FACULTAD(fac_id, fac_nombre)
VALUES( 1,'INGENIERIA DE SISTEMAS');

INSERT INTO UNIVERSIDAD.FACULTAD(fac_id, fac_nombre)
VALUES( 2,'CONTABILIDAD');

INSERT INTO UNIVERSIDAD.FACULTAD(fac_id, fac_nombre)
VALUES( 3,'PSICOLOGIA');

INSERT INTO UNIVERSIDAD.FACULTAD(fac_id, fac_nombre)
VALUES( 4,'DERECHO');

-- ============================================================================================================
--              INSERTANDO DATOS PARA           MATRICULA
-- ============================================================================================================

INSERT INTO UNIVERSIDAD.MATRICULA (mat_id, mat_fecha, mat_precio, mat_cuotas)
VALUES( 1,'10-10-2019','200.00','4');

INSERT INTO UNIVERSIDAD.MATRICULA (mat_id, mat_fecha, mat_precio, mat_cuotas)
VALUES( 2,'02-05-2019','200.00','8');

INSERT INTO UNIVERSIDAD.MATRICULA (mat_id, mat_fecha, mat_precio, mat_cuotas)
VALUES( 3,'11-11-2019','200','4');

INSERT INTO UNIVERSIDAD.MATRICULA (mat_id, mat_fecha, mat_precio, mat_cuotas)
VALUES( 4,'11-12-2019','200','4');

INSERT INTO UNIVERSIDAD.MATRICULA (mat_id, mat_fecha, mat_precio, mat_cuotas)
VALUES( 5,'09-11-2018','200','8');

INSERT INTO UNIVERSIDAD.MATRICULA (mat_id, mat_fecha, mat_precio, mat_cuotas)
VALUES( 6,'05-08-2018','200','4');

INSERT INTO UNIVERSIDAD.MATRICULA (mat_id, mat_fecha, mat_precio, mat_cuotas)
VALUES( 7,'02-06-2017','200','4');


-- ============================================================================================================
--              INSERTANDO DATOS PARA           PENSION
-- ============================================================================================================

INSERT INTO UNIVERSIDAD.PENSION (pen_id, pen_modalidad)
VALUES( 1,'PRESENCIA');

INSERT INTO UNIVERSIDAD.PENSION (pen_id, pen_modalidad)
VALUES( 2,'DISTANCIA');

-- ============================================================================================================
--              INSERTANDO DATOS PARA           PROFESOR
-- ============================================================================================================

INSERT INTO UNIVERSIDAD.PROFESOR (pro_id, pro_nombre, pro_apellido, pro_fecnacimiento, pro_sueldo, pro_dni, pro_celular, pro_email)
VALUES( 1,'GUSTAVO', 'CORONEL', '01-05-1969', '9000','10203040', '987654321', 'GCORONEL@GMAIL.COM');

INSERT INTO UNIVERSIDAD.PROFESOR (pro_id, pro_nombre, pro_apellido, pro_fecnacimiento, pro_sueldo, pro_dni, pro_celular, pro_email)
VALUES( 2,'JULIO', 'JAUREGUI', '02-02-1971', '4000','10203030', '963218503', 'PGARCIA@GMAIL.COM');

INSERT INTO UNIVERSIDAD.PROFESOR (pro_id, pro_nombre, pro_apellido, pro_fecnacimiento, pro_sueldo, pro_dni, pro_celular, pro_email)
VALUES( 3,'PEDRO', 'RUIZ', '06-05-1980', '6000','74963185', '963030301', 'PRUIZ@GMAIL.COM');

INSERT INTO UNIVERSIDAD.PROFESOR (pro_id, pro_nombre, pro_apellido, pro_fecnacimiento, pro_sueldo, pro_dni, pro_celular, pro_email)
VALUES( 4,'JUAN', 'ALMOGUER', '03-03-1985', '3000','96703579', '998676495', 'JALMOGUER@GMAIL.COM');

INSERT INTO UNIVERSIDAD.PROFESOR (pro_id, pro_nombre, pro_apellido, pro_fecnacimiento, pro_sueldo, pro_dni, pro_celular, pro_email)
VALUES( 5,'SANTIAGO', 'GONZALES', '11-11-1975', '4000','03309790', '989874620', 'SGONZALES@GMAIL.COM');





SELECT * FROM UNIVERSIDAD.ALUMNO;

SELECT * FROM UNIVERSIDAD.CURSO;

SELECT * FROM UNIVERSIDAD.FACULTAD;

SELECT * FROM UNIVERSIDAD.MATRICULA;

SELECT * FROM UNIVERSIDAD.PENSION;

SELECT * FROM UNIVERSIDAD.PROFESOR;


-- ============================================================================================================
                                 --10 CONSULTAS SIMPLES
-- ============================================================================================================

/*1. Desarrolle una sentencia SELECT para consultar el id, nombre, apellido y email de
todos los ALUMNOS. Esquema UNIVERSIDAD.*/

SELECT alu_id, alu_nombre, alu_apellido, alu_email
FROM UNIVERSIDAD.alumno;

/*2. Desarrollar una sentencia SELECT para consultar el nombre y apellido de un
alumno en una sola columna. Base de datos UNIVERSIDAD.*/

SELECT alu_id, alu_nombre || ',' || alu_apellido "NOMBRE COMPLETO"                
FROM UNIVERSIDAD.alumno;

/*3. Desarrolle una sentencia SELECT para consultar el nombre, vacantes y precio de
cada CURSO. Esquema UNIVERSIDAD.*/

SELECT cur_id , cur_nombre, cur_vacantes, cur_precio
FROM UNIVERSIDAD.curso;

/*4. Desarrolle una sentencia SELECT para consultar el id, nombre, apellido y email de
todos los PROFESOR. Esquema UNIVERSIDAD.*/

SELECT CUR_ID, CUR_NOMBRE, CUR_VACANTES * CUR_PRECIO "IMPORTE TOTAL"
FROM UNIVERSIDAD.CURSO;

/*4. Desarrolle una sentencia SELECT para consultar el id, nombre, apellido juntos de 
cada profesor. Esquema UNIVERSIDAD.*/

SELECT pro_id, pro_nombre || ',' || pro_apellido "NOMBRE COMPLETO" 
FROM UNIVERSIDAD.PROFESOR;


/*5. Desarrolle una sentencia SELECT para consultar el id, nombre, apellido juntos y el sueldo de 
cada profesor . Esquema UNIVERSIDAD.*/

SELECT pro_id, pro_nombre || ',' || pro_apellido "NOMBRE COMPLETO" , pro_sueldo
FROM UNIVERSIDAD.PROFESOR;


/*6. Desarrolle una sentencia SELECT para consultar el id, nombre, apellido y 
genero de todos los alumnos. Esquema UNIVERSIDAD.*/

SELECT alu_id, alu_nombre || ',' || alu_apellido "NOMBRE COMPLETO" , alu_genero
FROM UNIVERSIDAD.alumno;

/*7. Desarrolle una sentencia SELECT para consultar el nombre y el email de cada alumno.
Esquema UNIVERSIDAD.*/

SELECT alu_nombre  , alu_email
FROM UNIVERSIDAD.alumno;


/*8. Desarrolle una sentencia SELECT para consultar la direccion de cada alumno y su prespectivo nombre.
Esquema UNIVERSIDAD.*/

SELECT alu_nombre  , alu_direccion
FROM UNIVERSIDAD.alumno;

/*9. Desarrolle una sentencia SELECT para consultar el precio de cada curso.
Esquema UNIVERSIDAD.*/

SELECT cur_nombre, cur_precio
FROM UNIVERSIDAD.curso;

/*10. Desarrolle una sentencia SELECT para consultar las vacantes de cada curso.
Esquema UNIVERSIDAD.*/

SELECT cur_id, cur_nombre, cur_vacantes
FROM UNIVERSIDAD.curso;


/* Ejercicio 11
Calcula la cantidad de alumnos que hay en la universidad por genero */ 

Select alu_genero,count(1) cantidad
From UNIVERSIDAD.ALUMNO
GROUP BY alu_genero;

/* Ejercicio 12
Mostrar a los profesores con sueldo más alto */

Select * from UNIVERSIDAD.PROFESOR
WHERE PRO_SUELDO = (SELECT MAX(PRO_SUELDO) FROM UNIVERSIDAD.PROFESOR);

/* Ejercicio 13
Calcular la cantidad de matriculas con precios mas alto */

select count(1) 
from UNIVERSIDAD.MATRICULA
WHERE MAT_PRECIO=(SELECT MAX(MAT_PRECIO) FROM UNIVERSIDAD.MATRICULA);

/* Ejercicio 14 
Calcular la cantidad de pensiones por modalidad. */

SELECT pen_modalidad,count(1)
from UNIVERSIDAD.PENSION 
GROUP BY pen_modalidad;

/* Ejercicio 15
Mostrar los cursos con mayor vacantes */

SELECT * FROM UNIVERSIDAD.CURSO
WHERE cur_vacantes=(SELECT MAX(cur_vacantes) FROM UNIVERSIDAD.CURSO);

/* Ejercicio 16
Mostrar las matriculas con un precio mayor o igual al promedio */

SELECT * FROM UNIVERSIDAD.MATRICULA
WHERE MAT_PRECIO>=(SELECT AVG(MAT_PRECIO) FROM UNIVERSIDAD.MATRICULA);

/* Ejercicio 17
Mostrar los profesores con el salario menor o igual al promedio */

SELECT * FROM UNIVERSIDAD.PROFESOR
WHERE PRO_SUELDO<= (SELECT AVG(PRO_SUELDO) FROM UNIVERSIDAD.PROFESOR);

/* Ejercicio 18
Mostrar la cantidad de alumnos por año de nacimiento */

SELECT TO_CHAR(ALU_FECNACIMIENTO,'YYYY'),COUNT(1)
FROM UNIVERSIDAD.ALUMNO
GROUP BY TO_CHAR(ALU_FECNACIMIENTO,'YYYY');

/* Ejercicio 19
Mostrar la cantidad de matriculaS por mes. */

SELECT TO_CHAR(MAT_FECHA,'YYYYMM'),COUNT(1)
FROM UNIVERSIDAD.MATRICULA
GROUP BY TO_CHAR(MAT_FECHA,'YYYYMM');

/* Ejercicio 20
MOSTRAR LOS PROFESORES QUE NACIERON DESPUES DEL AÑO 1980 */

SELECT * FROM UNIVERSIDAD.PROFESOR
WHERE TO_CHAR(PRO_FECNACIMIENTO,'YYYY')>1980;
