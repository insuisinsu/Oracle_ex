-- self join, sub query


7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. 
 	������ ��Ī���� �ѱ۷� �����ÿ�. 
    
select e.ename as �̸�, e.eno as �����ȣ, e.manager as �����ڹ�ȣ, m.eno, m.ename as ������
from employee e join employee m
on e.manager = m.eno
    
8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�. 
select e.ename as �̸�, e.eno as �����ȣ, e.manager as �����ڹ�ȣ, m.ename as ������
from employee e join employee m 
on e.manager = m.eno (+)
order by e.eno

9. SELF JOIN�� ����Ͽ� ������ ����� �̸�, �μ���ȣ, ������ ����� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
   ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 

select e.ename as �̸�, e.dno as �μ���ȣ, m.ename as ����
from employee e join employee m
on e.dno = m.dno and e.ename = 'SCOTT' and m.ename <> 'SCOTT'

10. ??? SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 

select * from employee order by hiredate

select ename as �̸�, hiredate as  �Ի���
from employee
where hiredate > (select hiredate from employee where ename = 'WARD')

select m.ename as �̸�, m.hiredate
from employee e, employee m
where e.ename = 'WARD' and e.hiredate < m.hiredate;

11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
    ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 

select e.ename as ���, e.job, e.hiredate as "��� �Ի���", m.ename as "������ �̸�", m.job, m.hiredate as "������ �Ի���",  e.dno
from employee e join employee m
on e.manager = m.eno
where e.hiredate < m.hiredate
order by e.dno

select * from employee order by dno
    
    
<<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>

1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.  
select ename, job
from employee
where job = (select job from employee where eno = 7788)

2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 
select ename, job
from employee
where salary > (select salary from employee where eno = 7499)

3. ���޺� �ּ� �޿��� �޴� ����� �̸�, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)
select ename, job, salary
from employee
where salary in ( select min(salary) from employee group by job)


�ٽ� �ϱ� 4. ���޺� ��� �޿��� ���ϰ� , �װ� ���� ���� ���޿��� ���� ���� �޿��� �޴� ��� 

select ename �̸�, job ����, salary �޿�
from employee
where salary = (select min(salary) from employee
                group by job
                having avg(salary) = (select min ( avg (salary))
                from employee group by job))

select min (salary) �޿�, job ����
from employee
group by job
having avg(salary) <= all(select avg(salary) from employee group by job);

5. �� �μ��� �ʼ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
select ename, job, salary
from employee
where salary in ( select min(salary) from employee group by dno)

6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.

select eno, ename, job, salary
from employee
where job <> 'ANALYST'
    and salary < all (select salary from employee where job = 'ANALYST')

7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 
select ename
from employee
where not eno in (select nvl(manager, 0) from employee)

8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 
select ename
from employee
where eno in (select manager from employee)

9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 
select ename, hiredate
from employee
where dno = (select dno from employee where ename = 'BLAKE') and ename <> 'BLAKE'


10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 
select eno, ename
from employee
where salary > (select avg(salary) from employee)
order by salary


11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 

select eno, ename
from employee
where dno in (select dno from employee where ename like '%K%')

12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 

select ename, dno, job
from employee
where dno = (select dno from department where loc = 'DALLAS')

13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 
select ename, salary
from employee
where manager = (select eno from employee where ename= 'KING')

14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 
select dno, ename, job
from employee
where dno = (select dno from department where dname = 'RESEARCH')


15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 
��� �޿����� ���� �����鼭 �̸��� M �� �� ����� ���µ���?
select eno, ename, salary
from employee
where dno in ( select dno from employee where ename like '%M%' )

select eno, ename, salary, dno
from employee
where ename like '%M%'
       
select eno, ename, salary
from employee
where salary > (select avg(salary) from employee)

16. ��� �޿��� ���� ���� ������ ã���ÿ�. 

select job, avg(salary)
from employee
group by job
having avg(salary) = (select min(avg(salary)) from employee group by job)

17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 
�� �μ����� �Ŵ����� �� �ִµ���
select *
from employee
where dno in (select dno from employee where job = 'MANAGER')


select ename as �̸�, salary as �޿�, dno as �μ���ȣ
from employee
where salary in (select min(salary) from employee group by dno);

select * from employee



