--설명 예제
drop table gym_test;
create table gym_test(
    
    member_id       varchar2(20),
    member_pw       varchar2(20),
    member_name     varchar2(20)
);

drop sequence gym_test_seq;
create sequence gym_test_seq;

insert into gym_test(member_id, member_pw, member_name) 
values ( '홍길동', '글 제목1', '글 내용1');

select * from gym_test;
select * from gym_test where member_idx=1;

UPDATE gym_test SET member_id='박길동', member_pw='ㅇㅇㅇ', member_name='111';

drop table gym_test2;
create table gym_test2(
    
    test_idx       varchar2(20),
    test_pw       varchar2(20),
    test_value1     number(20),
    test_member_idx    number(4) references gym_member(member_idx) on delete cascade
);

insert into gym_test2(test_idx, test_pw, test_value1,test_member_idx) 
values ( '홍길동', '글 제목1', 10000,1);
insert into gym_test2(test_idx, test_pw, test_value1,test_member_idx) 
values ( '백길동', '글 제목2', 10000,2);
insert into gym_test2(test_idx, test_pw, test_value1,test_member_idx) 
values ( '홍길동', '글 제목1', 10000,1);
insert into gym_test2(test_idx, test_pw, test_value1,test_member_idx) 
values ( '홍길동', '글 제목1', 10000,1);

select sum(test_value1) from gym_test2 where test_member_idx = 1;