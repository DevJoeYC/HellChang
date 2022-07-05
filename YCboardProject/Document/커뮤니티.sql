create database community;
use community;

drop table comment;
drop table attach;
drop table board;
drop table user;

create table user
(
	user_no int primary key auto_increment comment 'ȸ����ȣ',
	user_id varchar(50) comment '���̵�',
	user_pw varchar(50) comment '��й�ȣ',
	user_name varchar(10) comment '�̸�',
	user_gender varchar(2) comment '����',
	user_check varchar(2) default 'Y' comment '���Կ���',
	join_date datetime default now() comment '��������',
	user_level varchar(2) default 'U' comment '����'
);

insert into user (user_id,user_pw,user_name,user_gender,user_level)
values ('rony',md5('rony'),'������','M','A');

create table board
(
	board_no int primary key auto_increment comment '�Խù� ��ȣ',
	user_no int comment 'ȸ����ȣ',
	board_type varchar(10) default 'G' comment '�Խù� ����',
	board_title varchar(100) comment '����',
	board_note text comment '����',
	board_name varchar(10) comment '�ۼ���',
	board_date datetime default now() comment '�ۼ���',
	board_hit int default 0 comment '��ȸ��',
	foreign key (user_no) references user(user_no)
);


create table attach
(
	attach_no int primary key auto_increment comment '÷������ ��ȣ',
	board_no int comment '�Խù� ��ȣ',	
	attach_pname varchar(256) comment '�������ϸ�',
	attach_fname varchar(256) comment '�����ϸ�',
	foreign key (board_no) references board(board_no)
);

create table comment
(
	comt_no int primary key auto_increment comment '��� ��ȣ',
	board_no int comment '�Խù� ��ȣ',	
	comt_userno int comment '����ۼ�ȸ����ȣ',
	comt_name varchar(100) comment '�ۼ���',
	comt_note text comment '����',
	comt_rp int comment '���',
	comt_depth int comment '��۱���',
	comt_date datetime default now() comment '�ۼ���',
	foreign key (board_no) references board(board_no),
	foreign key (comt_userno) references user(user_no)
);
