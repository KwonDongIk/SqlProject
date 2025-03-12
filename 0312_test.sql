----과제----
--1--
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary BETWEEN 7000 AND 12000 and last_name LIKE 'H%';

--2--
SELECT employee_id, last_name, job_id, salary, department_id
FROM employees
WHERE salary > 5000 and (department_id = 50 or department_id = 60);

--3--
SELECT employee_id, last_name,
        CASE
            WHEN salary <= 5000 THEN salary * 1.2
            WHEN salary <= 10000 THEN salary * 1.15
            WHEN salary <= 15000 THEN salary * 1.1
            ELSE salary
        END AS 인상된급여
FROM employees;

--4--
SELECT e.department_id, d.department_name, l.city
FROM employees e
JOIN departments d ON e.department_id = d.department_id 
JOIN locations l ON d.location_id = l.location_id;

--5--
SELECT employee_id, last_name, job_id
FROM employees
WHERE department_id = (SELECT department_id
                       FROM departments
                       WHERE department_name = 'IT');
                       
--6--
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id
FROM employees
WHERE hire_date < TO_DATE('2005-01-01', 'YYYY-MM-DD') AND JOB_ID = 'ST_CLERK';

--7--
SELECT last_name, job_id, salary, commission_pct
FROM employees
WHERE commission_pct is not null
ORDER BY salary;

--8--
CREATE TABLE PROF (PROFNO number(4), NAME varchar2(15) not null, ID varchar2(15) not null, HIREDATE date, PAY number(4));


--9--
--9-1--
INSERT INTO PROF VALUES (1001, 'Mark', 'm1001', TO_DATE('07/03/01', 'YY/MM/DD'), 800);
INSERT INTO PROF (PROFNO , NAME, ID, HIREDATE) VALUES (1003, 'Adam', 'a1003', TO_DATE('11/03/02', 'YY/MM/DD'));

--9-2--
UPDATE PROF SET PAY = 1200
WHERE PROFNO = 1001;

--9-3--
DELETE FROM PROF 
WHERE PROFNO = 1003;

--10--
--10-1--
ALTER TABLE PROF
ADD CONSTRAINTS PROF_PROFNO_PK PRIMARY KEY (PROFNO);

--10-2--
ALTER TABLE PROF
ADD (GENDER CHAR(3));

--10-3--
ALTER TABLE PROF
MODIFY (NAME varchar2(20));

--11--

SELECT * FROM PROF;

COMMIT;

