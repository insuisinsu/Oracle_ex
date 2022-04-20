-- 숫자 함수
/*
ROUND : 특정 자릿수에서 반올림
TRUNK : 특정 자릿수에서 버림
MOD   :  입력 받은 수를 나눈 나머지 값만 출력
*/

-- round(대상) : 소수점 첫자리에서 반올림하여 정수로 표현
-- round(대상, 자릿수) : 반올림 하여 자릿수 까지 표현
    -- 자릿수가 양수면 소숫점 자릿수 까지 표현
    -- 자릿수가 음수면 정수쪽에서 자릿수에서 반올림
select 98.7654, round(98.7654), round(98.7654, 2), round(7598.7654, -2)
from dual;

-- trunc(대상) : 소숫점 버림
-- trunc(대상, 자릿수) : 자릿수에서 버림
    -- 자릿수가 양수면 자릿수 아래 버림
    -- 자릿수가 음수이면 정수쪽으로 자릿수 만큼 버림
select 98.7654, trunc(98.7654), trunc(98.7654, 2), trunc(7598.7754 , -2)
from dual;

-- mod
select 98.7654, mod(98.7654, 2), mod(14, 3)
from dual;

select salary, mod (salary, 300)
from employee;

-- employee 테이블에서 사원번호가 짝수인 사원
select *
from employee
where mod(eno, 2) = 0 ;

/*
날짜 함수
sysdate : 시스템에 저장된 현재 날짜를 출력
nmonths_between : 두 날짜 사이의 개월 수 파악
add_months : 특정 날짜에 개월수를 더함
next_day : 특정 날짜에서 최초로 도래하는 인자로 받은 요일의 날짜 반환
last_day : 달의 마지막 날짜를 반환
round : 인자로 받은 날짜를 특정 기준으로 반올림
trunc : 인자로 받은 날짜를 특정 기준으로 버림
*/

--sysdate 자신의 시스템의 날짜 출력
select sysdate from dual;
select sysdate -1 as 어제, sysdate as 오늘, sysdate +1 as 내일 from dual;

select * from employee
order by hiredate;

select hiredate, hiredate -1, hiredate +10
from employee;

-- 입사일에서 부터 현재까지의 근무일수를 출력
select sysdate - hiredate from employee;
select round(sysdate) - hiredate as "총 근무일수" from employee;
select round(MONTHS_BETWEEN(SYSDATE,hiredate)) from employee;

-- 특정 날짜에서 월(Month)을 기준으로 버림한 날짜 구하기, round 는 16일 이상이면 반올림
select hiredate, trunc (hiredate, 'MONTH'), round (hiredate, 'MONTH')
from employee;

select hiredate,  (hiredate, 'MONTH')
from employee;

-- months_between ( date1, date2 )
-- 각 사원들의 근무한 개월 수 구하기
select ename, sysdate, hiredate, Months_between(sysdate, hiredate),
trunc (Months_between(sysdate, hiredate)) as "근무개월 수"
from employee;

-- 입사한 후 6개월이 지난 시점을 출력
select hiredate, add_months ( hiredate, 6)
from employee;

-- 입사한 후 100일이 지난 시점
select hiredate, hiredate + 100 as "입사 100일"
from employee;

-- next_day (date, '요일') : date 의 도래하는 요일에 대한 날짜
select next_day (sysdate, '토요일') from dual;

-- last_day ( date ) : date 에 들어간 달의 마지막 날짜
select hiredate, last_day(hiredate)
from employee;

-- 형 변환 함수!!
/*
TO_CHAR  : 날짜형 또는 숫자형 데이터를 문자형으로 변환
TO_DATE  : 문자형을 날짜형으로 변환하는 함수
TO_NUMBER : 문자형을 숫자형으로 변환하는 함수
*/

-- TO_CHAR (date, 'YYYYMMDD')
select ename, hiredate, to_char(hiredate, 'YYYYMMDD'),
to_char (hiredate, 'YY/MM'), to_char(hiredate, 'YY MM DD'),
to_char (hiredate, 'YY/MM day'), to_char(hiredate, 'YY MM DD dy')
from employee;

-- 날짜를 출력하고 시간 초 까지 출력
select sysdate, to_char(sysdate, 'YYYY/MM/DD HH:MI:SS DAY DY') from dual;

select hiredate, to_char(hiredate, 'YYYY-MM-DD HH:MI:SS DAY DY')
from employee;

-- to_char 에서 숫자와 관련된 형식
/*
    0 : 자릿수를 나타내며 자릿수가 맞지 않을 경우 0 으로 채움
    9 : 자릿수를 나타내며 자릿수가 맞지 않을 경우 채우지 않음ㄴ
    L : 각 지역별 통화기호를 출력
    . : 소숫점으로 표현
    , : 천 단위의 구분자
*/

select ename, to_char(salary, 'L999,999'),
to_char(salary, 'L0000,000')
from employee;

-- to_date ('cahr', 'format') : 날짜형식으로 변환
select sysdate, sysdate - '20000101'
from dual;

-- 2000 년 1월 1일 에서 부터 오늘 까지의 일수
select sysdate, trunc(sysdate) - to_date(20000101, 'YYYYMMDD') from dual;
select sysdate, trunc(sysdate - to_date(20000101, 'YYYYMMDD')) from dual;

select sysdate, to_date ('02/10/10', 'YY/MM/DD'),
trunc (sysdate - to_date ('021010', 'YYMMDD')) as 날짜의차
from dual;

select ename, hiredate
from employee
where hiredate = '81/02/22';

select ename, hiredate
from employee
where hiredate = to_date(19810222, 'YYYYMMDD');

select ename, hiredate
from employee
where hiredate = to_date('1981+02+22', 'YYYY+MM+DD');

-- 2000 년 12 월 25 일 부터 오늘까지 총 몇 달 인가요
select trunc (months_between(sysdate, '2000/12/25'))
from dual;

select trunc (months_between(sysdate, to_date('2000/12/25', 'YYYY/MM/DD')))
from dual;

-- to_number : number 데이터 타입으로 변환
select to_number('100000') - to_number('5000') from dual;
select to_number('100,000', '999,999') - to_number('5,000', '9,999') from dual;

-- NVL 함수 : null 을 다른 값으로 치환 해주는 함수
-- nvl(expr1, expr2) : expr1 에 있는 null 을 expr2 로 치환
select commission
from employee;

select commission, nvl(commission, 0)
from employee;

select manager, nvl ( manager, 1111 )
from employee;

-- NVL2(expr1, expr2, expr3) : expr1 이 null 이 아니면 expr2, null 이면 expr3

-- NVL 함수로 연봉 계산하기
select salary * 12 + nvl(commission, 0) as 연봉
from employee;

select nvl2( commission, salary*12 + commission, salary*12) as 연봉
from employee;

-- NULLIF : 두 표현식을 비교해서 동일한 경우 null 을 반환, 동일하지 않은 경우 첫 번째 표현식을 반환
select nullif ('A', 'A'), nullif('A', 'B')
from dual;

-- coalesce 함수
coalesce (expr1, expr2, expr3, ... , expr-n)
    --expr1 이 null 이 아니면 expr1 을 반환하고,
    --expr1 이 null 이고 expr2 가 null 이 아니면 expr2 를 반환
    --expr2 이 null 이고 expr3 가 null 이 아니면 expr3 를 반환 ...
    
select coalesce ('a', 'b', 'c', 'd') from dual;
select coalesce ( null , 'b', 'c', 'd') from dual;
select coalesce (null, null, 'c', 'd') from dual;

select ename, salary, commission, coalesce (commission + salary, salary, 0)
from employee;

--decode 함수     (switch case 문과 동일한 구문)
/*
    DECODE ( 표현식, 조건1, 결과1, 
                    조건2, 결과2,
                    ...
                    기본결과n
            )
*/

select ename, dno, decode (dno, 10, 'ACCOUNTING',
                                20, 'RESEARCH',
                                30, 'SALES',
                                40, 'OPERATION',
                                'DEFAULT'
                            ) as DNAME
from employee;    

--dno 가 10 일 경우 월급에서 + 300, 20 은 월급+500, 30 700 // 이름, 월급, 수정된 월급
select ename, salary, decode ( dno, 10, salary + 300,
                                     20, salary + 500,
                                     30, salary + 700,
                                     salary ) as "인상된 월급"
from employee
order by dno;

-- case : if ~ else if , else if ~~~
/*
    case 표현식 WHEN 조건1 THEN 결과1
                WHEN 조건2 THEN 결과2
                ...
                WHEN 조건n THEN 결과n
                ELSE 기본결과
    END
*/

select ename, dno, case when dno = 10 then 'ACCOUNTING'
                        when dno = 20 then 'RESEARCH'
                        when dno = 30 then 'SALES'
                        ELSE 'DEFAULT'
                    END as 부서명
from employee
order by dno;














