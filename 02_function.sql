-- �پ��� �Լ� ����ϱ�
/*
1. ���ڸ� ó���ϴ� �Լ�
UPPER : �빮�ڷ� ��ȯ
LOWER : �ҹ��ڷ� ��ȯ
INITCAP : ù�ڴ� �빮��, ������ �ҹ��ڷ� ��ȯ

dual ���̺� : �ϳ��� ����� ����ϵ��� �ϴ� ���̺�
*/

select '�ȳ��ϼ���' as �ȳ�
from dual

select 'Oracle mania', upper ('Oracle mania'), lower ('Oracle mania'), initcap('Oracle mania')
from dual

select * from employee;

select ename, lower(ename), initcap(ename), upper(ename)
from employee;

-- ���� ���� �빮�ڶ� �ҹ��ڷ� �˻��ϸ� ���� �� ����
select * from employee
where ename = 'allen';

-- ename �� �ҹ��ڷ� �ٲ㼭 �˻�
select * from employee
where lower(ename) = 'allen';

select * from employee
where initcap(ename) = 'Allen';

-- ������ ���̸� ����ϴ� �Լ�
/*
length : ������ ���̸� ��ȯ // ����, �ѱ� ������� ���ڼ� ����
lengthb : ������ ���̸� ��ȯ // �ѱ��� 3byte �� ��ȯ

*/

select length('Oracle mania'), length('����Ŭ �ŴϾ�'),
lengthb('Oracle mania'), lengthb('����Ŭ �ŴϾ�') from dual;

select ename, length(ename), job, length(job)
from employee;

-- ���� ���� �Լ� 
/*
concat : ���ڿ� ���ڸ� �����ؼ� ���
substr : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� // ����, �ѱ� 1byte
substrb : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� // ���� 1, �ѱ� 3byte
instr : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ
instrb : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ
lpad, rpad : �Է� ���� ���ڿ����� Ư�����ڸ� ����
trm : �߶󳻰� ���� ���ڸ� ��ȯ
*/

-- concat : ���ڿ� ���ڸ� �����ؼ� ���
select 'Oracle', 'mania', concat ('Oracle' , 'mania') from dual;
-- substr : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� // ����, �ѱ� 1byte
-- substr ( ���, ������ġ, ���ⰹ�� )
    -- ������ġ�� - �� ������ �ڿ��� ���� ��
select 'Oracle mania', substr ('Oracle mania', 4, 3),substr ('����Ŭ �ŴϾ�', 2, 3),
substrb ('Oracle mania', 4, 3),substrb ('����Ŭ �ŴϾ�', 2, 3)
from dual;

select 'Oracle mania', substr ('Oracle mania', -8, 4),substr ('����Ŭ �ŴϾ�', -5, 3),
substrb ('Oracle mania', -3, 2),substrb ('����Ŭ �ŴϾ�', -2, 3)
from dual;

select ename, substr (ename, 3, 2), substrb(ename, -4, 3)
from employee;

select concat ( ename, ' ' || job) from employee;
select '�̸��� : ' || ename || ' �̰�, ��å�� : ' || job || ' �Դϴ�.' as �÷�����
from employee;

select '�̸��� : ' || ename || ' �̰�, ����� ��ȣ�� ' || manager || ' �Դϴ�.' as A
from employee;

-- �̸��� N ���� ������ ����� ����ϱ� ( substr �Լ� ��� )
select *
from employee
where substr(ename, -1, 1) = 'N';

select *
from employee
where ename like '%N';

-- 87 �⵵ �Ի��� ����� ����ϱ�
select *
from employee
where substr(hiredate, 1, 2) = '87';

select *
from employee
where hiredate like '87%';

-- instr : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ
-- instr ( ���, ã�� ����, ������ġ, �� ��° �߰� )

select 'Oracle mania' , instr ('Oracle mania', 'O') from dual;
select 'Oracle mania' ,
instr ('Oracle mania', 'a'),
instr ('Oracle mania', 'a', 5),
instr ('Oracle mania', 'a', 5, 2),
instr ('Oracle mania', 'a', -5, 1)
from dual;

select distinct job from employee
where lower(job) = 'manager'

select distinct instr( job, 'A', 1, 1)
from employee
where lower(job) = 'manager'

-- lpad, rpad : Ư�� ���̸�ŭ ���ڿ��� �����ؼ� ����, �������� ������ Ư�� ���ڷ� ó��
select lpad (salary, 10, '*') from employee;
select rpad (salary, 10, '*') from employee;

select lpad (1234 , 10, '*'), rpad (1234 , 10, '*') from dual

















