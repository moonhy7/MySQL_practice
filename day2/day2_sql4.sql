-- GROUP BY
-- 그룹을 묶어주는 역할. 집계함수와 함께 사용 
-- SELECT .. FROM 테이블명 GROUP BY 컬럼명;

-- 갯수 구하기 COUNT(*|컬럼명)
-- 합계 구하기 SUM(컬럼명)
-- 평균 구하기 AVG(컬럼명)

-- buytbl 테이블에서 price의 전체 합계와 평균구하기 
USE sqldb;
SELECT * FROM buytbl;
DESC buytbl;

SELECT SUM(price) FROM buytbl;
SELECT AVG(price) FROM buytbl;
SELECT COUNT(*) FROM buytbl;

SELECT COUNT(*), SUM(price), AVG(price) FROM buytbl;

-- 각 종목의 가격(price) 합계, 평균를 groupName을 기준으로 정렬하여 표시하기 

-- groupName 필드의 데이타 값 확인 
SELECT DISTINCT groupname FROM buytbl; -- null, 전자, 의류, 서적 

-- groupname 필드를 기준으로 GROUP BY 
SELECT groupname, SUM(price), AVG(price) FROM buytbl
	GROUP BY groupname;

-- SELECT ... FROM .. GROUP BY .. ORDER BY .. LIMIT..    
SELECT groupname, SUM(price), AVG(price) FROM buytbl
	GROUP BY groupname 
    ORDER BY groupname DESC 
    LIMIT 2;

-- AS 별칭이름;
-- 컬럼명을 대신하는 별칭 이름 표시
-- SELECT 컬럼명 AS 별칭명 FROM 테이블명;  

SELECT 
	COUNT(*) AS '레코드 갯수', 
    SUM(price) AS '가격 합계', 
    AVG(price) AS '가격 평균'
		FROM buytbl;

SELECT 
	groupname AS '종목', SUM(price) AS '가격 합계', 
		AVG(price)  AS '가격 평균' FROM buytbl
	GROUP BY groupname 
    ORDER BY groupname DESC 
    LIMIT 2;

-- 퀴즈 : buytbl 테이블에서 사용자별로 구매합계 구하기 
/*
사용자아이디별 총구매액 표시 - GROUP BY, SUM(), AS
총구매액은? SUM(price*amount)

출력양식 

사용자아이디    총구매액  
BBK 		?
EJW			?
..
*/

SELECT * FROM buytbl;
SELECT 
	userid, price AS '가격', amount AS '수량', price*amount AS '구매액' 
		FROM buytbl;
        
SELECT 
	userid AS '회원아이디', SUM(price*amount) AS '총구매액' 
		FROM buytbl
        GROUP BY userid;
        
-- 집계함수 
-- MAX(필드명이나 수식)
-- MIN(필드명이나 수식)

-- 가격 필드의 최댓값, 최솟값, 수량 표시 
SELECT 	MAX(price) AS '최대값', 
	MIN(price) AS '최소값',
	COUNT(price) AS '갯수'
	FROM buytbl;

-- buytbl 테이블에서 각 사용자별로 물건을 몇개 사는지 평균 구하기 
-- GROUP BY, AVG() 
SELECT 	userid, AVG(amount)	
		FROM buytbl 
        GROUP BY userid ;
    
-- userTbl 테이블에서 가장 큰키와 가장 작은 키의 레코드를 출력하여라 
-- 서브쿼리를 사용하지 않은 경우 
SELECT MAX(height), MIN(height) FROM usertbl; -- 186, 166
SELECT * FROM usertbl 
		WHERE (height = 186) OR (height = 166);
SELECT * FROM usertbl 
		WHERE height IN (186 , 166);

-- Error Code: 1111. Invalid use of group function        
SELECT * FROM usertbl 
		WHERE height IN (MAX(height) , MIN(height));    
        
-- 서브쿼리를 사용한 경우    
-- 가장 큰키를 가진 레코드 모든 필드 출력  
SELECT MAX(height) FROM usertbl;
SELECT * FROM usertbl 
		WHERE height = (SELECT MAX(height) FROM usertbl);
        
-- 가장 작은키를 가진 레코드 모든 필드 출력  
SELECT * FROM usertbl 
		WHERE height = (SELECT MIN(height) FROM usertbl);

-- 가장 작은 키 레코드 + 가장 큰 키 레코드 
SELECT * FROM usertbl 
		WHERE height = (SELECT MIN(height) FROM usertbl)
				OR
			  height = (SELECT MAX(height) FROM usertbl);

-- NULL과 COUNT() 테스트 
SELECT COUNT(*) AS '전체 레코드수' FROM usertbl; -- 10
SELECT COUNT(mobile1) AS 'mobile1 필드 레코드수' FROM usertbl; -- 8 

-- userTbl 에서 휴대폰(mobile1) 유/무 에 따라 출력하기 
-- 휴대폰이 없는 사용자수 = 전체 사용자수-휴대폰이 있는 사용자수
-- 전체 사용자수 , 휴대폰이 있는 사용자수 ? , 휴대폰이 없는 사용자수 ?
SELECT  COUNT(*) AS '전체 사용자수', 
		COUNT(mobile1) AS '휴대폰이 있는 사용자수', 
        COUNT(*)-COUNT(mobile1) AS '휴대폰이 없는 사용자수'
			FROM usertbl;

SELECT * FROM usertbl; 

-- ##########################       
-- HAVING 절 
-- WHERE와 비슷하게 조건 제한. 
-- 주로 집계함수에 대해서 조건을 제한할때 사용 
-- 순서 주의 
-- SELECT .. FROM 테이블명 
-- GROUP BY 컬럼명 HAVING 조건 
-- ORDER BY 컬럼명 LIMIT 숫자;

-- buyTbl 테이블에서 총구매액이 
-- 1000 이상 조건으로 사용자(userID)별 총 구매액 표시 
-- GROUP BY 기준 : 사용자(userID)
-- 구매액 : SUM(price*amount) 

-- userid를 기준으로 총구매액 출력. 총구매액값을 기준으로 내림차순  
SELECT userid, SUM(price*amount) FROM buytbl
		GROUP BY userid
        ORDER BY SUM(price*amount) DESC; 
        
-- 1000 이상 조건으로 사용자(userID)별 총 구매액 표시    

-- WHERE 절 사용시 에러 발생 : Error Code: 1111. Invalid use of group function    
SELECT userid, SUM(price*amount) FROM buytbl
		WHERE SUM(price*amount) >= 1000
		GROUP BY userid
        ORDER BY SUM(price*amount) DESC;         

-- HAVING 절 이용 
SELECT userid, SUM(price*amount) FROM buytbl
		GROUP BY userid
        HAVING SUM(price*amount) >= 1000
        ORDER BY SUM(price*amount) DESC;           
        
-- 퀴즈
-- buyTbl 테이블에서 userID 별 
-- 평균 구매 횟수(AVG(amount))가 
-- 1~3 사이인 레코드만 출력하여라         
        
SELECT userID, AVG(amount)
            FROM buyTbl 
            GROUP BY userId
            ORDER BY AVG(amount);

SELECT userID, AVG(amount)
            FROM buyTbl 
            GROUP BY userId
            HAVING AVG(amount) BETWEEN 1 AND 3
            ORDER BY AVG(amount); 

SELECT userID, AVG(amount)
            FROM buyTbl 
            GROUP BY userId
            HAVING AVG(amount) >= 1 AND AVG(amount) <= 3
            ORDER BY AVG(amount); 
            
SELECT userID, AVG(amount)
            FROM buyTbl 
            GROUP BY userId
            HAVING AVG(amount) <= 3
            ORDER BY AVG(amount); 
            
            
-- ##########################       
--  WITH ROLLUP
--  중간 합계 
-- 순서 주의 
-- SELECT .. FROM 테이블명 
-- GROUP BY 컬럼명1, 컬럼명2 HAVING 조건 
-- WITH ROLLUP
-- ORDER BY 컬럼명 LIMIT 숫자;

-- buytbl 테이블에서 groupName 별로 합계 및 총합 구하기 
-- 총구매액 = sum(price*amount) 
SELECT * FROM buytbl;
DESC buytbl;
SELECT DISTINCT groupname FROM buytbl;    -- null, 전자, 의류, 서적         

-- 종목(groupName)을 기준으로 총구매액 표시             
SELECT groupName, SUM(price*amount) 
	FROM buytbl
    GROUP BY groupName;   
    
-- 종목(groupName), 주문번호(num)를 기준으로 총구매액 표시             
SELECT num, groupName, SUM(price*amount) 
	FROM buytbl
    GROUP BY groupName, num;     

-- groupNam 별로 부분합계가 표시     
SELECT num, groupName, SUM(price*amount) 
	FROM buytbl
    GROUP BY groupName, num
    WITH ROLLUP;       


-- 테이블의 레코드 CRUD 
-- 레코드 삽입, 레코드 삭제, 레코드 수정 

-- 기존 테이블 buytbl의 사본 테이블 생성 
-- 기존 테이블의 데이타도 함께 복사 
-- 키 속성들은 복사되지 않는다. (기본키, 자동증감, 외래키 ...) 
-- CREATE TABLE 새테이블명 (SELECT * FROM 테이블명);

CREATE TABLE buytbl2
	(SELECT * FROM buytbl);
SHOW TABLES;
SELECT count(*) FROM buytbl2; -- 12
DESC buytbl2;   
DESC buytbl;     
    
-- 레코드 삽입 1
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2... ) VALUES(값1, 값2 .. )
-- 컬럼명과 값을 모두 삽입
INSERT INTO buytbl2 (num, userid, prodName, groupName, price, amount)
	VALUES (13, 'TTT', '가습기', '생활가전', 90000, 1);
SELECT * FROM buytbl2 ORDER BY num DESC;
-- 특정 필드와 값만 삽입 
-- NULL 값 허용 필드 확인 - NULL이 YES인 값 
--  NULL 값 허용 필드 => groupName
-- groupName 필드값 생략시 NULL로 삽입된다. 
DESC buytbl2;
INSERT INTO buytbl2 (num, userid, prodName, price, amount)
	VALUES (14, 'TTT', '온풍기', 150000, 1);
SELECT * FROM buytbl2 ORDER BY num DESC;

-- 레코드 삽입 2 : 필드명 생략 방식 
-- 필드값이 삽입되는 순서 유의 
-- INSERT INTO 테이블명 VALUES(값1, 값2 .. )
INSERT INTO buytbl2 
	VALUES (15, 'BBK', '책상', '가구', 50000, 3);
SELECT * FROM buytbl2 ORDER BY num DESC;    

-- groupName 필드값을 삽입하고 싶지않다면? 
-- NULL 이용 
INSERT INTO buytbl2 
	VALUES (16, 'BBK', '전어', NULL, 12000, 10);
SELECT * FROM buytbl2 ORDER BY num DESC;   

-- 레코드 삽입 3
-- 다른 테이블의 레코드를 SELECT 문으로 삽입하기 
-- INSERT INTO 테이블명 (컬럼명1, 컬러명2 ... ) SELECT 문   
-- 테이블 구조(데이타형,필드명등)가 같아야한다.

-- buytbl 테이블에서 데이타 복사 X, 구조만 복사 => buytbl3
CREATE TABLE buytbl3
	(SELECT * FROM buytbl
		WHERE num=13);
SELECT COUNT(*) FROM buytbl3;
DESC buytbl3;

-- buyTbl 테이블에서 groupName 필드값이 전자 인 레코드만 복사해서 
-- buytbl3 테이블의 레코드로 삽입하기 
INSERT INTO buytbl3 
		(num, userid, prodName, groupName, price, amount) 
		SELECT num, userid, prodName, groupName, price, amount
				FROM buyTbl
                WHERE groupName = '전자';
SELECT COUNT(*) FROM buytbl3;
SELECT * FROM buytbl3;
DESC buytbl3;
  
-- #############################
-- 레코드 수정과 삭제를 위한 안전모드 해제하기 
-- [Edit]-[Preferences] 클릭하고 
-- SQL Editor 클릭하고 맨아래의 Safe ~ 항목 선택해제
-- 워크벤치 재실행 

-- 레코드 수정
-- UPDATE 테이블명 SET 컬럼명=값 WHERE 절;
SELECT * FROM buytbl2;
-- buytbl2의 userid 가 KBS 인 레코드에서 amount 값을 10으로 변경하여라 
UPDATE buytbl2 
		SET amount = 10
		WHERE userid = 'KBS';
        
SELECT * FROM buytbl2 WHERE userid = 'KBS';        

-- WHERE 절이 생략된 경우에는 모든 레코드에서 업데이트가 진행   
-- buytbl2 테이블에서 레코드의 price 가격 모두를 150%로 변경하여라 
-- price*1.5
SELECT * FROM buytbl2; 
UPDATE buytbl2 
		SET price = price*1.5;
SELECT * FROM buytbl2; 
SELECT * FROM buytbl;         

-- #############################
-- 특정 레코드 삭제 
-- DELETE FROM 테이블명 WHERE 절 
-- WHERE 절 생략시 레코드 모두 삭제 

SELECT * FROM buytbl2; 

-- buytbl2 테이블에서 전자 종목의 레코드를 모두 삭제 
DELETE FROM buytbl2 
	WHERE groupName = '전자';
SELECT * FROM buytbl2; 

-- WHERE 절 생략시 레코드 모두 삭제 
DELETE FROM buytbl2;
SELECT * FROM buytbl2; 

-- 테이블 삭제 
-- DROP TABLE 테이블명;
DROP TABLE buytbl2;
SHOW TABLES;

-- 테이블 구조 제외 레코드만 삭제 
-- TRUNCATE TABLE 테이블명;
SELECT * FROM buytbl3;
TRUNCATE TABLE buytbl3;
SHOW TABLES;
SELECT * FROM buytbl3;


          
            