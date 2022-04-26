-- 7일차 -- 제약조건

-- 테이블 복사 : 테이블의 전체를 복사함
    -- 테이블을 복사하면 컬럼과 레코드만 복사됨
    -- 테이블에 할당된 제약조건은 복사되지 않음
        -- Alter Table 을 사용해서 할당해야 함
/*
    제약 조건 
    . 컬럼에 할당되어 있음
    . 무결성을 체크하기 위함
        - NOT NULL
        - Primary Key
        - Unique
        - Foreign Key
        - Check
        - Default
*/

-- 테이블의 전체 레코드 복사하기
create table dept_COPY
as
select * from department;

create table emp_copy
as
select * from employee;
select * from emp_copy;

-- 테이블의 특정 컬럼만 복사하기
create table emp_second
as
select eno, ename, salary, dno from employee;
select * from emp_second

-- 조건을 사용하여 테이블 복사하기
create table emp_third
as
select eno, ename, salary
from employee
where salary > 2000;

select * from emp_third;

-- 컬럼명을 바꾸어서 테이블 복사하기
create table emp_forth
as
select eno 사원번호, ename 사원이름, salary 급여
from employee

select * from emp_forth;

-- 계산식을 이용해서 테이블 복사하기
-- 반드시 별칭을 사용해야 함 alias
create table emp_fifth
as
select eno, ename, salary * 12 as salary12
from employee;

select * from emp_fifth;

-- 테이블의 구조만 복사하기 ( 레코드 ㄴㄴ )
-- where 조건이 false 를 리턴함
-- 그럼 레코드가 안 찍혀서 테이블 구조만 복사됨
create table emp_sixth
as
select * from employee
where 0=1;     

select * from emp_sixth;
desc emp_sixth;

/*
테이블 수정하기 : Alter Table
    
*/

create table dept20
as
select * from department;

desc dept20;
select * from dept20;

-- 기존 테이블에 컬럼 추가하기
Alter table dept20
add (birth date);

alter table dept20
add (email varchar2(100));
alter table dept20
add (address varchar2(200));

-- 컬럼의 자료형 수정하기
    -- 현재 컬럼에 들어가있는 값들을 고려해야함
desc dept20;

alter table dept20
modify dname varchar2(100);

alter table dept20
modify dno number(4);

alter table dept20
modify address Nvarchar2(200);

/*
특정 컬럼 삭제하기
*/
alter table dept20
drop column birth;

alter table dept20
drop column email;

-- 컬럼 삭제시에는 부하가 많이 발생됨
    -- SET UNUSED : 특정 컬럼을 사용중지 .. 업무중에 중지 시켰다가 보통 야간에 삭제함
desc dept20;
select * from dept20;

alter table dept20
set unused (address);

-- unused 된 컬럼 삭제하기
alter table dept20
drop unused column;

/*
컬럼 이름 변경
*/
alter table dept20
rename column LOC to LOCATIONS;

alter table dept20
rename column DNO to D_Number;

/*
테이블 이름 변경
*/
rename dept20 to dept30;
desc dept30;

/*
테이블 삭제
*/
drop table dept30;

/*
DDL : Create (생성), Alter(수정), Drop(삭제)
    - 객체에 사용하는 것
    객체 : 테이블, 뷰, 인덱스, 트리거, 시퀀스, 함수, 저장프로시져
*/
/*
DML : Insert (레코드 추가), Update (레코드 수정), Delete (레코드 삭제)
    - 테이블의 값(레코드 or 로우) 에 사용하는 것
*/
/*
DQL : Select
*/
/*
테이블의 전체 내용이나 테이블 삭제시
    1. Delete
        - 테이블의 레코드 삭제
        - where 를 사용하지 않으면 모든 레코드 삭제
        - 레코드 한 줄씩 삭제함
        - 포맷
    2. Truncate
        - 테이블의 레코드 삭제
        - 속도가 빠름
        - 빠른 포맷
    3. Drop
        - 테이블 자체를 삭제
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
    제약 조건 
    . 컬럼에 할당되어 있음
    . 테이블의 무결성을 확보하기 위해서 컬럼에 부여되는 규칙
        1. Primary Key
        2. Unique
        3. NOT NULL
        4. Check
        5. Foreign Key
        6. Default
*/

/*
Primary Key : 중복된 값을 넣을 수 없다.
*/    
-- 1. 테이블 생성시 컬럼에 제약조건 부여
-- constraint 제약조건 이름
    -- 제약조건 이름을 지정하지 않을 경우 : Oracle 에서 랜덤한 이름으로 생성
    -- 제약조건을 수정할때 제약조건의 이름이 필요함
    -- PK_customer01_id : Primary Key, customer01(테이블명), id(컬럼명0
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

-- 2. 테이블에 컬럼을 생성한 후 제약조건 할당
create table customer03 (
    id varchar2(20) not null,
    pwd varchar2(20) constraint NN_customer03_pwd not null,
    name varchar2(20) constraint NN_customer03_name not null,
    phone varchar2(30) null,
    address varchar2(100) null,
    constraint PK_customer03_id Primary Key (id)
    );
    
/*
Foreign Key : 참조키 : 다른 테이블(부모)의 Praimary Key, Unique 컬럼을 참조해서 값을 할당
check       : 컬럼에 값을 할당할 때 check 에 맞는 값을 할당
*/

-- 부모 테이블 생성
create table ParentTb1(
    name varchar2(20),
    age number(3) constraint CK_ParentTb1_age check ( AGE > 0 and AGE < 200),
    gender varchar(3) constraint CK_ParentTb1_gender check (gender IN ('M','W')),
    infono number constraint PK_parentTb1_infono primary key
    );
desc parentTb1
select * from user_constraints
where table_name = 'PARENTTB1';

-- 자식 테이블 생성
create table ChildTbl (
    id varchar2(40) constraint PK_ChildTbl_id Primary Key,
    pw varchar2(40),
    infono number,
    constraint FK_ChildTbl_infono Foreign Key (infono) references ParentTb1(infono)
    );
select * from ParentTb1
insert into ParentTb1
values ( '홍길동', 30, 'M', 1);

-- 오류 발생, AGE(check 된 범위 밖), GENDER(check 값 안 맞음), INFONO(Parimary Key, 중복값) 오류
insert into ParentTb1
values('김똘똘', 300, 'K', 1) 

insert into ParentTb1
values('김똘똘', 50, 'M', 2) ;

select * from ChildTbl;
-- ParentTb1 의 infono 는 3 값을 가지고 있지 않기 때문에, 부모 키를 찾을 수 없음
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
Default : 값을 할당하지 않으면 default 값이 할당됨
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
values(1, '홍길동', default, 30, 'M', 10)
insert into member10
values(2, '김유신', default, 30, 'M', 20)

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
values (1, '1111', '유관순', 10000, default, 10);



