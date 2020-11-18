------------------------------------------------------------
-- 날짜와 문자열에 대한 명령
------------------------------------------------------------

select '2020-11-18' from dual;

select to_char(regist_date, 'YYYY-MM-DD') from person;
select to_char(regist_date, 'YYYY-MM-DD HH24:MI:SS') from person;
select to_char(regist_date, 'HH24:MI') from person;
select to_char(regist_date, 'YYYY.MM.DD') from person;
select to_char(regist_date, 'YYYY"년" MM"월" DD"일"') from person;

-- gender가 여자면 F, 남자면 M으로 출력
 select person_name, gender from person;
 select person_name, decode(gender, '남자', 'M', '여자', 'F', 'extra') "성별" from person;
 
 -- 2020년 데이터는 HH24:MI, 2019년 데이터는 YYYY-MM-DD로 출력
  select 
    person_name,
    decode( 
        extract(year from regist_date), 
        2019, to_char(regist_date, 'YYYY-MM-DD'),
        2020,to_char(regist_date, 'HH24:MI'),'?') 
    from person;
        
 select 
    person_name,
    decode(
        to_char(regist_date, 'YYYY'), 
        '2019', to_char(regist_date, 'YYYY-MM-DD'),
        '2020',to_char(regist_date, 'HH24:MI'),'?')
    from person;
    
select
    person_name,
    case to_char(regist_date, 'YYYY')
        when '2020' then to_char(regist_date, 'HH24:MI')
        when '2019' then to_char(regist_date, 'YYYY-MM-DD')
        else to_char(regist_date, 'YYYY-MM-DD HH24:MI:SS')
    end 가입일
from person;

select
person_name,
case to_char(regist_date, 'YYYY-MM-DD')
	when to_char(sysdate, 'YYYY-MM-DD')
		then to_char(regist_date, 'HH24:MI')
	else to_char(regist_date, 'YYYY-MM-DD')
end 가입일
from person;
select
person_name,
case to_char(regist_date, 'YYYY-MM-DD')
	when to_char(sysdate, 'YYYY-MM-DD')
		then to_char(regist_date, 'HH24:MI')
	else to_char(regist_date, 'YYYY-MM-DD')
end 가입일 from person;

-------------------------------------------------------------------------------
--테이블 제약조건(table constraint)
--목표: 내가 원하는 데이터만 저장할 수 있도록 조건 설정 (Java 접근제한자와 같은기능)
-------------------------------------------------------------------------------

--문제 상황
create table test1( 
  emp_no number, --사원번호
  emp_name varchar2(30), --사원이름 (대충 10글자로)
  dept varchar2(30), --부서명(=)
  salary number, --급여
  position varchar2(30),--직급
  enter date--입사일
);

-- 상황1 : 비어있는 데이터(오라클은 ''과 null 모두 비어있다고 생각)
insert into test1 values('', null, null, null, null, null);
select * from test1;

truncate table test1;
-- 상황2 : 중복 데이터
insert into test2 values(
1, 'Alice', '경영지원팀', 2000000, '사장', to_date('2010-01-01', 'YYYY-MM-DD'));

-- 상황3 : 지정하지 않은 데이터의 추가

-- 대표항목?(대표항목이면 검색속도가 빨라짐. 유일한 항목이면서 반드시 있어야 함)
-- => 사원번호 (만약 그런 항목이 여러개라면 그 중에서 선택)

-- 기본값 : ex)기본직급, 입사일오늘.. 

--테이블에 조건을 추가하여 문제 상황을 개선!
drop table test2;
create table test2( 
    emp_no number primary key, -- 대표항목( => 필수, 구분 포함됨)
    emp_name varchar2(30) not null, -- 필수
    dept varchar2(30) check(dept in ('개발','영업','기획')),
    salary number check(salary >= 0), --원하는 조건 설정
    position varchar2(30) default '프로' not null check(position in ('오너','프로')), --필수
    enter date default sysdate not null --기본값, 필수
);
insert into test2 values(2, 'Mary', '개발', 2000000, position, enter);


