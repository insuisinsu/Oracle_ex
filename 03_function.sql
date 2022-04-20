-- ���� �Լ�
/*
ROUND : Ư�� �ڸ������� �ݿø�
TRUNK : Ư�� �ڸ������� ����
MOD   :  �Է� ���� ���� ���� ������ ���� ���
*/

-- round(���) : �Ҽ��� ù�ڸ����� �ݿø��Ͽ� ������ ǥ��
-- round(���, �ڸ���) : �ݿø� �Ͽ� �ڸ��� ���� ǥ��
    -- �ڸ����� ����� �Ҽ��� �ڸ��� ���� ǥ��
    -- �ڸ����� ������ �����ʿ��� �ڸ������� �ݿø�
select 98.7654, round(98.7654), round(98.7654, 2), round(7598.7654, -2)
from dual;

-- trunc(���) : �Ҽ��� ����
-- trunc(���, �ڸ���) : �ڸ������� ����
    -- �ڸ����� ����� �ڸ��� �Ʒ� ����
    -- �ڸ����� �����̸� ���������� �ڸ��� ��ŭ ����
select 98.7654, trunc(98.7654), trunc(98.7654, 2), trunc(7598.7754 , -2)
from dual;

-- mod
select 98.7654, mod(98.7654, 2), mod(14, 3)
from dual;

select salary, mod (salary, 300)
from employee;

-- employee ���̺��� �����ȣ�� ¦���� ���
select *
from employee
where mod(eno, 2) = 0 ;

/*
��¥ �Լ�
sysdate : �ý��ۿ� ����� ���� ��¥�� ���
nmonths_between : �� ��¥ ������ ���� �� �ľ�
add_months : Ư�� ��¥�� �������� ����
next_day : Ư�� ��¥���� ���ʷ� �����ϴ� ���ڷ� ���� ������ ��¥ ��ȯ
last_day : ���� ������ ��¥�� ��ȯ
round : ���ڷ� ���� ��¥�� Ư�� �������� �ݿø�
trunc : ���ڷ� ���� ��¥�� Ư�� �������� ����
*/

--sysdate �ڽ��� �ý����� ��¥ ���
select sysdate from dual;
select sysdate -1 as ����, sysdate as ����, sysdate +1 as ���� from dual;

select * from employee
order by hiredate;

select hiredate, hiredate -1, hiredate +10
from employee;

-- �Ի��Ͽ��� ���� ��������� �ٹ��ϼ��� ���
select sysdate - hiredate from employee;
select round(sysdate) - hiredate as "�� �ٹ��ϼ�" from employee;
select round(MONTHS_BETWEEN(SYSDATE,hiredate)) from employee;

-- Ư�� ��¥���� ��(Month)�� �������� ������ ��¥ ���ϱ�, round �� 16�� �̻��̸� �ݿø�
select hiredate, trunc (hiredate, 'MONTH'), round (hiredate, 'MONTH')
from employee;

select hiredate,  (hiredate, 'MONTH')
from employee;

-- months_between ( date1, date2 )
-- �� ������� �ٹ��� ���� �� ���ϱ�
select ename, sysdate, hiredate, Months_between(sysdate, hiredate),
trunc (Months_between(sysdate, hiredate)) as "�ٹ����� ��"
from employee;

-- �Ի��� �� 6������ ���� ������ ���
select hiredate, add_months ( hiredate, 6)
from employee;

-- �Ի��� �� 100���� ���� ����
select hiredate, hiredate + 100 as "�Ի� 100��"
from employee;

-- next_day (date, '����') : date �� �����ϴ� ���Ͽ� ���� ��¥
select next_day (sysdate, '�����') from dual;

-- last_day ( date ) : date �� �� ���� ������ ��¥
select hiredate, last_day(hiredate)
from employee;

-- �� ��ȯ �Լ�!!
/*
TO_CHAR  : ��¥�� �Ǵ� ������ �����͸� ���������� ��ȯ
TO_DATE  : �������� ��¥������ ��ȯ�ϴ� �Լ�
TO_NUMBER : �������� ���������� ��ȯ�ϴ� �Լ�
*/

-- TO_CHAR (date, 'YYYYMMDD')
select ename, hiredate, to_char(hiredate, 'YYYYMMDD'),
to_char (hiredate, 'YY/MM'), to_char(hiredate, 'YY MM DD'),
to_char (hiredate, 'YY/MM day'), to_char(hiredate, 'YY MM DD dy')
from employee;

-- ��¥�� ����ϰ� �ð� �� ���� ���
select sysdate, to_char(sysdate, 'YYYY/MM/DD HH:MI:SS DAY DY') from dual;

select hiredate, to_char(hiredate, 'YYYY-MM-DD HH:MI:SS DAY DY')
from employee;

-- to_char ���� ���ڿ� ���õ� ����
/*
    0 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� 0 ���� ä��
    9 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� ä���� ������
    L : �� ������ ��ȭ��ȣ�� ���
    . : �Ҽ������� ǥ��
    , : õ ������ ������
*/

select ename, to_char(salary, 'L999,999'),
to_char(salary, 'L0000,000')
from employee;

-- to_date ('cahr', 'format') : ��¥�������� ��ȯ
select sysdate, sysdate - '20000101'
from dual;

-- 2000 �� 1�� 1�� ���� ���� ���� ������ �ϼ�
select sysdate, trunc(sysdate) - to_date(20000101, 'YYYYMMDD') from dual;
select sysdate, trunc(sysdate - to_date(20000101, 'YYYYMMDD')) from dual;

select sysdate, to_date ('02/10/10', 'YY/MM/DD'),
trunc (sysdate - to_date ('021010', 'YYMMDD')) as ��¥����
from dual;

select ename, hiredate
from employee
where hiredate = '81/02/22';

select ename, hiredate
from employee
where hiredate = to_date(19810222, 'YYYYMMDD');

select ename, hiredate
from employee
where hiredate = to_date('1981+02+22', 'YYYY+MM+DD');

-- 2000 �� 12 �� 25 �� ���� ���ñ��� �� �� �� �ΰ���
select trunc (months_between(sysdate, '2000/12/25'))
from dual;

select trunc (months_between(sysdate, to_date('2000/12/25', 'YYYY/MM/DD')))
from dual;

-- to_number : number ������ Ÿ������ ��ȯ
select to_number('100000') - to_number('5000') from dual;
select to_number('100,000', '999,999') - to_number('5,000', '9,999') from dual;

-- NVL �Լ� : null �� �ٸ� ������ ġȯ ���ִ� �Լ�
-- nvl(expr1, expr2) : expr1 �� �ִ� null �� expr2 �� ġȯ
select commission
from employee;

select commission, nvl(commission, 0)
from employee;

select manager, nvl ( manager, 1111 )
from employee;

-- NVL2(expr1, expr2, expr3) : expr1 �� null �� �ƴϸ� expr2, null �̸� expr3

-- NVL �Լ��� ���� ����ϱ�
select salary * 12 + nvl(commission, 0) as ����
from employee;

select nvl2( commission, salary*12 + commission, salary*12) as ����
from employee;

-- NULLIF : �� ǥ������ ���ؼ� ������ ��� null �� ��ȯ, �������� ���� ��� ù ��° ǥ������ ��ȯ
select nullif ('A', 'A'), nullif('A', 'B')
from dual;

-- coalesce �Լ�
coalesce (expr1, expr2, expr3, ... , expr-n)
    --expr1 �� null �� �ƴϸ� expr1 �� ��ȯ�ϰ�,
    --expr1 �� null �̰� expr2 �� null �� �ƴϸ� expr2 �� ��ȯ
    --expr2 �� null �̰� expr3 �� null �� �ƴϸ� expr3 �� ��ȯ ...
    
select coalesce ('a', 'b', 'c', 'd') from dual;
select coalesce ( null , 'b', 'c', 'd') from dual;
select coalesce (null, null, 'c', 'd') from dual;

select ename, salary, commission, coalesce (commission + salary, salary, 0)
from employee;

--decode �Լ�     (switch case ���� ������ ����)
/*
    DECODE ( ǥ����, ����1, ���1, 
                    ����2, ���2,
                    ...
                    �⺻���n
            )
*/

select ename, dno, decode (dno, 10, 'ACCOUNTING',
                                20, 'RESEARCH',
                                30, 'SALES',
                                40, 'OPERATION',
                                'DEFAULT'
                            ) as DNAME
from employee;    

--dno �� 10 �� ��� ���޿��� + 300, 20 �� ����+500, 30 700 // �̸�, ����, ������ ����
select ename, salary, decode ( dno, 10, salary + 300,
                                     20, salary + 500,
                                     30, salary + 700,
                                     salary ) as "�λ�� ����"
from employee
order by dno;

-- case : if ~ else if , else if ~~~
/*
    case ǥ���� WHEN ����1 THEN ���1
                WHEN ����2 THEN ���2
                ...
                WHEN ����n THEN ���n
                ELSE �⺻���
    END
*/

select ename, dno, case when dno = 10 then 'ACCOUNTING'
                        when dno = 20 then 'RESEARCH'
                        when dno = 30 then 'SALES'
                        ELSE 'DEFAULT'
                    END as �μ���
from employee
order by dno;














