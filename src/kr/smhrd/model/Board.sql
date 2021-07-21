--DROP TABLE "" CASCADE CONSTRAINTS;
create table tbl_board(
   idx int not null auto_increment,   -- 자동증가컬럼(1,2,3.....)
   title varchar(100) not null,
   contents varchar(4000) not null,
   writer varchar(50) not null,
   count int default 0,
   indate datetime not null default now(),
   primary key(idx)
);
select * from tbl_board;
create table tbl_user(
	user_id varchar(30) not null,
	user_name varchar(30) not null,
	password varchar(30) not null,
	primary key(user_id)
);
select * from tbl_user;
insert into tbl_user values('admin', '관리자', 'admin');
insert into tbl_user values('min', '박형민', '12345');
insert into tbl_user values('min1', '아가', '12345');
--저장
insert into tbl_board(title, contents, writer) 
values('게시판 테스트', '0', '관리자');
insert into tbl_board(title, contents, writer) 
values('게시판 테스트', '0', '홍길동');
insert into tbl_board(title, contents, writer) 
values('게시판 테스트', '0', '나길동');

select * from tbl_board;

select idx,title,contents,writer, DATE_FORMAT(indate,'%Y-%m-%d') AS indate from tbl_board;