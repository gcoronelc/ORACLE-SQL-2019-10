-- Ejemplo 1

select * from scott.emp;

update scott.emp
set sal = sal * 1.20
where empno = 7369;

commit;

/*
1 fila actualizadas.
*/

update scott.emp
set sal = sal * 1.20
where empno = 73699;

/*
0 filas actualizadas.

Error lógico del programador, el codigo es incorrecto.
*/



delete from scott.emp
where empno = 73699;











