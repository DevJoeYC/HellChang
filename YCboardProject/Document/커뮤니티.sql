create database community;
use community;

drop table comment;
drop table attach;
drop table board;
drop table user;

create table user
(
	user_no int primary key auto_increment comment '회원번호',
	user_id varchar(50) comment '아이디',
	user_pw varchar(50) comment '비밀번호',
	user_name varchar(10) comment '이름',
	user_gender varchar(2) comment '성별',
	user_check varchar(2) default 'Y' comment '가입여부',
	join_date datetime default now() comment '가입일자',
	user_level varchar(2) default 'U' comment '권한'
);

insert into user (user_id,user_pw,user_name,user_gender,user_level)
values ('rony',md5('rony'),'관리자','M','A');

create table board
(
	board_no int primary key auto_increment comment '게시물 번호',
	user_no int comment '회원번호',
	board_type varchar(10) default 'G' comment '게시물 구분',
	board_title varchar(100) comment '제목',
	board_note text comment '내용',
	board_name varchar(10) comment '작성자',
	board_date datetime default now() comment '작성일',
	board_hit int default 0 comment '조회수',
	foreign key (user_no) references user(user_no)
);


create table attach
(
	attach_no int primary key auto_increment comment '첨부파일 번호',
	board_no int comment '게시물 번호',	
	attach_pname varchar(256) comment '물리파일명',
	attach_fname varchar(256) comment '논리파일명',
	foreign key (board_no) references board(board_no)
);

create table comment
(
	comt_no int primary key auto_increment comment '댓글 번호',
	board_no int comment '게시물 번호',	
	comt_userno int comment '댓글작성회원번호',
	comt_name varchar(100) comment '작성자',
	comt_note text comment '내용',
	comt_rp int comment '답글',
	comt_depth int comment '답글깊이',
	comt_date datetime default now() comment '작성일',
	foreign key (board_no) references board(board_no),
	foreign key (comt_userno) references user(user_no)
);
