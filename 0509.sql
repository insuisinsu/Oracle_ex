-- 회원 정보를 저장하는 테이블
Create table mbTbl (
    idx number not null,
    id varchar2(100) not null,
    pass varchar2(100) not null,
    name varchar2(100) not null,
    email varchar2(100) not null,
    city varchar2(100) null,
    phone varchar2(100) null
);

select * from mbTbl order by idx;

drop table mbTbl
drop sequence seq_mbTbl_idx
alter table mbTbl
add constraint mbTbl_id_PK primary key (id);

create sequence seq_mbTbl_idx
    increment by 1
    start with 1
    nocache;

-- 더미 데이터 입력
insert into mbTbl ( idx, id, pass, name, email, city, phone)
values (seq_mbTbl_idx.nextval, 'admin', '1234', '관리자', 'kosmo@kosmo.com', '서울', '010-1111-1111');


drop table emp_copy
create table emp_copy
as
select * from employee;
select * from emp_copy
desc emp_copy

insert into emp_copy
values (9876, 'df', 'df', 8766, '2022-03-03', 1, 1, 99)


