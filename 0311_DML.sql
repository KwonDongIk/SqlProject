-- 데이터 조작어 --
CREATE TABLE dept(deptno number(5), dname varchar2(20), loc varchar2(20), make_date date);

INSERT INTO dept VALUES(10, 'sales', 'daegu', sysdate);

INSERT INTO dept VALUES(20, 'according', 'seoul', null);

INSERT INTO dept VALUES(30, 'IT', 'daegu', '25/02/05');

INSERT INTO dept VALUES(40, 'programmer', null, '24/12/31');

INSERT INTO dept
SELECT department_id, department_name, location_id, sysdate
FROM departments;

commit;

DELETE dept WHERE deptno = (SELECT department_id
                            FROM employees
                            WHERE employee_id = 150);

ROLLBACK;

DELETE departments
WHERE department_id = 50;

DELETE employees
WHERE department_id = 30;

UPDATE dept
SET deptno = 200
WHERE deptno = 10;

UPDATE dept
SET dname = 777
WHERE dname = 'IT';

UPDATE employees
SET department_id = 30
WHERE department_id = 20;

SELECT *
FROM dept
ORDER BY 1;

COMMIT;

DELETE dept
WHERE deptno = 20;

ROLLBACK;

DELETE dept
WHERE deptno = 20;

savepoint a;

DELETE dept
WHERE deptno = 30;

ROLLBACK to savepoint a;
commit;

SELECT *
FROM user_objects;

CREATE TABLE emp
as SELECT *
   FROM employees
   WHERE employee_id < 150;

-- ALTER --
ALTER TABLE dept
add (bigo varchar2(10));

ALTER TABLE dept
MODIFY (bigo varchar2(20));

ALTER TABLE dept
DROP COLUMN bigo;

DROP TABLE dept;

RENAME dept2 to dept;

ALTER TABLE dept
RENAME COLUMN loc to locno;

-- comment(주석달기) --
COMMENT ON TABLE dept
IS '임시테이블';

SELECT *
FROM user_tab_comments;

COMMENT ON COLUMN dept.locno
IS '부서가 위치한 지역';

SELECT *
FROM user_col_comments;


CREATE TABLE EMP_HW(EMPNO number(4), ENAME varchar2(10), JOB varchar2(9), MGR number(4), HIREDATE date, SAL number(7,2), COMM number(7,2), DEPNO number(2));

ALTER TABLE EMP_HW
add (bigo varchar2(20));

ALTER TABLE EMP_HW
MODIFY (bigo varchar2(30));

ALTER TABLE EMP_HW
RENAME COLUMN bigo to remark;

INSERT INTO EMP_HW (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPNO)
SELECT employee_id, first_name, job_id, manager_id, hire_date, salary, commission_pct, department_id
FROM employees;

ALTER TABLE EMP_HW
MODIFY (ENAME varchar2(30));

ALTER TABLE EMP_HW
MODIFY (JOB varchar2(15));

ALTER TABLE EMP_HW
MODIFY (DEPNO number(5));














