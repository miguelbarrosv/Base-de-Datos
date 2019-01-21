/* Averigua la estructura de la tabla EMPLE,  sus restricciones y las columnas que forman parte de cada restricción,
que se pretende crear una tabla de trabajo a partir de ella.*/
DESC EMPLE;

SELECT CONSTRAINT_TYPE, CONSTRAINT_NAME
FROM USER_CONSTRAINTS
WHERE upper(TABLE_NAME)='EMPLE';

SELECT *
FROM USER_CONS_COLUMS
WHERE UPPER(TABLE_NAME)='EMPLE';

/*Crear la tabla denominada EMPLEADOS30 con la misma estructura de la tabla EMPLE 
pero con los datos de los empleados del departamento 30 de la tabla EMPLE.  
Para ello utiliza CREATE TABLE … AS SELECT …. ¿Se crean todas las restricciones?*/

CREATE TABLE EMPLEADOS30 
AS (SELECT  EMP_NO ,
APELLIDO ,
OFICIO ,
ID_JEFE ,
FECHA_ALTA ,
SALARIO ,
COMISION_PCT ,
DEPT_NO  FROM EMPLE
WHERE DEPT_NO=30);

SELECT CONSTRAINT_TYPE, CONSTRAINT_NAME
FROM USER_CONSTRAINTS
WHERE upper(TABLE_NAME)='EMPLEADOS30';

ALTER TABLE EMPLEADOS30
ADD CONSTRAINT EMPLE30_DIR_FK FOREIGN KEY (DEPT_NO)
                            REFERENCES DEPART ON DELETE CASCADE;
                            
ALTER TABLE EMPLEADOS30
ADD CONSTRAINT EMPLE30_EMPNO_PK PRIMARY KEY (EMP_NO);

ALTER TABLE EMPLEADOS30
ADD CONSTRAINT EMPLE30_IDJEFE_FK FOREIGN KEY (ID_JEFE)
                                  REFERENCES EMPLE ON DELETE SET NULL ;

UPDATE EMPLEADOS30
SET ID_JEFE=NULL
WHERE EMP_NO IN (7698,7900);

SELECT *
FROM EMPLEADOS30;

/* Insertar en la tabla EMPLE a un empleado de apellido 'SAAVEDRA' con número de empleado 2000. 
La fecha de alta será la fecha actual, el SALARIO será el mismo salario que el del empleado de apellido 'SALA' 
más el 20% y el resto de datos serán los mismos que los datos del empleado de apellido 'SALA'.*/

SELECT * FROM EMPLE;

INSERT INTO EMPLE(APELLIDO,FECHA_ALTA,EMP_NO,SALARIO,COMISION_PCT,DEPT_NO )
SELECT 'SAAVEDRA',SYSDATE,2000,SALARIO + SALARIO * 0.2,COMISION_PCT,DEPT_NO
FROM EMPLE
WHERE UPPER(APELLIDO)='SALA';

SELECT * FROM EMPLE;

/*Actualiza la tabla EMPLE, cambiando el número de departamento, 
para todos los empleados que tenga el mismo oficio que el empleado 7566, 
por el número de departamento actual del empleado 7499.*/

SELECT * FROM EMPLE;

UPDATE EMPLE
SET DEPT_NO = (SELECT DEPT_NO
              FROM EMPLE
              WHERE EMP_NO=7499)
WHERE OFICIO = (SELECT OFICIO
              FROM EMPLE
              WHERE EMP_NO=7566);
               
SELECT * FROM EMPLE;

/*Borrar todos los departamentos de la tabla 
DEPART para los cuales no existan empleados en EMPLE.*/

SELECT * FROM DEPART;

DELETE FROM DEPART 
WHERE DEPT_NO NOT IN (SELECT DISTINCT
DEPT_NO
FROM EMPLE);

/*Eliminar a todos los empleados que están en un 
departamento cuyo nombre contiene una 'O'.*/

SELECT * FROM DEPART;

DELETE FROM DEPART
WHERE DEPT_NO IN (SELECT DEPT_NO
FROM DEPART
WHERE UPPER(DNOMBRE) LIKE '%O%');

SELECT * FROM DEPART;

/*Incrementa el salario del empleado de apellido REY. Su nuevo salario será el que tenía antes más un importe que 
corresponde con la comisión que tiene ARROYO.*/

SELECT * FROM EMPLE
WHERE UPPER(APELLIDO) = 'REY';

SELECT COMISION_PCT 
FROM EMPLE 
WHERE UPPER(APELLIDO)= 'ARROYO';

UPDATE EMPLE
SET SALARIO = SALARIO + (SELECT COMISION_PCT
                        FROM EMPLE
                        WHERE UPPER(APELLIDO)='ARROYO')
WHERE UPPER(APELLIDO)='ARROYO';

SELECT * FROM EMPLE;

