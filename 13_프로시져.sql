
-- 13���� - �������ν��� (Stored Procedure), �Լ� (Function), Ʈ���� (Trigger)

/*
    �������ν����� ����
        1. PL/SQL �� ��� �����ϴ�. �ڵ�ȭ
        2. ������ ������.
            �Ϲ����� SQL ���� : �����м� -> ��ü�̸�Ȯ�� -> ������Ȯ�� -> ����ȭ -> ������ -> ����
            �������ν��� ó������ : �����м� -> ��ü�̸�Ȯ�� -> ������Ȯ�� -> ����ȭ -> ������ -> ����
            �������ν��� �ι�°���� ���� : ������ (�޸𸮿� �ε�) -> ����
            
        3. �Է� �Ű�����, ��� �Ű������� ����� �� �ִ�.
        4. �Ϸ��� �۾��� ��� ���� (���ȭ�� ���α׷����� �����ϴ�.)
*/

-- 1. �������ν��� ����.
    -- ���� ����� ������ ����ϴ� ���� ���ν���

    Create procedure sp_salary
    is
        v_salary employee.salary%type;       -- �������ν����� is ������� ������ ����
    begin
        select salary into v_salary
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line ('SCOTT �� �޿��� : ' || v_salary || ' �Դϴ�'); 
    end;
    /
    
/* �������ν��� ������ Ȯ���ϴ� ������ ���� */

    select * from user_source
    where name = 'SP_SALARY';

-- 3. ���� ���ν��� ����

    EXECUTE sp_salary;      -- ��ü �̸�
    EXEC sp_salary;         -- ��� �̸�

-- 4. ���� ���ν��� ����

    Create or replace procedure sp_salary   -- sp_salary �� �������� ������ ����, �����ϸ� ����
    is
        v_salary employee.salary%type;       -- �������ν����� is ������� ������ ����
        v_commission employee.commission%type;
    begin
        select salary, commission into v_salary, v_commission
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line ('SCOTT �� �޿��� : ' || v_salary || 
                                ' ���ʽ��� : ' || v_commission || ' �Դϴ�'); 
    end;
    /

-- 4. ���� ���ν��� ����

drop procedure sp_salary ;

---------------------------- << ��ǲ �Ű������� ó���ϴ� ���� ���ν��� >> ------------------------------
    create or replace procedure sp_salary_ename (     -- �Է� �Ű�����(in), ��� �Ű�����(out)�� ����
        v_ename in employee.ename%type     -- ������ in �ڷ���   <== ���� :   << ; �� ����ϸ� �ȵȴ�. >> 
    )
    is          -- �������� (���� ���ν������� ����� ���� ���� ���)
        v_salary employee.salary%type;
    begin
        select salary into v_salary    -- ����
        from employee
        where ename = v_ename;         -- ��ǲ �Ű����� : v_ename
        
        dbms_output.put_line( v_ename || ' �� �޿��� ' || v_salary || ' �Դϴ�');
    end;
    /

    EXEC sp_salary_ename ('SCOTT');
    EXEC sp_salary_ename ('SMITH');
    EXEC sp_salary_ename ('KING');
    select * from employee;

/* �μ� ��ȣ�� ��ǲ �޾Ƽ� �̸�, ��å, �μ���ȣ�� ����ϴ� ���� ���ν����� �����ϼ���. (Ŀ���� ����ؾ���)*/
/*
���̺� �̸��� ��ǲ �޾Ƽ� employee ���̺��� �����ؼ� �����ϴ� �������ν����� �����ϼ���
��ǲ�� : emp_copy33
*/

create or replace procedure sp_createTable (
    v_name in varchar2
    )
is
    cursor1 INTEGER;
    v_sql varchar2(200);     --sql ������ �����ϴ� ����
begin
    v_sql := 'CREATE TABLE ' || v_name || ' as select * from employee'; -- ���̺� ���������� ������ �Ҵ�
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- Ŀ�� ���
    DBMS_SQL.parse ( cursor1, v_sql, dbms_sql.v7 ); -- Ŀ���� ����ؼ� sql ���� ����
    DBMS_SQL.close_cursor(cursor1);                 -- Ŀ�� ����
end;
/

grant create table to public;

exec sp_createTable('emp_copy33');
select & from emp_copy33;


