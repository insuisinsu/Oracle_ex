--7���� ������ ����

/*
������ ���� : �ý����� ���� ������ ������ִ� ���̺�
    user_   : �ڽ��� ������ ���� ��ü������ ���
    all_    : �ڽ��� ������ ������ ��ü�� ������ �ο����� ��ü ������ ���
    dba_    : ������ ���̽� �����ڸ� ���� ������ ��ü ������ ��� // ������ ���������� ��� ����
*/
-- user_
show user;                          -- ���� ������ ����
select * from user_tables;          -- ����ڰ� ������ ���̺� ���� ���
select table_name from user_tables;

select * from user_views;           -- ����ڰ� ������ �� ���� ���
select * from user_indexes;         -- ����ڰ� ������ �ε��� ���� ���
select * from user_constraints;     -- �������� Ȯ��
select * from user_sequences;

select * from user_constraints
where table_name = 'EMPLOYEE';

-- all_
select * from all_tables;

-- dba -- ������ ���������� ���� ����
select * from dba_tables;

