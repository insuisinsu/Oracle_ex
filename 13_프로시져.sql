
-- 13일차 - 저장프로시져 (Stored Procedure), 함수 (Function), 트리거 (Trigger)

/*
    저장프로시져의 장점
        1. PL/SQL 을 사용 가능하다. 자동화
        2. 성능이 빠르다.
            일반적인 SQL 구문 : 구문분석 -> 객체이름확인 -> 사용권한확인 -> 최적화 -> 컴파일 -> 실행
            저장프로시저 처음실행 : 구문분석 -> 객체이름확인 -> 사용권한확인 -> 최적화 -> 컴파일 -> 실행
            저장프로시저 두번째부터 실행 : 컴파일 (메모리에 로드) -> 실행
            
        3. 입력 매개변수, 출력 매개변수를 사용할 수 있다.
        4. 일련의 작업을 묶어서 저장 (모듈화된 프로그래밍이 가능하다.)
*/

-- 1. 저장프로시져 생성.
    -- 스콧 사원의 월급을 출력하는 저장 프로시져

    Create procedure sp_salary
    is
        v_salary employee.salary%type;       -- 저장프로시져는 is 블락에서 변수를 선언
    begin
        select salary into v_salary
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line ('SCOTT 의 급여는 : ' || v_salary || ' 입니다'); 
    end;
    /
    
/* 저장프로시져 정보를 확인하는 데이터 사전 */

    select * from user_source
    where name = 'SP_SALARY';

-- 3. 저장 프로시져 실행

    EXECUTE sp_salary;      -- 전체 이름
    EXEC sp_salary;         -- 약식 이름

-- 4. 저장 프로시져 수정

    Create or replace procedure sp_salary   -- sp_salary 가 존재하지 않으면 생성, 존재하면 수정
    is
        v_salary employee.salary%type;       -- 저장프로시져는 is 블락에서 변수를 선언
        v_commission employee.commission%type;
    begin
        select salary, commission into v_salary, v_commission
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line ('SCOTT 의 급여는 : ' || v_salary || 
                                ' 보너스는 : ' || v_commission || ' 입니다'); 
    end;
    /

-- 4. 저장 프로시져 삭제

drop procedure sp_salary ;

---------------------------- << 인풋 매개변수를 처리하는 저장 프로시져 >> ------------------------------
    create or replace procedure sp_salary_ename (     -- 입력 매개변수(in), 출력 매개변수(out)를 정의
        v_ename in employee.ename%type     -- 변수명 in 자료형   <== 주의 :   << ; 를 사용하면 안된다. >> 
    )
    is          -- 변수선언 (저장 프로시져에서 사용할 변수 선언 블락)
        v_salary employee.salary%type;
    begin
        select salary into v_salary    -- 변수
        from employee
        where ename = v_ename;         -- 인풋 매개변수 : v_ename
        
        dbms_output.put_line( v_ename || ' 의 급여는 ' || v_salary || ' 입니다');
    end;
    /

    EXEC sp_salary_ename ('SCOTT');
    EXEC sp_salary_ename ('SMITH');
    EXEC sp_salary_ename ('KING');
    select * from employee;

/* 부서 번호를 인풋 받아서 이름, 직책, 부서번호를 출력하는 저장 프로시져를 생성하세요. (커서를 사용해야함)*/
/*
테이블 이름을 인풋 받아서 employee 테이블을 복사해서 생성하는 저장프로시져를 생성하세요
인풋값 : emp_copy33
*/

create or replace procedure sp_createTable (
    v_name in varchar2
    )
is
    cursor1 INTEGER;
    v_sql varchar2(200);     --sql 쿼리를 저장하는 변수
begin
    v_sql := 'CREATE TABLE ' || v_name || ' as select * from employee'; -- 테이블 생성쿼리를 변수에 할당
    cursor1 := DBMS_SQL.OPEN_CURSOR;                -- 커서 사용
    DBMS_SQL.parse ( cursor1, v_sql, dbms_sql.v7 ); -- 커서를 사용해서 sql 쿼리 실행
    DBMS_SQL.close_cursor(cursor1);                 -- 커서 중지
end;
/

grant create table to public;

exec sp_createTable('emp_copy33');
select & from emp_copy33;


