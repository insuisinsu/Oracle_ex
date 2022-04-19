-- 2���� : DQL : Select

-- desc ���̺�� : ���̺��� ���� Ȯ��

desc department;

select * from department;

/*
SQL  = ����ȭ�� ���Ǿ��
Select ������ ��ü �ʵ� ����

�Ʒ� ������� �ԷµǾ�� �ϸ�, ������ �� ����

Selct - �÷���
Distinct -  �÷� ���� �ߺ��� ����
From - ���̺��, ���
Where - ����
Group By - Ư�� ���� �׷���
Having - �׷����� ���� ����
Order by - ���� �����ؼ� ���
*/

desc employee;
select * 
from employee;

-- Ư�� �÷��� ����ϱ�
select eno, ename from employee;

-- Ư�� �÷��� ���� �� ���
select eno, ename, eno, ename, ename from employee;
select eno, ename, salary from employee;

-- �÷��� ������ ����
select eno, ename, salary, salary * 12 from employee;

--�÷��� �˸�� ( Alias )
--�÷��� ������ �ϰų� �Լ��� ����ϸ� �÷����� ��������.
Select eno, ename, salary, salary * 12 as ���� from employee;
select eno as �����ȣ, ename as �����, salary as ����, salary * 12 as ���� from employee;
--as �� ���� ����
Select eno �����ȣ, ename �����, salary ����, salary * 12 ���� from employee;
--�����̳� Ư�����ڰ� �� ���� "" ���� ������� ��
Select eno "��� #��ȣ", ename �����, salary ����, salary * 12 ���� from employee;

-- nvl �Լ� : ����ÿ� null�� ó���ϴ� �Լ�
select * from employee;

-- nvl �Լ��� ������� �ʰ� ��ü ������ ���.  (null�� ���Ե� �÷��� ������ �����ϸ� null)
    -- null�� 0���� ó���ؼ� ���� �ؾ� �Ѵ�. : NVL
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
salary * 12,
salary *12 + commission       -- ��ü ����
from employee;

-- nvl �Լ��� ����ؼ� ����
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
salary * 12,
salary *12 + NVL(commission, 0)       -- ��ü ����
from employee;

-- Ư�� �÷��� ������ �ߺ� ������ ���
select * from employee;
select dno from employee;
select distinct dno from employee;

-- select ename, distinct dno from employee; -- �ٸ��÷� ������ ������ �� �� �ִ�.

-- ������ ����ؼ� �˻� (Where)
select * from employee;
select eno �����ȣ, ename �����, job ��å, manager ���ӻ��, hiredate �Ի糯¥,
    salary ����, commission ���ʽ�, dno �μ���ȣ
    from employee;
    
-- ��� ��ȣ�� 7788�� ����� �̸��� �˻�.
select * from employee
where eno = 7788;

select ename from employee
where eno = 7788;

-- ��� ��ȣ�� 7788�� ����� �μ���ȣ, ���ް� �Ի糯¥�� �˻�.
select dno �μ���ȣ, salary ����, hiredate �Ի糯¥ from employee
where eno = 7788;

desc employee;

select *
from employee
where ename = 'SMITH';

-- ���ڵ带 �����ö� 
    -- number �϶��� ''�� ������ �ʴ´�.
    -- ���� ������(Char, Varchar2)�� ��¥(Date)�� �����ö���  ''�� ó��.
    -- ��ҹ��ڸ� ����
    
-- �Ի糯¥�� '81/12/03' �� ��� ���
select ename, hiredate
from employee
where hiredate = '81/12/03';

-- �μ� �ڵ尡 10�� ��� ������� ���
select ename , dno
from employee
where dno = 10;

select * from employee;

-- ������ 3000�̻��� ����� �̸��� �μ��� �Ի� ��¥, ������ ���.
select ename, dno, hiredate, salary
from employee
where salary >= 3000 ;

-- null �˻� : is Ű���� ���.
select *
from employee
where commission is null;

-- commission�� 300 �̻��� ����̸���, ��å, ������ ���
select ename, job, salary, commission
from employee
where commission >= 300;

-- Ŀ�Լ��� ���� ������� �̸��� ���.
select ename, commission
from employee
where commission is null;

-- ���ǿ��� and, or, not

-- ������ 500 �̻� 2500 �̸��� ������� �̸�, �����ȣ, �Ի糯¥, ������ ���.
select ename, eno, hiredate, salary
from employee
where salary >= 500 and salary < 2500;

-- 1. ��å�� SALESMAN �̰ų�, �μ��ڵ尡 20�� ��� �̸�, ��å, ����, �μ��ڵ�
select * from employee;

select ename, job, salary, dno
from employee
where job = 'SALESMAN' or dno = 20;

-- 2. commission ���� ������߿� �μ��ڵ尡 20�� ������� �̸�, �μ��ڵ�� �Ի糯¥�� ���.
select ename, dno, hiredate
from employee
where commission is null and dno = 20;
 
-- 3. commission �� null�� �ƴ� ��� �̸�, �Ի糯¥, ����
select ename, hiredate, salary
from employee
where commission is not null;

-- ��¥ �˻�
-- between A and B : A �̻� B ����
select * from employee;

--1982/01/01 ~ 1983 ���̿� �Ի��� ���

select *
from employee
where hiredate between '1982/01/01' and '1983/01/01';

-- IN ������
-- commission �� 300, 500, 1400 �� ����� ename, job, hiredate
select ename, job, hiredate
from employee
where commission = 300 or commission = 500 or commission = 1400;
���� ���Ǿ�

select ename, job, hiredate
from employee
where commission in (300, 500, 1400);

-- like : �÷� ���� Ư���� ���ڿ��� �˻�
    -- �Խ��� ��� �� �˻� ����� ����� �� ���� �����
    -- % : �ڿ� � ���ڰ� �͵� ��� ����
    -- _ : �ڿ� �� ���ڰ� � ���̶� ��� ����
    
-- F �� �����ϴ� �̸��� ���� ��� �˻�
select *
from employee
where ename like 'F%';

-- �̸��� ES �� ������ ��� �˻�
select *
from employee
where ename like '%ES';

-- J �� �����ϰ� J ���� �� ���ڴ� ����, ES �� ������  ���
select *
from employee
where ename like 'J__ES';

-- R �� ������ ���
select * from employee
where ename like '%R';

-- MAN �� �� ��å ���
select * from employee
where job like '%MAN%';

-- 81�� 2���� �Ի��� ��� ���
select *
from employee
where hiredate like '81/02%';

-- ���� : order by  
    -- asc - �������� // default
    -- desc - ��������
    
select * 
from employee
order by eno desc;

-- �� �� �̻��� �÷��� ������ ��
-- �����亯�� �Խ��ǿ��� �ַ� ���

select * from employee
order by dno desc;

-- 1���� dno, 2���� ename 
select * 
from employee
order by dno, ename;

-- where �� order by �� ���� ���
-- Ŀ�̼� ���� �������� �̸� �������� ����
select *
from employee
where commission is null
order by ename desc;








