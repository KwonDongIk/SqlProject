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
