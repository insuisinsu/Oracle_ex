12일차 - PL/SQL : 오라클에서 프로그래밍 요소를 적용한 SQL , 유연하게 처리해서 적용. 
        MSSQL : T-SQL 
    SQL : 구조화된 질의언어 , 단점 : 유연한 프로그래밍 기능을 적용할 수 없다. 
    
set serveroutput on     -- PL/SQL의 출력을 활성화 


/* PL SQL의 기본 작성 구문 */ 

begin 
    -- PL/SQL 구문 
end;
/


show user; 

-- PL/SQL에서 기본 출력 

set serveroutput on 
begin
    dbms_output.put_line('Welcome to Oracle');
end;
/

-- PL / SQL에서 변수 선언 하기.

   변수명 :=  값 
   
 desc employee;  
 
   -- 자료형 선언 
      1.  Oracle 의 자료형을 사용. 
      2. 참조자료형 : 테이블의 컬럼의 선언된 자료형을 참조해서 사용. 
            %type  : 테이블의 특정컬럼의 자료형을 참조해서 사용. (테이블의 컬럼 1개 참조)
            %rowtype : 테이블 전체 컬럼의 자료형을 모두 참조 해서 사용. 
   
   
   
 set serveroutput on 
 
 declare  -- 변수 선언 (변수 선언부)
     v_eno number(4) ;              -- 오라클의 자료형       
     v_ename employee.ename%type;   -- 참조 자료형 : 테이블의 컬럼의 자료형을 참조해서 적용. 
 begin 
    v_eno := 7788;              -- :=  변수의 값을 할당 할때 사용. 
    v_ename := 'SCOTT';
    
    dbms_output.put_line('사원번호    사원이름'); 
    dbms_output.put_line('------------------'); 
    dbms_output.put_line(v_eno || '    ' || v_ename); 
 
 end;
 /
 
 /* 사원번호와 사원이름 출력 하기 */ 
 
  set serveroutput on 
  declare
    v_eno employee.eno%type; 
    v_ename employee.ename%type; 
  begin
      dbms_output.put_line('사원번호    사원이름'); 
      dbms_output.put_line('------------------'); 
      
      select eno, ename into v_eno, v_ename
      from employee
      where ename = 'SCOTT'; 
 
     dbms_output.put_line(v_eno || '    ' || v_ename); 
  
  end;
  /
  
  select eno, ename
  from employee
  where ename = 'SCOTT' 
  
  /* PL/sql에서 제어문 사용하기 */ 
  
  /* If ~ End if 문 사용하기 */ 
  
  set serveroutput on 
  declare
     v_employee employee%rowtype; -- rowtype :  employee테이블의 모든 컬럼의 자료형을 참조해서 사용.
                            -- v_employee 변수는 employee테이블의 모든 컬럼을 참조. 
     annsal number (7,2);   -- 총연봉을 저장하는 변수 
  begin
    select * into v_employee
    from employee
    where ename = 'SCOTT';   
    if (v_employee.commission is null) then 
        v_employee.commission := 0 ; 
    end if;  
    annsal := v_employee.salary *12 + v_employee.commission; 
    dbms_output.put_line('사원번호   사원이름   연봉');
    dbms_output.put_line('-----------------------');
    dbms_output.put_line(v_employee.eno || '   ' || v_employee.ename || '    ' ||
                annsal );
  end;
  /
  
  /*
        v_employee.eno  := 7788
        v_employee.ename := 'SCOTT'
        v_employee.job := ANALYST
        v_employee.manager := 7566
        v_employee.hiredate := 87/07/13
        v_employee.salary := 3000
        v_employee.commission := null
        v_employee.dn0 = 20 
  */

select * from employee
where ename = 'SCOTT'

/* PL/SQL 을 사용해서 department 테이블을 . 
    조건은 dno = 20 을 변수에 담아서 출력 해보세요. 
*/ 

1. %type  : 변수의 data type을 테이블의 컬럼하나하나를 참조해서 할당. 
set serveroutput on
declare 
  v_dno department.dno%type; 
  v_dname department.dname%type;
  v_loc department.loc%type; 
begin 
   select dno, dname, loc into v_dno, v_dname, v_loc
   from department
   where dno =20 ;
   
   dbms_output.put_line('부서번호   부서명   위치');
   dbms_output.put_line('---------------------');
    dbms_output.put_line(v_dno || '   ' || v_dname || '   ' || v_loc );
end;
/




2. %rowtype : 테이블의 모든 컬럼을 참조해서 사용. 
set serveroutput on
declare 
  v_department department%rowtype;  
begin 
   select dno, dname, loc into v_department
   from department
   where dno =20 ;
   
   dbms_output.put_line('부서번호   부서명   위치');
   dbms_output.put_line('---------------------');
    dbms_output.put_line(v_department.dno || '   ' || v_department.dname || '   ' || 
    v_department.loc );
end;
/

/* IF ~ ELSIF ~ END IF */

set serveroutput on
declare 
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dno employee.dno%type;
    v_dname department.dname%type := null ;
begin
    select eno, ename, dno into v_eno, v_ename, v_dno
    from employee
    where ename = 'SCOTT' ;
    
    if (v_dno = 10) then
        v_dname := 'ACCOUNT';
    elsif (v_dno = 20 ) then
        v_dname := 'SESEARCH';
    elsif (v_dno =30) then
        v_dname := 'SALES';
    elsif (v_dno = 40 ) then
        v_dname := 'OPERATIONS';
    end if; 
    
    dbms_output.put_line('사원번호  사원명   부서명');
    dbms_output.put_line('----------------------');
    dbms_output.put_line( v_eno || '   ' || v_ename || '   ' || v_dname);

end;
/

select * from employee where ename='SCOTT' 

/* employee 테이블의 eno, ename, salary, dno 을 PL/SQL 을 사용해서 출력 
    조건 은 보너스 1400인 사원 에 대해서  */
 
 완료시간 : 4:45 분까지    
    
1. %type 

set serveroutput on
declare 
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.dno%type;
begin
    select eno, ename,salary, dno into v_eno, v_ename,v_salary, v_dno
    from employee
    where commission = 1400;
    dbms_output.put_line('사원번호   사원명   월급   부서번호'); 
    dbms_output.put_line('--------------------------------'); 
    dbms_output.put_line(v_eno ||'   '|| v_ename||'    '||v_salary||'   '|| v_dno); 
end;
/ 


2. %rowtype 
    
 set serveroutput on
declare 
    v_employee employee%rowtype; 
begin
    select * into v_employee
    from employee
    where commission = 1400;
    dbms_output.put_line('사원번호   사원명   월급   부서번호'); 
    dbms_output.put_line('--------------------------------'); 
    dbms_output.put_line(v_employee.eno ||'   '|| v_employee.ename||'    '||
        v_employee.salary||'   '|| v_employee.dno); 
end;
/   

/* 커서 (cursor) : PL/SQL에서 select 한 결과가 단일 레코드가 아니라 레코드 셋인 경우에 커서가 필요하다. 
*/ 

declare 
  cursor  커서명                   1. 커서 선언 
  is 
  커서를 부착할 select 구문 
begin
  open 커서명 ;                    2. 커서 오픈 
  loop 
    fetch 구문                    3. 커서를 이동하고 출력
  end loop ; 
  close 커서명 ;                   4. 커서를 종료.
end;
/

/* 커서를 사용해서 department 테이블의 모든 내용을 출력 하기 */ 

set serveroutput on 
declare
    v_dept department%rowtype;   --변수 선언 
    cursor c1                       --1. 커서 선언  
    is 
    select * from department;  
begin
    dbms_output.put_line('부서번호   부서명   부서위치');
    dbms_output.put_line('-----------------------');
    open c1;                        -- 2. 커서 오픈 
    loop 
        fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc; 
        exit when c1%notfound;
        dbms_output.put_line(v_dept.dno || '   ' || v_dept.dname || '   ' || v_dept.loc); 
    end loop;
    close c1;                       -- 4 커서 종료. 
end;
/

/* 커서의 속성을 나타내는 속성값 
 커서명%notfound : 커서영역 내의 모든 자료가 FETCH되었다면 true
 커서명%fount : 커서영역 내의   FETCH 되지 않는 자료가 존재하면 true
 커서명%isopen : 커서가 오픈되었다면 true
 커서명%rowcount : 커서가 얻어온 레코드 갯수 
*/ 

/* 
  사원명,  부서명, 부서위치, 월급 을 출력 하세요 . PL/SQL 을 사용해서 출력하세요. <커서를 이용> 
  완료시간 : 6시 10분
*/ 

2. rowtype 를 사용해서 처리 

set serveroutput on 
declare 
    v_emp employee%rowtype; 
    v_dept department%rowtype;
    cursor c2
    is 
    select ename, dname, loc, salary 
    from employee e, department d
    where e.dno = d.dno ; 
    
begin
    dbms_output.put_line('사원명   부서명   부서위치   월급');
    dbms_output.put_line('-----------------------------');
    open c2;
    loop 
        fetch c2 into v_emp.ename, v_dept.dname, v_dept.loc, v_emp.salary; 
        exit when c2%notfound;
        dbms_output.put_line(v_emp.ename ||'   ' ||v_dept.dname||'   '||v_dept.loc ||'   '||
         v_emp.salary);
    end loop;
    close c2;

end;
/

/* cursor  for loop 문으로 커서를 사용해서 여러 레코드셋 출력 하기. 
    - open, close 를 생략 해서 사용;
    - 한 테이블의 전체 내용을 출력 할때 사용. 
*/ 

set serveroutput on
declare
    v_dept department%rowtype; 
    cursor c1                   --커서 선언 
    is 
    select * from department; 
begin
    dbms_output.put_line('부서번호   부서명   지역명');
    dbms_output.put_line('-----------------------'); 
    for v_dept in c1 loop
        dbms_output.put_line ( v_dept.dno || '   ' || v_dept.dname ||'   ' || v_dept.loc ); 
    end loop ;
end;
/ 


/* employee 테이블의 모든 내용을 cursor for loop를 사용해서 출력해 보세요. */ 

/* employee 테이블의 사원번호,사원명,월급,부서번호 을 출력,  월급이 2000 이상 , 부서가 20,30 부서만 출력 
    cursor for loop를 사용
*/ 


저장 프로시져 문제  : 완료 시간 : 4:00 까지 완료 

1. 각 부서별로 최소급여, 최대급여, 평균급여를 출력하는 저장프로시져를 생성하시오. 
	[employee, department ] 테이블 이용
    
    set serveroutput on 
    
    create or replace procedure sp_ex1 
    is  --변수 선언부, 커서 선언 
        v_dno employee.dno%type; 
        v_min employee.salary%type; 
        v_max employee.salary%type; 
        v_avg employee.salary%type; 
        
        cursor c1 
        is 
        select dno, min(salary), max(salary), avg(salary)
        from employee
        group by dno ; 
        
    begin
        dbms_output.put_line( '부서번호   최소급여   최대급여  평균급여');  
        dbms_output.put_line( '-----------------------------------');  
        open c1;   --커서 시작 
        loop
            fetch c1 into v_dno, v_min, v_max, v_avg ; 
            exit when c1%notfound ;    -- 레코드의 값이 더이상 존재하지 않을때 
            dbms_output.put_line( v_dno||'   '||v_min||'   '||v_max||'   '||v_avg) ;           
        end loop;         
        close c1; 
    end;
    / 
    
exec sp_ex1 ;     
    
    

2.  사원번호, 사원이름, 부서명, 부서위치를 출력하는 저장프로시져를 생성하시오.  
	[employee, department ] 테이블 이용
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
        where e.dno = d.dno ;
   
    begin
        dbms_output.put_line( '사원번호   사원이름   부서명   부서위치');  
        dbms_output.put_line( '-----------------------------------'); 
        open c1; 
        loop
            fetch c1 into v_eno, v_ename, v_dname, v_loc; 
            exit when c1%notfound; 
            dbms_output.put_line( v_eno||'   '|| v_ename||'   ' || v_dname||'   '||v_loc);
        end loop ;   
        close c1; 
    end;
    / 
    
  exec sp_ex2  
    
    


3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.
	저장프로시져명 : sp_salary_b
    create or replace procedure sp_ex3 (
        v_salary in employee.salary%type )   --주의 : in,out 에서는 ; 처리하면 안됨. 
    is
        v_emp employee%rowtype;   --모든 컬럼의 자료형을 선언 
        cursor c1 
        is 
        select ename, salary, job
        from employee
        where salary > v_salary; 
        
    begin
        dbms_output.put_line( '사원이름   급여   직책');  
        dbms_output.put_line( '--------------------'); 
        open c1;
        loop
            fetch c1 into v_emp.ename, v_emp.salary, v_emp.job; 
            exit when c1%notfound; 
            dbms_output.put_line( v_emp.ename|| '   '||v_emp.salary||'   '||v_emp.job );
        end loop;      
        close c1; 
    end; 
    / 
      
    exec sp_ex3( 2500 );   
    
4. 인풋 매개변수 : emp_c10, dept_c10  두개를 입력 받아 각각 employee, department 테이블을 복사하는 저장프로시져를 생성하세요. 
	저장프로시져명 : sp_copy_table
    
    -- PL/SQL 내부에서 익명 블락에서 테이블을 생성 : grant create table to public;  < sys 계정으로 접속 > 
    -- 저장프로시저 실행후 : revoke create table from public;
    create or replace procedure sp_ex4 (
        v_emp in varchar2 , v_dept in varchar2 )  -- 주의 : ';'을 넣으면 안됨, 자료형의 크기를 지정하면안됨
    is
        c1 integer;   --커서 변수 선언 
        v_sql1 varchar2(500); -- 테이블 생성 쿼리를 담을 변수 
        v_sql2 varchar2(500);
    begin
        v_sql1 := 'create table ' || v_emp || ' as select * from employee' ;
        v_sql2 := 'create table ' || v_dept || ' as select * from department';
        
        c1 := dbms_sql.open_cursor;         -- 커서 오픈 
        dbms_sql.parse(c1, v_sql1, dbms_sql.v7); 
        dbms_sql.parse(c1, v_sql2, dbms_sql.v7);
        dbms_sql.close_cursor(c1);   -- 커서 종료       
    end;
    /
    
    exec sp_ex4 ( 'emp_c10', 'dept_c10');  
    
    select * from emp_c10; 
    select * from dept_c10; 

5. dept_c10 테이블에서 dno, dname, loc 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 50  'HR'  'SEOUL'
	입력 값 : 60  'HR2'  'PUSAN' 
    
    exec sp_ex5 ( 50, 'HR', 'SEOUL'); 
     exec sp_ex5 ( 60, 'HR2', 'PUSAN'); 
    select * from dept_c10; 
    
    
create or replace procedure sp_ex5 (
    v_dno in dept_c10.dno%type, v_dname in dept_c10.dname%type, v_loc in dept_c10.loc%type  )
   is
   begin
        insert into dept_c10 
        values ( v_dno, v_dname, v_loc ); 
        
        dbms_output.put_line( ' 정상적으로 잘 입력이 되었습니다' ); 
       
   end;
   / 
   
   select * from dept_c10; 
    
    
    

6. emp_c10 테이블에서 모든 컬럼의 값을 인풋 받아 인풋 받은 값을 insert하는 저장프로시져를 생성하시요. 
	입력 값 : 8000  'SONG'    'PROGRAMER'  7788  sysdate  4500  1000  50 
   select * from emp_c10; 
   
   exec sp_ex6(8000,  'SONG' ,   'PROGRAMER' , 7788,  sysdate , 4500 , 1000,  50 ); 
   
   create or replace procedure sp_ex6 (
        v_eno in emp_c10.eno%type ,
        v_ename in emp_c10.ename%type,
        v_job in emp_c10.job%type,
        v_manager in emp_c10.manager%type,
        v_hiredate in emp_c10.hiredate%type,
        v_salary in emp_c10.salary%type,
        v_commission in emp_c10.commission%type,
        v_dno in emp_c10.dno%type
   )
   is 
   begin
        insert into emp_c10 
        values ( v_eno, v_ename, v_job, v_manager, v_hiredate, v_salary, v_commission, v_dno) ; 
        
        dbms_output.put_line('잘 입력 되었습니다.'); 
   end;
   / 
    
    
    


7. dept_c10 테이블에서 4번문항의 부서번호 50의 HR 을 'PROGRAM' 으로 수정하는 저장프로시져를 생성하세요. 
	<부서번호와 부서명을 인풋받아 수정하도록 하시오.> 
	입력값 : 50  PROGRAMER 
    select * from dept_c10; 
    exec sp_ex7 ( 50, 'PROGRAMER' ) 
    
    create or replace procedure sp_ex7 (
        v_dno in dept_c10.dno%type, 
        v_dname in dept_c10.dname%type)
    is
    begin
        update dept_c10 
        set dname = v_dname
        where dno = v_dno; 
        
        dbms_output.put_line('잘 업데이트 되었습니다.' ); 
    end;
    / 
    
    

8. emp_c10 테이블에서 사원번호를 인풋 받아 월급을 수정하는 저장 프로시져를 생성하시오. 
	입력 값 : 8000  6000
    create or replace procedure sp_ex8 (
        v_eno in emp_c10.eno%type, 
        v_salary in emp_c10.salary%type)
    is
        
    begin
        update emp_c10 
        set salary = v_salary
        where eno = v_eno ; 
        
        dbms_output.put_line('잘 수정되었습니다'); 
    
    end;
    / 
    exec sp_ex8 (8000, 6000); 
    
    select * from emp_c10; 
    
    
    

9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오. 
create or replace procedure sp_ex9 (
        v_emp in varchar2 , v_dept in varchar2 )  -- 주의 : ';'을 넣으면 안됨, 자료형의 크기를 지정하면안됨
    is
        c1 integer;   --커서 변수 선언 
        v_sql1 varchar2(500); -- 테이블 생성 쿼리를 담을 변수 
        v_sql2 varchar2(500);
    begin
        v_sql1 := 'drop table ' || v_emp  ;
        v_sql2 := 'drop table ' || v_dept ;
        
        c1 := dbms_sql.open_cursor;         -- 커서 오픈 
        dbms_sql.parse(c1, v_sql1, dbms_sql.v7); 
        dbms_sql.parse(c1, v_sql2, dbms_sql.v7);
        dbms_sql.close_cursor(c1);   -- 커서 종료       
    end;
    /

    select * from emp_c10; 
    select * from dept_c10; 
    exec sp_ex9 ( 'emp_c10', 'dept_c10'); 




10. 사원이름을 인풋 받아서 사원명, 급여, 부서번호, 부서명, 부서위치을 OUT 파라미터에 넘겨주는 프로시저를 
PL / SQL에서 호출
create or replace procedure sp_ex10 ( 
    v_ename in employee.ename%type, 
    v_o_ename out employee.ename%type,
    v_salary out employee.salary%type, 
    v_dno out employee.dno%type, 
    v_dname out department.dname%type,
    v_loc out department.loc%type) 
 is 
 begin
    select ename, salary, e.dno, dname, loc  into v_o_ename, v_salary, v_dno, v_dname,v_loc 
    from employee e , department d
    where e.dno = d.dno 
    and ename = v_ename;    -- v_ename을 조건으로해서 
 
 end;
 / 
 
 
 declare -- OUT 파라메타 받을 변순 선언 
    v_ename employee.ename%type; 
    v_salary employee.salary%type; 
    v_dno employee.dno%type; 
    v_dname department.dname%type; 
    v_loc department.loc%type;
 begin
    -- 익명 블락에서는 exec / execute 를 생략 함. 
    sp_ex10( 'SCOTT' , v_ename, v_salary, v_dno, v_dname, v_loc ); 
    
    dbms_output.put_line ('사원명   월급   부서번호   부서명   부서위치');
    dbms_output.put_line( '---------------------------------------');
    dbms_output.put_line( v_ename||'   '|| v_salary || '   ' || v_dno||'   ' || v_dname||'   '||
        v_loc); 
 end; 
 / 

11. 사원번호 를 받아서 사원명, 급여, 직책,  부서명, 부서위치 을 OUT 파라미터에 넘겨주는 프로시저를 PL / SQL에서 호출

create or replace procedure ex11 ( 
    v_eno in employee.eno%type, 
    v_ename out employee.ename%type, 
    v_salary out employee.salary%type,
    v_job out employee.job%type, 
    v_dname out department.dname%type,
    v_loc out department.loc%type)   
    is 
    begin
        select ename, salary, job, dname, loc into v_ename, v_salary, v_job, v_dname, v_loc
        from employee e, department d
        where e.dno = d.dno
        and eno = v_eno ; 
    end;
    / 


declare 
    v_ename  employee.ename%type; 
    v_salary  employee.salary%type;
    v_job  employee.job%type; 
    v_dname  department.dname%type;
    v_loc  department.loc%type; 
begin
    ex11( 7788 , v_ename, v_salary, v_job, v_dname, v_loc); 
    
    dbms_output.put_line('사원명   월급   직책   부서명   위치');
    dbms_output.put_line('---------------------------------');
    dbms_output.put_line(v_ename || '   ' || v_salary || '   '|| v_job || '   ' || 
        v_dname ||'   '|| v_loc);
end;
/ 





































  
 
 
   















