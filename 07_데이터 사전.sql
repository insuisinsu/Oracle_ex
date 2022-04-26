--7일차 데이터 사전

/*
데이터 사전 : 시스템의 각종 정보를 출력해주는 테이블
    user_   : 자신의 계정에 속한 객체정보를 출력
    all_    : 자신의 계정이 소유한 객체나 권한을 부여받은 객체 정보를 출력
    dba_    : 데이터 베이스 관리자만 접근 가능한 객체 정보를 출력 // 관리자 계정에서만 사용 가능
*/
-- user_
show user;                          -- 현재 접속한 유저
select * from user_tables;          -- 사용자가 생성한 테이블 정보 출력
select table_name from user_tables;

select * from user_views;           -- 사용자가 생성한 뷰 정보 출력
select * from user_indexes;         -- 사용자가 생성한 인덱스 정보 출력
select * from user_constraints;     -- 제약조건 확인
select * from user_sequences;

select * from user_constraints
where table_name = 'EMPLOYEE';

-- all_
select * from all_tables;

-- dba -- 관리자 계정에서만 실행 가능
select * from dba_tables;

