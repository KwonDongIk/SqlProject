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


SET SERVEROUTPUT ON
    
DECLARE
    v_number NUMBER(2,0) := 13;
BEGIN
    IF MOD(v_number, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다.');
    END IF;

END;
/

-- IF-THEN-ELSE ( IF-ELSE문 )
-- 해당 조건식이 true인 경우와 false인 경우 동시 처리
-- 문법
--IF 조건식 THEN
--    조건식이 true인 경우 수행할 명령어;
--ELSE
--    위의 모든 조건식들이 false인 경우 수행할 명령어
--END IF;

DECLARE
    V_NUMBER NUMBER := 14;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수 입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 짝수 입니다.');
    END IF;
END;
/

DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    IF V_SCORE >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A학점');
    ELSIF V_SCORE >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B학점');
    ELSIF V_SCORE >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C학점');
    ELSIF V_SCORE >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('D학점');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F학점');
    END IF;
END;
/

-- 문제
-- 3) 사원번호 입력 -> 입사일 출력
DECLARE
    v_hiredate employees.hire_date%TYPE;
    v_msg VARCHAR(100);
BEGIN
    SELECT hire_date
    INTO v_hiredate
    FROM employees
    WHERE employee_id = &사원번호;
    
    --IF v_hiredate >= TO_DATE('20050101', 'yyyyMMdd') THEN
    IF TO_CHAR(v_hiredate, 'yyyy') >= '2005' THEN
        v_msg := 'New employee';
    ELSE
        v_msg := 'Career employee';
    END IF;
        
    DBMS_OUTPUT.PUT_LINE(v_msg);
END;
/

-- 4) 테이블 입력
create table test01(empid, ename, hiredate)
as
  select employee_id, last_name, hire_date
  from   employees
  where  employee_id = 0;

create table test02(empid, ename, hiredate)
as
  select employee_id, last_name, hire_date
  from   employees
  where  employee_id = 0;
--
DECLARE
    v_eid employees.employee_id%TYPE;
    v_name employees.last_name%TYPE;
    v_hiredate employees.hire_date%TYPE;
BEGIN
    SELECT employee_id, last_name, hire_date
    INTO v_eid, v_name, v_hiredate
    FROM employees
    WHERE employee_id = &사원번호;
    
    --IF v_hiredate >= TO_DATE('20050101', 'yyyyMMdd') THEN
    IF TO_CHAR(v_hiredate, 'yyyy') >= '2005' THEN
        INSERT INTO test01(empid, ename, hiredate)
        VALUES (v_eid, v_name, v_hiredate);
    ELSE
        INSERT INTO test02(empid, ename, hiredate)
        VALUES (v_eid, v_name, v_hiredate);
    END IF;
        
END;
/
select * from test02;
--5)
DECLARE
    v_name employees.first_name;    
    
    
BEGIN
    SELECT last_name, salary
    INTO v_name, v_sal
    FROM employees
    WHERE employee_id = &사원번호;

END;
/
--------------------------------------------------------------------------------
DECLARE
    v_num number := 1;
    v_star VARCHAR2(20) := '*';
BEGIN
    LOOP
    DBMS_OUTPUT.PUT_LINE(v_star);
    v_star := v_star || '*';
    v_num := v_num + 1;
    EXIT WHEN v_num > 5;
    END LOOP;
END;
/
--------------------------------------------------------------------------------
DECLARE
    v_num number := 2;
    v_cnt number := 1;
BEGIN
    LOOP
    DBMS_OUTPUT.PUT_LINE(v_num || '단');
    v_cnt := 1;
        LOOP
            DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_cnt || '=' || (v_num * v_cnt));
            v_cnt := v_cnt + 1;
        EXIT WHEN v_cnt > 9;
        END LOOP;
    v_num := v_num + 1;
    EXIT WHEN v_num > 9;
    END LOOP;
END;
/
--------------------------------------------------------------------------------
--For loop문 : 횟수를 기준으로 반복
--문법
--FOR 임시변수 IN 최소값 .. 최대값 LOOP
--    -- 임시변수, 최소값, 최대값은 전부 정수 타입
--    반복 수행 작업;
--END LOOP;

--예시
BEGIN
    FOR idx IN 1 .. 5 LOOP
        DBMS_OUTPUT.PUT_LINE('임시변수 idx : ' || idx);
    END LOOP;
END;
/

--주의사항 1) 임시변수는 수정불가
BEGIN
    FOR idx IN 1 .. 5 LOOP
        idx := idx + 1;
    END LOOP;
END;
/

--주의사항 2) 최소값 보다 항상 최대값이 같거나 커야한다.
--reverse : 역순으로 값을 가져올 때 사용
BEGIN
    FOR idx IN REVERSE 5 .. 1 LOOP
        DBMS_OUTPUT.PUT_LINE(idx);
    END LOOP;
END;
/

--정수 1~10까지 총합
--(1, 2, 3, 4, 5, 6, 7, 8, 9 10) => LOOP문
DECLARE
    v_sum NUMBER(2,0) := 0; -- 총합
BEGIN
    FOR num IN 1 .. 10 LOOP
        v_sum := v_sum + num;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
END;
/
--------------------------------------------------------------------------------
DECLARE
    v_star VARCHAR2(20) := '';
BEGIN
    FOR num IN 1 .. 5 LOOP
    v_star := v_star || '*';
    DBMS_OUTPUT.PUT_LINE(v_star);
    END LOOP;
END;
/
--------------------------------------------------------------------------------
DECLARE
    v_num NUMBER(2,0); -- 몇단일까요?
    v_cnt NUMBER(2,0); -- 곱
BEGIN
    FOR v_cnt IN 1 .. 9 LOOP
        FOR v_num IN 2 .. 9 LOOP
            DBMS_OUTPUT.PUT(v_num || '*' || v_cnt || '=' || (v_num * v_cnt));
            DBMS_OUTPUT.PUT('                ');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/
--------------------------------------------------------------------------------
DECLARE
    v_num NUMBER(2,0); -- 몇단일까요?
    v_cnt NUMBER(2,0); -- 곱
BEGIN
    FOR v_cnt IN 1 .. 9 LOOP
        FOR v_num IN 1 .. 9 LOOP
        IF(MOD(v_num, 2) = 1) THEN
            DBMS_OUTPUT.PUT(v_num || '*' || v_cnt || '=' || (v_num * v_cnt));
            DBMS_OUTPUT.PUT('                ');
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/
--------------------------------------------------------------------------------
DECLARE
    v_num NUMBER(2,0); -- 몇단일까요?
    v_cnt NUMBER(2,0); -- 곱
BEGIN
   FOR v_num IN 1 .. 9 LOOP
   IF(MOD(v_num, 2) = 1) THEN
        FOR v_cnt IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT(v_num || '*' || v_cnt || '=' || (v_num * v_cnt));
            DBMS_OUTPUT.PUT('                ');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        END IF;
    END LOOP;
END;
/
--------------------------------------------------------------------------------
DECLARE
    -- 1) TYPE 정의
    TYPE 레코드타입이름 IS RECORD
        (필드명1 데이터타입,
        필드명2 데이터타입 NOT NULL DEFAULT 초기값,
        필드명3 데이터타입 := 초기값,
        ...);
    -- 2) 변수 선언
    변수명 레코드타입이름;
BEGIN
    -- 3) 실제사용 : 변수명.필드명
    변수명.필드명1 := 값;
    DBMS_OUTPUT.PUT_LINE(변수명.필드명2);
END;
/
--------------------------------------------------------------------------------
-- 예시 : 회원정보를 하나의 변수로 다룸
DECLARE
    -- 회원정보(아이디, 이름, 가입일자)를 의미
    -- 1) RECORD 정의
    TYPE user_record_type IS RECORD
        (user_id NUMBER(6,0),
         user_name VARCHAR2(100) := '익명',
         join_date DATE NOT NULL DEFAULT SYSDATE);
    -- 2) 변수 선언
    first_user user_record_type;
    new_user user_record_type;

BEGIN
    -- 3) 실제 사용 : 변수명.필드명
    -- DBMS_OUTPUT.PUT_LINE(first_user);
    DBMS_OUTPUT.PUT_LINE(first_user.user_id);
    DBMS_OUTPUT.PUT_LINE(first_user.user_name);
    DBMS_OUTPUT.PUT_LINE(first_user.join_date);

END;
/
-- 특정 사원의 사원번호, 사원이름, 급여를 출력하세요.
DECLARE
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_sal employees.salary%TYPE;
    
    v_new_eid employees.employee_id%TYPE;
    v_new_ename employees.last_name%TYPE;
    v_new_sal employees.salary%TYPE;
BEGIN
    SELECT employee_id, last_name, salary
    INTO v_eid, v_ename, v_sal
    FROM employees
    WHERE employee_id = 100;
    
    SELECT employee_id, last_name, salary
    INTO v_new_eid, v_new_ename, v_new_sal
    FROM employees
    WHERE employee_id = 200;
END;
/
--------------------------------------------------------------------------------
-- Record 적용
DECLARE
    -- 1) TYPE 정의
    TYPE emp_record_type IS RECORD
        (empno NUMBER(6,0),
        ename employees.last_name%TYPE NOT NULL := 'Hong',
        sal employees.salary%TYPE := 0);
    -- 2) 
    v_emp_info emp_record_type;
    v_emp_record emp_record_type;
BEGIN
    -- 변수 사용
    SELECT employee_id, last_name, salary
    -- INTO v_eid, v_ename, v_sal
    INTO v_emp_info
    -- 무조건 RECORD 타입 변수 하나만 사용
    FROM employees
    WHERE employee_id = 100;
    
    SELECT employee_id, last_name, salary
    -- INTO v_new_eid, v_new_ename, v_new_sal
    INTO v_emp_record
    -- emp_record_type (empno, ename, sal)
    FROM employees
    WHERE employee_id = 200;
    
    -- 사원번호 100
    DBMS_OUTPUT.PUT(v_emp_info.empno);
    DBMS_OUTPUT.PUT(', ' || v_emp_info.ename);
    DBMS_OUTPUT.PUT_LINE(', ' || v_emp_info.sal);
    -- 사원번호 200
    DBMS_OUTPUT.PUT(v_emp_record.empno);
    DBMS_OUTPUT.PUT(', ' || v_emp_record.ename);
    DBMS_OUTPUT.PUT_LINE(', ' || v_emp_record.sal);
END;
/
--------------------------------------------------------------------------------
-- %ROWTYPE
-- 테이블, view, 명시적 커서의 한행을 RECORD 타입으로 참조하도록 사용
-- 1) 필드명 따로 지정 불가, 참조하는 테이블의 컬럼명과 동일한 필드명 사용
-- 2) select할 때 사용 시 반드시 해당 테이블의 모든 컬럼을 선언 => * 사용
DECLARE
    -- 1) TYPE 정의 -> 생략
    -- 2) 변수 선언
    v_emp_info employees%ROWTYPE;
BEGIN
    -- 3) 변수 사용
    SELECT *
    INTO v_emp_info
    FROM employees
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.PUT_LINE(v_emp_info.employee_id);
    DBMS_OUTPUT.PUT_LINE(v_emp_info.last_name);
    DBMS_OUTPUT.PUT_LINE(v_emp_info.salary);
END;
/
--------------------------------------------------------------------------------
-- 명시적 커서
-- 예시
DECLARE
    CURSOR test_cursor IS
        SELECT employee_id, last_name
        FROM employees;
        
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
BEGIN
    OPEN test_cursor;
    
    FETCH test_cursor INTO v_eid, v_ename;
    DBMS_OUTPUT.PUT_LINE(v_eid);
    DBMS_OUTPUT.PUT_LINE(v_ename);
    
    CLOSE test_cursor;
    
END;
/
--------------------------------------------------------------------------------
-- 1) 목적 : 다중 행 SELECT문을 사용
DECLARE
    -- 1. 커서 정의 => 실행 X
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees
        WHERE department_id = &부서번호;
    -- 부서번호 50 :
    -- 부서번호  0 :
    
    -- 값을 담을 변수 선언
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    -- 2. 커서 실행
    -- 2-1. 실제 select문을 실행
    -- 2-2. 포인터의 위치를 가장 위로 배치
    OPEN emp_cursor;
    -- 3. 데이터 확인 및 반환 => 1건의 데이터만
    -- 3-1. 포인터를 밑으로 이동
    -- 3-2. 현재 포인터가 가리키는 한 행을 반환
    LOOP
        FETCH emp_cursor INTO v_eid, v_ename, v_hdate;
        -- FETCH를 기반으로 가져온 데이터가 새로운 데이터가 아닌경우
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- 1) LOOP문 안에선 현재 가지고 온 행의 갯수, 유동적
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : ');
        -- 가져온 데이터를 기반으로 작업
        DBMS_OUTPUT.PUT(v_eid);
        DBMS_OUTPUT.PUT(', ' || v_ename);
        DBMS_OUTPUT.PUT_LINE(', ' || v_hdate);
    END LOOP; -- 커서가 가진 모든 데이터를 가져온 상황
    
    -- 2) LOOP문 바깥에선 커서가 가지고 있는 총 데이터의 갯수, 고정적
    
    DBMS_OUTPUT.PUT_LINE('LOOP 종료 : ' || emp_cursor%ROWCOUNT);
    -- 4. 커서 종료
    -- 4-1. 메모리에서 결과를 삭제
    CLOSE emp_cursor;
END;
/

-- 사용방법 정리
DECLARE
    CURSOR 커서명 IS
        커서가 실행할 SELECT문
BEGIN  
    --2) 커서 실행
    OPEN 커서명;
    
    LOOP
        --3) 데이터 확인 및 반환
        FETCH 커서명 INTO 값을 담을 변수들;
        EXIT WHEN 커서명%NOTFOUND;
        
    END LOOP;
    -- 커서명 %ROWCOUNT : 커서가 가진 총 행수, 고정값
    --4) 커서 종료
    CLOSE 커서명;
    -- CLOSE 후 %ISOPEN을 제외한 속성에 접근 불가
END;
/
--------------------------------------------------------------------------------
/*
특정 업무를 수행하는 사원의 정보를 출력하세요.
출력할 사원의 정보는 사원번호, 사원이름, 입사일자
1) 출력 : SELET문, 다중행 => 명시적 커서
2) 입력 : 특정업무(job_id) => 출력 : 사원번호, 사원이름, 입사일자
단, 해당업무를 수행하는 사원이 없는 경우
'해당사원이 없습니다.'
*/
-- SELECT문
SELECT employee_id, last_name, hire_date
FROM employees
WHERE job_id LIKE UPPER('&업무%');

-- 명시적 커서
DECLARE
    -- 1) 커서 선언
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees
        WHERE job_id LIKE UPPER('&업무%');
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    -- 2) 커서 실행
    OPEN emp_cursor;
    LOOP
    
    -- 3) 데이터 인출 및 확인
        FETCH emp_cursor INTO v_eid, v_ename, v_hdate;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- 데이터가 존재하는 경우 실행할 직업
        DBMS_OUTPUT.PUT(v_eid);
        DBMS_OUTPUT.PUT(', ' || v_ename);
        DBMS_OUTPUT.PUT_LINE(', ' || v_hdate);
    END LOOP; -- 커서의 데이터를 다 가져온 상황
    
    IF emp_cursor%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원이 없습니다.');
    END IF;
    
    -- 4) 커서 종료
    CLOSE emp_cursor;
END;
/
--------------------------------------------------------------------------------
SELECT employee_id, last_name, hire_date
FROM employees;
--------------------------------------------------------------------------------
/*
1.
사원(employees) 테이블에서
사원의 사원번호, 사원이름, 입사연도를 
다음 기준에 맞게 각각 test01, test02에 입력하시오.
=> SELECT문, employees 전체조회
입사년도가 2005년(포함) 이전 입사한 사원은 test01 테이블에 입력
입사년도가 2005년 이후 입사한 사원은 test02 테이블에 입력
=> 조건문 if-else문
*/

DECLARE
	CURSOR emp_cursor IS
		SELECT employee_id, last_name, hire_date
		FROM employees;
	v_eid employees.employee_id%TYPE;
	v_ename employees.last_name%TYPE;
	v_hdate employees.hire_date%TYPE;
BEGIN
	OPEN emp_cursor;
	LOOP
		FETCH emp_cursor INTO v_eid, v_ename, v_hdate;
		EXIT WHEN emp_cursor%NOTFOUND;

        IF TO_CHAR(v_hdate, 'yyyy') <= '2005' THEN
             INSERT INTO test01(empid, ename, hiredate)
             VALUES (v_eid, v_ename, v_hdate);
             ELSE
             INSERT INTO test02(empid, ename, hiredate)
             VALUES (v_eid, v_ename, v_hdate);
        END IF;
	END LOOP;

	CLOSE emp_cursor;
END;
/

DELETE FROM TEST01;
DELETE FROM TEST02;

/*
2.
부서번호를 입력할 경우(&치환변수 사용)
해당하는 부서의 사원이름, 입사일자, 부서명을 출력하시오.
*/
DECLARE
	CURSOR ep_cursor IS
		SELECT e.employee_id, e.hire_date, d.department_name
		FROM employees e
			JOIN departments d ON (d.department_id = e.department_id)
		WHERE e.department_id = &부서번호;
	v_ename employees.last_name%TYPE;
	v_hdate employees.hire_date%TYPE;
	v_dname departments.department_name%TYPE;
BEGIN
	OPEN ep_cursor;
	LOOP
		FETCH ep_cursor INTO v_ename, v_hdate, v_dname;
		EXIT WHEN ep_cursor%NOTFOUND;
	DBMS_OUTPUT.PUT(v_ename);
	DBMS_OUTPUT.PUT(', ' || TO_CHAR(v_hdate, 'YYYY-MM-DD'));
   	DBMS_OUTPUT.PUT_LINE(', ' || v_dname);
	END LOOP;
	
	CLOSE ep_cursor;
END;
/
--------------------------------------------------------------------------------
/*
3.
부서번호를 입력(&사용)할 경우 
사원이름, 급여, 연봉->(급여*12+(급여*nvl(커미션퍼센트,0)*12))
을 출력하는  PL/SQL을 작성하시오.
*/
--------------------------------------------------------------------------------
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, salary
        FROM employees;
BEGIN
    FOR emp_info IN emp_cursor LOOP
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : ');
        DBMS_OUTPUT.PUT(emp_info.employee_id);
        DBMS_OUTPUT.PUT(', ' || emp_info.last_name);
        DBMS_OUTPUT.PUT_LINE(', ' || emp_info.salary);
    END LOOP; -- => close 암묵적 close 실행
END;
/
