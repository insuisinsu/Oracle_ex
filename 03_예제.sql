

--1. SUBSTR �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ��� �Ͻÿ�. 
select hiredate, substr (hiredate, 1, 5)
from employee;

--2. SUBSTR �Լ��� ����Ͽ� 4���� �Ի��� ����� ��� �Ͻÿ�. 
select *
from employee
where substr ( hiredate, 4, 2) = 04;


--3. MOD �Լ��� ����Ͽ� ���ӻ���� Ȧ���� ����� ����Ͻÿ�. 
select *
from employee
where mod ( manager , 2) != 0;

--3-1. MOD �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select *
from employee
where mod ( salary, 3) = 0;

--4. �Ի��� �⵵�� 2�ڸ� (YY), ���� (MON)�� ǥ���ϰ� ������ ��� (DY)�� �����Ͽ� ��� �Ͻÿ�. 
select to_char(hiredate, 'YY MON DD DY')
from employee;

--5. ���� �� ���� �������� ��� �Ͻÿ�. ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� TO_DATE �Լ��� ����Ͽ�
--   ������ ������ ��ġ ��Ű�ÿ�. 
select sysdate, trunc(sysdate - to_date(20000101, 'YYYYMMDD'))
from dual;


--5-1. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
select trunc(sysdate - to_date(19930820, 'YYYYMMDD'))
from dual;

--5-2. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���. 
select trunc (months_between(sysdate, '1993/08/20'))
from dual;

--6. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�. 
select coalesce ( manager, 0)
from employee;

--7.  DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANAIYST' ����� 200 , 'SALESMAN' ����� 180,
--    'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�. 
select ename, job, salary as "���� �޿�", decode(job, 'ANALYST', salary + 200,
                        'SALESMAN', salary + 180,
                        'MANAGER', salary + 150,
                        'CLERK', salary + 100,
                        salary) as "�λ�� �޿�"
from employee;

-- �����ȣ [�����ȣ 2�ڸ��� ���, �������� * ����] as "���� ��ȣ", �̸�, [�̸��� ù�ڸ� ���, ���ڸ��� *�� ����]
select eno, rpad(substr(eno, 1, 2), 4, '*') "���� ��ȣ", ename, rpad(substr(ename, 1, 1),4,'*') "���� �̸�"
from employee;

-- �ֹι�ȣ �� ����ϵ� ���ڸ� 1 ������, �������� *�� ����, ��ȭ��ȣ ��2 ��4 *�� ������
select rpad(substr('930820 - 1234567', 1, 10), 16, '*'),
rpad(substr('010-7799-3025', 1, 6), 13, '*')
from dual;

-- �����ȣ, �����, ���ӻ�� 
    -- ���ӻ���� �����ȣ�� ���� ��� 0000
    -- �� 2�ڸ��� 75�� ��� 5555
    -- �� 2�ڸ��� 76�� ��� 6666
    -- �� 2�ڸ��� 77�� ��� 7777
    -- �� 2�ڸ��� 78�� ��� 8888
    -- �������� �״��
    
    
select eno, ename, manager,  case  WHEN manager is null THEN 0000
                                  WHEN substr(manager, 1, 2) = 76 THEN 5555
                                  WHEN substr(manager, 1, 2) = 77 THEN 6666
                                  WHEN substr(manager, 1, 2) = 78 THEN 7777
                                  WHEN substr(manager, 1, 2) = 75 THEN 8888
                                   ELSE eno
                                  END as eno
from employee;

