use bbs;

drop table COMMENT;

/* 댓글 테이블 생성 */
create table comment(
    bbsID int,    
    commentID int,
    commentText varchar(100),
    userID varchar(20),
    commentDate varchar(50)
);

/* PK, FK 추가 */
alter table comment add primary key (commentID, bbsID); 
alter table comment add constraint bbsID_FK foreign key (bbsID) references bbs(bbsID);
ALTER TABLE comment MODIFY commentID INT not null auto_increment;
select max(bbsid), commentid from comment group by bbsID ;
set @cnt = 0;
update comment set commentID = @


select * from BBS;
select * from comment order by bbsid, commentID ;
select * from user;


/* 직접 대입 정석 */
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (1, 1, "집에서 댓글", 'ggoomter', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (1, 2, "집에서 댓글", 'ggoomter', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (2, 1, "집에서 댓글", 'gildong', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (2, 3, "집에서 댓글", 'ggoomter', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (3, 1, "집에서 댓글", 'gildong', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (3, 2, "집에서 댓글", 'ggoomter', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (3, 3, "집에서 댓글", 'gildong', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (3, 4, "집에서 댓글", 'ggoomter', now());

/* 이러면 보드id와 상관없이 계속 증가함 */
insert into COMMENT (bbsID, COMMENTTEXT, USERID, commentDate) values (1, "집에서 댓글", 'ggoomter', now());
insert into COMMENT (bbsID, COMMENTTEXT, USERID, commentDate) values (1, "집에서 댓글", 'ggoomter', now());
insert into COMMENT (bbsID, COMMENTTEXT, USERID, commentDate) values (2, "집에서 댓글", 'ggoomter', now());
insert into COMMENT (bbsID, COMMENTTEXT, USERID, commentDate) values (2, "집에서 댓글", 'ggoomter', now());

/* 어렵지만 정석 방법 */
insert into COMMENT
(bbsID, commentID, commentText, userID , commentDate)
values
(
    ${bbsID}, 
    (select coalesce(max(commentID), 0) + 1
    from COMMENT
    where bbsID = ${bbsID}),
    "집에서 댓글",
    'ggoomter',
    now()
);

/* 동적 파라미터 바인딩 */
select ? from dual;
select ${now} from dual;