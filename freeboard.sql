--�Խ��� �����

create table freeboard (
    id number constraint PK_freeboard_id Primary key, --�ڵ� ���� �÷�
    name varchar2(10) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null,     -- ����
    content varchar2(2000) not null,       -- ����
    inputdate varchar2(100) not null,       -- �ۼ���
    masterid number default 0,          -- ���� �亯�� �Խ��ǿ��� �亯�� ���� �׷��� �� �� ���
    readcount number default 0,         -- ��ȸ��
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
values(AA.nextval, '�̸�'||AA.nextval, '1234' , 'asdf@asdf.com', AA.nextval || ' ��°', '������ �󸶹� ������', '22-20-11 11:50 ����', null, null, null, null)


-- �亯���� �����ϴ� ���̺��� ����� ��, ������ �� �ؼ� �����;� �Ѵ�.

select * from freeboard
order by masterid desc, replaynum, step, id
-- masterid �÷��� �ߺ��� ���� ���� ���, replaynum �÷��� asc,,, setp,,, id

delete freeboard
where email = 'asdf@asdf.com'

commit

/*
 id �÷� : ���ο� ���� ��ϵ� ��, id �÷��� �ִ밪�� �����ͼ� +1 �Ͽ� ����� = ���ο� �� ��ȣ�� ���� �ѹ���
 
 �亯���� ó���ϱ� ���ؼ��� �÷��� 3�� �ʿ��ϴ�. (masterid, replayNum, step)
 masterid : ���� �亯�� �׷���
    - id �÷��� ���� �״�� �� ���, �亯���� �ƴ� ó������
 replayNum : �亯�ۿ� ���� �ѹ���
 step       : �亯���� ����
    - 0 : ó����(�亯���� �ƴ� �ڽ��� ����)
    - 1 : �亯��
    - 2 : �亯�� �亯
*/







