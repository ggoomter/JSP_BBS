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

insert into BBS_BOARD values (3,  '3����', 'ggoomter', SYSDATE,  '�ƹ��۳���', 1, 0);
insert into BBS_BOARD values (4,  '4����', 'ggoomter', SYSDATE,  '�ƹ��۳���', 1, 0);
insert into BBS_BOARD values (5,  '5����', 'ggoomter', SYSDATE,  '�ƹ��۳���', 1, 0);
insert into BBS_BOARD values (6,  '6����', 'ggoomter', SYSDATE,  '�ƹ��۳���', 1, 0);
insert into BBS_BOARD values (7,  '7����', 'ggoomter', SYSDATE,  '�ƹ��۳���', 1, 0);
insert into BBS_BOARD values (8,  '8����', 'ggoomter', SYSDATE,  '�ƹ��۳���', 1, 0);
insert into BBS_BOARD values (9,  '9����', 'ggoomter', SYSDATE,  '�ƹ��۳���', 1, 0);
insert into BBS_BOARD values (10, '10����', 'ggoomter', SYSDATE, '�ƹ��۳���', 1, 0);
insert into BBS_BOARD values (11, '11����', 'ggoomter', SYSDATE, '�ƹ��۳���', 1, 0);
insert into BBS_BOARD values (12, '12����', 'ggoomter', SYSDATE, '�ƹ��۳���', 1, 0);



commit;