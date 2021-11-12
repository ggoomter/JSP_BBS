use bbs;

drop table COMMENT;

/* 댓글 테이블 생성 */
create table comment(
	commentID int,
	bbsID int,
	commentText varchar(100),
	userID varchar(20),
	commentDate varchar(50)
);

/* PK, FK 추가 */
alter table comment add primary key (commentID); 
alter table comment add constraint bbsID_FK foreign key (bbsID) references bbs(bbsID);


select * from BBS;