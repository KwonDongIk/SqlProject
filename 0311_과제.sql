--그룹함수
--※ 다음 세 문장의 유효성을 판별하여 True 또는 False로 답하시오. 
--1. 그룹 함수는 여러 행에 적용되어 그룹 당 하나의 결과를 출력한다. 
--2. 그룹 함수는 계산에 널을 포함한다. 
--3. WHERE 절은 그룹 계산에 행(row)을 포함시키기 전에 행을 제한한다.
--4. 모든 사원의 급여 최고액, 최저액, 총액 및 평균액을 표시하시오. 열 레이블을 각각 Maximum, Minimum, Sum, Average로 지정하고 결과를 정수로 반올림하도록 작성하시오.
--5. 위의 질의를 수정하여 각 업무 유형(job_id)별로 급여 최고액, 최저액, 총액 및 평균액을 표시하시오.
--6. 업무별 사원 수를 표시하는 질의를 작성하시오.
--7. 관리자 수를 확인하시오. 열 레이블은 Number of Managers로 지정하시오. (힌트: MANAGER_ID 열을 사용)
--8. 최고 급여와 최저 급여의 차액을 표시하는 질의를 작성하고 열 레이블을 DIFFERENCE로 지정하시오.
--9. 관리자 번호, 해당 관리자에 속한 사원의 최저 급여를 표시하시오. 관리자를 알 수 없는 사원, 최저 급여가 6,000 미만인 그룹은 제외시키고 결과를 최저급여에 대한 내림차순으로 정렬하시오.
--10. 업무를 표시한 다음 해당 업무에 대해 부서 번호별(부서 20, 50, 80, 90) 급여 합계와 모든 사원의 급여 총액을 각각 표시하는 질의를 작성하고, 각 열에 적합한 머리글을 지정하시오.


--조인
--1. LOCATIONS, COUNTRIES 테이블을 사용하여 모든 부서의 주소를 생성하는 query를
--작성하시오. 출력에 위치 ID, 주소, 구/군, 시/도 및 국가를 표시하며, NATURAL JOIN을 사용하여
--결과를 생성합니다.
--2. 모든 사원의 last_name, 소속 부서번호, 부서 이름을 표시하는 query를 작성하시오.
--3. Toronto에 근무하는 사원에 대한 보고서를 필요로 합니다.
--toronto에서 근무하는 모든 사원의 last_name, 직무, 부서번호, 부서 이름을 표시하시오. (힌트 : 3-way join 사용)
--4. 사원의 last_name, 사원 번호를 해당 관리자의 last_name, 관리자 번호와 함께 표시하는 보고서를 작성하시오. 열 레이블을 각각 Employee, Emp#, Manager, Mgr#으로 지정하시오.
--5. King과 같이 해당 관리자가 지정되지 않은 모든 사원을 표시하도록 4번 문장을 수정합니다. 사원 번호순으로 결과를 정렬하시오.
--6. 사원의 last_name, 부서 번호, 같은 부서에 근무하는 모든 사원을 표시하는 보고서를 작성하시오. 각 열에 적절한 레이블을 자유롭게 지정해 봅니다.
--7. 직무, 급여에 대한 보고서를 필요로 합니다. 먼저 JOBS테이블의 구조를 표시한 다음, 모든 사원의 이름, 직무, 부서 이름, 급여를 표시하는 query를 작성하시오.


--서브쿼리
--1. Zlotkey와 동일한 부서에 속한 모든 사원의 이름과 입사일을 표시하는 질의를 작성하시오. Zlotkey는 결과에서 제외하시오.
--2. 급여가 평균 급여보다 많은 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 결과를 급여에 대해 오름차순으로 정렬하시오.
--3. 이름에 u가 포함된 사원과 같은 부서에서 일하는 모든 사원의 사원 번호와 이름을
--표시하는 질의를 작성하고 질의를 실행하시오.
--4. 부서 위치 ID가 1700인 모든 사원의 이름, 부서 번호 및 업무 ID를 표시하시오.
--5. King에게 보고하는(manager가 King) 모든 사원의 이름과 급여를 표시하시오.
--6. Executive 부서의 모든 사원에 대한 부서 번호, 이름, 업무 ID를 표시하시오.
--7. 평균 급여보다 많은 급여를 받고, 이름에 u가 포함된 사원과 같은 부서에 근무하는 모든 사원의 사원번호, 이름, 급여를 표시하시오.
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary > (SELECT AVG(salary) 
                FROM employees)
                AND LOWER(last_name) like '%u%';