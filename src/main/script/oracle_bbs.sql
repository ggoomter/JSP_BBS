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

SELECT * FROM BBS_BOARD;
SELECT * FROM BBS_BOARD WHERE bbsID < 100 AND bbsAvailable = 1 AND ROWNUM<=10 ORDER BY bbsID;
DELETE FROM BBS_BOARD WHERE BBSID = 13;
COMMIT;

SELECT bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable, VIEWCOUNT
FROM BBS_BOARD where bbsId between 1 and 100 order by bbsID DESC;
SELECT sysdate FROM dual;
# 2022-01-06 14:48:28      함수로
# 2022-01-06 11:08:06.000  db에
# 2022-01-06 14:51:19.000  sysdate로