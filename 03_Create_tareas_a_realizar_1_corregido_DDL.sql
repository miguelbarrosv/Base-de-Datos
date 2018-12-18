REM **** Borrado de las tablas

REM *** REM se usa para comentar una linea completa y -- para comentar en una linea pero el codigo de esa linea seguira ejecutandose

drop table employees cascade constraints; -- al borrar un DROP se borra todo lo que contenga
drop table departments cascade constraints;
drop table articulos cascade constraints;
drop table fabricantes cascade constraints;
drop table tiendas cascade constraints;
drop table pedidos cascade constraints;
drop table ventas cascade constraints;
/* LA PRIMERA VEZ TIENE SENTIDO EL ERROR POR NO EXISTIR LAS TABLAS
LUEGO YA NO . ENTONCES FIJARSE QUE FALTA LA S final en la palabra 
CONSTRAINT */


REM **** Creaci�n de las tablas
/*
CREATE TABLE ventas( -- ESTA TABLA ESTABA AQUI ANTES Y SE HA CAMBIADO AL FINAL
nif VARCHAR2(10) NOT NULL,
articulo VARCHAR2(20) NOT NULL,
cod_fabricante VARCHAR2(3) NOT NULL,
peso NUMBER(3) NOT NULL,
categoria VARCHAR2(10) NOT NULL,
fecha_venta DATE DEFAULT SYSDATE,
unidades_vendidas NUMBER(4), 
CONSTRAINT ven_pk PRIMARY KEY(nif, articulo, cod_fabricante, peso, categoria, fecha_venta),
CONSTRAINT ven_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(codigo),
CHECK (unidades_vendidas>0),
CHECK (categoria IN('primero','segundo','tercero')),
CONSTRAINT ven_art_fk FOREIGN KEY(articulo, cod_fabricante, peso, categoria) REFERENCES
articulos(articulo, cod_fabricante, peso, categoria),
CONSTRAINT ven_tie_fk FOREIGN KEY(nif) REFERENCES tiendas(nif)
);
*/

CREATE TABLE fabricantes (
cod_fabricante VARCHAR(3),
--cod_fabricante VARCHAR(3) NOT NULL,
-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
nombre  VARCHAR2(15),
pais VARCHAR2(15), 
CONSTRAINT fab_cod_fab_pk PRIMARY KEY(cod_fabricante),-- esta no tiene error pero por ejemplo tiene el pk(porque luego viene un primaty key),
CONSTRAINT fab_nombre_mayusuculas_ck CHECK(nombre = upper(nombre)), 
-- se ha corregido el CHEK a CHECK pero tambien hay que cambiarlos de posicion y aparte para,
-- poder poner nombre, hay que poner el nombre CONSTRAINT  y la palabra que empieza por fab, tiene que tener ck al final(porque luego va CHECK)
CONSTRAINT fab_pais__mayusculas_ck CHECK(pais = upper(pais)) -- se ha corregido la palabra mayusculas y el constraint
 -- CHEK fab_pais_mayusuculas (pais = upper(pais))--
);

CREATE TABLE articulos (
articulo VARCHAR2(20),
/*articulo VARCHAR2(20) NOT NULL,*/
-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
cod_fabricante VARCHAR2(3),
/*cod_fabricante VARCHAR2(3) NOT NULL,*/
-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
peso NUMBER(3),
/*peso NUMBER(3) NOT NULL,*/
-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
categoria VARCHAR2(10),
/*categoria VARCHAR2(10,5) NOT NULL,*/
-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
precio_venta NUMBER(4),
precio_costo NUMBER(4),
existencias NUMBER(5),
CONSTRAINT art_pk PRIMARY KEY(articulo, cod_fabricante, peso, categoria),
CONSTRAINT art_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante),
CONSTRAINT art_precioventa_ck CHECK (precio_venta>0),
CONSTRAINT art_preciocosto_ck CHECK (precio_costo>0),
CONSTRAINT art_peso_ck CHECK (peso>0),
/*CHECK (precio_venta>0 || precio_costo>0 || peso >0),*/
-- se ha puesto CONSTRAINT y se ha añadido
-- art_precioventa_ck y el CHECK por el ck anterior *** IMPORTANTE *** un CHECK solo puede tener una condico, lo que significa
-- que hay que separa las condiciones de precio_cosoto en 3.
CONSTRAINT art_categoria_ck CHECK (categoria  IN ('primera','segunda','tercera')) -- se ha puesto la condicion despues de la palabra CHECK
/*CHECK categoria  IN('primero','segundo','tercero') , se ha añadido un CONSTRAINT y se ha añadido art_preciocosto_ck*/
);

create table departments(
   department_id NUMBER(2),
   department_name VARCHAR2(30) CONSTRAINT dept_name_nn NOT NULL, -- he quitado la S al CONSTRAINT
   manager_id NUMBER(3),
   location_id NUMBER(4),
CONSTRAINT dept_id_pk PRIMARY KEY(department_id) --nombre de columna corregido ya que le faltaba a deparment-id la t
);


create table employees( -- faltaba la apertura del parentesis(()
   employee_id NUMBER(6),
   first_name VARCHAR2(25) NOT NULL ,
   last_name VARCHAR2(25),
   email VARCHAR2(25)
      		CONSTRAINT emp_email_uk UNIQUE,
   phone_number NUMBER(12),
   hire_date DATE  DEFAULT SYSDATE ,
   job_id VARCHAR2(10),
   salary NUMBER(8,2),
   comission_pct NUMBER(5,2),
   manager_id NUMBER(3),
   department_id NUMBER(2),
   CONSTRAINT emp_id_pk PRIMARY KEY(employee_id),
   CONSTRAINT emp_dept_fk FOREIGN KEY(department_id) -- se ha corregido FOREING a FOREIGN
   REFERENCES departments(department_id)-- se ha arreglado el deparmetmentes_id a deparments_id
); -- faltaba el cierre del parentesis y el punto y com(;)

/*
CREATE TABLE fabricantes (
cod_fabricante VARCHAR(3),
--cod_fabricante VARCHAR(3) NOT NULL,
-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
nombre  VARCHAR2(15),
pais VARCHAR2(15), 
CONSTRAINT fab_cod_fab_pk PRIMARY KEY(cod_fabricante),-- esta no tiene error pero por ejemplo tiene el pk(porque luego viene un primaty key),
CONSTRAINT fab_nombre_mayusuculas_ck CHECK(nombre = upper(nombre)), 
-- se ha corregido el CHEK a CHECK pero tambien hay que cambiarlos de posicion y aparte para,
-- poder poner nombre, hay que poner el nombre CONSTRAINT  y la palabra que empieza por fab, tiene que tener ck al final(porque luego va CHECK)
CONSTRAINT fab_pais__mayusculas_ck CHECK(pais = upper(pais)) -- se ha corregido la palabra mayusculas y el constraint
 -- CHEK fab_pais_mayusuculas (pais = upper(pais))--
);
*/


/*
CREATE TABLE articulos (
articulo VARCHAR2(20),
--articulo VARCHAR2(20) NOT NULL,--
-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
cod_fabricante VARCHAR2(3),
--cod_fabricante VARCHAR2(3) NOT NULL,--
-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
peso NUMBER(3),
--peso NUMBER(3) NOT NULL,--
-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
categoria VARCHAR2(10),
--categoria VARCHAR2(10,5) NOT NULL,--
-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
precio_venta NUMBER(4),
precio_costo NUMBER(4),
existencias NUMBER(5),
CONSTRAINT art_pk PRIMARY KEY(articulo, cod_fabricante, peso, categoria),
CONSTRAINT art_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante),
CONSTRAINT art_precioventa_ck CHECK (precio_venta>0),
CONSTRAINT art_preciocosto_ck CHECK (precio_costo>0),
CONSTRAINT art_preciopeso_ck CHECK (peso>0),
/*CHECK (precio_venta>0 || precio_costo>0 || peso >0),--
-- se ha puesto CONSTRAINT y se ha añadido
-- art_precioventa_ck y el CHECK por el ck anterior *** IMPORTANTE *** un CHECK solo puede tener una condico, lo que significa
-- que hay que separa las condiciones de precio_cosoto en 3.
CONSTRAINT art_preciocosto_ck CHECK (categoria  IN ('primera','segunda','tercera')) -- se ha puesto la condicion despues de la palabra CHECK
--CHECK categoria  IN('primero','segundo','tercero') , se ha añadido un CONSTRAINT y se ha añadido art_preciocosto_ck--
);
*/

CREATE TABLE tiendas (
nif VARCHAR2(10) CONSTRAINT tie_nif_pk PRIMARY KEY,
/*nif VARCHAR2(10) PRYMARY KEY,*/
-- mal escrito 
-- Y poner CONSTRAINT y un nombre 
nombre VARCHAR2(20),
direccion  VARCHAR2(20),
poblacion  VARCHAR2(20),
provincia  VARCHAR2(20),
codpostal  VARCHAR2(5),
CONSTRAINT tie_upper CHECK (provincia = upper(provincia))
/*CONSTRAINT tie_upper (provincia = uppercase(provincia))*/
-- falta la palbra CHECK
-- Ademas la funcion no es UPPERCASE
);

CREATE TABLE pedidos (
nif VARCHAR2 (10),
--nif VARCHAR2 (10) NOT NULL,--
-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
articulo VARCHAR2 (20),-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
cod_fabricante VARCHAR2 (3),-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
peso NUMBER(3),-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
categoria VARCHAR2 (10),-- se quita el NOT NULL porque va implicito en la restriccion PRYMARY KEY(ya que seria redundante)
fecha_pedido DATE DEFAULT SYSDATE,
--fecha_pedido DATE SYSDATE,--
-- hay que añadir la palabra DEFAULT para poder poner un valor por defecto
unidades_pedidas NUMBER(4),
CONSTRAINT ped_pk PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
CONSTRAINT ped_fk FOREIGN KEY (cod_fabricante) REFERENCES fabricantes(cod_fabricante),
--CONSTRAINT ped_fk FOREIGN KEY (cod_fabricante) REFERENCE fabricantes(cod_fabricante),--
-- se ha corregido REFERENCE
CONSTRAINT ped_unidades_ck CHECK (unidades_pedidas>0),
CONSTRAINT ped_categoria_ck CHECK (categoria  IN ('primero','segundo','tercero')),
--CONSTRAINT CHECK (categoria  IN(primero,segundo,tercero)),--
-- primero , segundo y tercero entre comillas simples
-- se da un espacio en IN
CONSTRAINT art_fk FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES articulos(articulo,cod_fabricante,peso,categoria),
--CONSTRAINT art_fk FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES articulos(articulo,peso,categoria),--
-- corregir columnas que formarn la PRIMARY KEY de ARTICULOS
-- Ademas no hay error sintactico, pero ponemos bien el nombre de la CONSTRAINT 
CONSTRAINT tie_fk FOREIGN KEY (nif) REFERENCES tiendas(nif)
);


/*
CREATE TABLE tiendas (
nif VARCHAR2(10) CONSTRAINT tie_nif_pk PRIMARY KEY,
--nif VARCHAR2(10) PRYMARY KEY,--
-- mal escrito 
-- Y poner CONSTRAINT y un nombre 
nombre VARCHAR2(20),
direccion  VARCHAR2(20),
poblacion  VARCHAR2(20),
provincia  VARCHAR2(20),
codpostal  VARCHAR2(5),
CONSTRAINT tie_upper CHECK (provincia = upper(provincia))
--CONSTRAINT tie_upper (provincia = uppercase(provincia))--
-- falta la palbra CHECK
-- Ademas la funcion no es UPPERCASE
);
*/

REM *** esta tabla ha sido cambiada de lugar porque tiene que seguir el orden correcto y por eso se ha puesto al final por el momento
CREATE TABLE ventas(
nif VARCHAR2(10),
articulo VARCHAR2(20),
cod_fabricante VARCHAR2(3),
peso NUMBER(3),
categoria VARCHAR2(10),
fecha_venta DATE DEFAULT SYSDATE,
unidades_vendidas NUMBER(4), 
CONSTRAINT ven_pk PRIMARY KEY(nif, articulo, cod_fabricante, peso, categoria, fecha_venta),
CONSTRAINT ven_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante),
/*CONSTRAINT ven_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_codigo),*/
-- se cambia en REFERENCES fabricantes(codigo) se pone cod_codigo porque asi lo pone en la tabla fabricantes
-- la colummna COD no existe en la tabla FABRICANTES
CONSTRAINT ven_unidades_ck CHECK (unidades_vendidas>0),
/*CHECK (unidades_vendidas>0),*/
-- poner nombre a la restriccion
CONSTRAINT ven_categoria_ck CHECK (categoria IN('primero','segundo','tercero')),
/*CHECK (categoria IN('primero','segundo','tercero')),*/
-- ponemos nombre a la restriccion
CONSTRAINT ven_art_fk FOREIGN KEY(articulo, cod_fabricante, peso, categoria) REFERENCES
articulos(articulo, cod_fabricante, peso, categoria),
CONSTRAINT ven_tie_fk FOREIGN KEY(nif) REFERENCES tiendas(nif)
);

/*Ejercicios*/
ALTER TABLE tiendas ADD CONSTRAINT tien_nombre_ck CHECK (nombre = INITCAP(nombre));
ALTER TABLE pedidos MODIFY (unidades_pedidas NUMBER(6));
ALTER TABLE ventas MODIFY (unidades_vendidas NUMBER(8));
ALTER TABLE tiendas ADD CONSTRAINT tien_prov_ck CHECK (provincia != 'TOLEDO');
ALTER TABLE pedidos ADD PVP NUMBER(4) DEFAULT 0;
ALTER TABLE ventas ADD PVP NUMBER(4) DEFAULT 0;
ALTER TABLE ventas DROP (PVP);
ALTER TABLE pedidos DROP (PVP);

-- EJERCICIO 2--

--COMPROBAR EXISTENCIA DE OBJETOS(SELECT)--
SELECT table_name
FROM user_tables--LISTA DE DICCIONARIO(USER_TABLES)--
WHERE INITCAP(table_name) IN ('Tiedass','Ventas','Pedidos','Articulos');
--UPPER(LE DICE A TABLE_NAMEQUE LAS CONVIERTA EN MAYUSCULAS Y LAS COMPARE CON LA LISTA DADA EN IN)--

--COMPROBAR LAS COLUMNAS DE CADA TABLA--
DESC TIENDAS
DESC Ventas
DESC Pedidos
desc Articulos

--1.COMPROBAR LAS RESTRICCIONES(USER_CONSTRAINTS) Y 2.SUS COLUMNAS(USER_COLUMNS)--
--1.--
DESC USER_CONSTRAINTS--ESTO ES PARA CONSULTAR EL NOMBRE DE TUS COLUMNAS--

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE INITCAP(table_name) IN ('Tiedass','Ventas','Pedidos','Articulos')
ORDER BY table_name;

--2.--
SELECT *
FROM USER_CONS_COLUMNS
WHERE INITCAP(table_name) IN ('Tiedass','Ventas','Pedidos','Articulos');

--Esto es para el ejercicio 4 del primer ejercicio D de especialistas--
--comprobar que hay datos(=filas) en las tablas SELECT de cada tabla--
SELECT *
FROM EMPLE;

SELECT * FROM DEPART

--EJERCICIO 4--

DESC USER_CONSTRAINTS

SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE, OWNER, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE upper(TABLE_NAME) IN
('ARTICULOS','TIENDAS','FABRICANTES','PEDIDOS','VENTAS');
