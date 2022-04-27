-- 7일차 테이블 정의서

create table member (
    id varchar2(20) not null,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate,
    constraint PK_member_id primary key (id),
    constraint FK_member_id_tb_zipcode Foreign key(zipcode) references tb_zipcode (zipcode)
    );
    
insert into member
values ('id1', 'pwd1', 'name1', 'zip1', 'add1', 'tel1', default);
insert into member
values ('id2', 'pwd2', 'name2', 'zip2', 'add2', 'tel2', default);
insert into member
values ('id3', 'pwd3', 'name3', 'zip3', 'add3', 'tel3', default);



create table tb_zipcode(
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode primary key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)    
    );

-- 수정
desc tb_zipcode

alter table tb_zipcode
rename column BUNGI to BUNJI;

alter table tb_zipcode
rename column GUGUM to GUGUN;

Alter table tb_zipcode
add (ZIP_SEQ varchar2(30));

alter table tb_zipcode
modify DONG varchar2(100);

ALTER TABLE member DROP CONSTRAINT FK_member_id_tb_zipcode;
ALTER TABLE tb_zipcode DROP PRIMARY KEY;
-- 수정 끝
    
insert into tb_zipcode
values ('zip1', 'sido1', 'gugum1', 'dong', 'bungi');
insert into tb_zipcode
values ('zip2', 'sido2', 'gugum2', 'dong2', 'bung2');
insert into tb_zipcode
values ('zip3', 'sido3', 'gugum3', 'dong3', 'bungi3');
    
    
    
create table products (
    product_code varchar2(20) not null constraint PK_products_product_code primary key,
    product_name varchar2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date
    );
    
insert into products
values('pcode1', 'name1', 'y', 'rkrur11', 'rkrur12', 'content1', 'img1','s11','e11','q1','y',sysdate);
insert into products
values('pcode2', 'name2', 'y', 'rkrur21', 'rkrur22', 'content2', 'img2','s22','e22','q2','y',sysdate);
insert into products
values('pcode3', 'name3', 'y', 'rkrur31', 'rkrur32', 'content3', 'img3','s33','e33','q3','y',sysdate);



create table orders (
    o_seq number(10) not null CONSTRAINT PK_orders_o_seq primary key,
    product_code varchar2(20),
    id varchar2(16),
    product_size varchar2(5),
    result char(1),
    indate date,
    constraint FK_orders_product_code Foreign key(product_code) references products (product_code),
    constraint FK_orders_id_member Foreign key(id) references member (id)
    );
insert into orders
values(1, 'pcode1', 'id1', 'siz1','y',sysdate);
insert into orders
values(2, 'pcode2', 'id2', 'siz2','y',sysdate);
insert into orders
values(3, 'pcode3', 'id3', 'siz3','y',sysdate);

select * from member;
select * from tb_zipcode;
select * from products;
select * from orders;


commit;

-- zip_seq 컬럼의 정렬이 제대로 되지 않음.
-- 그 이유는? 
select count(*) from tb_zipcode;
select * from tb_zipcode
order by zip_seq;

select * from tb_zipcode
where zip_seq = '4';

desc tb_zipcode;








