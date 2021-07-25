-- 네이버 공개자료실 
-- http://naver.me/GttcIFNX
-- 비번은 2020

-- 데이타베이스 
-- world, employees, sqldb

-- SQL  
-- CRUD

/* ------------------------- */ 
-- 필터링 : 조건에 맞는 레코드 출력하기 
-- SELECT */필드명나열 FROM 테이블명 WHERE 절;
-- SELECT */필드명나열 FROM 데이타베이스명.테이블명 WHERE 절;
-- WHERE 조건절의 연산자는? 
-- 관계연산자(>, =...),
-- 논리연산자(AND, OR, NOT)

-- sqldb 데이타베이스의 buytbl 테이블의 데이타를 출력하여라   
USE sqldb;
SHOW TABLES;
SELECT * FROM buytbl;

-- world 데이타베이스의 city 테이블의 데이타를 10개만 출력하여라. 
USE world;
SHOW TABLES;
SELECT * FROM city LIMIT 10;
SELECT * FROM city;

-- WHERE 절 이용하기 
-- WHERE 필드명+비교연산자|논리연산자 이용 
-- 관계연산자(>, =, <, >=, <=, <>, !=),
-- 논리연산자(AND, OR, NOT)
-- world.city 테이블안의 CountryCode 필드값이 BRA인 데이타만 출력하여라 
USE world;
SELECT * FROM city WHERE CountryCode = "BRA";

-- sqldb.userTbl 테이블에서 출생년도가 1970년도 이후 이고 키가 180보다 큰 데이타만 출력하여라 
USE sqldb;
SHOW TABLES;
DESC userTbl;
SELECT * FROM userTbl 
	WHERE birthyear>=1970 AND height>180;

-- userTbl 테이블에서 userID, name 필드만 출력하여라 (5개만) 
SELECT * FROM userTbl LIMIT 5;
SELECT userID, name FROM userTbl LIMIT 5;

-- userTbl 테이블에서 birthYear가 1970 보다 크거나 
--   주소가 서울인 데이타를 출력하여라 (필드는 name, birthYear, addr 만 출력한다.) 
select name, birthYear, addr from usertbl
				where (birthyear>1970) or (addr = '서울');



-- 연산자 
-- 관계연산자(비교 연산자) 
-- 논리연산자 
-- BETWEEN : 범위 지정 
-- IN : 특정 값 중 하나 
-- LIKE : 문자열. %, _

-- 범위를 지정할 때 사용하는 연산자 BETWEEN
-- 컬럼명 BETWEEN 값1 AND 값2 : 값1~값2
SELECT * FROM usertbl 
		WHERE height BETWEEN 180 AND 183;
        
SELECT * FROM usertbl 
		WHERE birthyear BETWEEN 1971 AND 1975;


-- 해당 값에 해당하는 레코드 추출 IN 연산자
-- 컬럼명 IN(값1, 값2...)
-- userTbl 에서 addr 컬럼값이 경남, 전남, 경북인 레코드 출력 
SELECT * FROM usertbl;

-- or 연산자와 = 연산자 이용 
SELECT * FROM usertbl 
		WHERE (addr='경남') OR (addr='전남') OR (addr='경북');  
        
 -- in 연산자 이용 
 SELECT * FROM usertbl 
		WHERE addr in('경남','전남','경북');       
        
-- LIKE 연산자 
-- 문자열이나 값 검색 LIKE ..%(무엇이든)
-- 문자열이나 값 검색 LIKE _(언더바) (글자값) 
-- WHERE 컬럼명 LIKE '.%'
-- WHERE 컬럼명 LIKE '_종신'

-- userTbl 에서 name 컬럼값이 김~으로 시작하는 데이타만 출력 
-- userTbl 에서 name 컬럼값이 ~신으로 끝나는 데이타만 출력 

 SELECT * FROM usertbl 
		WHERE name LIKE '김%';  

 SELECT * FROM usertbl 
		WHERE name LIKE '%신';  

SELECT * FROM usertbl; 
-- 전체글자수가 2글자. 마지막 글자가 신
SELECT * FROM usertbl WHERE name LIKE '_신'; 
-- 전체글자수가 3글자. 마지막 글자가 신
SELECT * FROM usertbl WHERE name LIKE '__신';      

-- userTbl에서 addr 지역명이 경~ 혹은 _남으로 끝나는 레코드 출력 
SELECT addr FROM userTbl;
SELECT * FROM usertbl 
	WHERE (addr LIKE '경%') OR (addr LIKE '_남');  
  
SELECT COUNT(*) FROM usertbl 
	WHERE (addr LIKE '경%') OR (addr LIKE '_남');    
    
-- 서브 쿼리(Sub Query)란?
-- 쿼리문안에 쿼리문이 들어가는 것 
-- SELECT .. FROM.. WHERE 조건절1 
--		(SELECT .. FROM.. WHERE 조건절2 )
-- 주의사항 : 서브쿼리의 레코드 결과값은 1개로 유일해야한다.

-- 177 을 또다른 쿼리문으로 대치 
-- 김경호의 키를 모른다는 가정. 
-- 주의사항 : 서브쿼리의 경우 레코드가 하나만 추출되어야 한다.
-- 김경호보다 키가 큰 사람의 이름과 키를 출력하여라 
-- 김경호의 키를 모른다는 가정. 
-- 주의사항 : 서브쿼리의 경우 레코드가 하나만 추출되어야 한다.     

-- 서브쿼리문을 사용하지 않은 경우 
-- 김경호의 키는?
SELECT height FROM usertbl WHERE name = '김경호'; -- 177
-- 김경호보다 키가 큰 사람의 이름과 키는? 
SELECT name, height FROM usertbl 
	WHERE height > 177;
-- 서브쿼리문을 사용한 경우 
SELECT name, height FROM usertbl 
	WHERE height > ( SELECT height FROM usertbl WHERE name = '김경호');
-- 서브쿼리문을 사용한 경우 
SELECT name, height FROM usertbl 
	WHERE height > ( SELECT height FROM usertbl WHERE name = '김경호');    
    
-- 서브쿼리문의 결과값이 다중인 경우 테스트 
-- userTbl 테이블에서 지역이 경남인 사람의 키보다 크거나 같은 사람을 출력 
SELECT * FROM usertbl WHERE addr = '경남';

SELECT name, height FROM usertbl 
	WHERE height > ( SELECT * FROM usertbl WHERE addr = '경남');


 -- 서브쿼리 결과값이 여러개인 경우  
-- SELECT .. FROM.. WHERE 조건절1 
--		ANY (SELECT .. FROM.. WHERE 조건절2 );

-- userTbl 테이블에서 지역이 경남인 사람의 키보다 크거나 같은 사람을 출력 
-- 지역이 경남에서 키가 가장 작은 사람보다 큰  데이타가 출력 
SELECT name, height FROM usertbl 
	WHERE height > ANY ( SELECT height FROM usertbl WHERE addr = '경남');
-- 서브쿼리문 예시
-- 이승기와 고향(addr)이 같은 레코드를 출력하여라 
-- 은지원 또는 김범수와 같은 고향(addr)인 레코드를 출력하여라.
-- 서브쿼리문 예시
-- 이승기와 고향(addr)이 같은 레코드를 출력하여라 
SELECT addr FROM usertbl WHERE name = '이승기'; -- 서울
SELECT * FROM usertbl WHERE addr = '서울';

SELECT * FROM usertbl 
		WHERE addr = (SELECT addr FROM usertbl WHERE name = '이승기');
-- 서브쿼리문 예시
-- 이승기와 고향(addr)이 같은 레코드를 출력하여라 
SELECT addr FROM usertbl WHERE name = '이승기'; -- 서울
SELECT * FROM usertbl WHERE addr = '서울';

SELECT * FROM usertbl 
		WHERE addr = (SELECT addr FROM usertbl WHERE name = '이승기');

-- 은지원 또는 김범수와 같은 고향(addr)인 레코드를 출력하여라.     
SELECT addr FROM usertbl WHERE name IN ('은지원', '김범수');   -- 경북, 경남  
SELECT * FROM usertbl WHERE addr IN ('경북', '경남');    

SELECT * FROM usertbl WHERE addr = ANY(
				SELECT addr FROM usertbl WHERE name IN ('은지원', '김범수')
				);

-- 특정 필드의 값과 관련된 정렬 
-- ORDER BY 컬럼명 ASC/DESC
-- ORDER BY 컬럼명1 ASC/DESC, 컬럼명2 ASC/DESC ...;
-- SELECT */필드명 FROM 테이블명 WHERE절 ORDER BY 절 LIMIT 숫자;


-- name 필드값으로 정렬 
SELECT * FROM usertbl ORDER BY name ASC; -- 오름차순
SELECT * FROM usertbl ORDER BY name;
SELECT * FROM usertbl ORDER BY name DESC; -- 내림차순 
    
-- 정렬기준이 2개인 경우 (addr 오름차순, name 내림차순) 
SELECT * FROM usertbl ORDER BY addr ASC;
SELECT * FROM usertbl ORDER BY addr ASC, name DESC;
-- ORDER BY 절 위치 테스트 
-- name 필드값으로 정렬 (3개만 출력) 
SELECT * FROM usertbl ORDER BY name LIMIT 3;    

-- Error Code: 1064. 
-- You have an error in your SQL syntax; 
-- SELECT * FROM usertbl LIMIT 3 ORDER BY name;
-- WHERE절 + ORDER BY 절
-- mobile1 값이 011인 레코드를 name 오름차순으로 정렬 
SELECT * FROM usertbl;
DESC usertbl;
SELECT * FROM usertbl 
			WHERE mobile1 = '011' 
            ORDER BY name;
-- WHERE절 + ORDER BY 절
-- mobile1 값이 011인 레코드를 name 오름차순으로 정렬 
SELECT * FROM usertbl;
DESC usertbl;
SELECT * FROM usertbl 
			WHERE mobile1 = '011' 
            ORDER BY name;
            

-- 중복을 제거하는 DISTINCT
-- SELECT [DISTINCT] 컬럼명|* FROM 테이블명 [WHERE절...] [ORDER BY ...];  
-- userTbl 테이블에서 지역(addr) 컬럼값을 중복없이 표시하여라.
SELECT addr FROM usertbl;
SELECT count(addr) FROM usertbl; -- 10

SELECT DISTINCT addr FROM usertbl;

SELECT count(DISTINCT addr) FROM usertbl; -- 5
-- LIMIT는 레코드 출력수 제한. 마지막에 지정 
-- SELECT * | 필드명 FROM 테이블 
-- 	WHERE 절  ORDER BY 절  LIMIT 숫자1, 숫자2;
-- 출생년도 순으로 정렬하여라 
SELECT * FROM usertbl ORDER BY birthyear;   

-- 출생년도가 가장 빠른 사람을 3명만 출력하여라  
SELECT * FROM usertbl ORDER BY birthyear LIMIT 3;
-- 출생년도가 가장 빠른 사람을 3명만 출력하여라  
SELECT * FROM usertbl ORDER BY birthyear LIMIT 3;   

-- LIMIT로 시작인덱스와 출력레코드수 제한하기 
-- SELECT * | 필드명 FROM 테이블 
-- 	WHERE 절  ORDER BY 절  
-- LIMIT 시작인덱번호, 갯수. 시작인덱스는 0부터 시작  

SELECT * FROM userTbl ORDER BY name ASC LIMIT 3, 2;

-- 출생년도가 5번째로 빠른 사람을 출력하여라         
SELECT * FROM usertbl ORDER BY birthyear LIMIT 4, 1; 

-- 출생년도가 3번째와 4번째로 빠른 사람을 출력하여라         
SELECT * FROM usertbl ORDER BY birthyear LIMIT 2, 2;
   