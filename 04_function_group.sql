-- 4����
/*
�׷��Լ� : ������ ���� ���ؼ� �׷��� �Ͽ� ó���ϴ� �Լ�
    group by  ���� Ư�� �÷��� ������ ���, �ش� �÷��� ������ ������ �׷����ؼ� ������ ����
    
�����Լ� :
    SUM : �׷��� �հ�
    AVG : �׷��� ���
    MAX : �׷��� �ִ밪
    MIN : �׷��� �ּҰ�
    COUNT : �׷��� �� ���� ( ���ڵ� �� )
*/

select sum (salary), round (avg (salary), 2), max (salary), min (salary)
from employee;

-- ���� : ���� �Լ��� ó���� �� .. ����÷� ���
-- ���� �Լ� ������, ���� �� �ٷ� ����
-- �ٵ� ename �� ���� �� ¥�� �÷��� ���� ������ ���� ��
/*  ����
select sum (salary), ename
from employee;
*/

select * from employee;

-- �����Լ��� null ���� ó���ؼ� �����Ѵ�.
select sum (commission), round (avg (commission), 2), max (commission), min (commission)
from employee;

-- count () : ���ڵ� ��, �ο� ��
select count (eno) from employee; --14
-- ��, null �� ������� ����
select count (commission) from employee; --4
-- ���̺��� ��ü ���ڵ� ���� ������ ��� count(*) or NOT NULL �� ������ �÷��� count()
select count(*) from employee;
select count(ename) from employee;

-- �ߺ����� �ʴ� ������ ���� // count (distinct Į����)
select job from employee;
select count (distinct job) from employee;
--�μ��� ����
select count (distinct dno) from employee;

--Group by : Ư�� �÷��� ��(�ߺ��Ǵ� ��)�� �׷��� �Ѵ�.
-- �ַ� �����Լ��� select ������ ���� �����
/*
select �÷���, �����Լ� ó���� �÷�
from ���̺�
where ����
group by �÷���
having ���� ( group by �� ����� ���� )
order by ����
*/

select dno from employee order by dno;
select dno from employee group by dno order by dno;

-- ��ü ��� �޿�
select avg(salary) as ��ձ޿�
from employee

-- �μ��� ��� �޿�
select dno as �μ���ȣ, avg(salary) as ��ձ޿�
from employee
group by dno

-- �μ��� �� �޿�
select dno, sum(salary)
from employee
group by dno

-- �μ��� - group by dno �� �����̹Ƿ�
-- �μ��� �ο��� - count(dno), �μ��� �� �޿� - sum(salary), �μ��� ��� �޿� - avg(salary)
-- �μ��� �ִ� ���ʽ� �޴� ����� �׼� - max(commission), �μ��� �ּ� ���ʽ� �޴� �׼� - min(commission)
select dno, count(dno), sum(salary), avg(salary), max(commission), min(commission)
from employee
group by dno
-- ���ڵ� ���� ���� ������ ������
/*
select dno, count(dno), sum(salary), ename
from employee
group by dno
*/

-- ������ ��å�� �׷����ؼ� ������ ���, �հ�, �ִ밪, �ּҰ�
select job ����, count(job) "������ �ο���", avg(salary) "������ ��ձ޿�",
sum(salary) "������ �� �޿�", max(salary) "�������� �޿� �ִ�", min(salary) "�������� �޿� �ּ�"
from employee
group by job;

--���� �÷��� �׷��� �ϱ�
-- ���� 1 - dno, ���� 2 - job
select dno, job, count(*), sum (salary)
from employee
group by dno, job
order by dno;
--Ȯ�� / dno 20, job CLERK �� 2���ΰ�?
select dno, job
from employee
where dno = 20 and job = 'CLERK';

--having : group by ���� ���� ����� �������� ó���� ��
-- �μ��� ������ �հ谡 9000 �̻��� �͸� ���
select dno , count(*), sum (salary) �μ����հ�, round(avg(salary), 2)
from employee
group by dno
having sum(salary) > 9000;
--�μ��� ������ ����� 2000 �̻� ���

-- ������ 1500 ���ϴ� �����ϰ� �� �μ����� ������ ����� 2500 �̻��� �͸� ����϶�
select dno, round(avg(salary))
from employee
where salary > 1500
group by dno
having avg(salary) >= 2500
order by dno;

-- ROLLUP
-- �� �÷� �̻� ��� ����
-- CUBE
    -- group by �� �ȿ��� ����ϴ� Ư���� �Լ�
    -- ���� �÷��� ���� �� �� �ִ�
    -- group by ���� �ڼ��� ���� ���
    -- ROLLUP �Լ��� �Ұ�� �հ踦 ������ �°� ��ȯ������
    -- CUBE �Լ��� ��� ������ ��� �Ұ�� �հ踦 ��ȯ�Ѵ�.

-- rollup ������
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by rollup(dno)
order by dno;
-- rollup ����
select dno, count(*), sum(salary), round(avg(salary))
from employee
group by rollup(dno)
order by dno;

-- �μ��� �հ�� ����� ��� ��, ������ ���ο� ��ü �հ�, ��� ���
select dno, job, count(*), max(salary), sum(salary), round(avg(salary))
from employee
group by cube(dno, job)
order by dno;
-- rollup - dno ���� ���� ���, job �������ε� ���
select dno, job, count(*), max(salary), sum(salary), round(avg(salary))
from employee
group by rollup(dno, job)
order by dno;

--Join : ���� ���̺��� ���ļ� �� ���̺��� �÷��� �����´�.
    -- department �� employee �� ������ �ϳ��� ���̺��̾����� �𵨸�(�ߺ�����, �������) �� ���� �� ���̺�� �и�
    -- �� ���̺��� ����Ű �÷�(dno), employee ���̺��� dno �÷��� department ���̺��� dno �÷��� ������
    -- �� �� �̻��� ���̺��� �÷��� JOIN ������ ����ؼ� ���

-- EQUI JOIN : ����Ŭ���� ���� ���� ����ϴ� JOIN,
        -- Oracle ������ ��� ����
    -- from �� : ������ ���̺���   ' , ' �� ó��
    -- where �� : �� ���̺��� ������ Ű �÷��� ' = ' �� ó��
    -- and �� : ������ ó��
    
select *
from employee, department
where department.dno = employee.dno
and job = 'MANAGER';

-- JOIN �� ���̺� �˸��
    -- from ���̺�� ��Ī, ���̺�� ��Ī
    -- where ��Ī.����Ű = ��Ī.����Ű
select *
from employee e, department d
where e.dno = d.dno
and salary > 1500;

-- select ������ ����Ű �÷��� ��½ÿ� ��� ���̺��� �÷����� ����ؾ� ��
select eno, job, d.dno, dname
from employee e, department d
where e.dno = d.dno;

-- �� ���̺��� JOIN �ؼ� �μ����� salary �� max �� dname ���� ��� 
select dname, count(*), max(salary)
from department d, employee e
where d.dno = e.dno
group by dname;

-- NATURAL JOIN : Oracle 9i ���� ����
    -- WQUI JOIN �� Where ���� ���� ( �� ���̺��� ����Ű �÷��� ' = ' �� ó���� )
    -- ����Ű �÷��� Oracle ���������� �ڵ����� �����ؼ� ó��
    -- ����Ű �÷��� ��Ī �̸��� ����ϸ� ���� �߻�
    -- �ݵ�� ����Ű �÷��� ������ Ÿ���� ���ƾ� ��
    -- from ���� natural join Ű���带 ���
select eno, ename, dname, dno
from employee e natural join department d
-- ���� : select ���� ����Ű �÷��� ����� �� ���̺��� ������� �ʾƾ� ��

/*
EQUI JOIN vs. NATURAL JOIN �� ���� Ű �÷� ó��
EQUI JOIN : ����Ű �÷��� ����� �� select ���� �ݵ�� ���̺� ���� ����ؾ� ��
NATURAL JOIN : ����Ű �÷��� ����� �� select ���� ���̺� ���� ����ϸ� �ȵ�
*/


-- where �� : �� ���̺��� ������ Ű �÷��� ' = ' �� ó��
    -- and �� : ������ ó��
-- where �� 
select *
from employee, department
where department.dno = employee.dno
and job = 'MANAGER';

-- ANSI ȣȯ : (INNER) JOIN <- ��� SQL ���� ��� ������ JOIN
        -- INNER �� ���� ����
-- on �� : �� ���̺��� ������ Ű �÷��� ' = ' �� ó��
    -- where �� : ������ ó��
-- on �� : ���� Ű �÷��� ó���� ���
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

--NOT EQUI JOIN : EQUI JOIN ���� Where ���� ' = ' �� ������� �ʴ� JOIN
select * from salgrade

select ename, salary, grade
from employee, salgrade
where salary between losal and hisal;

-- ���̺� 3�� ����
select ename, dname, salary, grade
from employee e, department d, salgrade s
where e.dno = d.dno
and salary between losal and hisal

/*
JOIN ���� USING �� ����ϴ� ���
    NATURAL JOIN : ���� Ű �÷��� Oracle ���ο��� �ڵ����� ó��
                - �ݵ�� �� ���̺��� ����Ű �÷��� ������ Ÿ���� ���ƾ� ��
            - �� ���̺��� ����Ű �÷��� ������ Ÿ���� �ٸ���� USING �� ���
            - �� ���̺��� ���� Ű �÷��� �������� ��� USING �� ���
*/

/*
SELF JOIN : �ڱ� �ڽ��� ���̺��� �����Ѵ�.
        - �ַ� ����� ��� ������ ����� �� �����, ������ ����
        - ��Ī�� ����ؾ� ��
        - select �� : ��� ���̺��� �÷����� ����ؾ� ��  /  ��Ī��.�÷���
*/

select eno, ename, manager
from employee
where manager = 7788

--self join �� ����ؼ� ����� �̸��� ���ӻ���� �̸��� ���
select e.eno as �����ȣ, e.ename as ����̸�, e.manager as �����ȣ, m.ename as ����̸�
from employee e, employee m    -- Self Join
where e.manager = m.eno
order by e.ename

select e.ename || ' �� ���ӻ���� ' || e.manager || ' �Դϴ�.'
from employee e, employee m
where e.manager = m.eno
order by e.ename

select eno, ename, manager, eno, ename
from employee

-- EQUI JOIN ���� SELF JOIN �� ó��

-- ANSI ȣȯ : INNER JOIN ���� ó��
select e.eno, e.ename, e.manager, m.ename
from employee e join employee m
on e.manager = m.eno

select e.ename || ' �� ���ӻ���� ' || e.manager || ' �Դϴ�.'
from employee e join employee m
on e.manager = m.eno

/*
OUTER JOIN
    : Ư�� �÷��� �� ���̺��� ���������� ���� ������ ����� �� ���
    : Null �� ��µ�
    : ( + ) �� ����Ͽ� ��� ( Oracle ) 
    : RIGHT/LEFT OUTER JOIN �� ����Ͽ� ��� ( ANSI )
        . Left Outer Join : �������� �κ��� ������ ���� ���̺��� ������ ���
        . Right Outer Join : �������� �κ��� ������ ������ ���̺��� ������ ���
        . Full Outer Join : �������� �κ��� ������ ���� ���̺��� ������ ���
*/
--OUTER JOIN - ( + ) ���
select e.ename, m.ename
from employee e join employee m
on e.manager = m.eno (+)
order by e.ename

--OUTER JOIN - ANSI
--left outer join
select e.ename, m.ename
from employee e left outer join employee m
on e.manager = m.eno
order by e.ename
--right outer join
select e.ename, m.ename
from employee e right outer join employee m
on e.manager = m.eno
order by e.ename
--full outer join
select e.ename, m.ename
from employee e full outer join employee m
on e.manager = m.eno
order by e.ename
