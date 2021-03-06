
create table BBS_COMMENT(
    bbsID NUMBER,    
    commentID NUMBER,
    commentText varchar2(100),
    userID varchar2(20),
    commentDate varchar2(50)
);

/* PK, FK 異붽� */
alter table BBS_COMMENT add primary key (commentID, bbsID); 
alter table BBS_COMMENT add constraint bbsID_FK foreign key (bbsID) references BBS_BOARD(bbsID);

CREATE SEQUENCE AAA START WITH 1 INCREMENT BY 1 MAXVALUE 100 CYCLE NOCACHE;


select * from BBS_BOARD;
select * from BBS_COMMENT order by bbsid, commentID ;
select * from BBS_USER;

