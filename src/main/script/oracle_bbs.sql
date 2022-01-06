SELECT SYSDATE FROM DUAL;
create table BBS_BOARD(
	bbsID NUMBER,
	bbsTitle VARCHAR2(50),
	userID VARCHAR2(20),
	bbsDate DATE,
	bbsContent VARCHAR2(2048),
	bbsAvailable NUMBER,
	primary key (bbsID)
);

alter table BBS_BOARD add VIEWCOUNT INT default 0; 

select * from BBS_BOARD;

insert into BBS_BOARD values (3,  '3번글', 'ggoomter', SYSDATE,  '아무글내용', 1, 0);
insert into BBS_BOARD values (4,  '4번글', 'ggoomter', SYSDATE,  '아무글내용', 1, 0);
insert into BBS_BOARD values (5,  '5번글', 'ggoomter', SYSDATE,  '아무글내용', 1, 0);
insert into BBS_BOARD values (6,  '6번글', 'ggoomter', SYSDATE,  '아무글내용', 1, 0);
insert into BBS_BOARD values (7,  '7번글', 'ggoomter', SYSDATE,  '아무글내용', 1, 0);
insert into BBS_BOARD values (8,  '8번글', 'ggoomter', SYSDATE,  '아무글내용', 1, 0);
insert into BBS_BOARD values (9,  '9번글', 'ggoomter', SYSDATE,  '아무글내용', 1, 0);
insert into BBS_BOARD values (10, '10번글', 'ggoomter', SYSDATE, '아무글내용', 1, 0);
insert into BBS_BOARD values (11, '11번글', 'ggoomter', SYSDATE, '아무글내용', 1, 0);
insert into BBS_BOARD values (12, '12번글', 'ggoomter', SYSDATE, '아무글내용', 1, 0);



commit;