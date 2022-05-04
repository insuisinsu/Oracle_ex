--14 일 트리거

/*
트리거 (Trigger)
    - 테이블에 부착되어 있다.
    - 테이블에 이벤트가 발생될 때 자동으로 작동되는 프로그램 코드
    - 테이블에 발생되는 이벤트(Insert, Update, Delete)
    - 트리거에서 정의된 begin ~ end 사이의 구문이 실행됨
    - before 트리거    : 테이블에서 트리거를 먼저 실행한 후 이벤트가 적용
    - after 트리거     : 이벤트 적용후에 트리거 실행
    -- 주문 테이블에 값을 넣을 대 배송 테이블에 자동으로 저장
    -- 중요 테이블의 로그를 남길 때도 사용
    -- :new : 가상의 임시 테이블, 트리거가 부착된 테이블에 새롭게 들어오는 레코드의 임시 테이블
    -- :old : 가상의 임시 테이블, 트리거가 부착된 테이블에 삭제되는 레코드의 임시 테이블
    -- 트리거는 하나의 테이블에 총 3개까지 부착됨(insert, update, delete)
*/

-- 실습 테이블 생성
create table dept_original
as
select * from department
where 0=1;

create table dept_copy
as
select * from department
where 0=1;

-- 트리거 생성
-- dept_original 테이블에 부착
    -- insert 이벤트가 발생될 때 자동으로 작동

create or replace trigger tri_sample1
    -- 트리거가 부탁될 테이블, 이벤트, Before, After
    after insert            -- insert 이벤트가 작동한 후 트리거 실행
    on dept_original        -- on 부탁될 테이블
    for each row            -- 모든 row 에 대해서
    
begin
    -- 트리거가 실행할 코드
    if inserting then
        dbms_output.put_line('Insert Trigger 발생');
        insert into dept_copy
        values( :new.dno, :new.dname, :new.loc);    -- new 가상 임시 테이블
    end if;
end;
/

-- 트리거 확인 데이터 사전 : user_source
select * from user_source where name = 'TRI_SAMPLE1';
select * from dept_original;
select * from dept_copy;
 
insert into dept_original
values(12, 'PROGRAME', 'BUSAN'); 
insert into dept_original
values(15, 'PROGRAME4', 'BUSAN4'); 

/*
delete 트리거
*/
create or replace trigger tri_del
    after delete
    on dept_original
    for each row
begin
        dbms_output.put_line('delete trigger 발생');
        delete dept_copy
        where dept_copy.dno = :old.dno;
end;
/
select * from user_source where name = 'TRI_DEL';
select * from dept_original;
select * from dept_copy;

delete dept_original
where dno = 14;

/*
update 트리거
*/

create or replace trigger tri_update
    after update
    on dept_original
    for each row
begin
    dbms_output.put_line('Update Trigger 발생');
    update dept_copy
    set dept_copy.dname = :new.dname
    where dept_copy.dno = 13;
end;
/
update dept_original
set dname = 'prog'
where dno = 13;

desc department;
desc salgrade;

select * from salgrade;





