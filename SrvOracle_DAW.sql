/*Visualizar el apellido, el oficio y la localidad de los departamentos donde trabajan los analistas*/
SELECT APELLIDO, OFICIO, LOC
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO= D.DEPT_NO AND 
UPPER(OFICIO)='ANALISTA';

/*Mostrar para cada empleado quien es su jefe(apellido). Si no tiene jefe, mostrar ausencia de valor(NULL)*/
SELECT 
    EMPLEADO.EMP_NO, 
    EMPLEADO.APELLIDO AS EMPLEADO, 
    NVL(JEFE.APELLIDO, 'SIN JEFE') AS JEFE
FROM EMPLE EMPLEADO, EMPLE JEFE
WHERE EMPLEADO.ID_JEFE = JEFE.EMP_NO(+)
ORDER BY EMPLEADO.DEPT_NO;

/*Mostrar para todos los departamentos que tenemos en la empresa los apellidos de los empleados que pertenecen a cada uno de ellos.*/
SELECT APELLIDO, DEPART.DEPT_NO
FROM DEPART 
WHERE EMPLE.DEPT_NO(+) = DEPART.DEPT_NO
ORDER BY DEPT_NO;
