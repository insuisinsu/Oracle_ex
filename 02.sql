-- 2일차 : DQL : Select

-- desc 테이블명 : 테이블의 구조 확인

desc department;

select * from department;

/*
SQL  = 구조화된 질의언어
Select 구문의 전체 필드 내용

아래 순서대로 입력되어야 하며, 생략될 수 있음

Selct - 컬럼명
Distinct -  컬럼 내의 중복값 제거
From - 테이블명, 뷰명
Where - 조건
Group By - 특정 값을 그룹핑
Having - 그룹핑한 값을 정렬
Order by - 값을 정렬해서 출력
*/

desc employee;
select * 
from employee;

-- 특정 컬럼만 출력하기
select eno, ename from employee;

-- 특정 컬럼을 여러 번 출력
select eno, ename, eno, ename, ename from employee;
select eno, ename, salary from employee;

-- 컬럼에 연산을 적용
select eno, ename, salary, salary * 12 from employee;

--컬럼명 알리어스 ( Alias )
--컬럼에 연산을 하거나 함수를 사용하면 컬럼명이 없어진다.
Select eno, ename, salary, salary * 12 as 연봉 from employee;
select eno as 사원번호, ename as 사원명, salary as 월급, salary * 12 as 연봉 from employee;
--as 는 생략 가능
Select eno 사원번호, ename 사원명, salary 월급, salary * 12 연봉 from employee;
--공백이나 특수문자가 들어갈 때는 "" 으로 묶어줘야 함
Select eno "사원 #번호", ename 사원명, salary 월급, salary * 12 연봉 from employee;

-- nvl 함수 : 연산시에 null을 처리하는 함수
select * from employee;

-- nvl 함수를 사용하지 않고 전체 연봉을 계산.  (null이 포함된 컬럼에 연산을 적용하면 null)
    -- null을 0으로 처리해서 연산 해야 한다. : NVL
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
salary * 12,
salary *12 + commission       -- 전체 연봉
from employee;

-- nvl 함수를 사용해서 연산
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
salary * 12,
salary *12 + NVL(commission, 0)       -- 전체 연봉
from employee;

-- 특정 컬럼의 내용을 중복 제거후 출력
select * from employee;
select dno from employee;
select distinct dno from employee;

-- select ename, distinct dno from employee; -- 다른컬럼 때문에 오류가 날 수 있다.

-- 조건을 사용해서 검색 (Where)
select * from employee;
select eno 사원번호, ename 사원명, job 직책, manager 직속상관, hiredate 입사날짜,
    salary 월급, commission 보너스, dno 부서번호
    from employee;
    
-- 사원 번호가 7788인 사원의 이름을 검색.
select * from employee
where eno = 7788;

select ename from employee
where eno = 7788;

-- 사원 번호가 7788인 사원의 부서번호, 월급과 입사날짜를 검색.
select dno 부서번호, salary 월급, hiredate 입사날짜 from employee
where eno = 7788;

desc employee;

select *
from employee
where ename = 'SMITH';

-- 레코드를 가져올때 
    -- number 일때는 ''를 붙히지 않는다.
    -- 문자 데이터(Char, Varchar2)나 날짜(Date)를 가져올때는  ''를 처리.
    -- 대소문자를 구분
    
-- 입사날짜가 '81/12/03' 인 사원 출력
select ename, hiredate
from employee
where hiredate = '81/12/03';

-- 부서 코드가 10인 모든 사원들을 출력
select ename , dno
from employee
where dno = 10;

select * from employee;

-- 월급이 3000이상인 사원의 이름과 부서와 입사 날짜, 월급을 출력.
select ename, dno, hiredate, salary
from employee
where salary >= 3000 ;

-- null 검색 : is 키워드 사용.
select *
from employee
where commission is null;

-- commission이 300 이상인 사원이름과, 직책, 월급을 출력
select ename, job, salary, commission
from employee
where commission >= 300;

-- 커밋션이 없는 사원들의 이름을 출력.
select ename, commission
from employee
where commission is null;

-- 조건에서 and, or, not

-- 월급이 500 이상 2500 미만인 사원들의 이름, 사원번호, 입사날짜, 월급을 출력.
select ename, eno, hiredate, salary
from employee
where salary >= 500 and salary < 2500;

-- 1. 직책이 SALESMAN 이거나, 부서코드가 20인 사원 이름, 직책, 월급, 부서코드
select * from employee;

select ename, job, salary, dno
from employee
where job = 'SALESMAN' or dno = 20;

-- 2. commission 없는 사용자중에 부서코드가 20인 사용자의 이름, 부서코드와 입사날짜를 출력.
select ename, dno, hiredate
from employee
where commission is null and dno = 20;
 
-- 3. commission 이 null이 아닌 사원 이름, 입사날짜, 월급
select ename, hiredate, salary
from employee
where commission is not null;

-- 날짜 검색
-- between A and B : A 이상 B 이하
select * from employee;

--1982/01/01 ~ 1983 사이에 입사한 사원

select *
from employee
where hiredate between '1982/01/01' and '1983/01/01';

-- IN 연산자
-- commission 이 300, 500, 1400 인 사원의 ename, job, hiredate
select ename, job, hiredate
from employee
where commission = 300 or commission = 500 or commission = 1400;
공용 동의어

select ename, job, hiredate
from employee
where commission in (300, 500, 1400);

-- like : 컬럼 내의 특정한 문자열을 검색
    -- 게시판 등에서 글 검색 기능을 사용할 때 많이 사용함
    -- % : 뒤에 어떤 글자가 와도 상관 없음
    -- _ : 뒤에 한 글자가 어떤 값이라도 상관 없음
    
-- F 로 시작하는 이름을 가진 사원 검색
select *
from employee
where ename like 'F%';

-- 이름이 ES 로 끝나는 사원 검색
select *
from employee
where ename like '%ES';

-- J 로 시작하고 J 뒤의 두 글자는 노상관, ES 로 끝나는  사원
select *
from employee
where ename like 'J__ES';

-- R 로 끝나는 사원
select * from employee
where ename like '%R';

-- MAN 이 들어간 직책 출력
select * from employee
where job like '%MAN%';

-- 81년 2월에 입사한 사원 출력
select *
from employee
where hiredate like '81/02%';

-- 정렬 : order by  
    -- asc - 오름차순 // default
    -- desc - 내림차순
    
select * 
from employee
order by eno desc;

-- 두 개 이상의 컬럼을 정렬할 때
-- 질문답변형 게시판에서 주로 사용

select * from employee
order by dno desc;

-- 1순위 dno, 2순위 ename 
select * 
from employee
order by dno, ename;

-- where 과 order by 를 같이 사용
-- 커미션 없는 직원들을 이름 역순으로 정렬
select *
from employee
where commission is null
order by ename desc;








