-- 4일차
/*
그룹함수 : 동일한 값에 대해서 그룹핑 하여 처리하는 함수
    group by  절에 특정 컬럼을 정의할 경우, 해당 컬럼의 동일한 값들을 그룹핑해서 연산을 적용
    
집계함수 :
    SUM : 그룹의 합계
    AVG : 그룹의 평균
    MAX : 그룹의 최대값
    MIN : 그룹의 최소값
    COUNT : 그룹의 총 갯수 ( 레코드 수 )
*/

select sum (salary), round (avg (salary), 2), max (salary), min (salary)
from employee;

-- 주의 : 집계 함수를 처리할 때 .. 출력컬럼 어떻게
-- 집계 함수 찍으면, 값이 한 줄로 나옴
-- 근데 ename 등 여러 줄 짜리 컬럼을 같이 넣으면 오류 남
/*  예시
select sum (salary), ename
from employee;
*/

select * from employee;

-- 집계함수는 null 값을 처리해서 연산한다.
select sum (commission), round (avg (commission), 2), max (commission), min (commission)
from employee;

-- count () : 레코드 수, 로우 수
select count (eno) from employee; --14
-- 단, null 은 계산하지 않음
select count (commission) from employee; --4
-- 테이블의 전체 레코드 수를 가져올 경우 count(*) or NOT NULL 로 지정된 컬럼을 count()
select count(*) from employee;
select count(ename) from employee;

-- 중복되지 않는 직업의 갯수 // count (distinct 칼럼명)
select job from employee;
select count (distinct job) from employee;
--부서의 갯수
select count (distinct dno) from employee;

--Group by : 특정 컬럼의 값(중복되는 값)을 그룹핑 한다.
-- 주로 집계함수를 select 절에서 같이 사용함
/*
select 컬럼명, 집계함수 처리된 컬럼
from 테이블
where 조건
group by 컬럼명
having 조건 ( group by 한 결과의 조건 )
order by 정렬
*/

select dno from employee order by dno;
select dno from employee group by dno order by dno;

-- 전체 평균 급여
select avg(salary) as 평균급여
from employee

-- 부서별 평균 급여
select dno as 부서번호, avg(salary) as 평균급여
from employee
group by dno

-- 부서별 총 급여
select dno, sum(salary)
from employee
group by dno

-- 부서별 - group by dno 이 기준이므로
-- 부서별 인원수 - count(dno), 부서별 총 급여 - sum(salary), 부서별 평균 급여 - avg(salary)
-- 부서별 최대 보너스 받는 사람의 액수 - max(commission), 부서별 최소 보너스 받는 액수 - min(commission)
select dno, count(dno), sum(salary), avg(salary), max(commission), min(commission)
from employee
group by dno
-- 레코드 수가 맞지 않으면 오류남
/*
select dno, count(dno), sum(salary), ename
from employee
group by dno
*/

-- 동일한 직책을 그룹핑해서 월급의 평균, 합계, 최대값, 최소값
select job 직종, count(job) "직종별 인원수", avg(salary) "직종별 평균급여",
sum(salary) "직종의 총 급여", max(salary) "직종에서 급여 최대", min(salary) "직종에서 급여 최소"
from employee
group by job;

--여러 컬럼을 그룹핑 하기
-- 기준 1 - dno, 기준 2 - job
select dno, job, count(*), sum (salary)
from employee
group by dno, job
order by dno;
--확인 / dno 20, job CLERK 이 2명인가?
select dno, job
from employee
where dno = 20 and job = 'CLERK';

--having : group by 에서 나온 결과를 조건으로 처리할 때
-- 부서별 월급의 합계가 9000 이상인 것만 출력
select dno , count(*), sum (salary) 부서별합계, round(avg(salary), 2)
from employee
group by dno
having sum(salary) > 9000;
--부서별 월급의 평균이 2000 이상만 출력

-- 월급이 1500 이하는 제외하고 각 부서별로 월급의 평균이 2500 이상인 것만 출력하라
select dno, round(avg(salary))
from employee
where salary > 1500
group by dno
having avg(salary) >= 2500
order by dno;

-- ROLLUP
-- 두 컬럼 이상도 사용 가능
-- CUBE
    -- group by 절 안에서 사용하는 특수한 함수
    -- 여러 컬럼을 나열 할 수 있다
    -- group by 절의 자세한 정보 출력
    -- ROLLUP 함수는 소계와 합계를 순서에 맞게 반환하지만
    -- CUBE 함수는 계산 가능한 모든 소계와 합계를 반환한다.

-- rollup 미적용
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by rollup(dno)
order by dno;
-- rollup 적용
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by rollup(dno)
order by dno;

-- 부서별 합계와 평균을 출력 후, 마지막 라인에 전체 합계, 평균 출력
select dno, job, count(*), max(salary), sum(salary), round(avg(salary))
from employee
group by cube(dno, job)
order by dno;
-- rollup - dno 기준 으로 찍고, job 기준으로도 찍고
select dno, job, count(*), max(salary), sum(salary), round(avg(salary))
from employee
group by rollup(dno, job)
order by dno;

--Join : 여러 테이블을 합쳐서 각 테이블의 컬럼을 가져온다.
    -- department 와 employee 는 원래의 하나의 테이블이었으나 모델링(중복제거, 성능향상) 을 위해 두 테이블로 분리
    -- 두 테이블의 콩통키 컬럼(dno), employee 테이블의 dno 컬럼은 department 테이블의 dno 컬럼을 참조함
    -- 두 개 이상의 테이블의 컬럼을 JOIN 구문을 사용해서 출력

-- EQUI JOIN : 오라클에서 제일 많이 사용하는 JOIN,
        -- Oracle 에서만 사용 가능
    -- from 절 : 조인할 테이블을   ' , ' 로 처리
    -- where 절 : 두 테이블의 공통의 키 컬럼을 ' = ' 로 처리
    -- and 절 : 조건을 처리
    
select *
from employee, department
where department.dno = employee.dno
and job = 'MANAGER';

-- JOIN 시 테이블 알리어스
    -- from 테이블명 별칭, 테이블명 별칭
    -- where 별칭.공통키 = 별칭.공통키
select *
from employee e, department d
where e.dno = d.dno
and salary > 1500;

-- select 절에서 공통키 컬럼을 출력시에 어느 테이블의 컬럼인지 명시해야 함
select eno, job, d.dno, dname
from employee e, department d
where e.dno = d.dno;

-- 두 테이블을 JOIN 해서 부서별로 salary 의 max 를 dname 으로 출력 
select dname, count(*), max(salary)
from department d, employee e
where d.dno = e.dno
group by dname;

-- NATURAL JOIN : Oracle 9i 부터 지원
    -- WQUI JOIN 의 Where 절을 없앰 ( 두 테이블의 공통키 컬럼을 ' = ' 로 처리함 )
    -- 공통키 컬럼을 Oracle 내부적으로 자동으로 감지해서 처리
    -- 공통키 컬럼을 별칭 이름을 사용하면 오류 발생
    -- 반드시 공통키 컬럼의 데이터 타입이 같아야 함
    -- from 절에 natural join 키워드를 사용
select eno, ename, dname, dno
from employee e natural join department d
-- 주의 : select 절에 공통키 컬럼을 출력할 때 테이블을 명시하지 않아야 함

/*
EQUI JOIN vs. NATURAL JOIN 의 공통 키 컬럼 처리
EQUI JOIN : 공통키 컬럼을 출력할 때 select 에서 반드시 테이블 명을 명시해야 함
NATURAL JOIN : 공통키 컬럼을 출력할 때 select 에서 테이블 명을 명시하면 안됨
*/


-- where 절 : 두 테이블의 공통의 키 컬럼을 ' = ' 로 처리
    -- and 절 : 조건을 처리
-- where 절 
select *
from employee, department
where department.dno = employee.dno
and job = 'MANAGER';

-- ANSI 호환 : (INNER) JOIN <- 모든 SQL 에서 사용 가능한 JOIN
        -- INNER 는 생략 가능
-- on 절 : 두 테이블의 공통의 키 컬럼을 ' = ' 로 처리
    -- where 절 : 조건을 처리
-- on 절 : 공통 키 컬럼을 처리한 경우
select *
from employee e join department d
on e.dno = d.dno
where job = 'MANAGER';


-- EQUI JOIN
select ename, salary, dname, e.dno
from employee e, department d
where e.dno = d.dno
and salary > 2000

-- NATURAL JOIN
select ename, salary, dname,dno
from employee natural join department d
where salary > 2000

-- ANSI : INNER  JOIN
select ename, salary, dname, e.dno
from employee e join department d
on e.dno = d.dno
where salary > 2000

--NOT EQUI JOIN : EQUI JOIN 에서 Where 절의 ' = ' 을 사용하지 않는 JOIN
select * from salgrade

select ename, salary, grade
from employee, salgrade
where salary between losal and hisal;

-- 테이블 3개 조인
select ename, dname, salary, grade
from employee e, department d, salgrade s
where e.dno = d.dno
and salary between losal and hisal

















