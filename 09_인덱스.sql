--9���� �ε���

/*
INDEX : Ư�� �÷��� �˻��� ������ ����� �� �ֵ��� �Ѵ�.
          - ���̺��� �÷��� ����
    . Index Page : �÷��� �߿� Ű���带 �ɷ��� ��ġ ������ ��Ƴ��� ������
        - DB ������ 10% ������ ������
    . ����(Index)
        - å�� ����, å ������ �߿� Ű���带 �����ؼ� ��ġ�� �˷���
    . ���̺� ��ĵ : ���ڵ��� ó������ ������ ���� �˻��ϴ� ��
       - index �� �����Ǿ� ���� ���� �÷����� �ǽ���
       - �˻� �ӵ��� ����
    . Primary Key, Unique �� ����� �÷��� �ڵ����� index page �� �������
    . Where ������ ���� �˻��ϴ� �÷��� Index �� ������
    . Index �� ������ ���� ���ϰ� ���� �ɸ��� ������ �ַ� �߰��� ������
*/

/*
index ������ ����Ǿ� �ִ� ������ ����
    . user_columns
    . user_ind_columns
*/
    
select * from user_tab_columns;
select * from user_ind_columns;

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMPLOYEE', 'DEPARTMENT');


-- ENO �÷��� Primary Key �� �Ҵ�Ǿ� �ֱ� ������ �ڵ����� Index �� �����Ǿ� ����
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

-- ename �÷��� index �� ���� ������ KING �� �˻��ϱ� ���� ���̺� ��ĵ�� �ǽ���
select * from emp_copy90
where ename = 'KING';

-- ename �÷��� index �����ϱ�
create index id_emp_ename
on emp_copy90(ename);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('EMP_COPY90');

drop index id_emp_ename;

/*
Index �� �ֱ������� ReBuild �ؾ���
    . Index Page �� ��������
        - Insert, Update, Delete �� ����ϰ� �Ͼ ���
*/

-- Index ReBuild �� �ؾ��Ѵٴ� ���� ���
-- Index �� Tree ���̰� 4 �̻��� ��찡 ��ȸ�� �Ǹ� ReBuild �� �ʿ䰡 ����
SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

-- Index Rebuild �ϱ�
-- Index �� ���Ӱ� ������
Alter index ID_EMP_ENAME rebuild;

/*

Index �� ����ؾ� �ϴ� ���
 1. ���̺��� ��(�ο�, ���ڵ�) �� ������ ���� ���
 2. Where ������ ���� ���Ǵ� �÷�
 3. Join �� ���Ǵ� Ű �÷�
 4. �˻� ����� ���� ���̺� �������� 2 ~ 4 % ���� �Ǵ� ���
 5. �ش� �÷��� null �� �������ϴ� ��� (������ null �� ����)
 
Index �� ������� �ʴ� ���
 1. ���̺��� ���� ������ ���� ���
 2. �˻� ����� ���� ���̺��� ���� ������ �����ϴ� ���
 3. Insert, Update, Delete �� ����ϰ� �Ͼ�� �÷�
 
*/

/*
Index ����
    1. ���� �ε��� (Unique Index)    : �÷��� �ߺ����� �ʴ� ������ ���� ���� Index (Primary Key, Unique
    2. ���� �ε��� (Single Index)    : �� �÷��� �ο��Ǵ� Index
    3. ���� �ε��� (Composite Index) : ���� �÷��� ��� ������ Index
    4. �Լ� �ε��� (Function Base Index) : �Լ��� ������ �÷��� ������ Index
*/

select * from emp_copy90;

-- ���� �ε��� ����
create index idx_emp_copy90_salary
on emp_copy90 (salary);

-- ���� �ε��� ����
create table dept_copy91
as
select * from department;

create index idx_emp_copy90_dname_loc
on dept_copy91 (dname, loc);

select index_name, table_name, column_name
from user_ind_columns
where table_name in ('DEPT_COPY91');

-- �Լ� ��� �ε���
create table emp_copy91
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91 ( salary * 12 );

-- �ε��� ����
drop index idx_emp_copy91_allsal;
















