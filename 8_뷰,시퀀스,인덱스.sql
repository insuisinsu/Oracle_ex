--8일차  뷰

/*
뷰(view) : 가상의 테이블
    - 테이블은 데이터 값을 가지고 있음
    - 뷰는 데이터를 가지지 않음. 실행 코드만 들어가 있음
    
    뷰를 사용하는 목적
    - 보안 : 실제 테이블의 특정 컬럼만 가져와서 실제 테이블의 중요 컬럼을 숨길 수 있음
    - 복잡한 쿼리를 뷰를 생성해서 편리하게 사용할 수 있음 ( 복잡한 JOIN 쿼리 )
    
    - 뷰는 일반적으로 select 구문이 온다.
    - 뷰에는 insert, update, delete 구문이 올 수 없음
    - 뷰에 값을 insert 하면 실제 테이블에 저장됨
        단, 실제 테이블의 제약조건을 만족해야 함
*/

create table dept_copy60
as
select * from department;

create table emp_copy60
as
select * from employee;

-- 뷰 생성
create view v_emp_job
as
select eno, ename, dno, job
from emp_copy60
where job like 'SALESMAN';

-- 뷰 생성 확인
select * from user_views;

-- 뷰 실행
select * from v_emp_job;

-- 복잡한 조인 쿼리를 뷰에 생성하기
create view v_join
as
select e.dno, ename, job, dname, loc
    from employee e, department d
where e.dno = d.dno
    and job = 'SALESMAN';

select * from v_join;

-- 뷰를 사용해서 실제 테이블의 중요한 정보 숨기기 ( 보안 )
select * from emp_copy60;

create view simple_emp
as
select ename, job, dno
from emp_copy60;

-- view 를 사용해서 실제 테이블의 중요 컬럼을 숨김
select * from simple_emp;
select * from user_views;

-- view 를 생성할 때 반드시 별칭을 사용해야 하는 경우
-- group by 할때
create view v_grouping
as
select dno, count(*) as 부서인원, avg(salary) as 월급평균, sum(salary) as 월급합계
from emp_copy60
group by dno;

select * from v_gruopping;

-- 뷰를 생성할 때 as 하위에 selecte 가 와야함
-- insert, update, delete 는 올 수 없음
create view v_error
as
insert into dno
values (60, 'HR', 'BUSAN');

-- 컬럼의 제약 조건을 만족하면 view 에도 값을 넣을 수 있음
-- 실제 테이블에 값이 insert 됨

create view v_dept
as
select dno, dname
from dept_copy60;

select * from dept_copy60;
select * from v_dept;

insert into v_dept
values(70, 'HR');

-- v_dept 가 존재하지 않을 경우 create 하고,
-- 존재할 경우 replace 해라
create or replace view v_dept
as
select dname, loc
from dept_copy60;

insert into v_dept
values('HR2', 'BUSAN');
select * from user_constraints
where table_name = 'DEPT_COPY60'


/*
예제
*/
create view emp_view
as
select * from employee;
-- 뷰 생성
create view v_em_dno
as
select eno, ename, dno
from emp_view
where dno = 20;

-- 뷰 실행
select * from v_em_dno;

create or replace view v_em_dno
as
select eno, ename, dno, salary from emp_view
where dno = 20;

-- 뷰 제거
drop view v_em_dno;

create or replace view v_sal_emp
as 
select dno as dno, min(salary) as min, max(salary) as max, round(avg(salary), 2) as avg, sum(salary) as sum
from emp_view
group by dno;

select * from v_sal_emp;

-- 읽기 전용으로 만들기
-- view 생성할 때 마지막 줄에 추가
with read only;










