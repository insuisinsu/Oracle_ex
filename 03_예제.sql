

--1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
select hiredate, substr (hiredate, 1, 5)
from employee;

--2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오. 
select *
from employee
where substr ( hiredate, 4, 2) = 04;


--3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오.  
select *
from employee
where mod ( manager , 2) != 0;

--3-1. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
select *
from employee
where mod ( salary, 3) = 0;

--4. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
select to_char(hiredate, 'YY MON DD DY')
from employee;

--5. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여
--   데이터 형식을 일치 시키시오. 
select sysdate, trunc(sysdate - to_date(20220101, 'YYYYMMDD'))
from dual;


--5-1. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
select trunc(sysdate - to_date(19930820, 'YYYYMMDD'))
from dual;

--5-2. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요. 
select trunc (months_between(sysdate, '1993/08/20'))
from dual;

--6. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오. 
select coalesce ( manager, 0), nvl(manager, 0)
from employee;

--7.  DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 'ANAIYST' 사원은 200 , 'SALESMAN' 사원은 180,
--    'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상하시오. 
select ename, job, salary as "기존 급여", decode(job, 'ANALYST', salary + 200,
                        'SALESMAN', salary + 180,
                        'MANAGER', salary + 150,
                        'CLERK', salary + 100,
                        salary) as "인상된 급여"
from employee;

-- 사원번호 [사원번호 2자리만 출력, 나머지는 * 가림] as "가린 번호", 이름, [이름의 첫자만 출력, 세자리는 *로 가림]
select eno, rpad(substr(eno, 1, 2), 4, '*') "가린 번호", ename, rpad(substr(ename, 1, 1),4,'*') "가린 이름"
from employee;

select eno, rpad(substr(eno, 1, 2), 4, '*') "가린 번호",
ename, rpad(substr(ename, 1, 1),length(ename),'*') "가린 이름"
from employee;

-- 주민번호 를 출력하되 뒷자리 1 까지만, 나머지는 *로 가림, 전화번호 앞2 뒤4 *로 가리기
select rpad(substr('930820 - 1234567', 1, 10), 16, '*'),
rpad(substr('010-7799-3025', 1, 6), 13, '*')
from dual;

-- 010-77**-****
select rpad(substr('010-7799-3025', 1, 6), 8, '*') || rpad(substr('010-7799-3025', 9, 1), 5, '*')
from dual;


SELECT rpad(rpad('951123-1111111', 8), 14, '*'), rpad(rpad('010-1111-1111', 6), 13, '*')
from dual;


-- 사원번호, 사원명, 직속상관 
    -- 직속상관의 사원번호가 없을 경우 0000
    -- 앞 2자리가 75일 경우 5555
    -- 앞 2자리가 76일 경우 6666
    -- 앞 2자리가 77일 경우 7777
    -- 앞 2자리가 78일 경우 8888
    -- 나머지는 그대로
    
    
select eno, ename, manager,  case  WHEN manager is null THEN 0000
                                  WHEN substr(manager, 1, 2) = 76 THEN 5555
                                  WHEN substr(manager, 1, 2) = 77 THEN 6666
                                  WHEN substr(manager, 1, 2) = 78 THEN 7777
                                  WHEN substr(manager, 1, 2) = 75 THEN 8888
                                   ELSE manager
                                  END as eno
from employee;

select eno, ename, manager,  case  WHEN manager is null THEN '0000'
                                  WHEN substr(manager, 1, 2) = '76' THEN '5555'
                                  WHEN substr(manager, 1, 2) = '77' THEN '6666'
                                  WHEN substr(manager, 1, 2) = '78' THEN '7777'
                                  WHEN substr(manager, 1, 2) = '75' THEN '8888'
                                   ELSE to_char (manager, '9999')
                                  END as eno
from employee;

select eno, ename, manager, case when manager like '75%' then 5555
                                when manager like '76%' then 6666
                                when manager like '77%' then 7777
                                when manager like '78%' then 8888
                                when manager is null then 0000
                                else manager
                            END as 번호
from employee;

