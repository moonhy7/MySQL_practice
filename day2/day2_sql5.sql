
-- SQL 퀴즈 

use sqldb;

-- 1) userTBL 테이블에서 구조만 복사하여 userTbl_sample 테이블을 생성하여라. 
-- CREATE TABLE IF NOT EXISTS 테이블명1
-- 		(SELECT */필드명... FROM 테이블명2 WHERE절);
-- WHERE절에 만족하는 레코드가 없다면 구조만 복사 

-- 2) userTbl_sample에 아래  데이터를 참조하여 데이터를 삽입하고 출력하여라.
/*
USERID   USERNAME    BIRTHYEAR      ADDR  MOBILE1 MOBILE2    HEIGHT       MDATE   

PJM			박지민	  1995			경남		010	22222222	173			2016-04-04
KSJ			김석진	  1993			경기						186			2015-04-04
KJD			김자두	  1997			전남		010	33333333	162			2017-07-07
GGD			고길동	  1995			서울		010	11111111	165			2018-08-08
*/

-- 3) userTbl 테이블에서 휴대폰 번호가 011로 시작하는 레코드만 userTbl_sample로 복사하여라. 

-- 4) userTbl_sample 테이블에서 ADDR 컬럼값이 경남인 경우 경남을 부산으로 데이터값을 수정하여라.

-- 5) userTbl_sample 테이블에서 MOBILE1과 MOBILE2 값이 NULL 인 경우 019, 55555555 값으로 수정하여라.

-- 6) userTbl_sample 테이블에서 레코드를 이름순으로 정렬한 후 복사하여 userTbl_sample2 테이블을 생성하여라. 

-- 7) userTbl_sample2 테이블에서 국번이 011인 데이터를 삭제하여라

-- 8) userTbl_sample2 테이블에서 모든 레코드를 삭제하여라. 

-- 9) userTbl_sample1, userTbl_sample3 테이블을 모두 삭제하여라.  

