--8����  ��

/*
��(view) : ������ ���̺�
    - ���̺��� ������ ���� ������ ����
    - ��� �����͸� ������ ����. ���� �ڵ常 �� ����
    
    �並 ����ϴ� ����
    - ���� : ���� ���̺��� Ư�� �÷��� �����ͼ� ���� ���̺��� �߿� �÷��� ���� �� ����
    - ������ ������ �並 �����ؼ� ���ϰ� ����� �� ���� ( ������ JOIN ���� )
    
    - ��� �Ϲ������� select ������ �´�.
    - �信�� insert, update, delete ������ �� �� ����
    - �信 ���� insert �ϸ� ���� ���̺� �����
        ��, ���� ���̺��� ���������� �����ؾ� ��
*/

create table dept_copy60
as
select * from department;

create table emp_copy60
as
select * from employee;

-- �� ����
create view v_emp_job
as
select eno, ename, dno, job
from emp_copy60
where job like 'SALESMAN';

-- �� ���� Ȯ��
select * from user_views;

-- �� ����
select * from v_emp_job;

-- ������ ���� ������ �信 �����ϱ�
create view v_join
as
select e.dno, ename, job, dname, loc
    from employee e, department d
where e.dno = d.dno
    and job = 'SALESMAN';

select * from v_join;

-- �並 ����ؼ� ���� ���̺��� �߿��� ���� ����� ( ���� )
select * from emp_copy60;

create view simple_emp
as
select ename, job, dno
from emp_copy60;

-- view �� ����ؼ� ���� ���̺��� �߿� �÷��� ����
select * from simple_emp;
select * from user_views;

-- view �� ������ �� �ݵ�� ��Ī�� ����ؾ� �ϴ� ���
-- group by �Ҷ�
create view v_grouping
as
select dno, count(*) as �μ��ο�, avg(salary) as �������, sum(salary) as �����հ�
from emp_copy60
group by dno;

select * from v_gruopping;

-- �並 ������ �� as ������ selecte �� �;���
-- insert, update, delete �� �� �� ����
create view v_error
as
insert into dno
values (60, 'HR', 'BUSAN');

-- �÷��� ���� ������ �����ϸ� view ���� ���� ���� �� ����
-- ���� ���̺� ���� insert ��

create view v_dept
as
select dno, dname
from dept_copy60;

select * from dept_copy60;
select * from v_dept;

insert into v_dept
values(70, 'HR');

-- v_dept �� �������� ���� ��� create �ϰ�,
-- ������ ��� replace �ض�
create or replace view v_dept
as
select dname, loc
from dept_copy60;

insert into v_dept
values('HR2', 'BUSAN');
select * from user_constraints
where table_name = 'DEPT_COPY60'


/*
����
*/
create view emp_view
as
select * from employee;
-- �� ����
create view v_em_dno
as
select eno, ename, dno
from emp_view
where dno = 20;

-- �� ����
select * from v_em_dno;

create or replace view v_em_dno
as
select eno, ename, dno, salary from emp_view
where dno = 20;

-- �� ����
drop view v_em_dno;

create or replace view v_sal_emp
as 
select dno as dno, min(salary) as min, max(salary) as max, round(avg(salary), 2) as avg, sum(salary) as sum
from emp_view
group by dno;

select * from v_sal_emp;

-- �б� �������� �����
-- view ������ �� ������ �ٿ� �߰�
with read only;










