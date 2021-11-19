USE BBS;

drop table BBS;

create table BBS(
	bbsID INT,
	bbsTitle VARCHAR(50),
	userID VARCHAR(20),
	bbsDate DATETIME,
	bbsContent VARCHAR(2048),
	bbsAvailable INT,
	primary key (bbsID)
);

alter table BBS add VIEWCOUNT INT default 0; 

select * from BBS;

insert into BBS values (3, '3번글', 'ggoomter', now(), '아무내용', 1);
insert into BBS values (4, '4번글', 'ggoomter', now(), '아무내용', 1);
insert into BBS values (5, '5번글', 'ggoomter', now(), '아무내용', 1);
insert into BBS values (6, '6번글', 'ggoomter', now(), '아무내용', 1);
insert into BBS values (7, '7번글', 'ggoomter', now(), '아무내용', 1);
insert into BBS values (8, '8번글', 'ggoomter', now(), '아무내용', 1);
insert into BBS values (9, '9번글', 'ggoomter', now(), '아무내용', 1);
insert into BBS values (10, '10번글', 'ggoomter', now(), '아무내용', 1);
insert into BBS values (11, '11번글', 'ggoomter', now(), '아무내용', 1);
insert into BBS values (12, '12번글', 'ggoomter', now(), '아무내용', 1);



set @bbsNum := (select MAX(bbsID) from BBS);
INSERT INTO bbs.bbs
(bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable, VIEWCOUNT)
VALUES(@bbsNum+1, concat(@bbsNum+1,'번글'), 'ggoomter', '2021-11-13 19:42:52', '아무내용', 1, 0);


commit;