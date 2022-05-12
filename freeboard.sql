--게시판 만들기

create table freeboard (
    id number constraint PK_freeboard_id Primary key, --자동 증가 컬럼
    name varchar2(10) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null,     -- 제목
    content varchar2(2000) not null,       -- 본문
    inputdate varchar2(100) not null,       -- 작성일
    masterid number default 0,          -- 질문 답변형 게시판에서 답변의 글을 그룹핑 할 때 사용
    readcount number default 0,         -- 조회수
    replaynum number default 0,         -- 
    step number default 0
);
select * from freeboard
order by id
drop table freeboard

commit

create sequence aa
    increment by 1
    start with 1

drop sequence aa

insert into freeboard (id, name, password, email, subject, content, inputdate, masterid, readcount, replaynum, step)
values(AA.nextval, '이름'||AA.nextval, '1234' , 'asdf@asdf.com', AA.nextval || ' 번째', '가나다 라마바 아자차', '22-20-11 11:50 오전', null, null, null, null)


-- 답변글이 존재하는 테이블을 출력할 때, 정렬을 잘 해서 가져와야 한다.

select * from freeboard
order by masterid desc, replaynum, step, id
-- masterid 컬럼에 중복된 값이 있을 경우, replaynum 컬럼을 asc,,, setp,,, id

delete freeboard
where email = 'asdf@asdf.com'

commit

/*
 id 컬럼 : 새로운 글이 등록될 때, id 컬럼의 최대값을 가져와서 +1 하여 저장됨 = 새로운 글 번호에 대한 넘버링
 
 답변글을 처리하기 위해서는 컬럼이 3개 필요하다. (masterid, replayNum, step)
 masterid : 글의 답변을 그룹핑
    - id 컬럼의 값이 그대로 들어간 경우, 답변글이 아닌 처음글임
 replayNum : 답변글에 대한 넘버링
 step       : 답변글의 깊이
    - 0 : 처음글(답변글이 아닌 자신의 본문)
    - 1 : 답변글
    - 2 : 답변의 답변
*/







