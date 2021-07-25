-- SQL 테이블 생성 방법 
-- 새로운 테이블명과 새로운 테이블 구조 : 완전 초기화 
-- 기존 테이블의 구조와 기존 레코드를 이용 : 복사본 생성. 쿼리의 결과를 저장하는 역할 

-- 기존 테이블 복사해서 새로운 테이블 만들기 
-- 기본 테이블의 데이타도 함께 복사 
-- CREATE TABLE 새테이블명 (SELECT */컬럼명 FROM 테이블명);

USE sqldb;
-- usertbl 테이블에서 지역이 서울인 레코드만 별도 테이블에 저장하여라. 
SELECT * FROM usertbl WHERE addr='서울';
CREATE TABLE usertbl_seoul
	(SELECT * FROM usertbl WHERE addr='서울');
SHOW TABLES;
SELECT * FROM usertbl_seoul;

-- userTbl 테이블에서 키순으로 정렬하고 
-- 결과 데이타값에서 1~5등까지만 userTbl_height5 테이블로 저장하여라. 
-- 컬럼은 userid, name, addr, height 으로 제한한다. 
SELECT userid, name, addr, height 
		FROM usertbl 
        ORDER BY height DESC 
        LIMIT 5;
        
CREATE TABLE userTbl_height5 
	(SELECT userid, name, addr, height 
		FROM usertbl 
        ORDER BY height DESC 
        LIMIT 5);
        
SHOW TABLES;
SELECT * FROM userTbl_height5;        

-- 테이블 삭제하기 
-- DROP TABLE 테이블명;
DROP TABLE usertbl_seoul;
SHOW TABLES;

-- 기존 테이블에서 테이블의 구조만 복사해서 별도 테이블로 저장하기 
-- WHERE 절에 결과값이 나오지 않는 형태
SELECT DISTINCT addr FROM usertbl;
SELECT * FROM usertbl WHERE addr='경주';
CREATE TABLE usertbl_a 
	(SELECT * FROM usertbl WHERE addr='경주');
SHOW TABLES;
SELECT count(*) FROM usertbl_a; 



