/*  */
-- 데이타베이스 종류
-- 관계형 : MySQL, ORACLE, MSSQL, SQL-LITE ...
-- 비관계형 : 몽고DB...

-- SQL : 데이타베이스 조작언어. 관계형 데이타베이스에서 공통 사용
-- 데이타베이스 구성요소는?
-- 데이타베이스 > 테이블 > 행(레코드)과 열(필드, 속성)

-- SQL 언어 주석 ctrl+/
-- 1줄 주석은? -- 주석문
-- 여러줄 주석은?
/*
 주석 내용
*/

-- 환경 설정
-- [Edit]-[Preferences]
-- Fonts ~ :  폰트 크기 등 설정
-- [SQL Editor]-[Query Editor] 에서 [USE UPPERCASE ~] 선택

-- SQL 문법 스타일 
-- 명령어는 대소문자 구분 없음
-- 마지막에 세미콜른(;)
-- 명령어;
-- SQL 명령 실행은? 블록을 지정하고 [Ctrl]+[Enter]

-- 데이타베이스 목록확인 
SHOW DATABASES;

-- 데이타베이스 접속하기 
-- USE 데이타베이스명;
USE employees;
USE world;

-- 접속중인 데이타베이스의 테이블 목록 확인하기 
USE employees;
SHOW TABLES;

USE world;
SHOW TABLES;

-- 접속중인 데이타베이스의 테이블 목록의 정보 확인하기 
SHOW TABLE STATUS;

-- 특정 테이블의 정보 확인하기 
-- DESCRIBE 테이블명;
-- DESC 테이블명;
-- DESCRIBE(/DESC) 데이타베이스명.테이블명;
USE employees;
SHOW TABLES;
DESC salaries;
DESC employees;
-- 다른 데이타베이스의 특정 테이블 정보 확인 
DESC world.city;

-- 교재의 샘플 데이타베이스와 테이블 생성하기
-- 워크벤치에서 [File]-[Open SQL Script]
-- 실습데이타베이스생성_초기화.sql
-- 각 sql 명령 실행 

-- 3개 확인 
SHOW DATABASES;

-- 필터링 : 조건에 맞는 레코드 출력하기 
-- SELECT */필드명나열 FROM 테이블명 WHERE 절;
-- SELECT */필드명나열 FROM 데이타베이스명.테이블명 WHERE 절;
-- WHERE 조건절의 연산자는? 
-- 관계연산자(>, =...),
-- 논리연산자(AND, OR, NOT)

USE sqldb;
SHOW TABLES;
SELECT * FROM buytbl;
SELECT * FROM buytbl LIMIT 3;

-- userTbl 테이블에서 김경호만 출력하기 
SELECT * FROM usertbl WHERE name = '김경호';

SELECT * FROM usertbl;

-- height이 170보다 작다 
SELECT * FROM usertbl 
	WHERE height < 170;

-- 논리 연산자 적용하기 
-- 175 ~ 180 
SELECT * FROM usertbl 
	WHERE (height >= 175) AND (height<180)


