--6
CREATE TABLE department
            (deptid NUMBER(10) PRIMARY KEY, 
             deptname VARCHAR2(10), 
             location VARCHAR2(10), 
             tel VARCHAR(15));

-- FK 제약조건
CREATE TABLE employee
             (empid NUMBER(10) PRIMARY KEY,
              empname VARCHAR2(10), 
              hiredate DATE, 
              addr VARCHAR2(12), 
              tel VARCHAR(15), 
              deptid NUMBER(10),
              CONSTRAINT emp_dept_deptif_FK FOREIGN KEY(deptid) REFERENCES department(deptid));

--7              
ALTER TABLE employee ADD birthday DATE;


SELECT * FROM department;

SELECT empid, empname, TO_CHAR(hiredate, 'YYYYMMDD') AS hiredate, addr, tel, deptid, NVL(TO_CHAR(birthday), '') as birthday
FROM employee;

--8
INSERT INTO department (deptid, deptname, location, tel)
VALUES (1001, '총무팀', '본101호', '053-777-8777');

INSERT INTO department (deptid, deptname, location, tel)
VALUES (1002, '회계팀', '본102호', '053-888-9999');

INSERT INTO department (deptid, deptname, location, tel)
VALUES (1003, '영업팀', '본103호', '053-222-3333');

INSERT INTO employee (empid, empname, hiredate, addr, tel, deptid)
VALUES (20121945, '박민수', TO_DATE('20120302', 'YYMMDD'), '대구', '010-1111-1234', 1001);

INSERT INTO employee (empid, empname, hiredate, addr, tel, deptid)
VALUES (20101817, '박준식', TO_DATE('20100901', 'YYMMDD'), '경산', '010-2222-1234', 1003);

INSERT INTO employee (empid, empname, hiredate, addr, tel, deptid)
VALUES (20122245, '선아라', TO_DATE('20120302', 'YYMMDD'), '대구', '010-3333-1222', 1002);

INSERT INTO employee (empid, empname, hiredate, addr, tel, deptid)
VALUES (20121749, '이범수', TO_DATE('20110302', 'YYMMDD'), '서울', '010-3333-4444', 1001);

INSERT INTO employee (empid, empname, hiredate, addr, tel, deptid)
VALUES (20121646, '이융희', TO_DATE('20120901', 'YYMMDD'), '부산', '010-1234-2222', 1003);

--9
ALTER TABLE employee MODIFY empname NOT NULL;

--10
SELECT e.empname as 이름,
       TO_CHAR(e.hiredate, 'YYYYMMDD') as 입사일,
       d.deptname as 부서명
FROM employee e
INNER JOIN department d on e.deptid = d.deptid
WHERE d.deptname = '총무팀';

--11
DELETE FROM employee
WHERE addr = '대구';

--12
UPDATE employee 
SET deptid = (SELECT deptid
              FROM department
              WHERE deptname = '회계팀')
WHERE deptid = (SELECT deptid
                FROM department
                WHERE deptname = '영업팀');

--13
SELECT e.empid,
       e.empname,
       e.birthday,
       d.deptname
FROM employee e
     JOIN department d
     ON (d.deptid = e.deptid)
WHERE e.hiredate > (SELECT hiredate
                    FROM employee
                    WHERE empid = '20121729');
       

--14
CREATE OR REPLACE VIEW emp_vw
AS
    SELECT e.empname,
           e.addr,
           d.deptname
    FROM employee e
         JOIN department d
         ON (d.deptid = e.deptid)
    WHERE d.deptname = '총무팀';
    
    
SELECT empname, addr, deptname FROM emp_vw;


COMMIT;








SET SERVEROUTPUT ON
--PL/SQL 블록
BEGIN
    DBMS.OUTPUT.PUT_LINE('Hello, PL/SQL!');
END;
/    






