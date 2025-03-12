-- 1. 사원 테이블, 급여가 6500 이상 13000 이하, 이름 (last_name)이 'H'로 시작하는 사원의 사원번호, 이름, 급여, 부서번호
SELECT employee_id, last_name, salary, department_id FROM employees WHERE salary BETWEEN 6500 AND 13000 and last_name LIKE 'H%';

-- 2. 50, 60번 부서 직원 가운데 급여가 4000 보다 많은 사원의 사원번호, 이름, 직무, 급여, 부서번호 출력
SELECT employee_id, first_name, job_id, salary, department_id FROM employees WHERE salary > 4000 and (department_id = 50 or department_id = 60);

-- 3. 사원번호, 이름, 급여, 인상된 급여 => 급여가 3000 이하면 30% 인상, 9000 이하면 20% 인상, 14000 이하면 10% 인상, 나머지 동결
SELECT first_name, job_id, salary,
    CASE 
            WHEN salary <= 3000 THEN salary * 1.3
            WHEN salary <= 9000 THEN salary * 1.2
            WHEN salary <= 14000 THEN salary * 1.2
            ELSE salary
    END as 인상된_급여
FROM employees;

-- 4. 이름, 부서번호, 부서이름, 도시명
SELECT e.first_name, e.department_id, d.department_name, l.city
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id 
LEFT JOIN locations l ON l.location_id = d.location_id; 

-- 5. 서브쿼리 이용해서 'sales' 부서에서 일하는 사원들의 사원번호, 이름, 직무를 출력
-- Join
SELECT e.employee_id, e.first_name, e.job_id
FROM employees e 
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Sales';
-- 서브쿼리
SELECT employee_id, first_name, job_id
FROM employees
WHERE department_id = (SELECT department_id
                       FROM departments 
                       WHERE department_name = 'Sales');

-- 6. 2005년 이전에 입사한 사원들 중 직무가 'ST_CLERK' 인 사원의 데이터 표시
SELECT employee_id, job_id
FROM employees
WHERE hire_date < TO_DATE('2005-01-01', 'YYYY-MM-DD') AND JOB_ID = 'ST_CLERK';

-- 7. 추가 수당을 받는 사원의 이름, 직무, 급여, 추가수당을 표시
SELECT first_name, job_id, salary, (salary * NVL(commission_pct, 0)) as 추가수당
FROM employees;

-- 8. 부서별, 급여 평균(정수), 합계표시 / 부서코드, 급여평균, 급여합계 출력 / 급여합계가 50000이상인 자료만 출력
SELECT 
    department_id AS 부서코드, 
    ROUND(AVG(salary)) AS 급여평균, 
    SUM(salary) AS 급여합계
FROM 
    employees
GROUP BY 
    department_id
HAVING 
    SUM(salary) >= 50000
ORDER BY
    department_id;



