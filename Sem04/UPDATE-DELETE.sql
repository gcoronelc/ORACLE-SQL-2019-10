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


-- update con subconsulta

-- Preparando el ambiente

update scott.emp2 
set sueldo = sueldo * 1.3;

update scott.emp
set sal = sal * 0.85;

commit;

select e1.empno, e1.ename, e1.sal, e2.sueldo
from scott.emp e1 
join scott.emp2 e2 on e1.empno = e2.id;


commit;

select * from scott.emp;
select * from scott.emp2;

update scott.emp e1
set e1.sal = (select e2.sueldo from scott.emp2 e2 where e2.id = e1.empno) 
WHERE EMPNO in (select id from scott.emp2);


alter table scott.emp2
add constraint pk_emp2 primary key( id );


update (
    select e1.empno, e1.ename, e1.sal, e2.sueldo
    from scott.emp e1 
    join scott.emp2 e2 on e1.empno = e2.id
) v1
set v1.sal = v1.sueldo;









