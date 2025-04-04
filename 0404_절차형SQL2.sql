SET SERVEROUTPUT ON
--PL/SQL 블록
BEGIN
    -- 한줄 주석
    /*
       여러줄 주석
    */
    DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL!');
END;
/   

-- 변수 선언
DECLARE
    -- identifier[constant] datatype[not null] [:= | DEFAULT expr];
    -- 기본 사용
    -- 변수명 데이터타입;
    v_str VARCHAR2(100);
    -- 상수 선언
    -- 변수명 constant 데이터타입 := 표현식;
    v_num CONSTANT NUMBER(2,0) := 10;
    -- not null 적용
    -- 변수명 데이터타입 not null := 표현식;
    v_count NUMBER(1,0) NOT NULL := 5;
    -- 변수 선언 및 초기화
    -- 변수명 데이터타입 := 표현식;
    v_sum NUMBER(3,0) := (v_num + v_count);
BEGIN
    -- v_str := 'Hello';
    -- CONSTANT 상수로 선언한 변수의 값을 바꿀 경우
    -- v_num := 100;
    -- NOT NULL 제약조건 발동
    -- v_count := null;
    -- v_sum := v_num + 1234;
    
    dbms_output.put_line('v_str : ' || v_str);
    dbms_output.put_line('v_num : ' || v_num);
    dbms_output.put_line('v_count : ' || v_count);
    dbms_output.put_line('v_sum : ' || v_sum);
    
END;
/

-- PL/SQL에서 함수 사용
DECLARE
    -- 선언부
    v_today DATE := SYSDATE;
    v_after_day v_today%TYPE;
    v_msg VARCHAR2(100);
BEGIN
    -- 실행부
    v_after_day := ADD_MONTHS(v_today, 3);
    v_msg := TO_CHAR(v_after_day, 'yyyy"년" MM"월" dd"일"');
    DBMS_OUTPUT.PUT_LINE(v_msg);

END;
/

-- PL/SQL의 SELECT문
-- 1) 예시
DECLARE
    v_ename employees.last_name%TYPE;
BEGIN
    SELECT last_name
    -- 조회한 데이터를 변수에 담는 구문
    INTO v_ename
    FROM employees
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.PUT_LINE(v_ename);
    
END;
/



SELECT last_name
--INTO v_ename
FROM employees
WHERE employee_id = 100;


-- 2) 결과는 반드시 only one
DECLARE
    v_ename VARCHAR2(100);
BEGIN
    SELECT last_name
    INTO v_ename
    FROM employees
    WHERE department_id = &부서번호;
    -- 부서번호 10 : 정상실행
    -- 부서번호 50 : TOO_MANY_ROWS(ORA-01422: exact fetch returns more than requested number of rows)
    -- 부서번호  0 : NOT_DATA_FOUND(ORA-01403: no data found)
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename);
    
END;
/


-- 3) SELECT 절의 컬럼과 INTO 절의 변수 관계
DECLARE
    v_eid employees.employee_id%TYPE;
    v_ename VARCHAR2(100);
BEGIN
    SELECT employee_id, last_name
    INTO v_eid, v_ename
    -- SELECT > INTO ) ORA-00947: not enough values
    -- SELECT < INTO ) ORA-00913: too many values
    FROM employees
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || v_eid || ', 사원이름 : ' || v_ename);
END;
/

/*
    사원번호를 입력(치환변수)할 경우 해당
    사원의 이름과 입사일자를 출력하는 PL/SQL을 작성
    1) SQL문 확인 ) 출력 -> SELECT문
       입력 : 사원번호 -> 출력 : 사원의 이름, 입사일자
       
       SELECT 사원이름, 입사일자
       FROM employees
       WHERE 사원번호
       
    2) PL/SQL 블록 생성
*/
--1
DECLARE
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_dname departments.department_name%TYPE;
BEGIN
    SELECT e.employee_id, e.last_name, d.department_name 
    INTO v_eid, v_ename, v_dname
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || v_eid || ', 사원이름 : ' || v_ename || ', 부서이름 : ' || v_dname);
END;
/

SELECT last_name, hire_date
FROM employees
WHERE employee_id = &사원번호;

--2
DECLARE
    v_ename employees.last_name%TYPE;
    v_salary employees.salary%TYPE;
    v_year number(15, 2);

BEGIN
    SELECT last_name, salary, (salary*12+(nvl(salary,0)*nvl(commission_pct,0)*12))
    INTO v_ename, v_salary, v_year
    FROM employees
    WHERE employee_id = &사원번호;
    
    
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename || ', 급여 : ' || v_salary || ', 연봉 : ' || v_year);
END;
/
