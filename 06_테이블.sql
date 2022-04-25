-- 6���� CRUD ( Create, Read, Update, Delete)
/*
Object ( ��ü ) :
*/


create Table dept(
    dno number(2) not null,
    dname varchar2(14) not null,
    loc varchar2(13) null
    );

select * from dept;

-- DML : ���̺��� ��(���ڵ�, �ο�)�� �ְ�(insert), ����(update), ����(delete)
    -- Ʈ������� �߻� ��Ŵ : log�� ����� �����ϰ� Database �� �����Ѵ�.
    
    begin transaction;  -- Ʈ����� ����
    rollback;           -- Ʈ����� �ѹ� ( RAM �� ����� Ʈ������� 
    commit;             -- Ʈ����� ���� ( ���� DB�� ������ ���� )
    
/*
    insert into ���̺�� ( �÷���, �÷���, �÷���)
    values ( ��1, ��2, ��3 )
*/
insert into dept (dno, dname, loc)
values ( 10, 'MANAGER', 'SEOUL');
    -- insert, update, delete ������ �ڵ����� Ʈ����� ����(begin transation;)
        -- ��, ������ RAM ���� ����Ǿ� �ִ� ����
        
rollback;        
commit;
select * from dept;

/*
    insert �� �÷����� ����
    insert into dept
    values ( ��1, ��2, ��3 )
*/

insert into dept
values (20, 'ACCOUTING', 'BUSAN')
        
-- Null ��� �÷��� ���� ���� �ʴ� ���
insert into dept (dno, dname)
values (30, 'RESEARCH')

-- ������ ������ ���� �ʴ� ���� ������ ���� �߻�
insert into dept (dno, dname, loc)
-- dno �� number(2) �� 300 �� ���� �� ����
values (300, 'SALES', TAEGUE');

insert into dept (loc, dname, dno)
values ('TAEGUN', 'SALESMMMMMMMMMMMMMMMMMMMMM', 60);
-- dname�� varchar(14) �� ����

-- ���� �ڷ���
/*
    char(10)    : ����ũ�� 10����Ʈ - 3����Ʈ�� ������ �� ���� 7����Ʈ ������
                - ������ ��������, �ϵ������ ������
                - �ڸ����� �˼� �ִ� ����ũ�� �÷��� ��� (�ֹι�ȣ, ��ȭ��ȣ ��)
    varchar(10) : ����ũ�� 10����Ʈ - 3����Ʈ�� ������ 3����Ʈ�� ������
                - ������ ��������, �ϵ������ �������� ����
                - �ڸ����� ����ũ���� Į���� ��� (�ּ�, �����ּ� ��)
    Nchar(10)   : �����ڵ� 10��(�ѱ�, �߱��� ��)
    Nbarchar2(10): �����ڵ� 10��(�ѱ�, �߱��� ��)
*/
-- ���� �ڷ���
/*
    NUMBER(2)   : ���� 2�ڸ��� �Է� ����
    NUMBER(7, 3): ��ü 7�ڸ�, �Ҽ��� 3�ڸ� ���� ���� ����
*/

create table test1_tb1(
    a number(3,2) not null,
    b number(7,5) not null,
    c char(6) null,
    d varchar2(10) null,
    e Nchar(6) null,
    f Nvarchar2(10) null
    );

drop table test1_tbl;

desc test1_tb1
select * from test1_tb1
insert into test1_tb1(a, b, c, d, e, f)
values(3.22, 55555.55555, 'AAAAAA', 'BBBBBBBBBB', '�ѱۿ�������','�ѱۿ����ڱ���������')
      
create table member1(
    no number(10) not null,
    id varchar2(50) not null,
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2(50) null
    );
drop table member1;
select * from member1;
desc member1;
        
insert into member1 (no, id, passwd, name, phone, address, mdate, email)
values(1, 'aaaa', 'password', 'ȫ�浿', '010-1234-1234', '���� ���', sysdate, 'aaa@aa.com')

insert into member1
values(2, 'bbbb', 'password', '�̼���', '010-4321-4321', '���� �����', sysdate, 'bbb@bb.com')

--Null ��� �÷��� Null �� �� �Ҵ�
insert into member1 (no, id, passwd, name, phone, address, mdate, email)
values(3, 'cccc', 'password', '������', null, null, sysdate, null);

--Null ��� Į���� ���� ���� ���� ��� Null�� ��
insert into member1 (no, id, passwd, name, mdate)
values(4, 'dddd', 'password', '�������', sysdate);

-- update ������ ���� // commit ����� ��
    -- �ݵ�� where ������ ����ؾ� ��
    -- �׷��� ������ ��� ���ڵ尡 ������
/*
    update ���̺��
    set �÷��� = ������ �� (������)
    where �÷��� = ��
*/

update member1
set name = '�Ż��Ӵ�'
where no = 2;

-- �ϳ��� ���ڵ忡�� �����÷� ���ÿ� �����ϱ�
update member1
set name = '������', phone = '010-3124-1453', email = 'kkk@kkk.com'
where no = 1;

update member1
set mdate = to_date('2022-01-01', 'YYYY-MM-DD')
where no = 3;

delete member1
where no = 3;

select * from member1
commit;
        
/*
    update, delete �� �ݵ�� where  ������ ����ؾ� ��
    �ȱ׷��� ��ü ���ڵ尡 ������ �̤�
    Ʈ����� ���� �ʿ� 1. rollback 2. commit
*/
/*
    �������� : �÷��� ���Ἲ�� Ȯ���ϱ� ���ؼ� ���
    ���Ἲ : ������ ���� ������ = ���ϴ� �����͸� ����
    
    Primary Key : �ϳ��� ���̺� �� ���� ���, �ߺ��� �����͸� ���� ���ϵ��� ����
*/

create table member2(
    no number(10) not null Primary key,
    id varchar2(50) not null,
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2(50) null
    );

insert into member2 (no, id, passwd, name, phone, address, mdate, email)
values(1, 'aaaa', 'password', 'ȫ�浿', '010-1234-1234', '���� ���', sysdate, 'aaa@aa.com')

insert into member2
values(2, 'bbbb', 'password', '�̼���', '010-4321-4321', '���� �����', sysdate, 'bbb@bb.com')

--Null ��� �÷��� Null �� �� �Ҵ�
insert into member2 (no, id, passwd, name, phone, address, mdate, email)
values(3, 'cccc', 'password', '������', null, null, sysdate, null);

--Null ��� Į���� ���� ���� ���� ��� Null�� ��
insert into member2 (no, id, passwd, name, mdate)
values(4, 'dddd', 'password', '�������', sysdate);

select * from member2    
commit;


-- UNIQUE �ߺ��� ���� ���� �� ����