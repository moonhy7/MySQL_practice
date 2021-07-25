-- 함수, 조인 영역 퀴즈중에서 50% 이상 퀴즈 풀어서 제출하시면 됩니다. 
-- 채팅창이나 메일로 전송. 
-- day3_sql_본인이름.sql 

-- 퀴즈 : 함수

-- Q1. employees 테이블에서 문자열 함수를 이용하여 다음과 같이 7개의 레코드만 정렬시켜 출력하여라.
-- 정렬 기준은 emp_no 사원번호 기준이다. 

        
/*
사원번호   이름                   생년월일   
499999	Sachin  Tsukuda			1958-05-01
499998	Patricia  Breugel		1956-09-05
499997	Berhard  Lenart			1961-08-03
499996	Zito  Baaz				1953-03-07
499995	Dekang  Lichtner		1958-09-24
499994	Navin  Argence			1952-02-26
499993	DeForest  Mullainathan	1963-06-04
*/        



-- Q2. employees 테이블에서 문자열 함수를 이용하여 birth_date 필드값이 
-- ????년 ??-?? 형태로 출력되도록 하여라. 
-- 정렬 기준은 first_name 기준이다. 

/*
emp_no  first_name	last_name    	birth_date        

11935	Aamer		Jayawardene		1963년  03-23
12160	Aamer		Garrabrants		1954년  12-11
15332	Aamer		Slutz			1961년  12-29
11800	Aamer		Fraisse			1958년  12-09
13011	Aamer		Glowinski		1955년  02-25
*/


        
-- Q3. employees 테이블에서 문자열 함수를 이용하여 hire_date 필드값에서
-- '-'를 '__'으로 교체하여 출력되도록 하여라.  
-- REPLACE(문자열, 원래문자열, 교체문자열)

/*
emp_no  first_name	last_name   hire_date 	         
10001	Georgi		Facello		1986__06__26
10002	Bezalel		Simmel		1985__11__21
10003	Parto		Bamford		1986__08__28
*/




-- Q4. employees 테이블에서 문자열 함수를 이용하여 다음과 같이 출력되도록 하여라. 
--     입사년도의 경우 년도만 출력되도록한다. 

/*
사원명           성별  입사년도
Georgi Facello	M	1986 년
Bezalel Simmel	F	1985 년
Parto Bamford	M	1986 년
...
*/




-- Q5. employees 테이블에서 문자열 함수를 이용하여 다음과 같이 출력되도록 하여라. 
--  first_name 필드값의 경우  첫글자 외에서 '*' , 
--  last_name 필드값의 경우 모든 글자를 '*'로 표시한다. 


/*
emp_no  first_name  last_name  gender  	hire_date

10001	G*****		*******		M		1986-06-26
10002	B******		******		F		1985-11-21
10003	P****		*******		M		1986-08-28

*/




-- Q6. employees 테이블에서 문자열 함수를 이용하여 다음과 같이 출력되도록 하여라. 
--  성별(gender) 필드값을 M,F를 남자,여자 로 표시한다.

-- IF(조건식, 값1, 값2)
-- 조건식이 True 이면 값1, False 이면 값2 반환 
/*
사원번호   생년월일        사원명          성별    입사일 
10001	1953-09-02	Georgi Facello	남자	 1986-06-26
10002	1964-06-02	Bezalel Simmel	여자	 1985-11-21
10003	1959-12-03	Parto Bamford	남자	 1986-08-28
*/



-- Q7. employees 테이블에서 가장 최근에 입사한 사람 3명만 출력하시오



-- Q8. employees 테이블에서  1999년에 입사한 직원 중 여자 직원(GENDER='F') 리스트를 구하시오.


-- Q9. employees 테이블에서  1999년에 입사한 직원 중 남자 직원(M)은 몇 명인가?


-- Q10. employees 테이블에서   1998년이나 1999년에 입사한 직원의 수를 구하시오.



-- world 데이타베이스 이용 
-- Q11. country 테이블에서 독립년도(IndepYear)가 NULL인 경우 '알수없음' 으로 표시하여라.

/*
  국가      독립년도
  ?        알수없음'
  ?          ?
  ?          ?
*/


    
    
-- world 데이타베이스 이용 
-- Q12.  country 테이블에서 독립년도(IndepYear)가 음수로 표시된 레코드의 필드값을
-- 'BC' 와 함께 연도를 표시하여라
/*
  국가         독립년도
  China     BC.1523
    ?            ?
    ?            ?
*/




-- ##################################
-- 퀴즈 : 조인
-- 1. 현재 근무 중인 직원 정보를 출력하시오.(employees 테이블과 dept_emp 테이블 조인 )
-- 현재 근무 중은? to_date='9999-01-01'
/*
사원번호  이름  성별   입사일(hire_date)  현재 근무중
  ?      ?   ?           ?       9999-01-01
*/



-- 2. 현재 근무 중인 직원의 모든 정보(수행업무 포함) 를 출력하시오.
-- 현재 근무 중은? to_date='9999-01-01'
-- Step1 : employees 테이블과 title 테이블 조인
-- Step2 : 1의 조인 명령 마지막에 WHERE 조건절 추가
/*
사원번호  이름   직무(title)  현재 근무중
  ?      ?        ?     9999-01-01
*/







-- 3. 현재 근무 중인 부서명를 출력하시오. (사원번호, 사원명, 부서코드, 부서명)
-- 3개의 테이블 조인
-- Step1 : dept_emp , employees, departments 테이블에서
-- Step2 : 1의 조인 명령 마지막에 WHERE 조건절 추가
/*
사원번호  사원명  부서코드(dept_no)  부서명(dept_name)  현재 근무중
  ?      ?        ?               ?         9999-01-01

*/

use employees;
select * from departments;


-- 4. 가장오래 근무한 직원 10명의 현재 부서를 출력하시오.
-- 3개의 테이블 조인
-- Step1 : dept_emp , employees, departments 테이블에서
-- Step2 : 1의 조인 명령 마지막에 WHERE 조건절 추가
-- Step3 : ORDER BY hire_date 정렬 옵션과 LIMIT 10 출력레코드 수 추가

/*
사원번호  사원명  부서명(dept_name)  입사일(hire_date)
  ?      ?        ?               ?

*/




-- 5. 현재 근무중인 부서별로 직원수와 부서 이름도 함께 출력하시오.
-- 2개의 테이블 조인
-- Step1 : dept_emp , departments 테이블에서
-- Step2 : 1의 조인 명령 마지막에 WHERE 조건절 추가
-- Step3 : group by, count() 이용

/*
부서명(dept_name)  직원수
        ?           ?

*/



-- 6. 현재 근무중인 사원을 기준으로 부서별로 성별 인원수를 표시하여라. 이때 부서 이름도 함께 출력한다.
-- 3개의 테이블 조인
-- Step1 : dept_emp , departments, employees 테이블에서
-- Step2 : 1의 조인 명령 마지막에 WHERE 조건절 추가
-- Step3 : group by, count() 이용

/*
  부서명    성별   직원수
  Sales    M     ?
  Sales    F     ?
  ...
*/




--  7. 현재 근무중인 사원을 기준으로 급여 평균이 가장 높은 부서 3개만 출력하여라
-- Step1 : dept_emp + departments + salaries 테이블에서
-- Step2 : 1의 조인 명령 마지막에 WHERE 조건절 추가
-- Step3 : group by , avg() 이용
/*
부서명              평균급여
   ?                ?
   ?                ?
   ...
*/




