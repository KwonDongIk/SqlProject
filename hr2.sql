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
SELECT * FROM emplyees;

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


-- 30) 숫자 876.567을 소수점 두 번째 자리까지 출력(반올림 처리)


-- 31) 숫자 876.567을 소수 첫째 자리까지 출력(버림 처리)


-- 32) 숫자 10을 3으로 나눈 나머지 값을 출력.


-- 33) 사원 번호와 사원 번호가 홀수이면 1, 짝수이면 0을 출력.


-- 34) 사원번호가 짝수인 사원들의 사원 번호와 이름을 조회.


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
-- 37) 2018년 10월 1일에서 2019년 6월 1일 사이의 총 주(Week) 수를 출력(정수).
-- 38) 2023년 5월 1일로부터 100달 뒤의 날짜 출력.
-- 39) 2023년 5월 1일로부터 100일 후 날짜 출력.
-- 40) 2023년 6월 30일 이후 바로 돌아올 화요일의 날짜 출력
-- 41) 2023년 9월 19일 이후 바로 돌아올 토요일의 날짜 출력
-- 42) 오늘 이후 돌아올 금요일의 날짜 출력
-- 43) 2020년 5월 22일부터 100달 뒤에 돌아오는 화요일의 날짜 출력
-- 44) 오늘부터 100달 뒤에 돌아오는 월요일의 날짜 출력
-- 45) 2019년 5월 22일 해당 달의 마지막 날짜가 어떻게 되는지 조회
-- 46) 오늘부터 이번 달 말일까지 총 며칠 남았는지 조회
-- 47) 이름이 SUSAN인 사원의 이름, 입사일, 입사한 달의 마지막 날짜를 조회
-- 48) 이름(last_name)이 GRANT(대문자로 변환)인 사원의 이름과 입사한 요일을 출력하고, GRANT의 월급에 천단위를 구분할 수 있는 콤마(,)를 붙여 조회
-- 50) 2008년도에 입사한 사원의 이름과 입사일 조회(to_char 함수 사용)
-- 51) 월급이 1500 이상인 사원의 이름과, 월급에 천단위를 구분할 수 있는 콤마(,)와 화폐단위를 붙여 조회
-- 52) 2005년 06월 14일에 입사한 사원의 이름과 입사일 조회(to_date 함수 사용)
-- 53) 사원의 이름과 커미션을 조회. (단 커미션이 NULL인 사원들은 0)
-- 54) 직업이 'SA_MAN' 또는 'IT_PROG' 인 사원의 월급, 추가수당, 월급여 조회 - 추가수당 : 월급 * 커미션(단 커미션이 NULL인 경우 0) - 월급여 : 월급 + 추가수당
-- 55) 사원의 이름과 부서 번호, 보너스 조회 보너스 : 부서 번호가 10번이면 300, 20번이면 400, 나머지 부서 번호는 0
-- 56) 사원 번호와 사원 번호가 짝수인지 홀수인지를 조회
-- 57) 사원의 이름, 직업, 보너스 조회 단 직무가 'SA_MAN'이면 보너스 5000 나머지 직무는 보너스 2000
-- 58) 사원의 이름, 직업, 월급, 보너스 조회 - 보너스 : 월급이 3000이상이면 500, 월급이 2000이상 3000미만이면 300, 월급이 1000이상 2000미만이면 200, 나머지는 0
-- 59) 사원의 이름, 직업, 커미션, 보너스 조회. 보너스 : 커미션이 NULL이면 500, NULL이 아니면 0
-- 60) 사원의 이름, 직업, 보너스 조회 - 보너스는 직무가 'SA_MAN', 'PU_CLERK' 이면 500, 'ST_CLERK', 'FI_ACCOUNT'이면 400 나머지 0



