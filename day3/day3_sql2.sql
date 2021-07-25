-- 조인이란? 
-- 두개이상의 테이블을 서로 묶어서 관리하는 기능 
-- 조인의 종류 
-- 내부 조인 
-- 외부 조인 
-- 크로스 조인 
-- 셀프 조인 

-- #################################
-- 예제 테이블 구조 확인 
-- 외래키 확인 
-- buytbl에서 외래키가 userID인지  확인 
-- 외래키는 Key값이 MUL로 표시 
-- usertbl 테이블의 userid => buytbl 테이블의 userid 

USE sqldb;
SELECT * FROM usertbl;
SELECT * FROM buytbl;
DESC usertbl; 
DESC buytbl;

-- 바비킴이 산 물건에 대한 구매액은? 

-- INNER JOIN 1 --
-- SELECT * 또는 컬럼명 
--    FROM 테이블1
--      INNER JOIN 테이블2
--         ON 조인될조건:테이블1.컬럼명 = 테이블2.컬럼명 이용 
--				(서로 공통된 관계의 컬럼이용)
--    [WHERE 조건절];

-- 구매 경험이 있는 모든 레코드가 출력 
-- 구매 경험이 없는 레코드는 표시되지 않는다. => 아우터조인으로 해결 
-- userID 컬럼명이 2번 표시 
-- 왼쪽이 buyTbl, 오른쪽이 userTbl

SELECT * FROM buyTbl; 
SELECT * FROM userTbl; 

-- buyTbl.userid = userTbl.userid
SELECT * FROM buyTbl
		INNER JOIN userTbl
        ON buyTbl.userid = userTbl.userid;

-- 레코드수는? 12
SELECT count(*) FROM buyTbl
		INNER JOIN userTbl
        ON buyTbl.userid = userTbl.userid;
        
SELECT count(*) FROM buyTbl; -- 12
SELECT count(*) FROM userTbl; -- 10


SELECT * FROM userTbl
		INNER JOIN buyTbl
        ON userTbl.userid = buyTbl.userid;

SELECT count(*) FROM userTbl
		INNER JOIN buyTbl
        ON userTbl.userid = buyTbl.userid;
        
-- 내부조인으로 두 테이블의 특정 필드 출력 1
-- 두 테이블의 모든 필드가 출력 
-- 내부조인시 각 테이블의 필드는 테이블명.필드명으로 탐색
-- userTbl => userID, name, addr
-- buyTbl =>  prodName, price, amount 

SELECT userTbl.userID,  userTbl.name, userTbl.addr, 
		buyTbl.prodName, buyTbl.price, buyTbl.amount 
		FROM userTbl
		INNER JOIN buyTbl
        ON userTbl.userid = buyTbl.userid;

-- 내부조인으로 두 테이블의 특정 필드 출력 2
-- 테이블에 중복으로 있는 필드명이 아니면 그대로 필드이름으로 호출이 가능  
SELECT userTbl.userID,  name, addr, 
		prodName, price, amount 
		FROM userTbl
		INNER JOIN buyTbl
        ON userTbl.userid = buyTbl.userid;        
        
-- Error Code: 1052. Column 'userID' in field list is ambiguous 
-- 공통컬럼 userID는 테이블명 생략이 불가능        
SELECT userID,  name, addr, 
		prodName, price, amount 
		FROM userTbl
		INNER JOIN buyTbl
        ON userTbl.userid = buyTbl.userid;

-- INNER JOIN 2 
-- 테이블명에 별칭 지정하기  
-- SELECT * 또는 별칭.컬럼명 
--    FROM 테이블1 테이블별칭1
--      INNER JOIN 테이블2 테이블별칭2
--         ON 조인될조건-별칭1.컬럼명 = 별칭2.컬럼명 이용 
--				(서로 공통된 관계의 컬럼이용)
--    [WHERE 조건절];

-- userTbl + buyTbl 조인시 테이블 별칭 이용하기 
-- U / B
SELECT U.userID,  U.name, U.addr, 
		B.prodName, B.price, B.amount 
		FROM userTbl U
		INNER JOIN buyTbl B
        ON U.userid = B.userid;


-- employees 데이타베이스에서 테이블 조인하기 
USE employees;

-- emp_no, birth_date, first_name, last_name, gender, hire_date
SHOW TABLES;
SELECT * FROM employees;
DESC employees;

-- emp_no, title(부서명) , from_date(부서근무시작일), 
-- to_date(부서근무마지막날짜) 9999-01-01 이면 현재근무중 
SELECT * FROM dept_emp;
DESC dept_emp;

-- employees + dept_emp 테이블 조인하기 
-- 공통 필드는? emp_no
-- 전체 필드 모두 출력 
SELECT * 
   FROM employees E
     INNER JOIN dept_emp D
        ON E.emp_no = D.emp_no
        LIMIT 10;

-- employees + dept_emp 테이블 조인하기 
-- 사원번호, 이름, 성별, 부서번호  필드만  출력 
SELECT 
	E.emp_no AS '사원번호',
	concat(E.first_name, '   ', E.last_name) AS '이름',
    E.gender AS '성별', 
    D.dept_no AS '부서번호'
   FROM employees E
     INNER JOIN dept_emp D
        ON E.emp_no = D.emp_no
        LIMIT 10;

-- employees + dept_emp 테이블 조인하기 
-- 사원번호, 이름, 성별, 부서번호  필드만  출력 
-- 남자 사원만 출력 (gender = 'M') 
-- 전체 레코드 갯수는 10명 
SELECT 
	E.emp_no AS '사원번호',
	concat(E.first_name, '   ', E.last_name) AS '이름',
    E.gender AS '성별', 
    D.dept_no AS '부서번호'
   FROM employees E
     INNER JOIN dept_emp D
        ON E.emp_no = D.emp_no
        WHERE E.gender = 'M'
        LIMIT 10;

-- 퀴즈 
-- employees + titles 테이블 조인하기        
-- 사원번호, 이름, title(부서명), 성별, 입사일 필드
-- 사원이름이 'S'로 시작하는 레코드만 10개 출력
-- 정렬기준은 사원이름 

SELECT * FROM employees;
DESC employees;
SELECT * FROM titles;
DESC employees;

 SELECT 
		E.emp_no AS '사원번호',
		concat(E.first_name, ' ', E.last_name) AS '이름',
        T.title AS '부서명',
		E.gender AS '성별',
		E.hire_date AS '입사일'        
	FROM employees E
	INNER JOIN titles T
	ON E.emp_no = T.emp_no 
      WHERE E.first_name like 'S%' 
      ORDER BY 이름
      LIMIT 10;
      
      
-- 3개의 테이블 조인하기 
-- DB 접속과 3개의 테이블 생성 
-- 학생(stdTbl), 학생동아리(stdclubTbl), 동아리(clubTbl)
-- 학생(stdTbl) : 학생이름, 지역 
-- 학생동아리(stdclubTbl) : 번호, 학생이름, 동아리명
-- 동아리(clubTbl) : 동아리명, 동아리방번호
-- 학생동아리(stdclubTbl) => 학생(stdTbl)
-- 학생동아리(stdclubTbl) => 동아리(clubTbl)    
      
      
USE sqlDB;   
SHOW TABLES;
  
-- 학생(stdTbl) 테이블 생성 - 이름, 지역 
-- stdTbl 테이블이 있다면 삭제 
DROP TABLE IF EXISTS stdTbl;
CREATE TABLE stdTbl 
( stdName  VARCHAR(10) NOT NULL PRIMARY KEY,
  addr	  CHAR(4) NOT NULL
);

DESC stdTbl;      
      
-- 동아리(clubTbl) 테이블 생성
-- 동아리명(clubName)과 동아리방(roomNo) 
DROP TABLE IF EXISTS clubTbl;
CREATE TABLE clubTbl 
( clubName  VARCHAR(10) NOT NULL PRIMARY KEY,
  roomNo    CHAR(4) NOT NULL
);

DESC clubTbl;      

-- 학생동아리(stdclubTbl) 테이블 생성 
-- num(num):int,  stdName(이름):VARCHAR(10), 
-- clubName(동아리명):VARCHAR(10) 
-- 외래키 2개 설정 
-- stdTbl(stdName), clubTbl(clubName)
-- FOREIGN KEY(컬럼명) REFERENCES 외부테이블명(컬럼명)

DROP TABLE IF EXISTS stdclubTbl;
CREATE TABLE stdclubTbl
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   stdName    VARCHAR(10) NOT NULL,
   clubName    VARCHAR(10) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdTbl(stdName),
FOREIGN KEY(clubName) REFERENCES clubTbl(clubName)
);
DESC stdclubTbl;      

SHOW TABLES;

-- 다수의 레코드 삽입하기 
/*
INSERT INTO 테이블명 VALUES (값1, 값2... ), (값1, 값2... ) ... ;
*/

-- 데이타 입력 후 테이블 확인 
INSERT INTO stdTbl 
	VALUES 	('김범수','경남'), 
			('성시경','서울'), 
			('조용필','경기'), 			
			('은지원','경북'),
			('바비킴','서울');

SELECT * FROM stdtbl;

INSERT INTO clubTbl 
	VALUES 
		('수영','101호'), ('바둑','102호'), 
		('축구','103호'), ('봉사','104호');
    
INSERT INTO stdclubTbl 
	VALUES 
		(NULL, '김범수','바둑'), (NULL,'김범수','축구'), 
        (NULL,'조용필','축구'), (NULL,'은지원','축구'), 
        (NULL,'은지원','봉사'), (NULL,'바비킴','봉사');

SELECT count(*) FROM stdTbl; -- 5
SELECT count(*) FROM clubTbl; -- 4
SELECT count(*) FROM stdclubTbl; -- 6

-- 3개의 테이블 조인하기1
-- 학생을 기준으로 학생이름, 지역, 가입 동아리, 동아리방번호 출력 

-- 학생동아리(stdclubTbl) => 학생(stdTbl)
-- 학생동아리(stdclubTbl) => 동아리(clubTbl)

-- stdTbl + stdclubTbl (stdName 공통필드) 
SELECT * FROM stdTbl;
SELECT * FROM stdclubTbl;

SELECT * 
	FROM stdTbl S
    INNER JOIN stdclubTbl SC
    ON S.stdName = SC.stdName;

-- clubTbl + stdclubTbl ( clubname 공통필드) 
SELECT * FROM clubTbl;
SELECT * FROM stdclubTbl;
SELECT * 
	FROM stdclubTbl SC
    INNER JOIN clubTbl C
    ON SC.clubName = C.clubName;

-- 3개의 테이블 조인하기
-- 동아리를 기준으로 가입 동아리, 동아리방번호 , 학생이름, 지역 출력 
-- stdTbl + stdclubTbl + clubTbl

SELECT * 
	FROM stdTbl S
    INNER JOIN stdclubTbl SC
		ON S.stdName = SC.stdName
    INNER JOIN clubTbl C
		ON SC.clubName = C.clubName;

-- 학생이름, 지역, 동아리명, 동아리방번호
SELECT 
	S.stdName AS '학생이름', 
    addr AS '지역', 
    SC.clubName AS '동아리명', 
    RoomNo AS '동아리방 번호'
		FROM stdTbl S
		INNER JOIN stdclubTbl SC
			ON S.stdName = SC.stdName
		INNER JOIN clubTbl C
			ON SC.clubName = C.clubName;

-- 퀴즈 : employees 데이타베이스에서 3개의 테이블 조인 
-- employees + dept_emp + departments 
-- employees => emp_no, birth_date, first_name, last_name, gender, hire_date
-- dept_emp => emp_no, dept_no(부서번호), from_date(부서근무시작일), to_date(부서근무마지막날짜)
-- departments => dept_no(부서번호), dept_name(부서명) 
-- 사원번호, 이름, 부서번호, 부서명, 성별 필드 출력 

-- 전체 필드 표시 
USE employees;
SELECT * 
	FROM dept_emp DE
		INNER JOIN employees E ON DE.emp_no = E.emp_no
        INNER JOIN departments D ON DE.dept_no = D.dept_no;
        
-- 사원번호, 이름, 부서번호, 부서명, 성별 필드 출력 
SELECT 
	DE.emp_no AS '사원번호',
    concat(E.first_name,' ', E.last_name) AS '사원이름',
    D.dept_no AS '부서번호',
    D.dept_name AS '부서명',
    E.gender AS '성별'
		FROM dept_emp DE
		INNER JOIN employees E ON DE.emp_no = E.emp_no
        INNER JOIN departments D ON DE.dept_no = D.dept_no
    LIMIT 10;

-- #################################
-- 외부조인 (OUTER JOIN)
-- 조인의 조건에 만족되지 않는 행까지도 포함시킨다. 

-- SELECT * 또는 컬럼명 
--    FROM 테이블1
--      <LEFT/RIGHT> OUTER JOIN 테이블2
--         ON 조인될조건:테이블1.컬럼명 = 테이블2.컬럼명 이용 
--				(서로 공통된 관계의 컬럼이용)
--    [WHERE 조건절];

USE sqldb;

-- 전체 회원 아이디 
SELECT count(userID) FROM usertbl; -- 10 
-- 중복없이 회원아이디만 표시 
SELECT DISTINCT userID FROM usertbl;
SELECT count(DISTINCT userID) FROM usertbl; -- 10

--  이너조인 (buytbl+usertbl)
SELECT * 
	FROM buytbl B
    INNER JOIN userTbl U
    ON B.userID = U.userID
    ORDER BY B.userID;

-- 12
SELECT COUNT(*) 
	FROM buytbl B
    INNER JOIN userTbl U
    ON B.userID = U.userID
    ORDER BY B.userID;
    
-- 이너조인한 테이블에서 userID를 중복없이 출력하기 
SELECT DISTINCT U.userID 
	FROM buytbl B
    INNER JOIN userTbl U
    ON B.userID = U.userID
    ORDER BY B.userID;
    
-- LEFT OUTER JOIN
-- 전체회원의 구매기록 확인하기.
-- 구매기록이 없는 회원도 모두 출력되어야 한다.
-- 왼쪽에 정의된 테이블 userTbl의 레코드가 모두 표시되어야한다.  

SELECT * 
	FROM userTbl U
    LEFT OUTER JOIN buytbl B
    ON U.userID = B.userID
    ORDER BY U.userID;

-- 12 + 5 = 17    
SELECT count(*)
	FROM userTbl U
    LEFT OUTER JOIN buytbl B
    ON U.userID = B.userID
    ORDER BY U.userID;   
    

-- RIGHT OUTER JOIN
-- 오른쪽에 해당하는 테이블의 레코드가 모두 표시된다. 

SELECT *
	FROM userTbl U
    RIGHT OUTER JOIN buytbl B
    ON U.userID = B.userID
    ORDER BY U.userID; 
    
SELECT COUNT(*)
	FROM userTbl U
    RIGHT OUTER JOIN buytbl B
    ON U.userID = B.userID
    ORDER BY U.userID;      
    
SELECT *
	FROM buytbl B
    RIGHT OUTER JOIN userTbl U
    ON B.userID = U.userID
    ORDER BY U.userID;     
    
SELECT count(*)
	FROM buytbl B
    RIGHT OUTER JOIN userTbl U
    ON B.userID = U.userID
    ORDER BY U.userID;   
    
    
    
-- stdTbl, clubtbl, stdclubtbl 테이블에서 
-- 학생을 기준으로 동아리 학생 목록을 LEFT OUTER JOIN을 이용하여 출력하여라. 
-- 이때 동아리에 가입하지 않은 학생 목록도 출력한다.

SELECT * FROM stdTbl;
SELECT * FROM stdclubtbl;
SELECT * FROM clubtbl;

-- stdTbl + stdclubTbl + clubTbl 3개 테이블 이너 조인 
-- 전체 필드 
SELECT  * 
    FROM stdTbl S
	INNER JOIN  stdclubTbl SC
		ON S.stdName = SC.stdName
    INNER JOIN  clubTbl C
		ON SC.clubName = C.clubName;  

-- stdTbl, clubtbl, stdclubtbl 테이블에서 
-- 학생을 기준으로 동아리 학생 목록을 LEFT OUTER JOIN을 이용하여 출력하여라. 
-- 이때 동아리에 가입하지 않은 학생 목록도 출력한다.

SELECT * FROM stdTbl;
SELECT * FROM stdclubtbl;
SELECT * FROM clubtbl;

-- 6 
SELECT  count(*)
    FROM stdTbl S
	INNER JOIN  stdclubTbl SC
		ON S.stdName = SC.stdName
    INNER JOIN  clubTbl C
		ON SC.clubName = C.clubName;  

-- 동아리에 가입한 학생 목록을 출력하여라   
SELECT  *
    FROM stdTbl S
	INNER JOIN  stdclubTbl SC
		ON S.stdName = SC.stdName
    INNER JOIN  clubTbl C
		ON SC.clubName = C.clubName;  
        

-- 동아리에 가입하지 않은 학생 목록을 출력하여라     
SELECT  *
    FROM stdTbl S
	LEFT OUTER JOIN  stdclubTbl SC
		ON S.stdName = SC.stdName;

-- 7         
SELECT  count(*)
    FROM stdTbl S
	LEFT OUTER JOIN  stdclubTbl SC
		ON S.stdName = SC.stdName;     
        
-- stdTbl + stdclubTbl + clubTbl 
-- 학생테이블(stdTbl)을 기준으로 아우터 조인        
SELECT  *
    FROM stdTbl S
	LEFT OUTER JOIN  stdclubTbl SC
		ON S.stdName = SC.stdName
    LEFT OUTER JOIN  clubTbl C
		ON SC.clubName = C.clubName;          
        
-- 동아리에 가입하지 않은 학생이름은?
SELECT  S.stdName
    FROM stdTbl S
	LEFT OUTER JOIN  stdclubTbl SC
		ON S.stdName = SC.stdName
    LEFT OUTER JOIN  clubTbl C
		ON SC.clubName = C.clubName
	WHERE SC.stdName IS NULL;     

-- 셀프 조인(자체 조인) 
-- INNER JOIN의 일종. 같은 테이블을 조인한다. 
-- 조직도등에 이용  

-- empTbl
-- 사원, 상관이름, 구내번호
USE sqldb;
DROP TABLE IF EXISTS empTbl;
CREATE TABLE empTbl 
	(emp CHAR(4), manager CHAR(4), empTel VARCHAR(8));

SHOW TABLES;

INSERT INTO empTbl VALUES('나사장',NULL,'0000');
INSERT INTO empTbl VALUES('김재무','나사장','2222');
INSERT INTO empTbl VALUES('김부장','김재무','2222-1');
INSERT INTO empTbl VALUES('이부장','김재무','2222-2');
INSERT INTO empTbl VALUES('우대리','이부장','2222-2-1');
INSERT INTO empTbl VALUES('지사원','이부장','2222-2-2');
INSERT INTO empTbl VALUES('이영업','나사장','1111');
INSERT INTO empTbl VALUES('한과장','이영업','1111-1');
INSERT INTO empTbl VALUES('최정보','나사장','3333');
INSERT INTO empTbl VALUES('윤차장','최정보','3333-1');
INSERT INTO empTbl VALUES('이주임','윤차장','3333-1-1');

SELECT * FROM empTBL;
SELECT COUNT(*) FROM empTBL; -- 11


-- 직원의 상관의 구내번호를 찾아라 
-- 직원(emp), 상관(manager), 구내번호(empTel) 
-- 가로로 2번 컬럼이 반복되어 표시 

SELECT * FROM empTBL;
-- 전체 필드 출력 
SELECT * 
	FROM empTbl A
    INNER JOIN empTbl B
    ON A.manager = B.emp; 

-- 사원명, 상관명, 상관의상관명, 사원구내번호, 상관구내번호
SELECT 	A.emp As '사원명', 
		A.manager AS '상관명', 
        A.empTel AS '사원구내번호', 
        B.manager AS '상관의 상관명', 
        B.empTel AS '상관구내번호'
	FROM empTbl A
    INNER JOIN empTbl B
    ON A.manager = B.emp; 

-- 우대리 직원의 상관의 구내번호를 찾아라 
SELECT 	A.emp As '사원명', 
		A.manager AS '상관명', 
        A.empTel AS '사원구내번호', 
        B.manager AS '상관의 상관명', 
        B.empTel AS '상관구내번호'
	FROM empTbl A
    INNER JOIN empTbl B
    ON A.manager = B.emp
    WHERE A.emp = '우대리'; 

SELECT 	B.empTel AS '상관구내번호'
	FROM empTbl A
    INNER JOIN empTbl B
    ON A.manager = B.emp
    WHERE A.emp = '우대리'; 
    
-- 최정보 사원의 상관이름과 상관의 연락처를 출력하여라     
SELECT 	
	A.manager AS '상관명',
	B.empTel AS '상관구내번호'
		FROM empTbl A
    INNER JOIN empTbl B
    ON A.manager = B.emp
    WHERE A.emp = '최정보';     
    
-- UNION / UNION ALL 
-- 쿼리의 결과를 합쳐서 보여준다. 
-- UNION 중복 X
-- UNION ALL 중복 허용 

-- SELECT ... -- 쿼리1
-- UNION
-- SELECT ... -- 쿼리2

SELECT * FROM clubtbl; -- 동아리정보 
SELECT * FROM stdtbl; -- 학생정보 
-- 첫번째 쿼리의 컬럼 아래에 두번째 쿼리의 컬럼 내용이 추가된다. 
SELECT stdName AS '학생이름 + 동아리이름' FROM stdtbl
UNION
SELECT clubName AS ' 동아리이름' FROM clubtbl;     
    
SHOW TABLES;  
SELECT * FROM stdclubtbl;  
    
-- UNION ALL 중복 허용 
SELECT clubName AS '동아리이름' FROM stdclubtbl
UNION ALL
SELECT clubName AS '동아리이름' FROM clubtbl;    

-- UNION 중복 X
SELECT clubName AS '동아리이름' FROM stdclubtbl
UNION
SELECT clubName AS '동아리이름' FROM clubtbl;  