SELECT SYSDATE FROM DUAL;

create table BBS_USER(
    userID varchar2(20),
    userPassword varchar2(20),
    userName varchar2(20),
    userGender varchar2(20),
    userEmail varchar2(50),
    primary key(userID)
);
DROP TABLE BBS_USER;
desc user;

INSERT INTO BBS_USER VALUES('gildong', '1234', 'È«±æµ¿', '³²ÀÚ', 'gildong@naver.com');
COMMIT;
SELECT * FROM BBS_USER;