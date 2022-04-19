-- 다양한 함수 사용하기
/*
1. 문자를 처리하는 함수
UPPER : 대문자로 변환
LOWER : 소문자로 변환
INITCAP : 첫자는 대문자, 나머지 소문자로 변환

dual 테이블 : 하나의 결과를 출력하도록 하는 테이블
*/

select '안녕하세요' as 안녕
from dual

select 'Oracle mania', upper ('Oracle mania'), lower ('Oracle mania'), initcap('Oracle mania')
from dual

select * from employee;

select ename, lower(ename), initcap(ename), upper(ename)
from employee;

-- 원래 값이 대문자라 소문자로 검색하면 값이 안 나옴
select * from employee
where ename = 'allen';

-- ename 을 소문자로 바꿔서 검색
select * from employee
where lower(ename) = 'allen';

select * from employee
where initcap(ename) = 'Allen';

-- 문자의 길이를 출력하는 함수
/*
length : 문자의 길이를 반환 // 영문, 한글 관계없이 글자수 리턴
lengthb : 문자의 길이를 반환 // 한글을 3byte 로 반환

*/

select length('Oracle mania'), length('오라클 매니아'),
lengthb('Oracle mania'), lengthb('오라클 매니아') from dual;

select ename, length(ename), job, length(job)
from employee;

-- 문자 조작 함수 
/*
concat : 문자와 문자를 연결해서 출력
substr : 문자를 특정 위치에서 잘라오는 함수 // 영문, 한글 1byte
substrb : 문자를 특정 위치에서 잘라오는 함수 // 영문 1, 한글 3byte
instr : 문자의 특정 위치의 인덱스 값을 반환
instrb : 문자의 특정 위치의 인덱스 값을 반환
lpad, rpad : 입력 받은 문자열에서 특수문자를 적용
trm : 잘라내고 남은 문자를 반환
*/

-- concat : 문자와 문자를 연결해서 출력
select 'Oracle', 'mania', concat ('Oracle' , 'mania') from dual;
-- substr : 문자를 특정 위치에서 잘라오는 함수 // 영문, 한글 1byte
-- substr ( 대상, 시작위치, 추출갯수 )
    -- 시작위치에 - 가 붙으면 뒤에서 부터 셈
select 'Oracle mania', substr ('Oracle mania', 4, 3),substr ('오라클 매니아', 2, 3),
substrb ('Oracle mania', 4, 3),substrb ('오라클 매니아', 2, 3)
from dual;

select 'Oracle mania', substr ('Oracle mania', -8, 4),substr ('오라클 매니아', -5, 3),
substrb ('Oracle mania', -3, 2),substrb ('오라클 매니아', -2, 3)
from dual;

select ename, substr (ename, 3, 2), substrb(ename, -4, 3)
from employee;

select concat ( ename, ' ' || job) from employee;
select '이름은 : ' || ename || ' 이고, 직책은 : ' || job || ' 입니다.' as 컬럼연결
from employee;

select '이름은 : ' || ename || ' 이고, 상관의 번호는 ' || manager || ' 입니다.' as A
from employee;

-- 이름이 N 으로 끝나는 사원들 출력하기 ( substr 함수 사용 )
select *
from employee
where substr(ename, -1, 1) = 'N';

select *
from employee
where ename like '%N';

-- 87 년도 입사한 사원들 출력하기
select *
from employee
where substr(hiredate, 1, 2) = '87';

select *
from employee
where hiredate like '87%';

-- instr : 문자의 특정 위치의 인덱스 값을 반환
-- instr ( 대상, 찾을 글자, 시작위치, 몇 번째 발견 )

select 'Oracle mania' , instr ('Oracle mania', 'O') from dual;
select 'Oracle mania' ,
instr ('Oracle mania', 'a'),
instr ('Oracle mania', 'a', 5),
instr ('Oracle mania', 'a', 5, 2),
instr ('Oracle mania', 'a', -5, 1)
from dual;

select distinct job from employee
where lower(job) = 'manager'

select distinct instr( job, 'A', 1, 1)
from employee
where lower(job) = 'manager'

-- lpad, rpad : 특정 길이만큼 문자열을 지정해서 왼쪽, 오른쪽의 공백을 특정 문자로 처리
select lpad (salary, 10, '*') from employee;
select rpad (salary, 10, '*') from employee;

select lpad (1234 , 10, '*'), rpad (1234 , 10, '*') from dual

















