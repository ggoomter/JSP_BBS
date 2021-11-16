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


alter table BBS add VIEWCOUNT INT default 0; 

commit;