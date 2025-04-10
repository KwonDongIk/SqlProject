--------------------------------------------------------------------------------
-- 명시적 커서 + 커서 FOR LOOP : 명시적 커서 단축방법
DECLARE
    -- 1. 커서 선언
    CURSOR 커서이름 IS
        SELECT
        FROM
BEGIN
    -- 2. 커서 제어 (OPEN, FETCH, CLOSE)
    FOR 임시변수 IN 커서이름 LOOP -- 암묵적으로 OPEN과 FETCH 실행
        -- 데이터가 존재하는 경우 수행할 작업
        -- 2-1) 임시변수는 RECORD 타입
        -- 2-2) 커서의 데이터가 없는 경우 실행불가
    END LOOP; -- 암묵적으로 CLOSE 실행
END;
/
--------------------------------------------------------------------------------
DECLARE
    -- 1) 커서 선언
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees
        WHERE department_id = &부서번호;
BEGIN
    -- 2) 커서 제어 .. 임시변수
    FOR emp_rec IN emp_cursor LOOP
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : ');
        -- emp_rec : RECORD 타입의 임시변수, 필드는 커서의 select절 컬럼이름
        DBMS_OUTPUT.PUT(emp_rec.employee_id);
        DBMS_OUTPUT.PUT(', ' || emp_rec.last_name);
        DBMS_OUTPUT.PUT_LINE(', ' || emp_rec.hire_date);    
    END LOOP;
END;
/
--------------------------------------------------------------------------------
/*
1.
사원(employees) 테이블에서
사원의 사원번호, 사원이름, 입사연도를 
다음 기준에 맞게 각각 test01, test02에 입력하시오.

입사년도가 2005년(포함) 이전 입사한 사원은 test01 테이블에 입력
입사년도가 2005년 이후 입사한 사원은 test02 테이블에 입력
*/
DECLARE
    CURSOR emp_cursor IS
    SELECT employee_id, last_name, hire_date
    FROM employees;
    
BEGIN
    FOR emp_ins IN emp_cursor LOOP
    -- emp_rec (employee_id, last_name, hire_date) => emp_rec.employee_id
    -- 2) 조건문 IF - else문
        IF TO_CHAR(emp_ins.hire_date, 'yyyy') <= '2005' THEN
            INSERT INTO test01(empid, ename, hiredate)
             VALUES (emp_ins.employee_id, emp_ins.last_name, emp_ins.hire_date);
             ELSE
             INSERT INTO test02(empid, ename, hiredate)
             VALUES (emp_ins.employee_id, emp_ins.last_name, emp_ins.hire_date); -- VALUES emp_ins; 도 가능함
        END IF;
    END LOOP;
END;
/
--------------------------------------------------------------------------------
/*
2.
부서번호를 입력할 경우(&치환변수 사용)
해당하는 부서의 사원이름, 입사일자, 부서명을 출력하시오.

입력 : 부서번호 / 출력 : 사원이름, 입사일자, 부서명 -> select문
SELECT 사원이름, 입사일자, 부서명
FROM employees (부서번호, 사원이름, 입사일자)
    JOIN departments(부서번호, 부서명)
    ON (employees.부서번호 = departments.부서번호)
WHERE employee.부서번호 -> 다중행 결과 / 명시적 커서

사원이름, 입사일자, 부서명 출력
*/
DECLARE
    CURSOR emp_cursor IS
    SELECT e.last_name, e.hire_date, d.department_name
    FROM employees e
        JOIN departments d 
        ON (d.department_id = e.department_id)
    WHERE e.department_id = &부서번호;
BEGIN
    FOR emp_sel IN emp_cursor LOOP
        DBMS_OUTPUT.PUT(emp_sel.last_name);
        DBMS_OUTPUT.PUT(', ' || TO_CHAR(emp_sel.hire_date, 'YYYY-MM-DD'));
        DBMS_OUTPUT.PUT_LINE(', ' || emp_sel.department_name);
    END LOOP;
END;
/
--------------------------------------------------------------------------------
/*
3.
부서번호를 입력(&사용)할 경우 
사원이름, 급여, 연봉->(급여*12+(급여*nvl(커미션퍼센트,0)*12))
을 출력하는  PL/SQL을 작성하시오.

입력 : 부서번호 / 출력 : 사원이름, 급여, 연봉 -> select문
SELECT 사원이름, 급여, 연봉
FROM employees( 부서번호, 사원이름, 급여 )
WHERE 부서번호 -> 다중행 결과 : 명시적커서                            --1)

연봉 계산해야되는거.. (급여*12+(급여*nvl(커미션퍼센트,0)*12))         --2)

사원이름, 급여, 연봉을 출력                                           --3)
*/
DECLARE
    CURSOR emp_cursor IS
    SELECT last_name, salary, commission_pct
    FROM employees
    WHERE department_id = &부서번호;
    
    v_annual NUMBER(15,2); -- 연봉
BEGIN
    FOR emp_sal IN emp_cursor LOOP
    -- emp_sal(last_name, salary, commision_pct)
    --2) 연봉계산
    v_annual := (emp_sal.salary*12+(emp_sal.salary*nvl(emp_sal.commission_pct,0)*12));
    
    DBMS_OUTPUT.PUT(emp_sal.last_name);
    DBMS_OUTPUT.PUT(', ' || emp_sal.salary);
    DBMS_OUTPUT.PUT_LINE(', ' || v_annual);
    END LOOP;
END;
/

DECLARE
    
BEGIN
    -- 실행
EXCEPTION
    -- 예외처리
    WHEN 예외이름 1 THEN
        예외가 발생했을 때 실행할 코드;
    WHEN 예외이름 2 OR 예외이름 3 THEN
        예외가 발생했을 때 실행할 코드;
    WHEN OTHERS THEN
        위에 선언되지 않은 예외가 발생한 경우 실행할 코드;
END;
/

-- 1) 예외유형 : 이미 오라클에 정의되어 있고 이름도 존재하는 예외
DECLARE
    v_ename employees.last_name%TYPE;
BEGIN
    SELECT last_name
    INTO v_ename
    FROM employees
    WHERE department_id = &부서번호;
    -- 부서번호 10 : 정상실행
    -- 부서번호 50 : T00_MANY_ROWS (ora-01422)
    -- 부서번호  0 : NO_DATA_FOUND (ora-01403)
    
     DBMS_OUTPUT.PUT_LINE(v_ename);
EXCEPTION
--    WHEN TOO_MANY_ROWS THEN -- WHEN 이름 기준으로
--        DBMS_OUTPUT.PUT_LINE('해당 부서에는 여러명의 사원이 존재합니다.');
--    WHEN NO_DATA_FOUND THEN
--        DBMS_OUTPUT.PUT_LINE('해당 부서에는 사원이 존재하지 않습니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('기타 예외가 발생했습니다.');
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM); -- insert문 사용할때는 못쓰고 변수를 사용해야함
END;
/
-- 2) 예외유형 : 이미 오라클에 정의되어 있지만 이름이 없는 예외
DECLARE
    -- 2-1) 예외이름 선언
    e_emps_remaining EXCEPTION;
    -- 2-2) 예외이름과 에러코드 연결
    PRAGMA EXCEPTION_INIT(e_emps_remaining, -02292);
BEGIN
    DELETE FROM departments
    WHERE department_id = &부서번호;
EXCEPTION
    WHEN e_emps_remaining THEN
        DBMS_OUTPUT.PUT_LINE('참조 데이터가 있습니다.');
END;
/
-- 3) 예외유형 : 사용자 정의 예외 -> 오라클 입장에선 정상 코드
DECLARE
    -- 3-1) 예외이름 선언
    e_dept_del_fail EXCEPTION;
BEGIN
    DELETE FROM departments
    WHERE department_id = 0;
    -- 3-2) 예외가 되는 상황을 설정
    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_dept_del_fail;
    END IF;
    DBMS_OUTPUT.PUT_LINE('정상적으로 삭제완료');
EXCEPTION
    WHEN e_dept_del_fail THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에는 존재하지 않습니다.');
        DBMS_OUTPUT.PUT_LINE('부서번호를 확인해주세요.');
END;
/

-- 사용자 정의 예외사항 VS 조건문
-- 해당 경우에 더이상 코드가 진행되면 안될 때 예외처리
DECLARE
    -- 3-1) 예외이름 선언
    e_dept_del_fail EXCEPTION;
BEGIN
    DELETE FROM departments
    WHERE department_id = 0;
    -- 3-2) 예외가 되는 상황을 설정
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서는 존재하지 않습니다.');
        DBMS_OUTPUT.PUT_LINE('부서번호를 확인해주세요.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('정상적으로 삭제되었습니다.');
END;
/

-- PROCEDURE : 독립된 기능을 구현하는 PL/SQL의 객체 중 하나
CREATE PROCEDURE test_pro_01
(p_msg IN VARCHAR2)
IS
-- DECLARE
    -- 선언부 : 변수, 커서, 예외
    v_msg VARCHAR2(1000) := 'Hello';

BEGIN
    DBMS_OUTPUT.PUT_LINE(v_msg || p_msg);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('데이터가 존재하지 않습니다.');
END;
/

-- 실행
DECLARE
    v_result VARCHAR2(1000);
BEGIN
    --v_result := test_pro_01('PL/SQL');
    -- 오라클은 프로시저와 함수를 호출하는 방식으로 구분
    -- => 프로시저를 호출할 때 왼쪽에 변수가 존재하면 안됨
    test_pro_01('PL/SQL');
END;
/

-- IN 모드 : 호출환경 -> 프로시저
DROP PROCEDURE raise_salary;
CREATE PROCEDURE raise_salary
(p_eid IN employees.employee_id%TYPE)
IS
    -- 선언부
BEGIN
    -- 실행부
    -- IN 모드 : 상수로 인식
    --p_eid := NVL(p_eid, 100);
    
    UPDATE employees
    SET salary = salary * 1.1
    WHERE employee_id = p_eid;
END;
/

DECLARE
    v_first NUMBER(3, 0) := 100;
    v_second CONSTANT NUMBER(3, 0) := 123;
    
BEGIN
    raise_salary(100);
    raise_salary((v_first+10));
    raise_salary(v_first);
    raise_salary(v_second);
END;
/

SELECT employee_id, salary
FROM employees
WHERE employee_id IN ( 100, 110, 123 );

-- OUT 모드 : 프로시저 -> 호출환경
CREATE PROCEDURE test_p_out
(p_num IN NUMBER,
p_out OUT NUMBER)
IS

BEGIN
    -- out 모드
    -- 1) 매개변수로 전달되는 값이 있어도 무조건 null로 값을 가정
    -- 2) out 모드의 매개변수가 가진 최종 값을 호출환경으로 반환
    DBMS_OUTPUT.PUT_LINE('IN : ' || p_num);
    DBMS_OUTPUT.PUT_LINE('OUT : ' || p_out);
END;
/

DECLARE
    v_result NUMBER(4,0) := 1234;
BEGIN
    DBMS_OUTPUT.PUT_LINE('1) result : ' || v_result);
    test_p_out(1000, v_result);
    DBMS_OUTPUT.PUT_LINE('2) result : ' || v_result);
END;
/

-- 더하기
CREATE PROCEDURE plus
(p_x IN NUMBER,
p_y IN NUMBER,
p_result OUT NUMBER)
IS

BEGIN
    p_result := (p_x + p_y);
    -- return (x + y);
END;
/

DECLARE
    v_total NUMBER(10,0);
BEGIN
    plus(10, 25, v_total);
    DBMS_OUTPUT.PUT_LINE(v_total);
END;
/

-- IN OUT 모드 : 호출환경 <-> 프로시저
-- '01012341234' => '010-1234-1234'
DROP PROCEDURE format_phone;
CREATE PROCEDURE format_phone
(p_phone_no IN OUT VARCHAR2)
IS

BEGIN
    --1) OUT 모드와 달리 호출환경에서 전달받은 값을 가질 수 있음
    DBMS_OUTPUT.PUT_LINE('before : ' || p_phone_no);
    --2) IN 모드와 달리 값을 변경할 수 있음
    p_phone_no := SUBSTR(p_phone_no, 1, 3)
        || '-' || SUBSTR(p_phone_no, 4, 4)
        || '-' || SUBSTR(p_phone_no, 8);
    --3) OUT 모드처럼 최종 값을 호출환경으로 반환
    DBMS_OUTPUT.PUT_LINE('after : ' || p_phone_no);
END;
/

DECLARE
    v_no VARCHAR2(100) := '01012341234';
BEGIN
    format_phone(v_no);
    DBMS_OUTPUT.PUT_LINE(v_no);
END;
/
--------------------------------------------------------------------------------
/*
프로시저, 매개변수(하나, 리터럴) in 모드
-> 내부에서 DBMS_OUTPUT.PUT_LINE 출력
'9501011667777' -> 950101-1******
*/
DROP PROCEDURE format_idnumber;
CREATE PROCEDURE format_idnumber
(p_id_no IN VARCHAR2)
IS
    v_result VARCHAR2(20); -- IN모드는 상수

BEGIN
	DBMS_OUTPUT.PUT_LINE('yedam_ju ' || p_id_no);
	v_result := SUBSTR(p_id_no, 1, 6)
	|| '-' || SUBSTR(p_id_no, 7, 1)
    || '******';
	DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

BEGIN
	format_idnumber('9501011667777');
END;
/
EXECUTE format_idnumber('9501011667777');

SELECT last_name, RPAD(last_name, 10, '-'), LPAD(last_name, 10, '-')
FROM employees;
--------------------------------------------------------------------------------
/*
2.
사원번호를 입력할 경우
삭제하는 TEST_PRO 프로시저를 생성하시오.
단, 해당사원이 없는 경우 "해당사원이 없습니다." 출력
예) EXECUTE TEST_PRO(176)
-- 프로시저, 매개변수 하나(리터럴) => IN 모드
-- 실제 기능 : DELETE, 조건 사원번호
*/
SET SERVEROUTPUT ON

-- 기능) DELETE문
--DELETE FROM employees
--WHERE employee_id = &사원번호;

-- 프로시저
DROP PROCEDURE test_pro;

CREATE PROCEDURE test_pro
(p_eid IN employees.employee_id%TYPE)
IS

BEGIN
    DELETE FROM employees
    WHERE employee_id = p_eid;
    -- DML의 결과를 확인 : 임시적커서의 ROWCOUNT 속성
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('해당사원이 없습니다.');
    END IF;
END;
/

EXECUTE TEST_PRO(0);
--------------------------------------------------------------------------------
-- 프로시저, 매개변수 하나 IN
-- 기능
-- 1) 입력 : 사원번호 -> 출력 : 사원이름(첫번째글자******)
-- SELECT문 사원이름
-- FROM employees
-- WHERE 사원번호

-- 2) 사원이름 -> 첫번째 글자 남기고 나머지는 전부 *****
-- 2-1) 첫번째 글자 남기고 SUBSTR(사원이름, 1, 1)
-- 2-2) 나머지를 알기위해 이름의 길이 확인) LENGTH(사원이름)
-- 2-3) 출력형태, 함수) RPAD(SUBSTR(사원이름, 1, 1), LENGTH(사원이름), '*')
-- 3) 결과 출력 -> 'TAYLOR -> T*****'
DROP PROCEDURE yedam_emp;
CREATE PROCEDURE yedam_emp
(p_name IN employees.last_name%TYPE)
IS
    v_ename employees.last_name%TYPE;
    v_result v_ename%TYPE;
BEGIN
         SELECT last_name
         FROM employees
         WHERE employee_id = 100;
    --2) 출력형태
        v_result := RPAD(SUBSTR(v_ename, 1, 1), LENGTH(v_ename), '*');
    
    --3) 결과출력
        DBMS_OUTPUT.PUT_LINE(v_ename || '->' || v_result);
END;
/
EXECUTE yedam_emp(100);
--------------------------------------------------------------------------------
SELECT (sysdate-hire_date) 몇일,
        (sysdate-hire_date)/30) 몇달,
        MONTHS_BETWEEN(sysdate, hire_date) 몇달
FROM employees
ORDER BY hire_date DESC;

-- 연차
-- 1) 일한 년도로써의 연차 : 1년부터 시작 / 예시 : 2년차
-- 2) 경력으로써의 연차 : 개월수부터 시작 / 예시 : 1년 9개월
SELECT employee_id
        , hire_date
        -- 총 개월수 : 실수이므로 소수점이하를 정리하는 함수를 추가로 사용해야 함
        , MONTHS_BETWEEN(sysdate, hire_date)
        -- 1) 일한 년도로써의 연차
        , CEIL(MONTHS_BETWEEN(sysdate, hire_date)/12) 년차
        -- 2) 경력으로써의 연차
        -- 년 = 총개월수/12의 몫
        , TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12) 년
        -- 개월 = 총개월수/12의 나머지
        , CEIL(MOD(MONTHS_BETWEEN(sysdate, hire_date),12)) 개월
FROM employees;
-- 기능) 입력 : 부서번호 -> 출력 : 사원번호, 사원이름, 연차
-- 1) SELECT문, 다중행 -> 명시적 커서 + 사원이 없을 경우 : 커서 FOR LOOP 사용불가
SELECT employee_id, last_name, hire_date
FROM employees
WHERE deparment_id = &부서번호;

-- 프로시저
CREATE PROCEDURE get_emp
(p_dept_id IN departments.department_id%TYPE)
IS
    
    CURSOR emp_dept_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees
        WHERE deparment_id = p_dept_id;
    v_emp_rec emp_dept_cursor%ROWTYPE;
    v_years NUMBER(2,0);
    --4. 사용자 정의 예외
    --4-1) 예외 선언
    e_no_search_emp EXCEPTION;
    
BEGIN
    
    OPEN emp_dept_cursor;
    LOOP
     
        -- 1-3) 데이터 인출
        FETCH emp_dept_cursor INTO v_emp_rec;
        EXIT WHEN emp_dept_cursor%NOTFOUND;
        
    
    v_years := CEIL(MONTHS_BETWEEN(sysdate, v_emp_rec.hire_date)/12);
   
    DBMS_OUTPUT.PUT(v_emp_rec.last_name);
    DBMS_OUTPUT.PUT(', ' || v_emp_rec.hire_date);
    DBMS_OUTPUT.PUT_LINE(', ' || v_years);
    
    END LOOP;
    -- 4-2) 예외가 발생하는 상황 설정
    -- LOOP문 밖에서 ROWCOUNT 속성 : 현재 커서의 총 행
    IF emp_dept_cursor%ROWCOUNT = 0 THEN
        -- 커서의 데이터가 없음을 의미
        RAISE e_no_search_emp;
    END IF;
    -- 1-4) 커서 종료
    CLOSE emp_dept_cursor;
EXCEPTION
    -- 4-3) 예외가 발생할 경우 수행할 작업
    WHEN e_no_search_emp THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에는 사원이 없습니다.');
        CLOSE emp_dept_cursor;
END;
/

/*
5.
직원들의 사번, 급여 증가치만 입력하면 Employees테이블에 쉽게 사원의 급여를 갱신할 수 있는 y_update 프로시저를 작성하세요. 
만약 입력한 사원이 없는 경우에는 ‘No search employee!!’라는 메시지를 출력하세요.(예외처리)
실행) EXECUTE y_update(200, 10)
*/

-- 실제 프로시저가 수행하고자 하는 코드
UPDATE employees
SET salary = salary + (salary * (10/100))
WHERE employee_id = 200;

-- 프로시저
DROP PROCEDURE y_update;
CREATE PROCEDURE y_update
(p_eid IN employees.employee_id%TYPE, p_raise IN NUMBER)
IS
    e_no_emp EXCEPTION;
BEGIN
    UPDATE employees
    SET salary = salary + (salary * (p_raise/100))
    WHERE employee_id = p_eid;
    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_no_emp;
    END IF;
    EXCEPTION
        WHEN e_no_emp THEN
            DBMS_OUTPUT.PUT_LINE('No search employee!!');
END;
/
EXECUTE y_update(206, 10);

-- FUNCTION : 독립된 기능을 구현하는 PL/SQL 객체 중의 하나
--            내부에서 DML 사용하지 않고 RETURN 타입이 NUMBER, VARCHAR, DATE일 경우
--            SQL(SELECT, INSERT, UPDATE, DELETE)문에서 사용가능
DROP FUNCTION test_func;
CREATE FUNCTION test_func
(p_msg VARCHAR2)  -- 무조건 IN 모드
RETURN VARCHAR2
IS
    -- 선언부 : 변수, 커서, 레코드타입, 예외 등 선언
    v_msg VARCHAR2(1000) := 'Hello! ';
BEGIN
    RETURN (v_msg || p_msg);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN '데이터가 존재하지 않습니다.';
END;
/

-- 실행방법
DECLARE
    v_result VARCHAR2(1000);
BEGIN
    v_result := test_func('PL/SQL');
    -- 오라클은 프로시저와 함수를 호출하는 방식으로 구분
    -- => 함수를 호출할 때 왼쪽에 변수가 반드시 필요
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

-- SQL 문에서 사용
SELECT test_func('PL/SQL')
FROM dual; -- 오라클이 만들어둔 더미테이블 select 할때만

-- 더하기
CREATE FUNCTION y_sum
(p_x NUMBER,
p_y NUMBER)
RETURN NUMBER -- RETURN 문에서 반환할 값의 데이터타입
IS

BEGIN
    RETURN (p_x + p_y);
    -- return ( x + y );
END;
/

SELECT y_sum(10, 25)
FROM dual;

-- 해당사원의 직속상사 이름을 출력 : 동일한 테이블을 기반으로 셀프 조인
SELECT emp.employee_id, emp.last_name, mgr.last_name
    FROM employees emp
        JOIN employees mgr
        ON emp.manager_id = mgr.employee_id;
DROP FUNCTION get_mgr;
CREATE FUNCTION get_mgr
(p_eid employees.employee_id%TYPE)
RETURN VARCHAR2
IS
v_mgr_name employees.last_name%TYPE;
BEGIN
    SELECT mgr.last_name
    INTO v_mgr_name
    FROM employees emp
        JOIN employees mgr
        ON emp.manager_id = mgr.employee_id
    WHERE emp.employee_id = p_eid;
    
    RETURN v_mgr_name;
END;
/

SELECT employee_id, last_name, get_mgr(employee_id)
FROM employees;
--------------------------------------------------------------------------------
/*
1.
사원번호를 입력하면 
last_name + first_name 이 출력되는 
y_yedam 함수를 생성하시오.
=> 함수, 매개변수 1개(employees.employee_id) : 결과, full name
- select문 필요
SELECT (last_name || first_name -- full name)
FROM employees
WHERE employee_id = 174;

실행) EXECUTE DBMS_OUTPUT.PUT_LINE(y_yedam(174))
출력 예)  Abel Ellen

SELECT employee_id, y_yedam(employee_id)
FROM   employees;
*/
DROP FUNCTION y_yedam;
CREATE FUNCTION y_yedam
(p_id NUMBER)
RETURN VARCHAR2 -- 함수를 실행한 결과, 이름(문자)
IS
v_lname VARCHAR2(30);
v_fname VARCHAR2(30);

BEGIN
	SELECT last_name, first_name -- full name
	INTO v_lname, v_fname -- 별도 선언 필요
	FROM employees
	WHERE employee_id = p_id;
	
	RETURN v_lname || ' ' || v_fname;
END;
/

EXECUTE DBMS_OUTPUT.PUT_LINE(y_yedam(174));
--------------------------------------------------------------------------------
/*
2.
사원번호를 입력할 경우 다음 조건을 만족하는 결과가 출력되는 ydinc 함수를 생성하시오.
- 급여가 5000 이하이면 20% 인상된 급여 출력
- 급여가 10000 이하이면 15% 인상된 급여 출력
- 급여가 20000 이하이면 10% 인상된 급여 출력
- 급여가 20000 초과이면 급여 그대로 출력
실행) SELECT last_name, salary, YDINC(employee_id)
     FROM   employees; 
1) 입력 : 사원번호 ->  인상된 급여 => SELECT문
SELECT 급여
FROM employees
WHERE 사원번호 

2) 다중 조건문
IF 급여가  5000이하 THEN
    20% 인상된 급여
ELSIF 급여가 10000이하 THEN
    15% 인상된 급여
ELSIF 급여가 15000이하 THEN
    10% 인상된 급여
ELSIF 급여가 15001이상 THEN -- 15000 초과 + 최대치가 없음 => ELSE
    급여 인상없음
    
3) 인상된 급여 계산
급여 * 인상율

4) 반환 : 인상된 급여
*/
CREATE FUNCTION ydinc
(p_eid employees.employee_id%TYPE)
RETURN NUMBER
IS
-- DECLARE
    -- v_ename  employees.last_name%TYPE;
    v_sal    employees.salary%TYPE;
    v_raise  NUMBER(4, 2);
    v_new    v_sal%TYPE;
BEGIN
    -- 1) SELECT문
    SELECT salary
    INTO  v_sal
    FROM employees
    WHERE employee_id = p_eid; 

    -- 2) 다중 조건문
    IF v_sal <= 5000 THEN
        v_raise := 20;
    ELSIF v_sal <= 10000 THEN
        v_raise := 15;
    ELSIF v_sal <= 15000 THEN
        v_raise := 10;
    ELSE
        v_raise := 0;
    END IF;
    
    -- 3) 인상된 급여 계산
    v_new := v_sal + (v_sal * v_raise/100);

    -- 4) 반환 : 인상된 급여
    RETURN v_new;
END;
/
SELECT last_name, salary, YDINC(employee_id)
     FROM   employees;
--------------------------------------------------------------------------------
--시험
DECLARE
    v_dname departments.department_name%TYPE;
    v_jid employees.job_id%TYPE;
    v_salary employees.salary%TYPE;
    v_year number(15,2);
BEGIN
    SELECT d.department_name, e.job_id, e.salary, (salary*12+(nvl(salary,0)*nvl(commission_pct,0)*12))
    INTO v_dname, v_jid, v_salary, v_year
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('부서이름 : ' || v_dname || ', 직업 : ' || v_jid || ', 급여 : ' || v_salary || ', 연간 총수입 : ' || v_year );
END;
/
--------------------------------------------------------------------------------
DECLARE
    v_hiredate employees.hire_date%TYPE;
    v_msg VARCHAR(100);
BEGIN
    SELECT hire_date
    INTO v_hiredate
    FROM employees
    WHERE employee_id = &사원번호;
    
    IF TO_CHAR(v_hiredate, 'yyyy') > '2005' THEN
        v_msg := 'New employee';
    ELSE
        v_msg := 'Career employee';
    END IF;
        
    DBMS_OUTPUT.PUT_LINE(v_msg);
END;
/
--------------------------------------------------------------------------------
DECLARE
    v_num NUMBER(2,0);
    v_cnt NUMBER(2,0);
BEGIN
    FOR v_cnt IN 1 .. 9 LOOP
        FOR v_num IN 1 .. 9 LOOP
        IF(MOD(v_num, 2) = 1) THEN
            DBMS_OUTPUT.PUT(v_num || '*' || v_cnt || '=' || (v_num * v_cnt));
            DBMS_OUTPUT.PUT(' ');
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/
--------------------------------------------------------------------------------
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, salary
        FROM employees
        WHERE department_id = &부서번호;
        
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_salary employees.salary%TYPE;
    
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO v_eid, v_ename, v_salary;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT(v_eid);
        DBMS_OUTPUT.PUT(', ' || v_ename);
        DBMS_OUTPUT.PUT_LINE(', ' || v_salary);
    END LOOP;
    CLOSE emp_cursor;
END;
/



select name, text
from user_source
where 
type in ('procedure', 'function', 'package', 'package body');


DECLARE
    v_num number := 1;
    v_space VARCHAR2(20) := '    ';
    v_star VARCHAR2(20) := '*';
BEGIN
    LOOP
    DBMS_OUTPUT.PUT_LINE(v_space || v_star);
    v_star := v_star || '*';
    v_num := v_num + 1;
    EXIT WHEN v_num > 5;
    END LOOP;
END;
/

CREATE FUNCTION id_func(p_eid employees.employee_id%TYPE)
RETURN NUMBER
IS
v_years NUMBER;
BEGIN
	SELECT TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12)
	INTO v_years
	FROM employees
	WHERE employee_id = p_eid;
	RETURN v_years;
END;
/

EXECUTE DBMS_OUTPUT.PUT_LINE(id_func(100));