/* 스키마 생성 */
CREATE DATABASE BBS;
USE BBS;

/*------------------------테이블 생성 -----------------*/
/* 게시글 테이블 생성 */
DROP TABLE BBS;
create table BBS(
	bbsID INT,
	bbsTitle VARCHAR(50),
	userID VARCHAR(20),
	bbsDate DATETIME,
	bbsContent VARCHAR(2048),
	bbsAvailable INT,
	primary key (bbsID)
);

/* 유저 테이블 생성 */
DROP TABLE USER;
create table USER(
    userID varchar(20),
    userPassword varchar(20),
    userName varchar(20),
    userGender varchar(20),
    userEmail varchar(50),
    primary key(userID)
);


/* 댓글 테이블 생성 */
DROP TABLE COMMENT;
create table COMMENT(
    bbsID int,    
    commentID int,
    commentText varchar(100),
    userID varchar(20),
    commentDate varchar(50)
);

/* 제약조건 추가 */
alter table BBS add VIEWCOUNT INT default 0; 
alter table COMMENT add primary key (commentID, bbsID); 
alter table COMMENT add constraint bbsID_FK foreign key (bbsID) references BBS(bbsID);
ALTER TABLE COMMENT MODIFY commentID INT not null auto_increment;




/* 조회 */

select * from BBS;
select * from COMMENT order by bbsid, commentID ;
select max(bbsid), commentid from COMMENT group by bbsID ;
select * from USER;
 

/*------------------------데이터 입력 -----------------*/
/* 유저 데이터 입력 */
INSERT INTO USER VALUES('gildong', '123456', '홍길동', '남자', 'gildong@naver.com');

/* 게시글 데이터 입력 */
insert into BBS values (1, '1번글', 'ggoomter', now(), '아무내용', 1, NULL);
insert into BBS values (2, '2번글', 'gildong', now(), '아무내용', 1, NULL);
insert into BBS values (3, '3번글', 'gildong', now(), '아무내용', 1, NULL);
insert into BBS values (4, '4번글', 'ggoomter', now(), '아무내용', 1, NULL);
insert into BBS values (5, '5번글', 'ggoomter', now(), '아무내용', 1, NULL);
insert into BBS values (6, '6번글', 'ggoomter', now(), '아무내용', 1, NULL);
insert into BBS values (7, '7번글', 'ggoomter', now(), '아무내용', 1, NULL);
insert into BBS values (8, '8번글', 'gildong', now(), '아무내용', 1, NULL);
insert into BBS values (9, '9번글', 'gildong', now(), '아무내용', 1, NULL);
insert into BBS values (10, '10번글', 'ggoomter', now(), '아무내용', 1, NULL);
insert into BBS values (11, '11번글', 'ggoomter', now(), '아무내용', 1, NULL);
insert into BBS values (12, '12번글', 'ggoomter', now(), '아무내용', 1, NULL);



/* 댓글 데이터 입력 */
/* 이러면 보드id와 상관없이 계속 증가함 */
/*
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (1, 1, "집에서 댓글", 'ggoomter', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (1, 2, "집에서 댓글", 'ggoomter', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (2, 1, "집에서 댓글", 'gildong', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (2, 3, "집에서 댓글", 'ggoomter', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (3, 1, "집에서 댓글", 'gildong', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (3, 2, "집에서 댓글", 'ggoomter', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (3, 3, "집에서 댓글", 'gildong', now());
insert into COMMENT (bbsID, commentID, COMMENTTEXT, USERID, commentDate) values (3, 4, "집에서 댓글", 'ggoomter', now());
*/

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