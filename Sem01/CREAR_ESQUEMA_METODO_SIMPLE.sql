-- CREACION DE UN ESQUEMA FORMA SIMPLE

-- Paso 1: Crear el usuario: ALMACEN

create user ALMACEN
identified by admin;

-- Paso 2: Privilegios para el usuario ALMACEN

grant connect, resource to ALMACEN;

-- Paso 3: Crear una tabla en ALMACEN

CREATE TABLE ALMACEN.PRODUCTO(
  ID NUMBER(10) NOT NULL,
  NOMBRE VARCHAR2(100) NOT NULL,
  PRECIO NUMBER(10,2) NOT NULL,
  CONSTRAINT PK_PRODUCTO PRIMARY KEY( ID ),
  CONSTRAINT CK_PRODUCTO_PRECIO CHECK(PRECIO>=0)
);





