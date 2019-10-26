-- ACTUALIZANDO COLUMNAS DE UNA TABLA
-- DESDE OTRA TABLA


CREATE TABLE SCOTT.EMPS AS
(SELECT * FROM SCOTT.EMP);



SELECT * FROM SCOTT.EMPS;

UPDATE SCOTT.EMPS
SET SAL = SAL / 2;


commit;



-- CASO 1

SELECT * FROM SCOTT.EMP;

UPDATE SCOTT.EMP A
SET SAL = (select sal from scott.emps b where a.empno = b.empno);

rollback;


-- CASO 2

SELECT * FROM SCOTT.EMP;

alter table scott.emps
add constraint pk_emps
primary key (empno );

UPDATE (
  select 
       a.empno a_empno,
       a.sal   a_sal,
       b.sal   b_sal
  from scott.emp a 
  join scott.emps b 
  on   a.empno = b.empno 
)
SET a_sal = b_sal;



rollback;


