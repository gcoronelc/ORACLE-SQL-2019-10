

select D.department_name,SUM(E.SALARY) from HR.departments D
INNER JOIN HR.employees E  ON D.department_id=E.department_id
GROUP BY ( D.DEPARTMENT_NAME)