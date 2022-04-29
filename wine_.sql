-- wine

create table sale (
    sale_date date default sysdate primary key not null,
    wine_code varchar2(6) not null,
    mem_id varchar2(30) not null,
    sale_amount varchar2(5) default '0' not null,
    sale_price varchar2(6) default '0' not null,
    sale_tot_price varchar2(15) default '0' not null,
    Foreign key (wine_code) references wine (wine_code),
    Foreign key (mem_id) references member (mem_id)
    );

create table member (
    mem_id varchar2(6) not null,
    mem_grade varchar2(20),
    mem_pw varchar2(20) not null,
    mem_birth date default sysdate not null,
    mem_tel varchar2(20),
    mem_pt varchar2(10) default '0' not null ,
    Foreign key(mem_grade) references grade_pt_rade (mem_grade)
    );

create table grade_pt_rade (
    mem_grade varchar2(20) not null primary key,
    grade_pt_rate number(3,2)
    );
    
create table today (
    today_code varchar2(6) primary key not null,
    today_sens_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
    );
    
create table nation (
    nation_code varchar2(26) primary key not null,
    nation_name varchar2(50) not null
    );

create table wine (
    wine_code varchar2(26) primary key not null,
    wine_name varchar2(100) not null,
    wine_url blob,
    nation_code varchar2(6),
    wine_type_code varchar2(6),
    wine_sugar_code varchar2(3),
    wine_price varchar2(6) default 0 not null,
    wine_vintage varchar2(4),
    theme_code varchar2(6),
    today_code varchar2(6),
    foreign key (nation_code) references nation (nation_code),
    foreign key (wine_type_code) references wine_type (wine_type_code),
    foreign key (theme_code) references theme (theme_code),
    foreign key (today_code) references today (today_code)
    );
    
create table theme (
    theme_code varchar2(6) primary key not null,
    theme_name varchar2(50) not null
    );

create table stock_management (
    stock_code varchar2(6) primary key not null,
    wine_code varchar2(6),
    manager_id varchar2(30),
    ware_date date default sysdate not null,
    stock_amount number(5) default 0 not null,
    foreign key (wine_code) references wine (wine_code),    
    foreign key (manager_id) references manager (manager_id)
    );

create table manager (
    manager_id varchar2(30) primary key not null,
    manager_pwd varchar2(20) not null,
    manager_tel varchar2(20)
    );

create table wine_type (
    wine_type_code varchar2(6) primary key not null,
    wine_type_name varchar2(50)
    );
    
    
    
