-- 12���� ���� ���ν��� ���� 

--1. �� �μ����� �ּұ޿�, �ִ�޿�, ��ձ޿��� ����ϴ� �������ν����� �����Ͻÿ�. 
	[employee ] ���̺� �̿�

create or replace procedure sp_sal
is
    v_min number;
    v_max number;
    v_avg number;
    cursor c1
    is
    select min(salary), max(salary), avg(salary) into v_min , v_max, v_avg -- *����*
    from employee
    group by dno;
begin
    dbms_output.put_line ('�ּұ޿�   �ִ�޿�   ��ձ޿�');
    dbms_output.put_line ('--------------------------');
    open c1;
    loop
        fetch c1 into v_min, v_max, v_avg;
        exit when c1%notfound;
        dbms_output.put_line (v_min || '   ' || v_max || '   ' || v_avg);
    end loop;
    close c1; 
end;
/
exec sp_sal;


-- 2.  �����ȣ, ����̸�, �μ���, �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.  
-- [employee, department ] ���̺� �̿�

create or replace procedure sp_emp_dept1
is 
    v_emp  employee%rowtype;
    v_dept department%rowtype; 
    cursor c2
    is
    select eno, ename, dname, loc  -- *����*
    from employee e, department d
    where e.dno = d.dno;
begin
    FOR v_emp IN c2 LOOP
    dbms_output.put_line ('�����ȣ   ����̸�   �μ���   �μ���ġ');
    dbms_output.put_line ('----------------------------------');
    dbms_output.put_line (v_emp.eno || '   ' || v_emp.ename|| '   ' || v_dept.dname || '   ' || v_dept.loc);
    end loop;
end;
/
exec sp_emp_dept1;



-- 3. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
-- �������ν����� : sp_salary_b

create or replace procedure sp_salary_b (
    v_salary in employee.salary%type
)
is 
    v_emp employee%rowtype; 
    v_dept department%rowtype;    
    cursor c1
    is
    select eno, ename, dname, loc   -- *����*
    from employee e, department d
    where e.dno = d.dno;
begin
    FOR v_emp IN c1 LOOP
    dbms_output.put_line ('�����ȣ   ����̸�   �μ���   �μ���ġ');
    dbms_output.put_line ('----------------------------------');
    dbms_output.put_line (v_emp.eno || '   ' || v_emp.ename|| '   ' || v_dept.dname || '   ' || v_dept.loc);
    end loop;
end;
/
exec sp_salary_b (3000);



-- 4. ��ǲ �Ű����� : emp_c10, dept_c10  �ΰ��� �Է� �޾� ���� employee, department ���̺��� �����ϴ� �������ν����� �����ϼ���. 
-- 	�������ν����� : sp_copy_table
set serveroutput on	
create or replace procedure sp_copy_table1 (
    v_name in varchar2
    )
is

begin
    v_sql := 'CREATE TABLE ' || v_name || ' as select * from employee' ;  -- ���̺� ���������� ������ �Ҵ�.

    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- Ŀ�� ���
    DBMS_SQL.PARSE ( cursor1, v_sql, dbms_sql.v7);  -- Ŀ���� ����ؼ� sql ������ ����
    DBMS_SQL.CLOSE_CURSOR(cursor1);                 -- Ŀ�� ����
end;
/

create or replace procedure sp_copy_table2 (
    v_name in varchar2
    )
is
    cursor1 INTEGER;
    v_sql varchar2(100) ;  -- SQL ������ �����ϴ� ����

begin
    v_sql := 'CREATE TABLE ' || v_name || ' as select * from department' ;  -- ���̺� ���������� ������ �Ҵ�.
    
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- Ŀ�� ���
    DBMS_SQL.PARSE ( cursor1, v_sql, dbms_sql.v7);  -- Ŀ���� ����ؼ� sql ������ ����
    DBMS_SQL.CLOSE_CURSOR(cursor1);                 -- Ŀ�� ����
end;
/
drop table emp_c10;
exec sp_copy_table1 ('emp_c10');
exec sp_copy_table2 ('dept_c10');

select * from emp_c10;
select * from dept_c10;

5. dept_c10 ���̺��� dno, dname, loc �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 50  'HR'  'SEOUL'
	�Է� �� : 60  'HR2'  'PUSAN' 
    
    desc dept_c10;
    
create or replace procedure d_c10(
    v_dno in dept_c10.dno%type,
    v_dname in dept_c10.dname%type,
    v_loc in dept_c10.loc%type
)
is

begin
    INSERT INTO dept_c10(dno, dname, loc)
    VALUES(v_dno, v_dname, v_loc);

    COMMIT;
end;
/
exec d_c10 (50,'HR','SEOUL');
exec d_c10 (60,'HR2','PUSAN');


-- 6. emp_c10 ���̺��� ��� �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert�ϴ� �������ν����� �����Ͻÿ�. 
	�Է� �� : 8000  'SONG'    'PROGRAMER'  7788  sysdate  4500  1000  50 
select * from emp_c10;

create or replace procedure e_c10(
    v_eno emp_c10.eno%type,
    v_ename emp_c10.ename%type, 
    v_job emp_c10.job%type, 
    v_manager emp_c10.manager%type,
    v_hiredate emp_c10.hiredate%type, 
    v_salary emp_c10.salary%type, 
    v_commission emp_c10.commission%type, 
    v_dno emp_c10.dno%type 
)
is
begin
    INSERT INTO emp_c10
    values (v_eno, v_ename, v_job, v_manager, v_hiredate, v_salary, v_commission, v_dno);
    commit;
end;
/
exec e_c10 (8000,'SONG','PROGRAMER',7788,sysdate,4500,1000,50);



-- 7. dept_c10 ���̺��� 4�������� �μ���ȣ 50�� HR �� 'PROGRAM' ���� �����ϴ� �������ν����� �����ϼ���. 
--	<�μ���ȣ�� �μ����� ��ǲ�޾� �����ϵ��� �Ͻÿ�.> 
	�Է°� : 50  PROGRAMMER 

create or replace procedure d_c10(
    v_dno dept_c10.dno%type, 
    v_dname dept_c10.dname%type
)
is   
begin
    UPDATE dept_c10 
    SET dname = v_dname 
    where dno = v_dno ;   
    commit;
end;
/

exec D_C10(50,'PROGRAMER');

select * from dept_c10 ;

-- 8. emp_c10 ���̺��� �����ȣ�� ��ǲ �޾� ������ �����ϴ� ���� ���ν����� �����Ͻÿ�. 
	�Է� �� : 8000  6000

select * from emp_c10;

set serveroutput on 
create or replace procedure e_c10(
    v_eno emp_c10.eno%type, v_salary emp_c10.salary%type
)
is
begin
    UPDATE emp_c10 
    SET salary = v_salary 
    where eno = v_eno ;  
    commit;
end;
/
exec E_C10(8000,6000);

select * from emp_c10;

-- 9. ���� �� ���̺���� ��ǲ �޾� �� ���̺��� �����ϴ� �������ν����� ���� �Ͻÿ�. 

set serveroutput on
create or replace procedure sp_deleteTable (
    v_name1 in varchar2, 
    v_name2 in varchar2
    )
is
    cursor1 INTEGER;
    v_sql varchar2(100) ;
begin
    v_sql := 'drop table' || v_name1 || ';' ' drop table ' || v_name2 || ';';
    
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- Ŀ�� ���
    DBMS_SQL.PARSE ( cursor1, v_sql, dbms_sql.v7);  -- Ŀ���� ����ؼ� sql ������ ����
    DBMS_SQL.CLOSE_CURSOR(cursor1);  
end;
/

exec sp_deleteTable('emp_c10','dept_c10');

select * from dept_c10;

-- 10. ����̸��� ��ǲ �޾Ƽ� �����, �޿�, �μ���ȣ, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL / SQL���� ȣ��
create or replace procedure sp_ename_dno1 (
    v_ename in employee.ename%type,
    v_eno out employee.eno%type,
    v_salary out employee.salary%type,
    v_dno out employee.dno%type,
    v_dname out department.dname%type,
    v_loc out department.loc%type
)
is
begin
    select eno, salary, e.dno, dname, loc into v_eno, v_salary, v_dno, v_dname, v_loc
    from employee e , department d
    where e.dno = d.dno
    and ename = v_ename;
end;
/
set serveroutput on
declare
    var_eno varchar2(50);
    var_sal number;
    var_dno number;
    var_dname varchar2(50);
    var_loc varchar2(50);
begin
    -- �͸� ��Ͽ����� �������� ���� ȣ��� exec�� ������ �ʴ´�.
    sp_ename_dno1 ('SCOTT', var_eno, var_sal, var_dno, var_dname, var_loc );  -- �������ν��� ȣ��
    dbms_output.put_line('��ȸ��� : ' || var_eno || '   ' || var_sal || '   ' || var_dno || '   ' || var_dname || '   ' || var_loc);
end;
/

-- 11. �����ȣ�� �޾Ƽ� �����, �޿�, ��å, �μ���, �μ���ġ�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL/SQL���� ȣ�� 
create or replace procedure sp_eno_n1 (
    v_eno in employee.eno%type,
    v_ename out employee.ename%type,
    v_salary out employee.salary%type,
    v_dname out department.dname%type,
    v_loc out department.loc%type
    )
is
    cursor c1
    is
    select ename, salary, dname, loc into v_ename, v_salary, v_dname, v_loc
    from employee e, department d
    where e.dno = d.dno
    and eno = v_eno;    
begin
    open c1;
    loop
        fetch c1 into v_ename, v_salary, v_dname, v_loc;
        exit when c1%notfound;
        dbms_output.put_line(v_ename || '   ' || v_salary || '   ' || v_dname || '   ' || v_loc );
    end loop;
    close c1;
end;
/

select * from  department; 
declare    
    var_ename varchar2(50);
    var_sal number;
    var_dname varchar2(50);
    var_loc varchar2(50);
begin 
    sp_eno_n1 (7788, var_ename, var_sal, var_dname, var_loc);
    dbms_output.put_line(var_ename || '   ' || var_sal || '   ' || var_dname || '   ' || var_loc);
end;
/