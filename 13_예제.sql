--13 ���ν��� ����

--1. �� �μ����� �ּұ޿�, �ִ�޿�, ��ձ޿��� ����ϴ� �������ν����� �����Ͻÿ�. 
--	[employee ] ���̺� �̿�

create or replace procedure sp_ex1
is
    v_dno employee.dno%type;
    v_min employee.salary%type;
    v_max employee.salary%type;
    v_avg employee.salary%type;
    
    cursor c1
    is
    select dno, min(salary), max(salary), avg(salary)
    from employee
    group by dno;
    
begin
    dbms_output.put_line ( '�μ���ȣ   �ּұ޿�   �ִ�޿�   ��ձ޿�');
    dbms_output.put_line (' -------------------------------------');
    open c1;
    loop
        fetch c1 into v_dno, v_min, v_max, v_avg;
        exit when c1%notfound;
        dbms_output.put_line(v_min || '    ' || v_max || '   ' || v_avg);
    end loop;
    close c1;
end;
/

exec sp_ex1;


-- 2.  �����ȣ, ����̸�, �μ���, �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.  
-- [employee, department ] ���̺� �̿�

    create or replace procedure sp_ex2
    is
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
        
        cursor c1
        is
        select eno, ename, dname, loc
        from employee e , department d
        where e.dno = d.dno;
        
    begin
       dbms_output.put_line('�����ȣ   ����̸�    �μ���   �μ���ġ');
       dbms_output.put_line('-------------------------------------');
       open c1;   -- Ŀ�� ����
       loop
            fetch c1 into v_eno, v_ename, v_dname, v_loc;
            exit when c1%notfound;    -- ���ڵ��� ���� ���̻� �������� ���� ��
            dbms_output.put_line(v_eno || '   ' || v_ename || '   ' || v_dname || '   ' || v_loc);
       end loop;
       close c1;
    end;
    /
exec sp_ex2;

-- 3. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.
create or replace procedure sp_ex3(
    v_salary in employee.salary%type
    )
is
    v_emp employee%rowtype;
    cursor c1
    is
    select ename, salary, job
    from employee
    where salary > v_salary;
begin
    dbms_output.put_line('����̸�   �޿�   ��å');
    dbms_output.put_line('------------------------');
    open c1;
    loop
        fetch c1 into v_emp.ename, v_emp.salary, v_emp.job;
        exit when c1%notfound;    -- ���ڵ��� ���� ���̻� �������� ���� ��
        dbms_output.put_line(v_emp.ename || '   ' || v_emp.salary || '   ' || v_emp.job);
   end loop;
   close c1;
end;
/
exec sp_ex3(1500);
select * from emp_c10;
    

    

4. ��ǲ�Ű����� : emp_c10, dept_c10 �ΰ��� �Է¹޾� ���� employee, department ���̺��� �����ϴ� �������ν��� ������
    �������ν��� �� : sp_copy_table
    
    PL/SQL ���ο��� �͸� ������� ���̺��� ���� : grant create table to public; <sys �������� ����>
    �������ν��� ������ : revoke create table from public; �����ؼ� ���� ȸ��
    
create or replace procedure sp_ex4(
    v_emp in varchar2 , v_dept in varchar2 -- 1. ; �� ������ �ȵ� 2. �ڷ����� ũ�⸦ �����ϸ� �ȵ�
    )
is
    c1 integer;     -- Ŀ�� ���� ����
    v_sql1 varcahr2(500);   -- ���̺� ���� ������ ���� ����
    v_sql2 varchar2(500);
begin
    v_sql1 := 'create table ' || v_emp || ' as select * from employee';
    v_sql2 := 'create table ' || v_dept || ' as select * from department';
    
    c1 := dbms_sql.open_cursor;
    dbms_sql.parse(c1, v_sql1, dbms_sql.v7);
    dbms_sql.parse(c1, v_sql2, dbms_sql.v7);
    dbms_sql.close_cursor(c1);
end;
/
exec sp_ex4('emp_c10', 'dept_c10');
select * from emp_c10;
select * from dept_c10;
    
5. dept_c10 ���̺��� dno, dname, loc �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert �ϴ� �������ν����� ����
�Է°� : 50 'HR' 'SEOUL'
�Է°� : 60 'HR2' 'BUSAN'

create or replace procedure sp_ex5 (
    v_dno in dept_c10%type,
    v_dname in dept_c10%type,
    v_loc in dept_c10%type
    )
    
    is
    begin 
       insert into dept_c10
       values ( v_dno, v_dname, v_loc);
    end;
    /
    
exec sp_ex5 (50, 'HR', 'SEOUL');
select * from dept_c10;


-- 6. emp_c10 ���̺��� ��� �÷��� ���� ��ǲ �޾� ��ǲ ���� ���� insert �ϴ� �������ν����� �������Ͻÿ�
 -- �Է°� : 8000 'SONG' 'PROGRAMER' 7788 sysdate 4500 1000 50
 select * from emp_c10;
 
 create or replace procedure sp_ex6 (
    v_eno in emp_c10.eno%type,
    v_ename in emp_c10.ename%type,
    v_job in emp_c10.job%type,
    v_manager in emp_c10.manager%type,
    v_hiredate in emp_c10.hiredate%type,
    v_salary in emp_c10.salary%type,
    v_commission in emp_c10.commission%type,
    v_dno in emp_c10.dno%type,
)
is
begin
    insert into emp_c10
    values ( v_eno, v_ename, v_job, v_manager, v_hiredate, v_salary, v_commission, v_dno);
    
    dbms_output.put_line('�� �ԷµǾ����ϴ�.');
end;
/
    
-- 7. dept_c10 ���̺��� 4�������� �μ���ȣ 50�� HR �� 'PROGRAM' ���� �����ϴ� �������ν����� �����ϼ���. 
--	<�μ���ȣ�� �μ����� ��ǲ�޾� �����ϵ��� �Ͻÿ�.> 
	-- �Է°� : 50  PROGRAMMER 
    
create or replace procedure sp_ex7 (
    v_dno in dept_c10.dno%type,
    v_dname in dept_c10.dname%type
    )
    
is
begin 
    update dept_c10
    set dname = vdname
    where dno = v_dno;
 
    dbms_output.put_line('������Ʈ �Ǿ����ϴ�.');
end;
/


--8 emp_c10 ���̺��� �����ȣ�� ��ǲ�޾� ������ �����ϴ� �������ν����� �����Ͻÿ� 8000 6000
create or replace procedure sp_ex8(
    v_eno in emp_c10.eno%type,
    v_salary in emp_c10.salary%type
    )
is

begin
    update emp_c10
    set salary = v_salary
    where eno = v_eno;
    
    dbms_output.put_line('�����Ǿ����ϴ�.');
end;
/
exec sp_ex8 (8000, 6000);
    