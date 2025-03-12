SELECT *
FROM USER_CONSTRAINTS;

SELECT *
FROM user_cons_columns;

ALTER TABLE dept
ADD CONSTRAINT dept_deptno_pk PRIMARY KEY (deptno);

-- deptno 40 1개 삭제 --
DELETE FROM dept WHERE DNAME = 'programmer';

ALTER TABLE dept
MODIFY (dname varchar2(20) not null);

-- not null 제약조건 삭제 --
ALTER TABLE dept
DROP CONSTRAINT SYS_C007035;

-- primary key 삭제 --
ALTER TABLE dept
DROP CONSTRAINT dept_deptno_pk;

ALTER TABLE dept
ADD CONSTRAINT dept_deptno_pk PRIMARY KEY (deptno);

ALTER TABLE dept
MODIFY (dname varchar2(20) not null);

ALTER TABLE dept
MODIFY (locno varchar2(20) not null);


-- view 생성 --
CREATE VIEW dept50
AS SELECT employee_id, first_name, hire_date, salary, (salary * 12) as annsal
   FROM employees
   WHERE department_id = 50;
   
DROP VIEW dept50;

SELECT * FROM dept50;

-- view 급여가 10000 이상인 사원 --
CREATE OR REPLACE VIEW maxsal_ve
AS SELECT e.employee_id, e.first_name, e.hire_date, e.job_id, e.department_id, d.department_name, e.salary
   FROM employees e
   JOIN departments d ON e.department_id = d.department_id
   WHERE salary >= 10000;
   
SELECT * FROM maxsal_ve ORDER BY employee_id;

SELECT *
FROM user_indexes;

SELECT *
FROM user_ind_columns;

CREATE SEQUENCE dept_deptno_sq
       INCREMENT BY 10
       START WITH 300
       MAXVALUE 1000
       NOCYCLE
       NOCACHE;
       
INSERT INTO dept VALUES (DEPT_DEPTNO_SQ.nextval, 'qqq', 'Daegu', sysdate);
INSERT INTO dept VALUES (DEPT_DEPTNO_SQ.nextval, 'www', 'Seoul', sysdate);


ROLLBACK;

SELECT *
FROM user_sequences;

-- drop seq 삭제 --
DROP SEQUENCE dept_deptno_sq;

CREATE SEQUENCE dept_deptno_sq
       INCREMENT BY 10
       START WITH 350
       MAXVALUE 400
       NOCYCLE
       NOCACHE;
       

CREATE SYNONYM empt
FOR employees;

SELECT * 
FROM empt;
    
CREATE SYNONYM dep
FOR departments;

-- 사원번호, 이름, 부서코드, 부서명, 위치코드 --
SELECT employee_id, first_name, empt.department_id, location_id
FROM empt
JOIN dep ON empt.department_id = dep.department_id;

SELECT rownum, e.*
FROM (SELECT * FROM empt ORDER BY salary desc) e 
WHERE rownum <= 5;



