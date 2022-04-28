-- 9���� ������
/*
������ : �ڵ� ��ȣ �߻���
    - ��ȣ�� �ڵ� �߻��� �Ǹ� �ڷ� �ǵ��� �� ���� ( ���� �� �ٽ� �����ؾ� �� )
    - Primary Key �÷��� ��ȣ�� �ڵ����� �߻���Ű�� ���� ���
        - �������� �߻��� ���� �ߺ����� �ʱ� ������
*/

-- �ʱⰪ 10, ������ 10
create sequence sample_seq
    increment by 10
    start with 10;

-- �������� ������ ����ϴ� ������ ����
select * from user_sequences;

-- �������� ���� �� ���
select sample_seq.currval from dual;
-- �������� ���� �� ���
select sample_seq.nextval from dual;

/*
nocache : ĳ���� ������� �ʰڴ� (RAM)
    ������ ���ϸ� �ٿ��� �� ����
*/
-- �ʱⰪ 2, ������ 2
create sequence sample_seq2
increment by 2
start with 2
nocache;

select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;

-- �������� Primary Key �� �����ϱ�
create table dept_copy80
as
select * from department
where 0=1;

select * from dept_copy80;

-- ������ ���� : �ʱⰪ 10, ������ 10
create sequence dept_seq
    increment by 10
    start with 10
    nocache;
    
insert into dept_copy80 (dno, dname, loc)
values (dept_seq.nextval, 'HR', 'SEOUL');

/*
Sequence �� cache �� ����ϴ� ���
cache : ������ ������ ����Ű�� �ϱ� ���� ��� ( �⺻ 20�� )
    ������ �ٿ�� ���
        - ĳ���� �ѹ����� ��� ����
        - ���ο� ���� �Ҵ� �޴´�.
*/

create sequence emp_seq_no
    increment by 1
    start with 1
    nocache;

create table emp_copy80
as
select * from employee
where 0=1;

select * from emp_copy80;

insert into emp_copy80
values (emp_seq_no.nextval, 'insu', 'SALESMAN', 2134, sysdate, 9000, 9000, null);

/*
������ ������ ����
*/
select * from user_sequences;
    
-- maxvalue
alter sequence emp_seq_no
    maxvalue 1000;

/*
������ ����
*/

drop sequence emp_seq_no;
drop sequence sample_seq2;

    
    
    
    
