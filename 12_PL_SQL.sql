-- 12일차 PL / SQL - 오라클에 프로그래밍 요소를 적용한 sql

/*
    SQL : 구조화된 질의언어 but 유연한 프로그래밍 기능을 적용할 수 없음
*/

-- PL/SQL 의 출력을 활성화
set serveroutput on

-- PL/SQL 의 기본 작성 구문
begin
-- PL/SQL 구문
end;
/

-- PL/SQL 에서 기본 구문 출력
set serveroutput on
begin
    dbms_output.put_line('Welcome to Oracle');
end;
/

-- PL/SQL 에서 변수 선언하기 : declare
-- 변수에 값을 할당할 때는 := 사용
declare
    v_eno number(4);
    v_ename employee.ename%type;
begin
    v_eno := 7788;
    v_ename := 'SCOTT';
    
    dbms_output.put_line('사원번호     사원이름');
    dbms_output.put_line('--------------------');
    dbms_output.put_line(v_eno || '     ' || v_ename);
end;
/

/*
    자료형 선언
    1. Oracle 의 자료형을 사용
    2. 참조자료형 - 테이블의 컬럼의 선언된 자료형을 참조해서 사용
        %type       : 테이블의 특정컬럼의 자료형을 참조해서 사용 / 테이블.컬럼%type
        &rowtype    : 테이블 전체 컬럼의 자료형을 모두 참조해서 사용
*/

-- 사원번호와 사원이름 출력하기
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
begin
    dbms_output.put_line('사원번호     사원이름');
    dbms_output.put_line('--------------------');
    
    select eno, ename into v_eno, v_ename
    from employee
    where ename = 'SCOTT';
    
    dbms_output.put_line(v_eno || '     ' || v_ename);
    
end;
/

-- PL/SQL 에서 제어문 사용하기
-- IF - End if 문

declare
    v_employee employee%rowtype;
    annsal number (7,2);
begin
    select * into v_employee
    from employee
    where ename = 'SCOTT';
    if(v_employee.commission is null) then
        v_employee.commission := 0;
    end if;
    annsal := v_employee.salary * 12 + v_employee.commission;
    dbms_output.put_line('사원번호   사원이름   연봉');
    dbms_output.put_line('------------------------');
    dbms_output.put_line(v_employee.eno ||'   ' || v_employee.ename || '   ' || annsal);
end;
/

/*

    v_employee.eno  7788
    v_employee.ename := 'SCOTT'
    v_employee.job := 'ANALIST'
    v_employee.manager := 7566
    v_employee.hiredate := '87/07/13'
    v_employee.salary := 3000
    v_employee.commission := null
    v_employee.dno := 20
*/

/*
    PL/SQL 을 사용해서 department 테이블을 ,
    조건은 dno = 20 을 변수에 담아서 출력
*/

declare
    v_department department%rowtype;
begin
    select * into v_department
    from department
    where dno = 20;
    
    dbms_output.put_line(v_department.dno ||'  ' || v_department.dname || '  ' || v_department.loc);
end;
/

select * from department

declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_dno employee.dno%type;
    v_dname department.dname%type := null;
begin
    select eno, ename, dno into v_eno, v_ename, v_dno
    from employee
    where ename = 'SCOTT';
    
    if (v_dno = 10) then
        v_dname := 'ACCOUNT';
    elsif (v_dno = 20) then
        v_dname := 'RESEARCH';
    elsif (v_dno = 30) then
        v_dname := 'SALES';
    elsif (v_dno = 40) then
        v_dname := 'OPERATIONS';
    end if;

    dbms_output.put_line('사원번호  사원명  부서명');
    dbms_output.put_line('----------------------');
    dbms_output.put_line(v_eno || '   '|| v_ename||'   '||v_dname);
end;
/
/*
    employee 테이블의 eno, ename, salary, dno 를 PL/SQL 을 사용해서 출력
    조건 ,, commission 이 1400 인 사원에 대해서
    1. %type
    2. %rowtype
*/
-- 1. %type
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.dno%type;
begin
    select eno, ename, salary, dno into v_eno, v_ename, v_salary, v_dno
    from employee
    where commission = 1400;
    
    dbms_output.put_line('사원번호  사원명  월급   부서번호');
    dbms_output.put_line('----------------------');
    dbms_output.put_line(v_eno || '   '|| v_ename||'   '||v_salary||'   '||v_dno);
end;
/

-- 2. %rowtype
declare
    v_employee employee%rowtype;
begin
    select * into v_employee
    from employee
    where commission = 1400;
    dbms_output.put_line('사원번호  사원명  월급   부서번호');
    dbms_output.put_line('----------------------');
    dbms_output.put_line(v_employee.eno || '   '|| v_employee.ename||'   '||v_employee.salary||'   '||v_employee.dno);
end;
/

/*
커서 (cusor) : PL/SQLㅇ에서 select 한 결과가 단일 레코드가 아닌 레코드 셋인 경우에 필요
*/
/*
declare
    cursor 커서명                  1. 커서 선언
    is
    커서를 부착할 select 구문
begin
    open 커서명;                   2. 커서 오픈
    loop                           3.  커서를 이동하고 출력
        fetch 구문
        exit 
        
    end loop;
    close 커서명;                  4. 커서 종료
end;
/
*/
set serveroutput on;
declare
    v_dept department%rowtype;
    cursor c1
    is
    select * from department;
begin
    dbms_output.put_line('부서번호   부서명    부서위치');
    dbms_output.put_line('=-------------------------');
    open c1;
    loop
        fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc;
        exit when c1%notfound;
        dbms_output.put_line(v_dept.dno || '  ' || v_dept.dname || '  ' || v_dept.loc);
    end loop;
    close c1;
end;
/

/*
    커서의 속성을 나타내는 속성값
    커서명%notfound : 커서영역 내의 모든 자료가 fetch 되었다면 true
    커서명%found : 커서영역 내의 fetch 되지 않은 자료가 존재하면 true
    커서명%isopen  : 커서가 오픈되었다면 true
    커서명%rowcount : 커서가 얻어온 레코드 갯수
*/
/*
    사원명, 부서명, 부서위치, 월급을 출력하세요. 
*/

declare
    v_ename employee.ename%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
    v_salary employee.salary%type; 	
    cursor c1
    is
    select ename, dname, loc, salary from employee e join department d
    on e.dno = d.dno;
begin
    dbms_output.put_line('사원명   부서명   부서위치   월급');
    dbms_output.put_line('-------------------------------');
    open c1;
    loop
        fetch c1 into v_ename, v_dname, v_loc, v_salary;
        exit when c1%notfound;
        dbms_output.put_line(v_ename ||'   '|| v_dname ||'   '|| v_loc ||'   '|| v_salary);
    end loop;
    close c1;
end;
/

declare
    v_emp employee%rowtype;
    v_dept department%rowtype;
    cursor c1
    is
    select ename, dname, loc, salary from employee e join department d
    on e.dno = d.dno;
begin
    dbms_output.put_line('사원명   부서명   부서위치   월급');
    dbms_output.put_line('-------------------------------');
    open c1;
    loop
        fetch c1 into v_emp.ename, v_dept.dname, v_dept.loc, v_emp.salary;
        exit when c1%notfound;
        dbms_output.put_line(v_emp.ename ||'   '|| v_dept.dname ||'   '|| v_dept.loc ||'   '|| v_emp.salary);
    end loop;
    close c1;
end;
/

/*
employee 테이블의 사원번호, 사원명, 월급, 부서번호를 출력,,  부서가 20, 30 인 사람만
*/

set serveroutput on

declare
    v_emp employee%rowtype;
    cursor c1
    is 
    select eno, ename, salary, dno
    from employee
    where dno in (20, 30);
begin
    dbms_output.put_line('사원번호   사원이름   월급   부서번호');
    dbms_output.put_line('---------------------------------');
    open c1;
    loop
        fetch c1 into v_emp.eno, v_emp.ename, v_emp.salary, v_emp.dno;
        exit when c1%notfound;
        dbms_output.put_line(v_emp.eno ||'   '|| v_emp.ename ||'   '|| v_emp.salary ||'   '|| v_emp.dno);
    end loop;
    close c1;
end;
/




