-- 데이타베이스 단위 
-- 계정 > 데이타베이스 > 테이블 > 레코드+필드 > 값 

-- 데이타베이스 생성, 목록확인, 삭제 

-- 데이타베이스 생성
-- CREATE DATABASE [IF NOT EXISTS] 데이타베이스이름;

-- 계정안에 생성된 데이타베이스 목록 확인 
-- SHOW DATABASES;

-- 데이타베이스 삭제 
-- DROP DATABASE [IF EXISTS] 데이타베이스이름;

CREATE DATABASE IF NOT EXISTS sqlDB1;
SHOW DATABASES;
DROP DATABASE IF EXISTS sqlDB1; 
SHOW DATABASES;

USE employees;
SHOW TABLES;

-- SQL 변수 지정 
-- SET @변수명 = 초기값;
-- SELECT @변수명;
USE sqldb;
SET @a = 10;
SET @b = 5.5;
SET @c = 'Hello MySQL';
SELECT @a, @b, @c, @a+@b AS '더한값', @a*@b AS '곱한값'

/* 퀴즈
 usertbl 테이블에서 키가 180 넘는 레코드만 추출한 후 아래와 같은 형태로 출력하여라 
           이름   키   
 가수이름 => 김경호   ?  cm
 가수이름 => 이승기   ?  cm 
 */
SET @t1 = '가수이름 =>';
SET @t2 = 'cm';
SELECT  @t1 AS ' ', name AS '이름', height AS '키', @t2 AS ' '
			FROM usertbl
        WHERE height>180;

-- 데이터 형변환 CASTING  -- 
/*
CAST ( .. AS 데이터형식)
CONVERT ( .. , 데이터형식)

데이터형식 : 
 숫자형(정수, 실수, 부호없음, 부호있음..)
 문자열 
 날짜형 
 바이너리형  
 BINARY, CHAR(), DATE , TIME, 
 SIGNED INTEGER, UNSIGNED INTEGER
*/

-- 실수 => 정수 
-- 평균구매횟수 => 정수형태로 변환 
SELECT * FROM buytbl;
DESC buytbl;
SELECT AVG(amount) FROM buytbl; -- 2.9167
-- CAST ( .. AS 데이터형식) | -- CONVERT ( .. , 데이터형식)
SELECT CAST(AVG(amount) AS SIGNED INTEGER ) FROM buytbl; -- 3
SELECT CONVERT(AVG(amount) , SIGNED INTEGER ) FROM buytbl; -- 3

-- 숫자 => 문자 | 문자 => 숫자
SELECT  3.14, 
		CAST( 3.14 AS CHAR(10)), 
		CAST( '2345pfpf6728' AS SIGNED INTEGER);

-- 제어흐름함수 
-- IF(조건식, True값1, False값2)
-- IFNULL(값1, 값2) : 값1이 NULL이면 값2 반환, 값1이 NULL이 아니면 현재값1 반환 

SELECT IF(100>200, '참', '거짓'), IF(100<200, '참', '거짓');
-- 거짓, 참 
SELECT IFNULL(NULL, '널값이다'), IFNULL(500, '널값이다');
-- 널값이다, 500

/* buytbl 테이블에서 groupName 컬럼값이 NULL 이면 자료없음으로 표시하여라 */
SELECT * FROM buytbl;
SELECT  prodName,  
		groupName, 
        IFNULL(groupName, '자료없음') AS '종목'
		FROM buytbl;

-- 다중분기 
-- CASE 값1 
--     WHEN 값2 THEN 결과값1 
--     WHEN 값3 THEN 결과값2
--     ELSE 결과값n 
--     END;

/* @price 변수값에 따라 짝수, 홀수 출력하기  */ 
SET @price = 45; 
SELECT
	@price AS '변수값',
	CASE @price%2 
		WHEN 0 THEN '짝수' 
		ELSE '홀수'
		END AS '결과';

/* buytbl 테이블에서 price 컬럼값이 따라 짝수, 홀수 출력하기  */                
DESC buytbl; 

SELECT  price, 
		CASE price%2 
		WHEN 0 THEN '짝수' 
		ELSE '홀수'
		END AS '결과'
			FROM buytbl; 

-- 문자열 자료형 종류 
-- CHAR(n), VARCHAR(n), TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT, BLOB, LONGBLOB
-- 여러 문자열을 하나의 문자열로 표시 

-- 문자열 함수 
-- CONCAT(EXP...) : 문자열을 함께 출력할 때 사용 
-- CONCAT_WS(구분자, 문자열1, 문자열2 ...) : 문자열을 구분자와 함께 표시 


/* CONCAT()이용해서 하나의 컬럼에 2개의 컬럼값 표시  */
-- 단가  X  수량 = 입금액 
-- 
SELECT * FROM buytbl;
DESC buytbl;
SELECT price, amount, price*amount FROM buytbl;
SELECT  num,
		CONCAT(price,' X ', amount, ' = ', price*amount) 
			AS '가격 X 수량'
		FROM buytbl;

-- usertbl 테이블에서 핸드폰 번호 같이 출력하기 
SELECT * FROM usertbl;
SELECT  userID, name, 
		CONCAT(mobile1, ' - ', mobile2) AS 'mobile'
		FROM usertbl;       

-- 소숫점 자리 표시         
-- FORMAT(숫자, 소숫점 자릿수)   
SET @x = 123.456789;
SELECT @x, FORMAT(@x, 1), FORMAT(@x, 3);

-- 특정 글자로 교체하기 
-- INSERT(문자열, 시작위치, 길이, 교체문자열) : 시작위치의 인덱스값은 1
-- REPLACE(문자열, 원래문자열, 교체문자열)
SET @m = '010-1234-5678';
SELECT 	@m, 
		INSERT(@m, 5, 4, '****') AS '결과1', 
        REPLACE(@m, '1234', '****') AS '결과2';


-- 특정 부분만 표시하기 
-- LEFT(문자열, 길이), RIGHT(문자열, 길이) : 왼쪽이나 오른쪽을 기준으로 길이만큼 잘라서 표시 
-- SUBSTRING(문자열, 시작위치, 길이) : 시작위치에서 길이만큼 잘라서 표시한다. 
SET @sample = 'abcdefghij';
SELECT  @sample, 
		LEFT(@sample, 3), RIGHT(@sample, 3), 
		SUBSTRING(@sample, 3, 3);
        
-- 퀴즈 : uertbl 테이블에서 아래와 같이 표시하여라 
-- 회원명(name) => 김**
-- 연락처(mobile1, mobile2) => ???-????-????       
SELECT * FROM usertbl;
-- 회원명  연락처
-- 바**  010-0000-0000

SELECT  INSERT(name, 2, 2, '**') AS '회원명',
		CONCAT(mobile1,'-',LEFT(mobile2,4),'-',RIGHT(mobile2,4)) AS '연락처'
        FROM usertbl;
        
-- LPAD(문자열, 길이, 채울문자열), RPAD(문자열, 길이, 채울문자열)
--  : 왼쪽이나 오른쪽에 길이만큼 늘려 문자열을 채운다.
-- REPEAT(문자열, 반복횟수) : 문자열을 횟수만큼 반복한다.
SET @user1 = '신짱구';
SELECT  @user1, 
		REPEAT(@user1, 3),
        REPEAT('=', 5),
        LPAD(@user1, 10, '#'), 
        RPAD(@user1, 10, '#'), 
        CONCAT(LPAD(@user1, 10, '#'),'########')
        ;

-- 문자열 공백 없애기 
-- LTRIM(문자열), RTRIM(문자열), TRIM(문자열)
SET @user2 = '      선우미란     ';
SELECT  CONCAT('*****',@user2,'*****'),
		CONCAT('*****',LTRIM(@user2),'*****'), 
        CONCAT('*****',RTRIM(@user2),'*****'), 
        CONCAT('*****',TRIM(@user2),'*****') ;

-- 날짜 자료형 종류 
-- YEAR, DATE, TIME, DATETIME

-- 현재 시간과 날짜 출력 
-- NOW() : 내장함수로 현재의 날짜와 시간을 표시 
-- SYSDATE() : 내장함수로 현재의 날짜와 시간을 표시 
-- CURDATE() : 현재 날짜 표시 
-- CURTIME() : 현재 시간 표시 

SELECT  NOW(), SYSDATE(), CURDATE(), CURTIME();
-- '2021-01-18 11:25:48', '2021-01-18 11:25:48', '2021-01-18', '11:25:48'
        
-- YEAR(날짜), MONTH(날짜), DAY(날짜), DAYOFMONTH(날짜), DATE(날짜)  
-- HOUR(시간), MINUTE(시간), SECOND(시간), TIME(시간) 

-- 현재 시간을 기준으로 년월일 시분초 분리시켜 출력하기 
SELECT  NOW(), 
		YEAR(NOW()), MONTH(NOW()), 
        DAY(NOW()), DAYOFMONTH(NOW()), DATE(NOW()), 
        HOUR(NOW()), MINUTE(NOW()), SECOND(NOW()), TIME(NOW()) 
        ;

-- userTble  테이블에서 날짜형으로 지정된 mDate 필드값을 
-- 년도, 월, 일로 분리시켜 출력하기 
DESC usertbl;
SELECT name, mdate, 
	   YEAR(mdate) AS '가입년도', 
       MONTH(mdate) AS '가입월', 
       DAY(mdate) AS '가입일'
       FROM usertbl;

-- usertbl 테이블에서 5월에 가입한 회원목록만 출력시켜라. 
SELECT name, mdate FROM usertbl
		WHERE MONTH(mdate) = 5; 
        
-- usertbl 테이블에서  2013년 이후에 가입한 회원목록만 출력시켜라. 
SELECT name, mdate FROM usertbl
		WHERE YEAR(mdate) >= 2013 
        ORDER BY mdate DESC; 

-- DAYOFWEEK(날짜) : 요일표시 1~7(일요일~토요일)
-- MONTHNAME(날짜) : 달을 영문으로 표시 
-- DAYOFYEAR(날짜) : 1년중 몇번째 날인지 표시 

SELECT  NOW(), 
		DAYOFWEEK(NOW()),  MONTHNAME(NOW()), DAYOFYEAR(NOW());

-- usertbl 테이블에서 목요일에 가입한 회원목록만 출력시켜라. 
SELECT name, mdate FROM usertbl
		WHERE DAYOFWEEK(mdate) = 5; 

-- 날짜 연산 함수 
-- DATEDIFF(날짜1, 날짜2) : 날짜1 - 날짜 2 : ????-??-??
-- TIMEDIFF(시간1, 시간2) : 시간1- 시간2

SELECT  NOW(), 
		DATEDIFF('2021-12-31', now()), 
        TIMEDIFF('24:00:00', CURTIME());
        
/*  구정까지 얼마남았을까요? 2021년 2월 12일 */
SELECT  CONCAT( '구정까지 남은 날짜는? =>', DATEDIFF('2021-02-12', now()));


