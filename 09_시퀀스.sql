-- 9일차 시퀀스
/*
시퀀스 : 자동 번호 발생기
    - 번호가 자동 발생이 되면 뒤로 되돌릴 수 없음 ( 삭제 후 다시 생성해야 함 )
    - Primary Key 컬럼에 번호를 자동으로 발생시키기 위해 사용
        - 시퀀스로 발생한 값은 중복되지 않기 때문에
*/

-- 초기값 10, 증가값 10
create sequence sample_seq
    increment by 10
    start with 10;

-- 시퀀스의 정보를 출력하는 데이터 사전
select * from user_sequences;

-- 시퀀스의 현재 값 출력
select sample_seq.currval from dual;
-- 시퀀스의 다음 값 출력
select sample_seq.nextval from dual;

/*
nocache : 캐쉬를 사용하지 않겠다 (RAM)
    서버의 부하를 줄여줄 수 있음
*/
-- 초기값 2, 증가값 2
create sequence sample_seq2
increment by 2
start with 2
nocache;

select sample_seq2.nextval from dual;
select sample_seq2.currval from dual;

-- 시퀀스를 Primary Key 에 적용하기
create table dept_copy80
as
select * from department
where 0=1;

select * from dept_copy80;

-- 시퀀스 생성 : 초기값 10, 증가값 10
create sequence dept_seq
    increment by 10
    start with 10
    nocache;
    
insert into dept_copy80 (dno, dname, loc)
values (dept_seq.nextval, 'HR', 'SEOUL');

/*
Sequence 에 cache 를 사용하는 경우
cache : 서버의 성능을 향상시키게 하기 위해 사용 ( 기본 20개 )
    서버가 다운된 경우
        - 캐쉬된 넘버링이 모두 날라감
        - 새로운 값을 할당 받는다.
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
기존의 시퀀스 수정
*/
select * from user_sequences;
    
-- maxvalue
alter sequence emp_seq_no
    maxvalue 1000;

/*
시퀀스 제거
*/

drop sequence emp_seq_no;
drop sequence sample_seq2;

    
    
    
    
