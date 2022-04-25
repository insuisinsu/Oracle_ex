-- 6일차 CRUD ( Create, Read, Update, Delete)
/*
Object ( 객체 ) :
*/


create Table dept(
    dno number(2) not null,
    dname varchar2(14) not null,
    loc varchar2(13) null
    );

select * from dept;

-- DML : 테이블의 값(레코드, 로우)을 넣고(insert), 수정(update), 삭제(delete)
    -- 트랜잭션을 발생 시킴 : log에 기록을 먼저하고 Database 에 적용한다.
    
    begin transaction;  -- 트랜잭션 시작
    rollback;           -- 트랜잭션 롤백 ( RAM 에 적용된 트랜잭션을 
    commit;             -- 트랜잭션 적용 ( 실제 DB에 영원히 적용 )
    
/*
    insert into 테이블명 ( 컬럼명, 컬럼명, 컬럼명)
    values ( 값1, 값2, 값3 )
*/
insert into dept (dno, dname, loc)
values ( 10, 'MANAGER', 'SEOUL');
    -- insert, update, delete 구문은 자동으로 트랜잭션 시작(begin transation;)
        -- 단, 아직은 RAM 에만 적용되어 있는 상태
        
rollback;        
commit;
select * from dept;

/*
    insert 시 컬럼명을 생략
    insert into dept
    values ( 값1, 값2, 값3 )
*/

insert into dept
values (20, 'ACCOUTING', 'BUSAN')
        
-- Null 허용 컬럼에 값을 넣지 않는 경우
insert into dept (dno, dname)
values (30, 'RESEARCH')

-- 데이터 유형에 맞지 않는 값을 넣으면 오류 발생
insert into dept (dno, dname, loc)
-- dno 는 number(2) 라서 300 을 넣을 수 없음
values (300, 'SALES', TAEGUE');

insert into dept (loc, dname, dno)
values ('TAEGUN', 'SALESMMMMMMMMMMMMMMMMMMMMM', 60);
-- dname이 varchar(14) 라서 오류

-- 문자 자료형
/*
    char(10)    : 고정크기 10바이트 - 3바이트만 넣으면 빈 공간 7바이트 생성됨
                - 성능이 빠르지만, 하드공간을 낭비함
                - 자릿수를 알수 있는 고정크기 컬럼에 사용 (주민번호, 전화번호 등)
    varchar(10) : 가변크기 10바이트 - 3바이트만 넣으면 3바이트만 생성됨
                - 성능이 느리지만, 하드공간을 낭비하지 않음
                - 자릿수가 가변크기인 칼럼에 사용 (주소, 메일주소 등)
    Nchar(10)   : 유니코드 10자(한글, 중국어 등)
    Nbarchar2(10): 유니코드 10자(한글, 중국어 등)
*/
-- 숫자 자료형
/*
    NUMBER(2)   : 정수 2자리만 입력 가능
    NUMBER(7, 3): 전체 7자리, 소숫점 3자리 까지 저장 가능
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
values(3.22, 55555.55555, 'AAAAAA', 'BBBBBBBBBB', '한글여섯글자','한글열글자까지가능함')
      
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
values(1, 'aaaa', 'password', '홍길동', '010-1234-1234', '서울 어딘가', sysdate, 'aaa@aa.com')

insert into member1
values(2, 'bbbb', 'password', '이순신', '010-4321-4321', '서울 어디쯤', sysdate, 'bbb@bb.com')

--Null 허용 컬럼에 Null 로 값 할당
insert into member1 (no, id, passwd, name, phone, address, mdate, email)
values(3, 'cccc', 'password', '강감찬', null, null, sysdate, null);

--Null 허용 칼럼에 값을 넣지 않을 경우 Null이 들어감
insert into member1 (no, id, passwd, name, mdate)
values(4, 'dddd', 'password', '세종대왕', sysdate);

-- update 데이터 수정 // commit 해줘야 함
    -- 반드시 where 조건을 사용해야 함
    -- 그렇지 않으면 모든 레코드가 수정됨
/*
    update 테이블명
    set 컬럼명 = 수정할 값 (수정후)
    where 컬럼명 = 값
*/

update member1
set name = '신사임당'
where no = 2;

-- 하나의 레코드에서 여러컬럼 동시에 수정하기
update member1
set name = '김유신', phone = '010-3124-1453', email = 'kkk@kkk.com'
where no = 1;

update member1
set mdate = to_date('2022-01-01', 'YYYY-MM-DD')
where no = 3;

delete member1
where no = 3;

select * from member1
commit;
        
/*
    update, delete 는 반드시 where  조건을 사용해야 함
    안그러면 전체 레코드가 수정됨 ㅜㅜ
    트랜잭션 종료 필요 1. rollback 2. commit
*/
/*
    제약조건 : 컬럼의 무결성을 확보하기 위해서 사용
    무결성 : 결함이 없는 데이터 = 원하는 데이터만 저장
    
    Primary Key : 하나의 테이블에 한 번만 사용, 중복된 데이터를 넣지 못하도록 설정
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
values(1, 'aaaa', 'password', '홍길동', '010-1234-1234', '서울 어딘가', sysdate, 'aaa@aa.com')

insert into member2
values(2, 'bbbb', 'password', '이순신', '010-4321-4321', '서울 어디쯤', sysdate, 'bbb@bb.com')

--Null 허용 컬럼에 Null 로 값 할당
insert into member2 (no, id, passwd, name, phone, address, mdate, email)
values(3, 'cccc', 'password', '강감찬', null, null, sysdate, null);

--Null 허용 칼럼에 값을 넣지 않을 경우 Null이 들어감
insert into member2 (no, id, passwd, name, mdate)
values(4, 'dddd', 'password', '세종대왕', sysdate);

select * from member2    
commit;


-- UNIQUE 중복된 값을 넣을 수 없다