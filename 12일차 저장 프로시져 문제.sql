-- 12일차 저장 프로시져 문제 

--1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
	[employee ] 테이블 이용

create or replace procedure sp_sal
is
    v_min number;
    v_max number;
    v_avg number;
    cursor c1
    is
    select min(salary), max(salary), avg(salary) into v_min , v_max, v_avg -- *주의*
    from employee
    group by dno;
begin
    dbms_output.put_line ('최소급여   최대급여   평균급여');
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


-- 2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
-- [employee, department ] 테이블 이용

create or replace procedure sp_emp_dept1
is 
    v_emp  employee%rowtype;
    v_dept department%rowtype; 
    cursor c2
    is
    select eno, ename, dname, loc  -- *주의*
    from employee e, department d
    where e.dno = d.dno;
begin
    FOR v_emp IN c2 LOOP
    dbms_output.put_line ('사원번호   사원이름   부서명   부서위치');
    dbms_output.put_line ('----------------------------------');
    dbms_output.put_line (v_emp.eno || '   ' || v_emp.ename|| '   ' || v_dept.dname || '   ' || v_dept.loc);
    end loop;
end;
/
exec sp_emp_dept1;



-- 3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
-- 저장프로시져명 : sp_salary_b

create or replace procedure sp_salary_b (
    v_salary in employee.salary%type
)
is 
    v_emp employee%rowtype; 
    v_dept department%rowtype;    
    cursor c1
    is
    select eno, ename, dname, loc   -- *주의*
    from employee e, department d
    where e.dno = d.dno;
begin
    FOR v_emp IN c1 LOOP
    dbms_output.put_line ('사원번호   사원이름   부서명   부서위치');
    dbms_output.put_line ('----------------------------------');
    dbms_output.put_line (v_emp.eno || '   ' || v_emp.ename|| '   ' || v_dept.dname || '   ' || v_dept.loc);
    end loop;
end;
/
exec sp_salary_b (3000);



-- 4. 인풋 매개변수 : emp_c10, dept_c10  두개를 입력 받아 각각 employee, department 테이블을 복사하는 저장프로시져를 생성하세요. 
-- 	저장프로시져명 : sp_copy_table
set serveroutput on	
create or replace procedure sp_copy_table1 (
    v_name in varchar2
    )
is

begin
    v_sql := 'CREATE TABLE ' || v_name || ' as select * from employee' ;  -- 테이블 생성쿼리를 변수에 할당.

    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- 커서 사용
    DBMS_SQL.PARSE ( cursor1, v_sql, dbms_sql.v7);  -- 커서를 사용해서 sql 쿼리를 실행
    DBMS_SQL.CLOSE_CURSOR(cursor1);                 -- 커서 중지
end;
/

create or replace procedure sp_copy_table2 (
    v_name in varchar2
    )
is
    cursor1 INTEGER;
    v_sql varchar2(100) ;  -- SQL 쿼리를 저장하는 변수

begin
    v_sql := 'CREATE TABLE ' || v_name || ' as select * from department' ;  -- 테이블 생성쿼리를 변수에 할당.
    
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- 커서 사용
    DBMS_SQL.PARSE ( cursor1, v_sql, dbms_sql.v7);  -- 커서를 사용해서 sql 쿼리를 실행
    DBMS_SQL.CLOSE_CURSOR(cursor1);                 -- 커서 중지
end;
/
drop table emp_c10;
exec sp_copy_table1 ('emp_c10');
exec sp_copy_table2 ('dept_c10');

select * from emp_c10;
select * from dept_c10;

5. dept_c10 테이블에서 dno, dname, loc 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 50  'HR'  'SEOUL'
	입력 값 : 60  'HR2'  'PUSAN' 
    
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


-- 6. emp_c10 테이블에서 모든 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 8000  'SONG'    'PROGRAMER'  7788  sysdate  4500  1000  50 
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



-- 7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
--	<부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
	입력갑 : 50  PROGRAMMER 

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

-- 8. emp_c10 테이블에서 사원번호를 인풋 받아 월급을 수정하는 저장 프로시져를 생성하시오. 
	입력 값 : 8000  6000

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

-- 9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오. 

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
    
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- 커서 사용
    DBMS_SQL.PARSE ( cursor1, v_sql, dbms_sql.v7);  -- 커서를 사용해서 sql 쿼리를 실행
    DBMS_SQL.CLOSE_CURSOR(cursor1);  
end;
/

exec sp_deleteTable('emp_c10','dept_c10');

select * from dept_c10;

-- 10. 사원이름을 인풋 받아서 사원명, 급여, 부서번호, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출
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
    -- 익명 블록에서는 저장프로 시져 호출시 exec를 붙이지 않는다.
    sp_ename_dno1 ('SCOTT', var_eno, var_sal, var_dno, var_dname, var_loc );  -- 저장프로시져 호출
    dbms_output.put_line('조회결과 : ' || var_eno || '   ' || var_sal || '   ' || var_dno || '   ' || var_dname || '   ' || var_loc);
end;
/

-- 11. 사원번호를 받아서 사원명, 급여, 직책, 부서명, 부서위치를 OUT 파라미터에 넘겨주는 프로시저를 PL/SQL에서 호출 
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