-- table booklist
-- 

create table booklist (
    book_no number, -- primary key
    ISBN varchar2(13), --unique, not null
    title varchar2(60), --not null
    price number(7), --
    author varchar(30), --not null
    release_date date --
);
create sequence book_seq;
