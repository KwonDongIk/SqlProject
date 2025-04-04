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






