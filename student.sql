drop table member;
drop SEQUENCE member_seq;
create table member (
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20),
    MEMBER_PW VARCHAR(20),
    MEMBER_NICK VARCHAR(20),
    MEMBER_POINT NUMBER(7),
    JOIN_DATE DATE
);
create sequence member_seq;
---- 데이터 추가

insert into member(member_no,member_id,member_pw,member_nick,member_point, join_date)
values(MEMBER_SEQ.nextval, 'tester', 'test1234', '테스트유저', 500, to_date('2019-05-01', 'YYYY-MM-DD'));

insert into member(member_no,member_id,member_pw,member_nick,member_point, join_date)
values(MEMBER_SEQ.nextval, 'admin', 'admin1234', '관리자', 999999, to_date('2019-01-01', 'YYYY-MM-DD'));

insert into member(member_no,member_id,member_pw,member_nick,member_point, join_date)
values(MEMBER_SEQ.nextval, 'student', 'student', '학생', 1000, to_date('2019-03-01', 'YYYY-MM-DD'));

insert into member(member_no,member_id,member_pw,member_nick,member_point, join_date)
values(MEMBER_SEQ.nextval, 'master', 'master', '사장', 50000, to_date('2020-05-05', 'YYYY-MM-DD'));

select * from member;

-- 포인트가 1000점 이하인 회원 조회
select * from member where member_point <= 1000;

-- 포인트가 1000점 이상 2000점 이하인 회원 조회
select * from member where member_point >= 1000 AND member_point <=2000;

-- 아이디가 admin인 회원 조회
select * from member where member_id ='admin';

-- 닉네임에 "관리"라는 글자가 포함된 회원 조회
select * from member where instr(member_nick, '관리') > 0;

-- 포인트가 가장 많은 회원의 모든 정보를 조회
select * from (
select * from member order by member_point desc
)where rownum = 1;

-- 회원을 최근에 가입한 순으로 정렬하여 조회
select * from member order by join_date asc;

-- 회원을 포인트가 많은 순으로 정렬하여 조회
select * from member order by member_point desc;

-- 연도별 회원의 보유 포인트 합계를 조회
select 연도, sum(member_point) from (
    select member.*, extract(year from join_date) "연도" from member
)
group by 연도
order by 연도;

-- 모든 회원에게 포인트 50점 부여
update member set member_point = member_point+50;

-- 2019년에 가입한 회원에게 포인트 500점 부여 
update member set member_point = member_point+500 where
    extract(year from join_date) = 2019;

select * from member;
commit;