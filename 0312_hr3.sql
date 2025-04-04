SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM countries;
SELECT * FROM regions;

SELECT employee_id, job_id FROM employees;

SELECT * FROM employees;
SELECT * FROM employees;

SELECT DISTINCT job_id FROM employees;


SELECT employee_id, first_name, salary, salary * 12 + (salary * commission_pct) as 연봉 FROM employees;

SELECT DISTINCT department_id FROM employees;

SELECT * FROM departments;

SELECT first_name||' '||last_name, job_id FROM employees WHERE department_id = '50';
SELECT first_name||' '||last_name, job_id, employee_id, salary FROM employees WHERE salary > 10000;

SELECT employee_id, first_name||' '||last_name as fullname, job_id FROM employees WHERE salary BETWEEN 1500 AND 2500;


SELECT employee_id, first_name, salary, department_id FROM employees WHERE salary >= 5000 and department_id in (30, 50, 90);

SELECT first_name, salary * 12 as 연봉, salary FROM employees WHERE first_name LIKE '%t';

SELECT employee_id, first_name, department_id, salary, hire_date FROM employees WHERE job_id LIKE '%\_%' ESCAPE '\';

SELECT * FROM employees WHERE commission_pct is null;

SELECT * FROM employees WHERE commission_pct is null ORDER BY job_id, salary desc;

-- 직무별로 오름차순, 급여별로 내림차순 정렬

-- 조회필드 : 사번, 이름, 부서코드, 급여, 연봉
-- 부서별로 오름차순, 연봉이 높은 순서대로 표시

SELECT employee_id, first_name, department_id, salary, (salary * 12) as 연봉 FROM employees ORDER BY department_id asc, 연봉 desc;



-- 1) 사원 테이블에서 사원번호와 이름과 월급 조회.
SELECT employee_id, first_name, salary FROM employees;

-- 2) 사원 테이블의 모든 컬럼 조회.
SELECT * FROM employees;

-- 3) 사원 테이블의 사원번호와 이름, 월급 조회. 컬럼명을 한글로 '사원 번호', '사원 이름'으로 조회.
SELECT employee_id as 사원번호, first_name as 사원이름, salary FROM employees;

-- 4) 사원 테이블의 이름과 월급을 이용하여 다음과 같이 조회. -- - 출력예제 ) 사원 이름이 Steven 이고 월급이 30000일 경우, 'Steven 의 월급은 30000 달러입니다.'
SELECT first_name, salary FROM employees WHERE first_name = 'Steven' and salary = 30000;

-- 5) 사원 테이블에서 중복된 데이터를 제외한 직무 조회.
SELECT DISTINCT department_id FROM employees;

-- 6) 모든 사원의 이름과 월급 조회. 월급이 낮은 사원부터 출력.
SELECT first_name, salary FROM employees ORDER BY salary;

-- 7) 모든 사원 중 월급이 3000인 사원들의 이름, 월급, 직무를 조회.
SELECT first_name, salary, job_id FROM employees WHERE salary = 3000;

-- 8) 이름이 'Steven'인 사원의 이름, 월급, 직무, 입사일, 부서번호 조회.
SELECT first_name, salary, job_id, hire_date, department_id FROM employees WHERE first_name = 'Steven';

-- 9) 연봉이 36000이상인 사원들의 이름과 연봉을 조회. -- - 연봉은 월급에 수당을 더하고 12를 곱해서 구한다. 
-- - 수당은 월급에 커미션을 곱해서 구한다. -- - NVL(필드명,0) => 필드명이 null이면 0으로 처리
SELECT first_name, (salary + (salary * NVL(commission_pct, 0))) * 12 as 연봉 FROM employees WHERE (salary + (salary * NVL(commission_pct, 0))) * 12 >= 36000 ORDER BY (salary + (salary * NVL(commission_pct, 0))) * 12;

-- 10) 월급이 12000이하인 사원들의 이름과, 월급, 직무, 부서번호를 조회.
SELECT first_name, salary, job_id, department_id FROM employees WHERE salary >= 12000;

-- 11) 직무가 'SA_MAN'이 아닌 사원들의 이름과 부서번호, 직무를 조회.
SELECT first_name, department_id, job_id FROM employees WHERE not job_id = 'SA_MAN';

-- 12) 월급이 1000에서 3000사이인 사원들의 이름과 월급을 조회.
SELECT first_name, salary FROM employees WHERE salary between 1000 and 3000;

-- 13) 월급이 1000에서 3000사이가 아닌 사원들의 이름과 월급을 조회.
SELECT first_name, salary FROM employees WHERE salary NOT between 1000 and 3000;

-- 14) 2006년도에 입사한 사원들의 이름과 입사일 조회.
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '06%';

-- 15) 이름의 첫 글자가 S, s로 시작하는 사원들의 이름과 월급을 조회.
SELECT first_name, salary FROM employees WHERE first_name LIKE 'S%' or first_name LIKE 's%';

-- 16) 이름의 끝 글자가 t, T로 끝나는 사원들의 이름과 월급을 조회.
SELECT first_name, salary FROM employees WHERE first_name LIKE '%T' or first_name LIKE '%t';

-- 17) 이름의 두 번째 철자가 m, M 인 사원의 이름과 월급을 조회.
SELECT first_name, salary FROM employees WHERE first_name LIKE '_M%' or first_name LIKE '_m%';

-- 18) 이름에 A, a를 포함하고 있는 사원들의 이름을 조회.
SELECT first_name FROM employees WHERE first_name LIKE '%a%' or first_name LIKE '%A%';

-- 19) 커미션이 NULL인 사원들의 이름과 커미션을 조회.
SELECT first_name, commission_pct FROM employees WHERE commission_pct IS NULL;

-- 20) 직무가 'SA_MAN', 'PU_CLERK', 'IT_PROG' 인 사원들의 이름, 월급, 직무 조회.
SELECT first_name, salary, job_id FROM employees WHERE job_id in ('SA_MAN' , 'PU_CLERK' , 'IT_PROG');

-- 21) 직무가 'SA_MAN', 'PU_CLERK', 'IT_PROG' 가 아닌 사원들의 이름, 월급, 직무 조회.
SELECT first_name, salary, job_id FROM employees WHERE job_id NOT in ('SA_MAN' , 'PU_CLERK' , 'IT_PROG');

-- 22) 직업이 'SA_MAN'이고 월급이 1200이상인 사원들의 이름, 월급, 직무를 조회.
SELECT first_name, salary, job_id FROM employees WHERE job_id = 'SA_MAN' and salary >= 1200;





select * from employees;

SELECT * FROM employees WHERE first_name LIKE '%s';
SELECT * FROM employees WHERE department_id = 30 and job_id = 'PU_CLERK';
SELECT * FROM employees WHERE department_id in (20, 30);
SELECT * FROM employees WHERE salary >= 2000 and salary <= 3000;
SELECT first_name, employee_id, salary, department_id FROM employees WHERE salary NOT BETWEEN 1000 AND 2000;
SELECT first_name, employee_id, salary, department_id FROM employees WHERE first_name LIKE '%E%' and salary NOT between 1000 and 2000;

SELECT * 
FROM employees 
WHERE commission_pct is not null 
and manager_id is not null 
and (job_id LIKE '%CLERK' or job_id LIKE '%MAN') 
and first_name not LIKE '_l%';








SELECT sysdate-1 as 날짜 FROM dual;

SELECT UPPER('ye dam'), LOWER('YE DAM'), INITCAP('   YE DAM ') FROM dual;

-- first name 에 s가 들어있는 사람 사원의 이름, 급여, 부서명 조회
SELECT first_name, salary, department_id FROM employees WHERE lower(first_name) LIKE '%s%';

SELECT concat(concat('ye', ' '), 'dam') as 결과 FROM dual;


SELECT salary, LPAD(salary, (salary/1000) + length(salary) , '*') as 급여표시, LPAD(last_name, 10, '*') as LPAD_표시, first_name ,substr(first_name, 3, 1) as 세번째_글자, length('first_name') as 글자수, INSTR(lower(first_name), 'a') as 이름의_위치,
   department_id
FROM employees 
WHERE department_id = 80;

SELECT lengthb('abc'), lengthb('한글') FROM dual;

SELECT '250307-4111111' as 주민번호, replace('250307-4111111', substr('250307-4111111', 9), '******') as 마스킹_주민번호, 
   trim('      한글 '), '      한글',
   trim('a' from 'aafffaa'),
   rtrim('<_aaa_>', '<_>')
FROM dual;

-- 사원번호가 홀수면 1, 짝수면 0
-- 사원번호, 이름, 홀짝구분

SELECT employee_id, first_name, mod(employee_id, 2)
FROM employees;

-- 사번, 이름, 입사일 6개월이 지난시점 날짜, 근속개월
SELECT employee_id, first_name, hire_date, add_months(hire_date, 6) as 여섯달후의입사일, trunc(MONTHS_BETWEEN(SYSDATE,hire_date) / 12 ) as 근속개월, 
   NEXT_DAY(SYSDATE, '수'), LAST_DAY(SYSDATE)
FROM employees;

-- 날짜 포맷 변경
ALTER SESSION SET
nls_date_format = 'rrrr-mm-dd';

SELECT * FROM employees;

SELECT sysdate, round(sysdate, 'cc'), round(sysdate, 'yyyy'), round(sysdate, 'q'), round(sysdate, 'ddd') FROM dual;

SELECT sysdate, trunc(sysdate, 'cc'), trunc(sysdate, 'yyyy'), trunc(sysdate, 'q'), trunc(sysdate, 'ddd') , sysdate + 10 FROM dual;


-- 23) 사원 테이블의 이름을 조회. 단 첫 번째 컬럼은 이름을 대문자로 출력하고, 두번째 컬럼은 이름을 소문자로 출력하고, 
-- 세 번째 컬럼은 이름의 첫 번째 철자는 대문자로, 나머지는 소문자로 조회.
SELECT UPPER(first_name), LOWER(first_name), INITCAP(first_name) FROM employees; 

-- 24) 이름이 alexander(모두 소문자로 변환)인 사원의 이름과 월급 조회.
SELECT first_name, salary FROM employees WHERE LOWER(first_name) = 'alexander';

-- 25) 영어 단어 SMITH에서 SMI만 잘라서 조회.
SELECT substr('SMITH', 1, 3) as 결과값 FROM dual;

-- 26) 사원들의 이름(last_name)과 이름의 철자 개수를 출력.
SELECT last_name, length(last_name) FROM employees;

-- 27) 이름에 소문자 a가 존재하는 경우 몇 번째 자리에 위치하는지 조회.
SELECT first_name, INSTR(first_name, 'a') FROM employees;

-- 28) 사원들의 이름과 월급을 조회. 단 월급 컬럼의 자릿수를 10자리로 하고, 월급을 출력하고 남은 나머지 자리에 *(별표)를 채워서 조회.
SELECT first_name, salary, LPAD(salary, 10, '*') as 값 FROM employees; 

-- 29) 사원들의 이름과 월급 조회. 단 월급은 1000을 네모(■) 하나로 출력.
SELECT first_name, RPAD(' ', CEIL(salary/1000), '■') as 월급표시
FROM employees;

-- 30) 숫자 876.567을 소수점 두 번째 자리까지 출력(반올림 처리)
SELECT ROUND(876.567, 2) FROM dual;

-- 31) 숫자 876.567을 소수 첫째 자리까지 출력(버림 처리)
SELECT TRUNC(876.567, 1) FROM dual;

-- 32) 숫자 10을 3으로 나눈 나머지 값을 출력.
SELECT MOD(10, 3) FROM dual;

-- 33) 사원 번호와 사원 번호가 홀수이면 1, 짝수이면 0을 출력.
SELECT employee_id, MOD(employee_id, 2) as 홀짝구분 
FROM employees;

-- 34) 사원번호가 짝수인 사원들의 사원 번호와 이름을 조회.
SELECT employee_id, first_name 
FROM employees 
WHERE MOD(employee_id, 2) = 0;


-- 35) 사원의 이름과 입사한 날짜부터 오늘까지 총 몇 달을 근무했는지 조회(정수).
SELECT first_name, hire_date, trunc(months_between(sysdate, hire_date)) || '개월' as 근속개월 
FROM employees;




--변환함수
--문자 변환함수 숫자, 날짜 => 문자로
SELECT first_name, hire_date, to_char(hire_date, 'yyyy/mm/dd day'), to_char(salary, 'l999')
FROM employees
WHERE department_id = 50;

ALTER SESSION SET
  nls_date_format = 'rr/mm/dd';


-- 추가수당이 null이면 200, 아니면 급여 * 추가수당
-- 사번, 이름, 급여, 추가수당

SELECT employee_id, first_name, salary, nvl2(commission_pct, salary * commission_pct, 200) as 추가수당 from employees;


-- if-then-else
-- 급여가 1000보다 작다. 30% 인상, 급여가 2000보다 작다. 20% 인상, 급여가 3000보다 작다. 10% 인상
SELECT first_name, salary, 
    CASE WHEN salary < 1000 THEN salary * 1.3 
         WHEN salary < 2000 THEN salary * 1.2 
         WHEN salary < 3000 THEN salary * 1.1 
         ELSE salary 
         END 
         AS 인상된_급여 
FROM employees;


SELECT first_name, department_id, 
    CASE WHEN department_id = 20 or department_id = 30 or department_id = 50 THEN '서울' 
         WHEN department_id = 60 or department_id = 70 or department_id = 80 THEN '대구'
         ELSE '제주도'
         END
         AS 이동지역
FROM employees;


-- 36) 2018년 10월 1일에서 2019년 6월 1일 사이의 총일수 출력.
SELECT TO_DATE('2019-06-01', 'YYYY-MM-DD') - TO_DATE('2018-10-01', 'YYYY-MM-DD') as 총일수
FROM dual;

-- 37) 2018년 10월 1일에서 2019년 6월 1일 사이의 총 주(Week) 수를 출력(정수).
SELECT TRUNC((TO_DATE('2019-06-01', 'YYYY-MM-DD') - TO_DATE('2018-10-01', 'YYYY-MM-DD')) / 7) as 총주수
FROM dual;

-- 38) 2023년 5월 1일로부터 100달 뒤의 날짜 출력.
SELECT ADD_MONTHS(TO_DATE('2023-05-01', 'YYYY-MM-DD'), 100) as 백달후
FROM dual;

-- 39) 2023년 5월 1일로부터 100일 후 날짜 출력.
SELECT TO_DATE('2023-05-01', 'YYYY-MM-DD') + 100 as 백일후
FROM dual;

-- 40) 2023년 6월 30일 이후 바로 돌아올 화요일의 날짜 출력
SELECT NEXT_DAY(TO_DATE('2023-06-30', 'YYYY-MM-DD'), '화') as 다음화요일
FROM dual;

-- 41) 2023년 9월 19일 이후 바로 돌아올 토요일의 날짜 출력
SELECT NEXT_DAY(TO_DATE('2023-09-19', 'YYYY-MM-DD'), '토') as 다음토요일
FROM dual;

-- 42) 오늘 이후 돌아올 금요일의 날짜 출력
SELECT NEXT_DAY(SYSDATE, '금') as 다음금요일
FROM dual;

-- 43) 2020년 5월 22일부터 100달 뒤에 돌아오는 화요일의 날짜 출력
SELECT NEXT_DAY(ADD_MONTHS(TO_DATE('2020-05-22', 'YYYY-MM-DD'), 100), '화') as 백달후_화요일
FROM dual;

-- 44) 오늘부터 100달 뒤에 돌아오는 월요일의 날짜 출력
SELECT NEXT_DAY(ADD_MONTHS(SYSDATE, 100), '월') as 백달후_월요일
FROM dual;

-- 45) 2019년 5월 22일 해당 달의 마지막 날짜가 어떻게 되는지 조회
SELECT LAST_DAY(TO_DATE('2019-05-22', 'YYYY-MM-DD')) as 달의마지막날
FROM dual;

-- 46) 오늘부터 이번 달 말일까지 총 며칠 남았는지 조회
SELECT LAST_DAY(SYSDATE) - SYSDATE as 남은일수
FROM dual;

-- 47) 이름이 SUSAN인 사원의 이름, 입사일, 입사한 달의 마지막 날짜를 조회
SELECT first_name, hire_date, LAST_DAY(hire_date) as 입사월마지막날
FROM employees
WHERE UPPER(first_name) = 'SUSAN';

-- 48) 이름(last_name)이 GRANT(대문자로 변환)인 사원의 이름과 입사한 요일을 출력하고, GRANT의 월급에 천단위를 구분할 수 있는 콤마(,)를 붙여 조회
SELECT last_name, TO_CHAR(hire_date, 'DAY') as 입사요일, TO_CHAR(salary, '999,999') as 월급
FROM employees
WHERE UPPER(last_name) = 'GRANT';

-- 50) 2008년도에 입사한 사원의 이름과 입사일 조회(to_char 함수 사용)
SELECT first_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = '2008';

-- 51) 월급이 1500 이상인 사원의 이름과, 월급에 천단위를 구분할 수 있는 콤마(,)와 화폐단위를 붙여 조회
SELECT first_name, TO_CHAR(salary, '$999,999') as 월급
FROM employees
WHERE salary >= 1500;

-- 52) 2005년 06월 14일에 입사한 사원의 이름과 입사일 조회(to_date 함수 사용)
SELECT first_name, hire_date
FROM employees
WHERE hire_date = TO_DATE('2005-06-14', 'YYYY-MM-DD');

-- 53) 사원의 이름과 커미션을 조회. (단 커미션이 NULL인 사원들은 0)
SELECT first_name, NVL(commission_pct, 0) as 커미션
FROM employees;

-- 54) 직업이 'SA_MAN' 또는 'IT_PROG' 인 사원의 월급, 추가수당, 월급여 조회 
-- - 추가수당 : 월급 * 커미션(단 커미션이 NULL인 경우 0) 
-- - 월급여 : 월급 + 추가수당
SELECT first_name, salary, 
   salary * NVL(commission_pct, 0) as 추가수당, 
   salary + (salary * NVL(commission_pct, 0)) as 월급여
FROM employees
WHERE job_id IN ('SA_MAN', 'IT_PROG');

-- 55) 사원의 이름과 부서 번호, 보너스 조회 보너스 : 부서 번호가 10번이면 300, 20번이면 400, 나머지 부서 번호는 0
SELECT first_name, department_id,
   CASE department_id 
        WHEN 10 THEN 300
        WHEN 20 THEN 400
        ELSE 0
   END as 보너스
FROM employees;

-- 56) 사원 번호와 사원 번호가 짝수인지 홀수인지를 조회
SELECT employee_id,
   CASE MOD(employee_id, 2)
        WHEN 0 THEN '짝수'
        ELSE '홀수'
   END as 홀짝구분
FROM employees;

-- 57) 사원의 이름, 직업, 보너스 조회 단 직무가 'SA_MAN'이면 보너스 5000 나머지 직무는 보너스 2000
SELECT first_name, job_id,
   CASE 
        WHEN job_id = 'SA_MAN' THEN 5000
        ELSE 2000
   END as 보너스
FROM employees;

-- 58) 사원의 이름, 직업, 월급, 보너스 조회 
-- - 보너스 : 월급이 3000이상이면 500, 월급이 2000이상 3000미만이면 300, 월급이 1000이상 2000미만이면 200, 나머지는 0
SELECT first_name, job_id, salary,
   CASE 
        WHEN salary >= 3000 THEN 500
        WHEN salary >= 2000 THEN 300
        WHEN salary >= 1000 THEN 200
        ELSE 0
   END as 보너스
FROM employees;

-- 59) 사원의 이름, 직업, 커미션, 보너스 조회. 보너스 : 커미션이 NULL이면 500, NULL이 아니면 0
SELECT first_name, job_id, commission_pct,
   CASE 
        WHEN commission_pct IS NULL THEN 500
        ELSE 0
   END as 보너스
FROM employees;

-- 60) 사원의 이름, 직업, 보너스 조회 - 보너스는 직무가 'SA_MAN', 'PU_CLERK' 이면 500, 'ST_CLERK', 'FI_ACCOUNT'이면 400 나머지 0
SELECT first_name, job_id,
   CASE 
        WHEN job_id IN ('SA_MAN', 'PU_CLERK') THEN 500
        WHEN job_id IN ('ST_CLERK', 'FI_ACCOUNT') THEN 400
        ELSE 0
   END as 보너스
FROM employees;




-----------------------------------------------------------------------------------------------------------------------------------
-- 전 사원의 급여의 합계, 평균, 최대값, 최소값, 사원수
select department_id, job_id, sum(salary), round(avg(salary)), max(salary), min(salary), count(*)
from employees
group by department_id, job_id
having sum(salary) >= 50000
order by department_id ;

-- 직무별 급여 합계를 구하고, 합계가 30000이상인 자료만 표시
-- 합계를 이용해서 내림차순 정렬
select job_id, sum(salary) 
from employees
group by job_id
having sum(salary) >= 30000
order by 2 desc;

-- 회사 관리자 수 표시
select count(distinct manager_id) as 관리자수
from employees;

--추가 수당을 받는 사원 수
select count(*)
from employees
--추가 수당이 없는 사원 수
where commission_pct is null;

-- 사원의 급여의 최대값과 최소값의 차이 표시
select max(salary)- min(salary) as 차이
from employees;

-- 부서번호가 50번 이상인 부서만 표시
-- 최소 입사사원의 입사일과, 가장 최근 입사자의 입사일 표시
-- 부서별 급여 합계가 30000이상인 자료만 표시
select department_id, min(hire_date),max(hire_date),sum(salary)
from employees
where department_id >= 50
group by department_id
having sum(salary) < 30000
order by department_id;



----------------------------------------------------------------------------------------------------------------------------------------------
-- 1. 그룹 함수는 여러 행에 적용되어 그룹 당 하나의 결과를 출력한다. 
-- 2. 그룹 함수는 계산에 널을 포함한다. 
-- 3. WHERE 절은 그룹 계산에 행(row)을 포함시키기 전에 행을 제한한다. 
-- 4. 모든 사원의 급여 최고액, 최저액, 총액 및 평균액을 표시하시오. 열 레이블을 각각 Maximum, Minimum, Sum, Average로 지정하고 결과를 정수로 반올림하도록 작성하시오.
select max(salary) as Maximum, min(salary) as Minimum, sum(salary) as Sum, round(avg(salary)) as Average
from employees;
-- 5. 위의 질의를 수정하여 각 업무 유형(job_id)별로 급여 최고액, 최저액, 총액 및 평균액을 표시하시오. 
select job_id, max(salary) as Maximum, min(salary) as Minimum, sum(salary) as Sum, round(avg(salary)) as Average
from employees
group by job_id;

-- 6. 업무별 사원 수를 표시하는 질의를 작성하시오.
select job_id, count(employee_id)
from employees
group by job_id;

-- 7. 관리자 수를 확인하시오. 열 레이블은 Number of Managers로 지정하시오. (힌트: MANAGER_ID 열을 사용)
select count(manager_id) as NumberofManagers
from employees;

-- 8. 최고 급여와 최저 급여의 차액을 표시하는 질의를 작성하고 열 레이블을 DIFFERENCE로 지정하시오.
select max(salary)-min(salary) as DIFFERENCE
from employees;

-- 9. 관리자 번호, 해당 관리자에 속한 사원의 최저 급여를 표시하시오. 관리자를 알 수 없는 사원, 최저 급여가 6,000 미만인 그룹은 제외시키고 결과를 최저급여에 대한 내림차순으로 정렬하시오.
select manager_id, min(salary) 
from employees
where manager_id is not null
and salary <= 6000
group by manager_id 
order by 2 desc;

-- 10. 업무를 표시한 다음 해당 업무에 대해 부서 번호별(부서 20, 50, 80, 90) 급여 합계와  모든 사원의 급여 총액을 각각 표시하는 질의를 작성하고, 각 열에 적합한 머리글을 지정하시오
SELECT 
job_id AS "업무",  -- 업무 표시
sum(decode(department_id, 20, salary, 0)) AS "부서 20 급여 합계",  -- 부서 20 급여 합계
sum(decode(department_id, 50, salary, 0)) AS "부서 50 급여 합계",  -- 부서 50 급여 합계
sum(decode(department_id, 80, salary, 0)) AS "부서 80 급여 합계",  -- 부서 80 급여 합계
sum(decode(department_id, 90, salary, 0)) AS "부서 90 급여 합계",  -- 부서 90 급여 합계
sum(salary) AS "전체 급여 합계"  -- 전체 급여 합계
from 
employees
group by 
job_id;  -- 업무별로 그룹화

--join
-- 부서코드, 부서이름, 사원번호, 이름
select employee_id, first_name, e. department_id, department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

--직무에 해당하는 급여의 최소 최대값
select first_name, e.job_id, salary, j.job_id, min_salary, max_salary
from employees e, jobs j
where e.job_id = j.job_id
order by first_name;


--셀프 조인  사원번호, 이름, 상사의 번호, 상사이름
select e.employee_id, e.first_name, e.manager_id, e2.employee_id, e2.first_name 
from employees e, employees e2
where e.manager_id = e2.employee_id;

-- 부서코드, 부서이름, 위치한 도시명
select department_id, department_name,d.location_id, l.location_id, city
from departments d, locations l
where d.location_id = l.location_id
order by department_id;

--표준조인 ( natural join)
select employee_id, department_name, e.department_id
from employees e ,departments d
where e.department_id = d.department_id and e.manager_id = d.manager_id
order by department_id;

--using절 사용
select employee_id, department_id, department_name
from employees e join departments d using(department_id)
order by department_id;

--on절 사용
select employee_id, d.department_id, department_name
from employees e right join departments d on(e.department_id = d.department_id)
order by department_id;

--급여가 13,000초과인 사원들의 부서정보와 사원정보를 출력
--부서번호, 부서이름, 사원번호, first_name, 급여 출력
--기본 방시(+), SQL-99방식
select d.department_id, department_name, employee_id, first_name, salary
from employees e join departments d on(e.department_id = d.department_id)
where salary > 13000
order by e.department_id;

--부서번호, 부서이름, 평균급여(정수로 반올림), 최대급여, 최소급여, 사원수 출력
select d.department_id, department_name, round(avg(salary)), max(salary), min(salary), count(*)
from employees e join departments d on(e.department_id = d.department_id)
group by d.department_id, department_name 
order by d.department_id;

-- 모든 사원 정보가 포함된 결과를 부서번호, first_name 순으로 정렬하여 출력
-- 부서번호, 부서이름, 사원번호, first_name, 직책명(job_title), 급여 출력
select d.department_id, department_name, employee_id, first_name, job_id, salary
from employees e left join departments d on(e.department_id = d.department_id)
order by d.department_id;

--모든부서, 사원정보, 사원의 상관정보를 부서번호와 사원번호 순으로 정렬하여 출력
-- 부서번호, 부서이름, 사원번호, first_name, 상관번호(manager_id),급여, 상관사원번호(employee_id),상관이름(first_name) 출력
select d.department_id, department_name, 
    e.employee_id, e.first_name, e.manager_id, e.salary,
    e2.employee_id, e2.first_name
from employees e right join departments d on(e.department_id = d.department_id)
            left join employees e2 on(e.manager_id = e2.employee_id); 

-- selcet 나타나고다 하는 필드명
-- from table, join( table1 join table2 조건절(using(필드명),on(비교식)))
-- where  조건절
-- group by  그룹화활 필드명
-- having 그룹화한 결과를 이용한 조건절
-- order by 정렬을 할 필드명


-- 1. LOCATIONS, COUNTRIES 테이블을 사용하여 모든 부서의 주소를 생성하는 query를 작성하시오. 
-- 출력에 위치 ID, 주소, 구/군, 시/도 및 국가를 표시하며, NATURAL JOIN을 사용하여 결과를 생성합니다.
select location_id, state_province, city, street_address,country_name
from locations l natural join countries c;

--2. 모든 사원의 last_name, 소속 부서번호, 부서 이름을 표시하는 query를 작성하시오.
select last_name, d.department_id, d.department_name
from employees e join departments d on(d.department_id = e.department_id);

--3. Toronto에 근무하는 사원에 대한 보고서를 필요로 합니다. toronto에서 근무하는 모든 사원의 last_name, 직무, 부서번호, 부서 이름을 표시하시오. (힌트 : 3-way join 사용)
select e.last_name, e.job_id, e.department_id, d.department_name
from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id
where l.city = 'Toronto';

--4. 사원의 last_name, 사원 번호를 해당 관리자의 last_name, 관리자 번호와 함께 표시하는 보고서를 작성하시오.  열 레이블을 각각 Employee, Emp#, Manager, Mgr#으로 지정하시오. 
select e.last_name, e.employee_id, e.manager_id, e2.last_name
from employees e join employees e2 on(e.manager_id = e2.employee_id);

--5. King과 같이 해당 관리자가 지정되지 않은 모든 사원을 표시하도록 4번 문장을 수정합니다. 사원 번호순으로 결과를 정렬하시오. 
select e.last_name, e.employee_id, e.manager_id, e2.last_name, e2.employee_id
from employees e left join employees e2 on(e.manager_id = e2.employee_id)
where e.manager_id is null
order by e.employee_id;

--6. 사원의 last_name, 부서 번호,  같은 부서에 근무하는 모든 사원을 표시하는 보고서를 작성하시오. 각 열에 적절한 레이블을 자유롭게 지정해 봅니다.
SELECT e1.last_name AS Employee_Last_Name,
   e1.department_id AS Department_ID,
   e2.last_name AS Colleague_Last_Name
FROM employees e1
JOIN employees e2 ON e1.department_id = e2.department_id
WHERE e1.employee_id != e2.employee_id
ORDER BY e1.department_id, e1.last_name;

--7. 직무, 급여에 대한 보고서를 필요로 합니다. 먼저 JOBS테이블의 구조를 표시한 다음, 모든 사원의 이름, 직무, 부서 이름, 급여를 표시하는 query를 작성하시오


----- 서브커리-----------
-- 부서명이 IT인 사원의 이름과 부서코드 출력
select first_name, department_id
from employees
where department_id = (select department_id
                    from departments 
                    where upper(department_name) = 'IT'); -- 부서명이 it인 
                    
-- 표시 필드: 사원번호, 사원의 이름, 급여
-- 조건 : 사원전체 급여의 평균 이하인 사원만 출력
select employee_id, first_name, salary
from employees
where salary <= all (select avg(salary)
                    from employees);
                    
--- 최대
select employee_id, first_name, salary
from employees
where salary = (select max(salary)
                    from employees);

--최소
select employee_id, first_name, salary
from employees
where salary = (select min(salary)
                    from employees);
                    
                    
--1. Zlotkey와 동일한 부서에 속한 모든 사원의 이름과 입사일을 표시하는 질의를 작성하시오. Zlotkey는 결과에서 제외하시오.
--2. 급여가 평균 급여보다 많은 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 결과를 급여에 대해 오름차순으로 정렬하시오.
--3. 이름에 u가 포함된 사원과 같은 부서에서 일하는 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 질의를 실행하시오.
--4. 부서 위치 ID가 1700인 모든 사원의 이름, 부서 번호 및 업무 ID를 표시하시오.
--5. King에게 보고하는(manager가 King) 모든 사원의 이름과 급여를 표시하시오.
select last_name, salary, manager_id
from employees
where manager_id in (select employee_id
                    from employees
                    where lower(last_name) = 'King');
                    
--6. Executive 부서의 모든 사원에 대한 부서 번호, 이름, 업무 ID를 표시하시오.
--7. 평균 급여보다 많은 급여를 받고, 이름에 u가 포함된 사원과 같은 부서에 근무하는 모든 사원의 사원번호, 이름, 급여를 표시하시오



-- from절 사용
SELECT employee_id, first_name, e.department_id, salary, salavg 
FROM employees e, 
  (SELECT department_id, round(avg(salary)) as salavg FROM employees GROUP BY department_id) b
WHERE e.department_id = b.department_id
and e.salary = b.salavg;






