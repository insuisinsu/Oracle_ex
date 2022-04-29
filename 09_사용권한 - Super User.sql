show user;

-- 최고 관리자 계정 sys
--  - 계정을 생성할 수 있는 권한을 가지고 있음

-- id : usertest01, pw : 1234
create user usertest01 identified by 1234;

-- 계정/암호 생성 하더라도 Oracle 에 접속할 수 있는 권한을 받아야함

-- System privileges
    -- Create Session   : 오라클에 접속할 수 있는 권한
    -- Create Table     : 오라클에서 테이블을 생성할 수 있는 권한
    -- Create Sequence  : 
    -- Create view
    
/*
DDL : 객체 생성 (Create, Alter, Drop)
DML : 레코드 조작 (Insert, Update, Delete)
DQL : 레코드 검색 (Select)
DTL : 트랜잭션 (Begin transaction, rollback, commit)
DCL : 권한관리 (Grant 부여, Revoke 뺏기, Deny 거부)
*/

-- 생성한 계정에게 권한 부여하기
-- grant 부여할 권한 to 계정명
grant create session to usertest01;

grant create table to usertest01;

/*
테이블 스페이스 ( Table Space )
    - 객체를 저장할 수 있는 공간
    - 관리자 계정에서 각 사용자별 테이블 스페이스를 확인
*/
select * from dba_users;

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in('HR', 'USERTEST01');

-- 계정의 테이블 스페이스 변경 (SYSSTEM -> USERS)
alter user usertest01
default tablespace users
temporary tablespace temp;

-- 계정에게 Users 테이블 스페이스를 사용할 수 있는 공간 할당
alter user usertest01
quota 2m on users;

/*
usertest02 계정을 생성한 후에 users 테이블 스페이스에서 테이블(tbl2) 생성후 insert
*/

create user usertest02 identified by 1234;
grant create session to usertest02;
grant create table to usertest02;

alter user usertest02
default tablespace users
temporary tablespace temp;

alter user usertest02
quota 1m on users;

/*
테이블 스페이스 : 객체와 Log 를 저장하는 물리적인 파일
    DataFile : 객체를 저장하고 있음
    Log      : Transaction Log 를 저장
    
    DataFile 과 Log 파일은 물리적으로 다른 하드공간에 저장해야 성능을 높일 수 있음
        -RAID 된 공간에 저장하면 성능을 높일 수 있음

*/





