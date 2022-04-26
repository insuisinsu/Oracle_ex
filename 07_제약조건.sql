-- 7���� -- ��������

-- ���̺� ���� : ���̺��� ��ü�� ������
    -- ���̺��� �����ϸ� �÷��� ���ڵ常 �����
    -- ���̺� �Ҵ�� ���������� ������� ����
        -- Alter Table �� ����ؼ� �Ҵ��ؾ� ��
/*
    ���� ���� 
    . �÷��� �Ҵ�Ǿ� ����
    . ���Ἲ�� üũ�ϱ� ����
        - NOT NULL
        - Primary Key
        - Unique
        - Foreign Key
        - Check
        - Default
*/

-- ���̺��� ��ü ���ڵ� �����ϱ�
create table dept_COPY
as
select * from department;

create table emp_copy
as
select * from employee;
select * from emp_copy;

-- ���̺��� Ư�� �÷��� �����ϱ�
create table emp_second
as
select eno, ename, salary, dno from employee;
select * from emp_second

-- ������ ����Ͽ� ���̺� �����ϱ�
create table emp_third
as
select eno, ename, salary
from employee
where salary > 2000;

select * from emp_third;

-- �÷����� �ٲپ ���̺� �����ϱ�
create table emp_forth
as
select eno �����ȣ, ename ����̸�, salary �޿�
from employee

select * from emp_forth;

-- ������ �̿��ؼ� ���̺� �����ϱ�
-- �ݵ�� ��Ī�� ����ؾ� �� alias
create table emp_fifth
as
select eno, ename, salary * 12 as salary12
from employee;

select * from emp_fifth;

-- ���̺��� ������ �����ϱ� ( ���ڵ� ���� )
-- where ������ false �� ������
-- �׷� ���ڵ尡 �� ������ ���̺� ������ �����
create table emp_sixth
as
select * from employee
where 0=1;     

select * from emp_sixth;
desc emp_sixth;

/*
���̺� �����ϱ� : Alter Table
    
*/

create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- ���� ���̺� �÷� �߰��ϱ�
Alter table dept20
add (birth date);

alter table dept20
add (email varchar2(100));
alter table dept20
add (address varchar2(200));

-- �÷��� �ڷ��� �����ϱ�
    -- ���� �÷��� ���ִ� ������ ����ؾ���
desc dept20;

alter table dept20
modify dname varchar2(100);

alter table dept20
modify dno number(4);

alter table dept20
modify address Nvarchar2(200);

/*
Ư�� �÷� �����ϱ�
*/
alter table dept20
drop column birth;

alter table dept20
drop column email;

-- �÷� �����ÿ��� ���ϰ� ���� �߻���
    -- SET UNUSED : Ư�� �÷��� ������� .. �����߿� ���� ���״ٰ� ���� �߰��� ������
desc dept20;
select * from dept20;

alter table dept20
set unused (address);

-- unused �� �÷� �����ϱ�
alter table dept20
drop unused column;

/*
�÷� �̸� ����
*/
alter table dept20
rename column LOC to LOCATIONS;

alter table dept20
rename column DNO to D_Number;

/*
���̺� �̸� ����
*/
rename dept20 to dept30;
desc dept30;

/*
���̺� ����
*/
drop table dept30;

/*
DDL : Create (����), Alter(����), Drop(����)
    - ��ü�� ����ϴ� ��
    ��ü : ���̺�, ��, �ε���, Ʈ����, ������, �Լ�, �������ν���
*/
/*
DML : Insert (���ڵ� �߰�), Update (���ڵ� ����), Delete (���ڵ� ����)
    - ���̺��� ��(���ڵ� or �ο�) �� ����ϴ� ��
*/
/*
DQL : Select
*/
/*
���̺��� ��ü �����̳� ���̺� ������
    1. Delete
        - ���̺��� ���ڵ� ����
        - where �� ������� ������ ��� ���ڵ� ����
        - ���ڵ� �� �پ� ������
        - ����
    2. Truncate
        - ���̺��� ���ڵ� ����
        - �ӵ��� ����
        - ���� ����
    3. Drop
        - ���̺� ��ü�� ����
*/
create table emp30
as
select * from employee;

--emp10 / delete 
delete emp10;
--emp20 / truncate
truncate table emp20;
--emp30 / drop
drop table emp30;
commit;

drop table dept

/*
    ���� ���� 
    . �÷��� �Ҵ�Ǿ� ����
    . ���̺��� ���Ἲ�� Ȯ���ϱ� ���ؼ� �÷��� �ο��Ǵ� ��Ģ
        1. Primary Key
        2. Unique
        3. NOT NULL
        4. Check
        5. Foreign Key
        6. Default
*/

/*
Primary Key : �ߺ��� ���� ���� �� ����.
*/    
-- 1. ���̺� ������ �÷��� �������� �ο�
-- constraint �������� �̸�
    -- �������� �̸��� �������� ���� ��� : Oracle ���� ������ �̸����� ����
    -- ���������� �����Ҷ� ���������� �̸��� �ʿ���
    -- PK_customer01_id : Primary Key, customer01(���̺��), id(�÷���0
    -- NN_customer01_pwd : Not Null, customer01, pwd
create table customer01 (
    id varchar2(20) not null constraint PK_customer01_id Primary Key,
    pwd varchar2(20) constraint NN_customer01_pwd not null,
    name varchar2(20) constraint NN_customer01_name not null,
    phone varchar2(30) null,
    address varchar2(100) null
    );

select * from user_constraints
where table_name = 'CUSTOMER01';

create table customer02 (
    id varchar2(20) not null Primary Key,
    pwd varchar2(20) not null,
    name varchar2(20) not null,
    phone varchar2(30) null,
    address varchar2(100) null
    );
select * from user_constraints
where table_name = 'CUSTOMER02';

-- 2. ���̺� �÷��� ������ �� �������� �Ҵ�
create table customer03 (
    id varchar2(20) not null,
    pwd varchar2(20) constraint NN_customer03_pwd not null,
    name varchar2(20) constraint NN_customer03_name not null,
    phone varchar2(30) null,
    address varchar2(100) null,
    constraint PK_customer03_id Primary Key (id)
    );
    
/*
Foreign Key : ����Ű : �ٸ� ���̺�(�θ�)�� Praimary Key, Unique �÷��� �����ؼ� ���� �Ҵ�
check       : �÷��� ���� �Ҵ��� �� check �� �´� ���� �Ҵ�
*/

-- �θ� ���̺� ����
create table ParentTb1(
    name varchar2(20),
    age number(3) constraint CK_ParentTb1_age check ( AGE > 0 and AGE < 200),
    gender varchar(3) constraint CK_ParentTb1_gender check (gender IN ('M','W')),
    infono number constraint PK_parentTb1_infono primary key
    );
desc parentTb1
select * from user_constraints
where table_name = 'PARENTTB1';

-- �ڽ� ���̺� ����
create table ChildTbl (
    id varchar2(40) constraint PK_ChildTbl_id Primary Key,
    pw varchar2(40),
    infono number,
    constraint FK_ChildTbl_infono Foreign Key (infono) references ParentTb1(infono)
    );
select * from ParentTb1
insert into ParentTb1
values ( 'ȫ�浿', 30, 'M', 1);

-- ���� �߻�, AGE(check �� ���� ��), GENDER(check �� �� ����), INFONO(Parimary Key, �ߺ���) ����
insert into ParentTb1
values('��ʶ�', 300, 'K', 1) 

insert into ParentTb1
values('��ʶ�', 50, 'M', 2) ;

select * from ChildTbl;
-- ParentTb1 �� infono �� 3 ���� ������ ���� �ʱ� ������, �θ� Ű�� ã�� �� ����
insert into ChildTbl
values('aaaaa', 'aaa', 3);

insert into ChildTbl
values('aaaaa', 'aaa', 1);

insert into ChildTbl
values('bbbb', 'bbb', 2);

commit

create table ParentTbl2 (
    dno number(2) not null Primary Key,
    dname varchar(50),
    loc varchar2(50)
    );
insert into ParentTbl2
values(10, 'SALES', 'SEOUL');

create table ChildTbl2 (
    no number not null,
    ename varchar(50),
    dno number(2) not null,
    foreign key (dno) references ParentTbl2(dno)
    );
insert into ChildTbl2
values(1, 'Park', 10);

/*
Default : ���� �Ҵ����� ������ default ���� �Ҵ��
*/

Create Table emp_sample01 (
    eno number(4) not null Primary Key,
    ename varchar(50),
    salary number(7,2) default 1000
    );

insert into emp_sample01
values ( 1111 ,'INSU', 1500);

insert into emp_sample01
values ( 2222 ,'INSOO', null);

insert into emp_sample01 (eno, ename)
values ( 3333, 'INGSOO')

insert into emp_sample01
values ( 4444, 'FJFJ', default)

select * from emp_sample01

/*
Primary Key, Foreign Key, Unique, check, default, not null
*/

create table member10 (
    no number not null constraint PK_member10_no Primary Key,
    name varchar(50) constraint NN_member10_name not null,
    birthday date default sysdate,
    age number(3) check (age > 0 and age < 150),
    gender char(1) check (gender in ('M', 'W')),
    dno number(2) unique
    );
select * from member10

insert into member10
values(1, 'ȫ�浿', default, 30, 'M', 10)
insert into member10
values(2, '������', default, 30, 'M', 20)

Create table orders10 (
    no number not null Primary key,
    P_no varchar(100) not null,
    p_name varchar(100) not null,
    price number check (price > 10),
    phone varchar(100) default '010-0000-0000',
    dno number(2) not null,
    foreign key (dno) references member10(dno)
    );
select * from orders10

insert into orders10
values (1, '1111', '������', 10000, default, 10);



