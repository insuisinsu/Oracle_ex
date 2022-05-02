show user;

-- �ְ� ������ ���� sys
--  - ������ ������ �� �ִ� ������ ������ ����

-- id : usertest01, pw : 1234
create user usertest01 identified by 1234;

-- ����/��ȣ ���� �ϴ��� Oracle �� ������ �� �ִ� ������ �޾ƾ���

-- System privileges
    -- Create Session   : ����Ŭ�� ������ �� �ִ� ����
    -- Create Table     : ����Ŭ���� ���̺��� ������ �� �ִ� ����
    -- Create Sequence  : 
    -- Create view
    
/*
DDL : ��ü ���� (Create, Alter, Drop)
DML : ���ڵ� ���� (Insert, Update, Delete)
DQL : ���ڵ� �˻� (Select)
DTL : Ʈ����� (Begin transaction, rollback, commit)
DCL : ���Ѱ��� (Grant �ο�, Revoke ����, Deny �ź�)
*/

-- ������ �������� ���� �ο��ϱ�
-- grant �ο��� ���� to ������
grant create session to usertest01;

grant create table to usertest01;


/*
���Ѱ���

    ������
    . DBMS �� ���� ���� �����
    . DBMS �� ������ �� �ִ� ����ڸ� ����
        .. ����( Authentication   : Credential = ( Identity + Password ) Ȯ��)
        .. �㰡( Authorization    : ������ ����ڿ��� Oracle �� �ý��� ����, ��ü ������
            ... System Privileges : ����Ŭ�� �������� ���� �Ҵ�, ���̺� �����̽� ������ �������� ����
            ... Object Privileges : ��ü ��뿡 ���� �������� ���� �Ҵ�
                (���̺�, ��, Ʈ����, �Լ�, �������ν���, ������, �ε��� ��)
*/

-- Oracle ���� ���� ����
-- �Ϲ� ���������� ������ ������ �� �ִ� ������ ����

--Object Pricileges : ���̺�, ��, Ʈ����, �Լ�
    -- ���� ���ν���, ������, �ε����� �ο��Ǵ� ���� �Ҵ�
    
/*
    ����      Table       View        Sequence        Procedeur
    Alter       O                       O
    Delete      O           O  
    Execute                                                 O
    Index       O 
    Insert      O           O
    References  O
    Select      O           O           O 
    Update      O           O
*/    

-- Ư�� ���̺� select ���� �ο��ϱ�
-- ���� ����
-- Autication(����) : credential( ID + PW )
create user user_test10 identified by 1234;
-- Authorization(�㰡) : system ���� �Ҵ�
grant create session, create table, create view to user_test10;
-- ������ �����ϸ� �⺻������ system ���̺� �����̽��� ����� <- �����ڸ� ��밡���� ���̺�
-- ���̺� �����̽��� USERS �� ����
Alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- Ư�� �������� ��ü�� �����ϸ� �� ������ �� ��ü�� �����ϰ� ��

select * from dba_tables
where owner in ('HR', 'USER_TEST10');

-- user_test10 ���� HR �� �������� employee ���̺��� ������ �� ��ü�� ���ٱ��� �ʿ�
-- ��ü ��½� ��ü�� �տ� ��ü�� ������ �����ָ��� �־������
    -- ��, �ڱ� ��ü�� ���� ����
select * from hr.employee; 
-- ���� �ο�
grant select on hr.employee to user_test10;



show user;

-- create user id identified by pw;
create user usertest01 identified by 1234;

-- 

/*
���̺� �����̽� ( Table Space )
    - ��ü�� ������ �� �ִ� ����
    - ������ �������� �� ����ں� ���̺� �����̽��� Ȯ��
*/
select * from dba_users;

select username, default_tablespace as DataFile, temporary_tablespace as LogFile
from dba_users
where username in('HR', 'USERTEST01');

-- ������ ���̺� �����̽� ���� (SYSSTEM -> USERS)
alter user usertest01
default tablespace users
temporary tablespace temp;

-- �������� Users ���̺� �����̽��� ����� �� �ִ� ���� �Ҵ�
alter user usertest01
quota 2m on users;

/*
usertest02 ������ ������ �Ŀ� users ���̺� �����̽����� ���̺�(tbl2) ������ insert
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
���̺� �����̽� : ��ü�� Log �� �����ϴ� �������� ����
    DataFile : ��ü�� �����ϰ� ����
    Log      : Transaction Log �� ����
    
    DataFile �� Log ������ ���������� �ٸ� �ϵ������ �����ؾ� ������ ���� �� ����
        -RAID �� ������ �����ϸ� ������ ���� �� ����

*/





