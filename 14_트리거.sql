--14 �� Ʈ����

/*
Ʈ���� (Trigger)
    - ���̺� �����Ǿ� �ִ�.
    - ���̺� �̺�Ʈ�� �߻��� �� �ڵ����� �۵��Ǵ� ���α׷� �ڵ�
    - ���̺� �߻��Ǵ� �̺�Ʈ(Insert, Update, Delete)
    - Ʈ���ſ��� ���ǵ� begin ~ end ������ ������ �����
    - before Ʈ����    : ���̺��� Ʈ���Ÿ� ���� ������ �� �̺�Ʈ�� ����
    - after Ʈ����     : �̺�Ʈ �����Ŀ� Ʈ���� ����
    -- �ֹ� ���̺� ���� ���� �� ��� ���̺� �ڵ����� ����
    -- �߿� ���̺��� �α׸� ���� ���� ���
    -- :new : ������ �ӽ� ���̺�, Ʈ���Ű� ������ ���̺� ���Ӱ� ������ ���ڵ��� �ӽ� ���̺�
    -- :old : ������ �ӽ� ���̺�, Ʈ���Ű� ������ ���̺� �����Ǵ� ���ڵ��� �ӽ� ���̺�
    -- Ʈ���Ŵ� �ϳ��� ���̺� �� 3������ ������(insert, update, delete)
*/

-- �ǽ� ���̺� ����
create table dept_original
as
select * from department
where 0=1;

create table dept_copy
as
select * from department
where 0=1;

-- Ʈ���� ����
-- dept_original ���̺� ����
    -- insert �̺�Ʈ�� �߻��� �� �ڵ����� �۵�

create or replace trigger tri_sample1
    -- Ʈ���Ű� ��Ź�� ���̺�, �̺�Ʈ, Before, After
    after insert            -- insert �̺�Ʈ�� �۵��� �� Ʈ���� ����
    on dept_original        -- on ��Ź�� ���̺�
    for each row            -- ��� row �� ���ؼ�
    
begin
    -- Ʈ���Ű� ������ �ڵ�
    if inserting then
        dbms_output.put_line('Insert Trigger �߻�');
        insert into dept_copy
        values( :new.dno, :new.dname, :new.loc);    -- new ���� �ӽ� ���̺�
    end if;
end;
/

-- Ʈ���� Ȯ�� ������ ���� : user_source
select * from user_source where name = 'TRI_SAMPLE1';
select * from dept_original;
select * from dept_copy;
 
insert into dept_original
values(12, 'PROGRAME', 'BUSAN'); 
insert into dept_original
values(15, 'PROGRAME4', 'BUSAN4'); 

/*
delete Ʈ����
*/
create or replace trigger tri_del
    after delete
    on dept_original
    for each row
begin
        dbms_output.put_line('delete trigger �߻�');
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
update Ʈ����
*/

create or replace trigger tri_update
    after update
    on dept_original
    for each row
begin
    dbms_output.put_line('Update Trigger �߻�');
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





