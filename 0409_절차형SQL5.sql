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
    v_second CONSTANT NUMBER(3, 0) := 149;
    
BEGIN
    raise_salary(100);
    raise_salary((v_first+10));
    raise_salary(v_first);
    raise_salary(v_second);
END;
/

SELECT employee_id, salary
FROM employees
WHERE employee_id IN ( 100, 110, 149 );

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
	p_id_no := SUBSTR(p_id_no, 1, 6)
	|| '-' || SUBSTR(p_id_no, 7, 1)
    || '******';
	DBMS_OUTPUT.PUT_LINE(p_id_no);
END;
/

DECLARE
	v_id VARCHAR2(100) := '9501011667777';
BEGIN
	format_idnumber(v_id);
	DBMS_OUTPUT.PUT_LINE(v_id);
END;
/