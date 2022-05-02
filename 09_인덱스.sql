--9일차 인덱스

/*
INDEX : 특정 컬럼의 검색을 빠르게 사용할 수 있도록 한다.
          - 테이블의 컬럼에 생성
    . Index Page : 컬럼의 중요 키워드를 걸러서 위치 정보를 담아놓은 페이지
        - DB 공간의 10% 정도를 차지함
    . 색인(Index)
        - 책의 색인, 책 내용의 중요 키워드를 수집해서 위치를 알려줌
    . 테이블 스캔 : 레코드의 처음부터 마지막 까지 검색하는 것
       - index 가 생성되어 있지 않은 컬럼에서 실시함
       - 검색 속도가 느림
    . Primary Key, Unique 가 적용된 컬럼은 자동으로 index page 가 만들어짐
    . Where 절에서 자주 검색하는 컬럼에 Index 를 생성함
    . Index 를 생성할 때는 부하가 많이 걸리기 때문에 주로 야간에 생성함
*/

/*
index 정보가 저장되어 있는 데이터 사전
    . user_columns
    . user_ind_columns
*/
    
select * from user_tab_columns;
select * from user_ind_columns;

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT');


-- ENO 컬럼에 Primary Key 가 할당되어 있기 때문에 자동으로 Index 가 생성되어 있음
select * from employee; 

create table tbl1 (
    a number(4) constraint PK_tbl1_a Primary Key,
    b number(4),
    c number(4)
    );

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('TBL1', 'TBL2', 'EMPLOYEE', 'DEPARTMENT');

select * from tbl1;

create table tbl2(
    a number(4) constraint PK_TBL2_a Primary Key,
    b number(4) constraint UK_TBL2_b Unique,
    c number(4) constraint UK_TBL2_c unique,
    d number(4),
    e number(4)
    );

create table emp_copy90
as
select * from employee;

-- ename 컬럼에 index 가 없기 때문에 KING 을 검색하기 위해 테이블 스캔을 실시함
select * from emp_copy90
where ename = 'KING';

-- ename 컬럼에 index 생성하기
create index id_emp_ename
on emp_copy90(ename);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP_COPY90');

drop index id_emp_ename;

/*
Index 는 주기적으로 ReBuild 해야함
    . Index Page 는 조각난다
        - Insert, Update, Delete 가 빈번하게 일어날 경우
*/

-- Index ReBuild 를 해야한다는 정보 얻기
-- Index 의 Tree 깊이가 4 이상인 경우가 조회가 되면 ReBuild 할 필요가 있음
SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- Index Rebuild 하기
-- Index 를 새롭게 생성함
Alter index ID_EMP_ENAME rebuild;

/*

Index 를 사용해야 하는 경우
 1. 테이블의 행(로우, 레코드) 의 갯수가 많은 경우
 2. Where 절에서 자주 사용되는 컬럼
 3. Join 시 사용되는 키 컬럼
 4. 검색 결과가 원본 테이블 데이터의 2 ~ 4 % 정도 되는 경우
 5. 해당 컬럼이 null 을 포함하하는 경우 (색인은 null 을 제외)
 
Index 를 사용하지 않는 경우
 1. 테이블의 행의 갯수가 적은 경우
 2. 검색 결과가 원본 테이블의 많은 비중을 차지하는 경우
 3. Insert, Update, Delete 가 빈번하게 일어나는 컬럼
 
*/

/*
Index 종류
    1. 고유 인덱스 (Unique Index)    : 컬럼이 중복되지 않는 고유한 값을 갖는 Index (Primary Key, Unique
    2. 단일 인덱스 (Single Index)    : 한 컬럼에 부여되는 Index
    3. 결합 인덱스 (Composite Index) : 여러 컬럼을 묶어서 생성한 Index
    4. 함수 인덱스 (Function Base Index) : 함수를 적용한 컬럼에 생성한 Index
*/

select * from emp_copy90;

-- 단일 인덱스 생성
create index idx_emp_copy90_salary
on emp_copy90 (salary);

-- 결합 인덱스 생성
create table dept_copy91
as
select * from department;

create index idx_emp_copy90_dname_loc
on dept_copy91 (dname, loc);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('DEPT_COPY91');

-- 함수 기반 인덱스
create table emp_copy91
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91 ( salary * 12 );

-- 인덱스 삭제
drop index idx_emp_copy91_allsal;
















