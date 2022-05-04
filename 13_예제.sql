--13 프로시져 예제

--1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
--	[employee ] 테이블 이용

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
    dbms_output.put_line ( '부서번호   최소급여   최대급여   평균급여');
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


-- 2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
-- [employee, department ] 테이블 이용

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
       dbms_output.put_line('사원번호   사원이름    부서명   부서위치');
       dbms_output.put_line('-------------------------------------');
       open c1;   -- 커서 시작
       loop
            fetch c1 into v_eno, v_ename, v_dname, v_loc;
            exit when c1%notfound;    -- 레코드의 값이 더이상 존재하지 않을 때
            dbms_output.put_line(v_eno || '   ' || v_ename || '   ' || v_dname || '   ' || v_loc);
       end loop;
       close c1;
    end;
    /
exec sp_ex2;

-- 3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
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
    dbms_output.put_line('사원이름   급여   직책');
    dbms_output.put_line('------------------------');
    open c1;
    loop
        fetch c1 into v_emp.ename, v_emp.salary, v_emp.job;
        exit when c1%notfound;    -- 레코드의 값이 더이상 존재하지 않을 때
        dbms_output.put_line(v_emp.ename || '   ' || v_emp.salary || '   ' || v_emp.job);
   end loop;
   close c1;
end;
/
exec sp_ex3(1500);
select * from emp_c10;
    

    

4. 인풋매개변수 : emp_c10, dept_c10 두개를 입력받아 각각 employee, department 테이블을 복사하는 저장프로시저 만들어라
    저장프로시저 명 : sp_copy_table
    
    PL/SQL 내부에서 익명 블락에서 테이블을 생성 : grant create table to public; <sys 계정으로 접속>
    저장프로시저 실행후 : revoke create table from public; 실행해서 권한 회수
    
create or replace procedure sp_ex4(
    v_emp in varchar2 , v_dept in varchar2 -- 1. ; 을 넣으면 안됨 2. 자료형의 크기를 지정하면 안됨
    )
is
    c1 integer;     -- 커서 변수 선언
    v_sql1 varcahr2(500);   -- 테이블 생성 쿼리를 담을 변수
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
    
5. dept_c10 테이블에서 dno, dname, loc 컬럼의 값을 인풋 받아 인풋 받은 값을 insert 하는 저장프로시져를 생성
입력값 : 50 'HR' 'SEOUL'
입력값 : 60 'HR2' 'BUSAN'

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


-- 6. emp_c10 테이블에서 모든 컬럼의 값을 인풋 받아 인풋 받은 값을 insert 하는 저장프로시져를 새엇ㅇ하시오
 -- 입력값 : 8000 'SONG' 'PROGRAMER' 7788 sysdate 4500 1000 50
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
    
    dbms_output.put_line('잘 입력되었습니다.');
end;
/
    
-- 7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
--	<부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
	-- 입력값 : 50  PROGRAMMER 
    
create or replace procedure sp_ex7 (
    v_dno in dept_c10.dno%type,
    v_dname in dept_c10.dname%type
    )
    
is
begin 
    update dept_c10
    set dname = vdname
    where dno = v_dno;
 
    dbms_output.put_line('업데이트 되었습니다.');
end;
/


--8 emp_c10 테이블에서 사원번호를 인풋받아 월급을 수정하는 저장프로시져를 생성하시오 8000 6000
create or replace procedure sp_ex8(
    v_eno in emp_c10.eno%type,
    v_salary in emp_c10.salary%type
    )
is

begin
    update emp_c10
    set salary = v_salary
    where eno = v_eno;
    
    dbms_output.put_line('수정되었습니다.');
end;
/
exec sp_ex8 (8000, 6000);
    