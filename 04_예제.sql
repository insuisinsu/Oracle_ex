

-- 1. ��� ����� �޿� �ְ��, ������, �Ѿ�, �� ��� �޿��� ��� �Ͻÿ�.
-- �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select max(salary) �ְ��, min(salary) ������, sum(salary) �Ѿ�, round(avg(salary)) "��� �޿�"
from employee;

-- 2. �� ������ �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�.
-- �÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select job, max(salary) as �ְ��, min(salary) as ������, sum(salary) as �Ѿ�, round(avg(salary)) as ��ձ޿�
from employee
group by job;

select dno, job, max(salary) as �ְ��, min(salary) as ������, sum(salary) as �Ѿ�, round(avg(salary)) as ��ձ޿�
from employee
group by cube(dno, job)
order by dno;

-- 3. count(*)�Լ��� ����Ͽ� ��� ������ ������ ������� ����Ͻÿ�. 
select job, count(*)
from employee
group by job;

-- 4. ������ ���� ���� �Ͻÿ�. �÷��� ��Ī�� "�����ڼ�" �� ���� �Ͻÿ�. 
-- count �� null �� �������� ����
select count(distinct(manager)) "������ ��"
from employee;

select manager, count(*) as �����ڼ�
from employee
group by manager;

-- 5. �޿� �ְ��, ���� �޿����� ������ ��� �Ͻÿ�, �÷��� ��Ī�� "DIFFERENCE"�� �����Ͻÿ�.
select max(salary) - min(salary) DIFFERENCE
from employee;

-- 6. ���޺� ����� ���� �޿��� ����Ͻÿ�.
-- �����ڰ� �������� �� �� ���� ��� �� ���� �޿��� 2000�̸��� �׷��� ���� ��Ű��
-- ����� �޿��� ���� ������������ �����Ͽ� ��� �Ͻÿ�. 
select job, min(salary)
from employee
where manager is not null
group by job
having min(salary) > 2000
order by min(salary) desc;

select job, min(salary)
from employee
where manager is not null
group by job
having not min(salary) < 2000
order by min(salary) desc;

-- 7. �� �μ������� �μ���ȣ, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�.
-- �÷��� ��Ī�� [�μ���ȣ, �����, ��ձ޿�] �� �ο��ϰ� ��ձ޿��� �Ҽ��� 2°�ڸ����� �ݿø� �Ͻÿ�. 
select dno �μ���ȣ, count(ename) �����, round(avg(salary),1) ��ձ޿�
from employee
group by dno;


/*
8. �� �μ��� ���� �μ���ȣ�̸�, ������, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. 
�ᷳ�� ��Ī�� �Ʒ� [ ��¿���] �� �����ϰ� ��ձ޿��� ������ �ݿø� �Ͻÿ�.  

[��¿���] 

dname		Location		Number of People		Salary
-----------------------------------------------------------------------------------------------
SALES		CHICAO			6		1567
RESERCH		DALLS			5		2175
ACCOUNTING   	NEW YORK		3		2917
*/
 
select case dno when 10 then 'ACCOUNTING'
                when 20 then 'RESEARCH'
                when 30 then 'SALES'
                ELSE 'DEFAULT'
                END dname,
            decode (dno, 10, 'NEW YORK',
                         20, 'DALLS',
                         30, 'CHICAO',
                        'DEFAULT'
                    ) as Location,
        count(dno) "Number of People", round(avg(salary)) Salary
from employee
group by dno;


-- ���̺� ���� ���� - 06

--1. EQUI ������ ����Ͽ� SCOTT ����� �μ� ��ȣ�� �μ� �̸��� ��� �Ͻÿ�. 
select ename, e.dno , dname
from employee e, department d
where e.dno = d.dno and ename = 'SCOTT'

--2. INNER JOIN�� ON �����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����Ͻÿ�. 
select ename as ����̸�, dname as �μ���, loc as ������
from employee e join department d
on e.dno = d.dno;

--3. INNER JOIN�� USING �����ڸ� ����Ͽ� 10�� �μ��� ���ϴ� ��� ��� ������
-- ������ ���(�ѹ����� ǥ��)�� �μ��� �������� �����Ͽ� ��� �Ͻÿ�. 
select dno, job, loc
from employee e join department d
using(dno)
where dno = 10

--4. NATUAL JOIN�� ����Ͽ� Ŀ�Լ��� �޴� ��� ����� �̸�, �μ��̸�, �������� ��� �Ͻÿ�. 
select ename, dname, commission, loc
from employee natural join department
where commission > 0;

select ename, dname, commission, loc
from employee natural join department
where commission is not null;

--5. EQUI ���ΰ� WildCard�� ����Ͽ� �̸��� A �� ���Ե� ��� ����� �̸��� �μ����� ��� �Ͻÿ�. 
select ename, dname
from employee e, department d
where e.dno = d.dno
    and ename like '%A%'

--6. NATURAL JOIN�� ����Ͽ� NEW YORK�� �ٹ��ϴ� ��� �����
--�̸�, ����, �μ���ȣ �� �μ����� ����Ͻÿ�. 
select ename, job, dno, dname
from employee natural join department
where loc = 'NEW YORK'

select * from department
select * from employee order by dno


