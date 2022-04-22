-- 2022. 04. 22. 5일차 제약조건, 서브쿼리

/*
제약조건 : 테이블의 컬럼에 할당되어서 데이터의 무결성(결함이 없는)을 확보
    Primary Key : 테이블에 한 번만 사용할 수 있음 + 하나의 컬럼, 두개 이상을 그룹핑해서 적용
                  중복된 값을 넣을 수 없음
                  NULL 을 넣을 수 없음
                  
    UNIQUE      : 테이블의 여러 컬럼에 할당할 수 있음
                  중복된 값을 넣을 수 없음
                  NULL 을 넣을 수 있음.. 단, 한번만 넣을 수 있음 ?- 중복된 값을 넣을 수 없어서
                  
    Foregin Key : 다른 테이블의 특정 컬럼의 값을 참조해서 넣을 수 있음
                  자신의 컬럼에 임의의 값을 할당하지 못함
                  
    NOT NULL    : NULL 값을 컬럼에 할당할 수 없음
    
    CHECK       : 컬럼에 값을 할당할 때 체크해서(조건에 만족하는) 값을 할당
    
    DEFAULT     : 값을 넣지 않을 때 기본값이 할당됨
*/

--서브쿼리
/*
Sub Query : Select 문 내에 Select 문이 있는 쿼리
where 조건절 : sub query
having 조건절 : sub query
*/

select ename, salary from employee;
select salary from employee where ename = 'SCOTT';

-- SCOTT 의 월급과 같거나 많은 사용자를 출력하라
select ename, salary
from employee 
where salary >= 3000

select ename, salary
from employee 
where salary >= (select salary from employee where ename = 'SCOTT')

-- SCOTT 과 동일한 부서에 근무하는 사원들 출력하기
select *
from employee
where dno = (select dno from employee where ename = 'SCOTT')
-- 최소 급여를 받는 사원의 이름, 담당업무, 급여
select ename, job, salary
from employee
where salary = (select min (salary) from employee)

-- 30 번 부서 dno 에서 최소 월급을 받는 사원보다 많은 월급을 받는 사원들의
-- 이름, 부서, 부서번호, 월급
select ename, dname, e.dno, salary
from employee e join department d
on e.dno = d.dno
where e.dno = 30 and e.salary > (select min(salary) from employee where dno = 30)

--having 절에 Sub query 사용하기
-- 부서의 최소월급이 30번 부서의 최소월급 보다 큰 부서
--30 번 부서의 최소월급 보다 큰
select dno, min(salary), count(dno)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno = 30)

/*
단일행 서브 쿼리 : sub query 의 결과 값이 단 하나만 출력
        . 단일행 비교 연산자 : >, =, >=, <, <=, <>, <=
다중행 서브 쿼리 : sub query 의 결과 값이 여러개 출력
        . 다중행 서브쿼리 연산자 : IN, ANY, SOME, ALL, EXITS
        IN : 메인 쿼리의 비교 조건 ( ' = ' 로 비교할 경우) 이 서브쿼리의 결과값 중에 하나라도 일치할 경우
        ANY, SOME : 메인 쿼리의 비교조건이 서브쿼리의 검색 결과와 하나 이상 일치하면 참
            . 서브쿼리가 반환하는 각각의 값과 비교함
            . ' < any ' 는 최대값 보다 작음을 나타냄
            . ' > any ' 는 최솟값 보다 큼
            . ' = any ' 는 IN 과 동일함
        ALL : 메인 쿼리의 비교조건이 서브쿼리의 검색 결과와 모든 값이 일치하면 참
            . Sub Query 의 반환하는 모든 값과 비교
            . ' > all '  은 최대값 보다 큼
            . ' < all '  은 최솟값 보다 작음
        EXITS : 메인 쿼리의 비교조건이 서브쿼리의 결과값 중에서 만족하는 값이 하나라도 존재하면 참
*/

--IN 연산자 사용하기
select ename, eno, dno, salary
from employee
order by dno asc

-- 부서별로 최소 월급을 받는 사용자들 출력하기 ( 서브쿼리를 사용하여 )
select dno, min (salary), count(*)
from employee
group by dno

select ename, dno, salary
from employee
where salary in (select min(salary) from employee group by dno)


-- 직급이 SALESMAN 이 아니면서 급여가, 급여를 가장 많이 받는 SALEMAN 보다 작은 사원
select eno, ename, job, salary
from employee
where salary < any (select salary from employee
                    where job = 'SALESMAN')
                    and job <> 'SALESMAN'                    

select eno, ename, job, salary
from employee
where job <> 'SALESMAN' and salary < any (select salary from employee
                                        where job = 'SALESMAN')
select * from employee order by job
                                     
-- 직급이 SALESMAN 이 아니면서 급여가, 임의의 SALEMAN 보다 작은 사원
select eno, ename, job, salary
from employee
where job <> 'SALESMAN'
    and salary < all (select salary from employee where job = 'SALESMAN')

-- 담당 업무가 분석가ANALYST인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들
select eno, ename, job, salary
from employee
where job <> 'ANALYST'
    and salary < all (select salary from employee where job = 'ANALYST')
select * from employee order by job

-- 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시.. 급여에 대해 오름차순
select eno, ename, salary
from employee
where salary > (select avg(salary) from employee)
order by salary


