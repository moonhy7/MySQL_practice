-- 퀴즈 : 
-- 10문제 정도만 작성하시고 보내주시면 됩니다. coderecipe@naver.com 
-- 또는 채팅창으로 전송 


USE sqldb;

-- 1) buyTbl 테이블의 구조를 출력하여라.
DESC buytbl;

-- 2) buyTbl 테이블에서 userID, prodName 컬럼만 출력하여라.
SELECT userID, prodName FROM buytbl;
 
-- 3) buyTbl 테이블에서 userID가 'KBS'인 레코드만 출력하여라.
SELECT userID, prodName FROM buytbl
               WHERE userID = 'KBS';

-- 4) buyTbl 테이블에서 prodName 컬럼을 중복없이 출력하여라.
-- SELECT prodName From buytbl;

SELECT DISTINCT prodName From buytbl;
-- 갯수 확인 
-- SELECT COUNT(DISTINCT prodName) From buytbl;


-- 5) buyTbl 테이블에서 groupName이 NULL인 레코드를 출력하여라. (IS NULL 이용)
SELECT * From buyTbl WHERE groupName IS NULL; 

-- 6) buyTbl 테이블에서 amount가 5보다 큰 레코드를 출력하여라.
SELECT * FROM buytbl 
        WHERE amount > 5;
        

-- 7) buyTbl 테이블에서 prodName 컬럼이 '청바지' 이거나 '운동화'인 레코드 출력구문을 
-- 2가지로 방법으로 작성하여라.
-- (OR, IN 사용)

SELECT * FROM buyTbl WHERE (prodName = "청바지") OR (prodName = "운동화"); 
SELECT * FROM buyTbl WHERE prodName IN ("청바지", "운동화"); 


-- 8) buyTbl 테이블에서 price 컬럼값이 30~80인 레코드 출력구문을 
-- 2가지로 방법으로 작성하여라.
-- (AND 구문, BETWEEN .. AND 구문 이용)

SELECT * FROM buytbl 
        WHERE price >= 30 AND  price <= 80;  

SELECT * FROM buytbl 
        WHERE price BETWEEN 30 AND 80;
        

-- 9) buyTbl 테이블에서 userID에 'K'로 시작하는 레코드를 출력하여라. (LIKE 이용)

SELECT * FROM buytbl WHERE userID LIKE 'K%';
SELECT * FROM buytbl WHERE userID LIKE 'K__';

-- 10) buyTbl 테이블에서 prodName이 ??화로 끝나는 레코드를 출력하여라. (LIKE 이용)
SELECT * FROM buytbl WHERE prodName LIKE '__화';

-- 11) buyTbl 테이블에서 userID 컬럼값이 'JYP'인 price 컬럼값 보다 큰 레코드를 출력하여라.
-- (서브쿼리 이용)

-- select price from buytbl where userID = 'JYP';

SELECT * FROM buytbl WHERE price > ( select 
										price from buytbl 
												where userID = 'JYP'
									);
                                    

    
-- 12) buyTbl 테이블에서 userID 컬럼값이 'JYP'인 amount 컬럼값과 같은 레코드를 출력하여라.
-- (서브쿼리 이용)

select * from buytbl where amount = (
                     select amount from buytbl where userID = 'JYP'
                           );
                           

-- 13) buyTbl 테이블에서 price 컬럼값이 큰 순서대로 5개만 레코드를 출력하여라.
-- (ORDER BY, LIMIT) 이용

select * from buytbl order by price desc limit 5;


-- 14) buyTbl 테이블에서 userID 컬럼값이 'KBS'인 레코드 목록 중 
-- price 컬럼값이 가장 작은 레코드를 출력하여라.
-- (WHERE, ORDER BY, LIMIT) 이용

select * from buytbl where userID = 'KBS' 
					order by price limit 1;

-- 15) userTbl 테이블에서 addr 컬럼값이 '서울'인 레코드만 복사해서 새로운 테이블로 생성하는 
-- 코드를 완성하여라. 
-- (CREATE TABLE ~) 이용
create table userTbl1 (
                  select * from usertbl where addr = '서울'
                  );

-- 16) userTbl 테이블에서 name 컬럼값이 '은지원'인 레코드의 height 컬럼값보다 
--  큰 레코드만 height 값을 기준으로 정렬하여 복사해서 새로운 테이블로 생성하는 
-- 코드를 완성하여라. 
-- (CREATE TABLE ~) 이용

-- select height from usertbl where name = '은지원';

-- select * from usertbl where height > (
-- 				select height from usertbl where name = '은지원')
--                 order by height;

CREATE TABLE usertbl2  (
						select * from usertbl where height > (
								select height from usertbl where name = '은지원')
							order by height);               

show tables;
SELECT * FROM usertbl2;



-- 17) buyTbl 테이블에서 price 컬럼의 값을 중복없이 출력하여라.
-- (DISTINCT, ORDER BY) 이용

SELECT DISTINCT price FROM buytbl ORDER BY price DESC;

-- 18) 17번의 레코드 결과에서 2번째로 큰 가격의 값은? (내용 수정)
-- (ORDER BY, LIMIT) 이용
SELECT DISTINCT price FROM buytbl ORDER BY price DESC LIMIT 1,1;


-- 19) buyTbl 테이블에서 18번의 결과 가격값과 동일한 가격값을 갖는 레코드를 모두 출력하여라. 
-- (WHERE, ORDER BY, LIMIT, 서브쿼리) 이용

SELECT * FROM buytbl WHERE price = (
						SELECT DISTINCT price 
						FROM buytbl ORDER BY price DESC 
						LIMIT 1,1);

    


