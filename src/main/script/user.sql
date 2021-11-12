CREATE DATABASE BBS;
USE BBS;

show databases;

create table USER(
    userID varchar(20),
    userPassword varchar(20),
    userName varchar(20),
    userGender varchar(20),
    userEmail varchar(50),
    primary key(userID)
);

desc user;

INSERT INTO USER VALUES('gildong', '123456', '홍길동', '남자', 'gildong@naver.com');
COMMIT;
SELECT * FROM USER;