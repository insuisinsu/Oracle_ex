-- 2022. 04. 22. 5���� ��������, ��������

/*
�������� : ���̺��� �÷��� �Ҵ�Ǿ �������� ���Ἲ(������ ����)�� Ȯ��
    Primary Key : ���̺� �� ���� ����� �� ���� + �ϳ��� �÷�, �ΰ� �̻��� �׷����ؼ� ����
                  �ߺ��� ���� ���� �� ����
                  NULL �� ���� �� ����
                  
    UNIQUE      : ���̺��� ���� �÷��� �Ҵ��� �� ����
                  �ߺ��� ���� ���� �� ����
                  NULL �� ���� �� ����.. ��, �ѹ��� ���� �� ���� ?- �ߺ��� ���� ���� �� ���
                  
    Foregin Key : �ٸ� ���̺��� Ư�� �÷��� ���� �����ؼ� ���� �� ����
                  �ڽ��� �÷��� ������ ���� �Ҵ����� ����
                  
    NOT NULL    : NULL ���� �÷��� �Ҵ��� �� ����
    
    CHECK       : �÷��� ���� �Ҵ��� �� üũ�ؼ�(���ǿ� �����ϴ�) ���� �Ҵ�
    
    DEFAULT     : ���� ���� ���� �� �⺻���� �Ҵ��
*/

--��������
/*
Sub Query : Select �� ���� Select ���� �ִ� ����
where ������ : sub query
having ������ : sub query
*/

select ename, salary from employee;
select salary from employee where ename = 'SCOTT';

-- SCOTT �� ���ް� ���ų� ���� ����ڸ� ����϶�
select ename, salary
from employee 
where salary >= 3000

select ename, salary
from employee 
where salary >= (select salary from employee where ename = 'SCOTT')

-- SCOTT �� ������ �μ��� �ٹ��ϴ� ����� ����ϱ�
select *
from employee
where dno = (select dno from employee where ename = 'SCOTT')
-- �ּ� �޿��� �޴� ����� �̸�, ������, �޿�
select ename, job, salary
from employee
where salary = (select min (salary) from employee)

-- 30 �� �μ� dno ���� �ּ� ������ �޴� ������� ���� ������ �޴� �������
-- �̸�, �μ�, �μ���ȣ, ����
select ename, dname, e.dno, salary
from employee e join department d
on e.dno = d.dno
where e.dno = 30 and e.salary > (select min(salary) from employee where dno = 30)

--having ���� Sub query ����ϱ�
-- �μ��� �ּҿ����� 30�� �μ��� �ּҿ��� ���� ū �μ�
--30 �� �μ��� �ּҿ��� ���� ū
select dno, min(salary), count(dno)
from employee
group by dno
having min(salary) > (select min(salary) from employee where dno = 30)

/*
������ ���� ���� : sub query �� ��� ���� �� �ϳ��� ���
        . ������ �� ������ : >, =, >=, <, <=, <>, <=
������ ���� ���� : sub query �� ��� ���� ������ ���
        . ������ �������� ������ : IN, ANY, SOME, ALL, EXITS
        IN : ���� ������ �� ���� ( ' = ' �� ���� ���) �� ���������� ����� �߿� �ϳ��� ��ġ�� ���
        ANY, SOME : ���� ������ �������� ���������� �˻� ����� �ϳ� �̻� ��ġ�ϸ� ��
            . ���������� ��ȯ�ϴ� ������ ���� ����
            . ' < any ' �� �ִ밪 ���� ������ ��Ÿ��
            . ' > any ' �� �ּڰ� ���� ŭ
            . ' = any ' �� IN �� ������
        ALL : ���� ������ �������� ���������� �˻� ����� ��� ���� ��ġ�ϸ� ��
            . Sub Query �� ��ȯ�ϴ� ��� ���� ��
            . ' > all '  �� �ִ밪 ���� ŭ
            . ' < all '  �� �ּڰ� ���� ����
        EXITS : ���� ������ �������� ���������� ����� �߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��
*/

--IN ������ ����ϱ�
select ename, eno, dno, salary
from employee
order by dno asc

-- �μ����� �ּ� ������ �޴� ����ڵ� ����ϱ� ( ���������� ����Ͽ� )
select dno, min (salary), count(*)
from employee
group by dno

select ename, dno, salary
from employee
where salary in (select min(salary) from employee group by dno)


-- ������ SALESMAN �� �ƴϸ鼭 �޿���, �޿��� ���� ���� �޴� SALEMAN ���� ���� ���
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
                                     
-- ������ SALESMAN �� �ƴϸ鼭 �޿���, ������ SALEMAN ���� ���� ���
select eno, ename, job, salary
from employee
where job <> 'SALESMAN'
    and salary < all (select salary from employee where job = 'SALESMAN')

-- ��� ������ �м���ANALYST�� ������� �޿��� �����鼭 ������ �м����� �ƴ� �����
select eno, ename, job, salary
from employee
where job <> 'ANALYST'
    and salary < all (select salary from employee where job = 'ANALYST')
select * from employee order by job

-- �޿��� ��� �޿����� ���� ������� �����ȣ�� �̸��� ǥ��.. �޿��� ���� ��������
select eno, ename, salary
from employee
where salary > (select avg(salary) from employee)
order by salary


