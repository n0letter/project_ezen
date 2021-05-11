-- 굿초이스 db 만들기

-- 1. 이승운

-- 회원 가입 정보
drop table gym_member;
create table gym_member(
    member_idx      number(4) primary key,
    member_id       varchar2(20),
    member_pw       varchar2(20),
    member_name     varchar2(20),
    member_birth_date      varchar2(20), 
    member_gender          varchar2(10),
    member_phone           varchar2(20),
    member_email           varchar2(100),
    member_email_receive   number(10), -- 0:비수신 1:수신
    member_coupon01        number(10) default 0,
    member_coupon02        number(10) default 0,
    member_locker          number(10) default 0,
    member_pay_sum         number(20) default 0,
    member_agree           varchar2(10), -- N:비동의 Y:동의
    member_join_date       date default sysdate
);

drop sequence gym_member_seq;
create sequence gym_member_seq;

-- 탈퇴 회원 등록 정보
drop table gym_out_member;
create table gym_out_member(
    out_member_idx        number(4) primary key,
    out_member_id         varchar2(20),
    out_member_name       varchar2(20),
    out_member_pay_sum    varchar2(20),
    out_member_join_date  varchar2(30), 
    out_member_reason     varchar2(100),
    out_member_opinion    varchar2(1000),
    out_member_date       date default sysdate,
    out_member_date12     date
);

drop sequence gym_out_member_seq;
create sequence gym_out_member_seq;

--insert into board(board_idx, board_name, board_title, board_content, board_date) 
--values (board_seq.nextval, '홍길동', '글 제목1', '글 내용1', sysdate);


-- 2. 이수지

-- 회원권 구매 정보
drop table gym_pay;
create table gym_pay(
  pay_idx             number(4) primary key, 
  pay_id              varchar2(30),
  pay_name            varchar2(30),
  pay_membership      varchar2(40),
  pay_coupon_num      number(4),
  pay_amount          number(20),
  pay_start_date      varchar2(30),
  pay_end_date        varchar2(30),
  pay_payment_date    date default sysdate,
  pay_member_idx      number(4) references gym_member(member_idx) on delete cascade
);

drop sequence gym_pay_seq;
create sequence gym_pay_seq;   

-- 1:1문의 게시글 정보
drop table gym_inquiry;
create table gym_inquiry(
  inq_idx             number(4) primary key,     
  inq_type            varchar2(20),
  inq_title           varchar2(100),
  inq_name            varchar2(20),
  inq_content         varchar2(700), 
  inq_state           varchar2(30),
  inq_re_content      varchar2(500), 
  inq_date            date default sysdate,
  inq_member_idx      number(4) references gym_member(member_idx) on delete cascade
);

drop sequence gym_inquiry_seq;
create sequence gym_inquiry_seq; 

-- FAQ 게시글 정보
drop table gym_faq;
create table gym_faq(
  faq_idx             number(4) primary key,     
  faq_title           varchar2(100),
  faq_content         varchar2(1000),
  faq_date            date default sysdate
);

drop sequence gym_faq_seq;
create sequence gym_faq_seq; 

insert into gym_faq(faq_idx, faq_title, faq_content, faq_date) 
values (gym_faq_seq.nextval, '헬스장 운영시간 및 휴일은 언제인가요?', 
'굿초이스 헬스장은 평일 24시간, 연중무휴 오픈을 원칙으로 운영하고 있습니다. 
 단, 지점 재정비 등 부득이 하게 휴관을 해야하는 경우 회원님들께
 사전 공지해드립니다.', sysdate);
insert into gym_faq(faq_idx, faq_title, faq_content, faq_date) 
values (gym_faq_seq.nextval, '회원권 이용 요금이 궁금합니다.', 
'굿초이스 헬스장은 회원권 종류에 따라 이용 요금이 다르게 책정됩니다.
 ※ 일반회원권 1개월-5만원, 3개월-13만원, 6개월-22만원, 12개월-37만원.
 스페셜회원권(3개월) 그룹PT-40만원, 필라테스-45만원, 골프-56만원 입니다. ※', sysdate);
insert into gym_faq(faq_idx, faq_title, faq_content, faq_date) 
values (gym_faq_seq.nextval, ' 퍼스널 트레이닝(P.T) 가격과 신청방법이 궁금합니다.', 
'굿초이스 헬스장은 트레이너의 경력,역량에 따라 트레이너 레벨을 구분하고 있으며,
 레벨 별 퍼스널 트레이닝 금액이 상이합니다. 수업은 50분 기준으로 진행되며,
 등록하는 세션에 따라 할인율이 달라질 수 있습니다. 따라서 신청을 위해 지점으로
 직접 방문하여 맞춤 상담을 받아보시기를 추천드립니다.', sysdate);
insert into gym_faq(faq_idx, faq_title, faq_content, faq_date) 
values (gym_faq_seq.nextval, '운동복과 개인사물함을 꼭 신청해야 하나요?', 
'운동복과 개인 사물함 필수가 아닌 선택 서비스입니다. 저희 굿초이스 헬스장에서는 
 회원님들께 편의를 드리고자 모두 무료로 대여해드리고 있습니다.
 회원권 시작후 첫 방문시 데스크에 오시면 개인사물함 번호와 함께 열쇠를 지급해드리며,
 회원권이 끝나고 반드시 열쇠를 반납해주셔야 됩니다. 
 ※ 열쇠 분실시 3만원을 지불해야 하므로 주의해주세요! ※', sysdate);
insert into gym_faq(faq_idx, faq_title, faq_content, faq_date) 
values (gym_faq_seq.nextval, '개인적으로 준비해야 할 부분이 있을까요?', 
'샤워 용품센터에서는 수건과 비누를 제공하고 있습니다.평소 사용하시는 샤워 용품이 
 있으시면 개인 지참 부탁드립니다. 또한 실외에서 신은 운동화는 센터 내에서 
 착용하실 수 없기 때문에, 실내 전용 운동화를 반드시 준비해주시기 바랍니다.
 마지막으로 대여용 운동복을 원하지 않는 경우에는 개인 운동복도 함께 준비해주세요.', sysdate); 
insert into gym_faq(faq_idx, faq_title, faq_content, faq_date) 
values (gym_faq_seq.nextval, '운동을 처음 해보는데, 어떻게 운동해야 하는지 모르겠어요.', 
'걱정하지 않으셔도 됩니다! 굿초이스 헬스장에서는 신규 회원 등록 시, 
 전문적인 트레이너의 1:1 운동 지도 2회를 제공해 드리고 있습니다. 뿐만 아니라, 
 센터 내에 상주하는 트레이너가 친절하게 도와드리고 있으니 부담 갖지 마시고
 언제라도 편하게 트레이너 및 데스크에 문의해 주세요.', sysdate); 
insert into gym_faq(faq_idx, faq_title, faq_content, faq_date) 
values (gym_faq_seq.nextval, 'G.X이용 방법이 궁금합니다.', 
'G.X 프로그램은 회원권 이용시 무료로 자유롭게 이용하실 수 있습니다.
 다만, 예약제로 운영되기 때문에 전화또는 현장에서 예약후 이용가능합니다.
 G.X 프로그램 시간표는 [헬스장소개<Schedule] 또는 홈페이지의 메인화면에서
 확인가능합니다.', sysdate); 
insert into gym_faq(faq_idx, faq_title, faq_content, faq_date) 
values (gym_faq_seq.nextval, '연기는 가능한가요?', 
'연기 신청은 3개월 등록 기간을 기준으로 1회, 1회 당 최대 1개월(30일)까지 가능합니다.
 연기 기간 만료 시 이용 기간은 자동으로 진행되며 별도로 안내드리지 않습니다.
 저희 헬스장으로 전화 주시거나 직접 방문하여 연기 신청을 할 수 있습니다.', sysdate);
insert into gym_faq(faq_idx, faq_title, faq_content, faq_date) 
values (gym_faq_seq.nextval, '개인사물함 사용기간 만료 시에는 물품을 언제까지 보관하나요?', 
'굿초이스 헬스장에서는 소비자기본법과 공정거래위원회의 권장 규정에 따라
 이용 기간 종료 후 14일 경과 후에도 이용자가 소지품 미회수 시
 보관 중인 소지품을 회수하여 따로 보관하며, 그때로부터
 다시 14일 경과 후에도 이용자가 소지품을 미회수 시 보관품을 폐기 등 
 적정한 방법으로 처분합니다.', sysdate);
insert into gym_faq(faq_idx, faq_title, faq_content, faq_date) 
values (gym_faq_seq.nextval, '환불은 어떻게 진행되나요?', 
'환불에 관한 문의는 굿초이스 헬스장으로 전화주시거나 직접 방문해 주세요.', sysdate);

-- 3. 이세영

-- 트레이너 정보

-- 시간표 정보

-- 시간표 정보1
drop table gym_schedule;

create table gym_schedule(

    gym_schedule_idx       number(4) primary key,
    gym_schedule_content   number(4),
    gym_mon101 varchar2(30),
    gym_mon102 varchar2(30),
    gym_mon103 varchar2(30),
    gym_mon104 varchar2(30),
    gym_tue101 varchar2(30),
    gym_tue102 varchar2(30),
    gym_tue103 varchar2(30),
    gym_tue104 varchar2(30),
    gym_wed101 varchar2(30),
    gym_wed102 varchar2(30),
    gym_wed103 varchar2(30),
    gym_wed104 varchar2(30),
    gym_thu101 varchar2(30),
    gym_thu102 varchar2(30),
    gym_thu103 varchar2(30),
    gym_thu104 varchar2(30),
    gym_fri101 varchar2(30),
    gym_fri102 varchar2(30),
    gym_fri103 varchar2(30),                   
    gym_fri104 varchar2(30),
    gym_sat101 varchar2(30),                     
    gym_sat102 varchar2(30),
    gym_sat103 varchar2(30),
    gym_sat104 varchar2(30),
    gym_sun101 varchar2(30),
    gym_sun102 varchar2(30),
    gym_sun103 varchar2(30),
    gym_sun104 varchar2(30)
);
--gym_schedule_idx는 본인 admin 계정의 idx번호를 넣어야 한다.
insert into gym_schedule(gym_schedule_idx, gym_schedule_content,gym_mon101,gym_mon102,gym_mon103,gym_mon104,gym_tue101,gym_tue102,gym_tue103,gym_tue104, gym_wed101, gym_wed102, gym_wed103, gym_wed104,gym_thu101,gym_thu102,gym_thu103,gym_thu104, gym_fri101, gym_fri102, gym_fri103, gym_fri104, gym_sat101, gym_sat102, gym_sat103, gym_sat104,gym_sun101,gym_sun102,gym_sun103,gym_sun104
) 
values (1, 10,'줌바댄스','요가',' 필라테스','스피닝','에어로빅','필라테스','요가','바디스컬트','줌바댄스','요가','필라테스','스피닝','에어로빅','필라테스','요가','바디스컬트','줌바댄스','요가','필라테스','스피닝','에어로빅','필라테스','요가','바디스컬트','줌바댄스','요가','필라테스','스피닝'
);

--시간표 정보2
drop table gym_schedule2;

create table gym_schedule2(

    gym_schedule2_idx       number(4) primary key,
    gym_schedule2_content   number(4),
    gym_mon201 varchar2(30),
    gym_mon202 varchar2(30),
    gym_mon203 varchar2(30),
    gym_mon204 varchar2(30),
    gym_tue201 varchar2(30),
    gym_tue202 varchar2(30),
    gym_tue203 varchar2(30),
    gym_tue204 varchar2(30),
    gym_wed201 varchar2(30),
    gym_wed202 varchar2(30),
    gym_wed203 varchar2(30),
    gym_wed204 varchar2(30),
    gym_thu201 varchar2(30),
    gym_thu202 varchar2(30),
    gym_thu203 varchar2(30),
    gym_thu204 varchar2(30),
    gym_fri201 varchar2(30),
    gym_fri202 varchar2(30),
    gym_fri203 varchar2(30),                   
    gym_fri204 varchar2(30),
    gym_sat201 varchar2(30),                     
    gym_sat202 varchar2(30),
    gym_sat203 varchar2(30),
    gym_sat204 varchar2(30),
    gym_sun201 varchar2(30),
    gym_sun202 varchar2(30),
    gym_sun203 varchar2(30),
    gym_sun204 varchar2(30)                           
);

insert into gym_schedule2(gym_schedule2_idx, gym_schedule2_content, gym_mon201,gym_mon202,gym_mon203,gym_mon204,gym_tue201,gym_tue202,gym_tue203,gym_tue204, gym_wed201, gym_wed202, gym_wed203, gym_wed204,gym_thu201,gym_thu202,gym_thu203,gym_thu204, gym_fri201, gym_fri202, gym_fri203, gym_fri204, gym_sat201, gym_sat202, gym_sat203, gym_sat204,gym_sun201,gym_sun202,gym_sun203,gym_sun204) 
values (1,20, '그룹PT','골프',' 필라테스','그룹PT','그룹PT','골프',' 필라테스','그룹PT','그룹PT','골프',' 필라테스','그룹PT','그룹PT','골프',' 필라테스','그룹PT','그룹PT','골프',' 필라테스','그룹PT','그룹PT','골프',' 필라테스','그룹PT','그룹PT','골프',' 필라테스','그룹PT');

--헬스 트레이너 소개
drop table gym_trainner;
create table gym_trainner(
    trainner_idx      number(4) primary key,
    trainner_int    varchar2(300),
    trainner_content varchar2(3000),
    trainner_img  clob
);
drop sequence gym_trainner_seq;
create sequence gym_trainner_seq; 

insert into gym_trainner(trainner_idx, trainner_int,  trainner_content, trainner_img) 
values (gym_trainner_seq.nextval, '안녕하세요. 굿초이스 PT트레이너 김한구 입니다.
', ' 학생시절부터 여러 운동을 접하면서 끈기와 인내심을 배웠습니다. 극한을 극복해 나아가는 것에 흥미를 두었고 그로인해 따라오는 실패 또한 겸허히 받아들이는 법을 
터득할 수 있었습니다. 성공을 향한 갈망과 이뤄냈을 때의 성취감을 누구보다도 잘 느껴보았기에 그 경험을 바탕으로 트레이닝을 시작할 때 열정을 키워주고 운동을 지속해
나아갈 수 있는 끈기를 잡아드리며 그 끝에는 원하는 목표에 도달해내는 성취감을 느낄 수 있도록 늘 최선을 다해 트레이닝을 도와드리겠습니다.','tra01_img.jpg');

insert into gym_trainner(trainner_idx, trainner_int,  trainner_content, trainner_img) 
values (gym_trainner_seq.nextval, '안녕하세요. 굿초이스서윤환 상무 입니다.', ' "진정한 노력은 배신하지 않는다"라는 말이 있습니다. 
사람은 누구나 행복에 대한 긍정적인 생각들을 갖고 있습니다. 부족함없는 생활이 행복할까요? 
어떤 리서치 조사결과 부의 축적이 행복지수에 큰 반영은 미치질 못한다 했습니다. 
그 반면에 운동을 하며 하루를 마무리하고 하루를 시작하는 건강한 집단에 대한 행복지수는 급격히 상승곡선을 그린다고 합니다. 
자신의 운동시간에 투자하고, 스스로 만들어 가신다면 저희 헬로우짐 직원들은 그 방법을 알려드리는 조력자의 역할에 앞장 서겠습니다. 
끝으로 헬로우짐 회원님뿐만이 아닌 모든분들이 운동하는 그날을 꿈꾸며, 사랑하는 가족, 연인, 친구분들의 건강한 삶을 기원합니다.','tra02_img.jpg');

insert into gym_trainner(trainner_idx, trainner_int,  trainner_content, trainner_img) 
values (gym_trainner_seq.nextval, '안녕하세요. 굿초이스 트레이너 이석우 입니다.', ' 지금보다 중요한 순간은 없다고 생각합니다. 미래를 꿈꾸고 생각한다면, 
지금 실천해야 합니다. 항상 처음과 시작은 당연히 두렵기도 하고, 생각이 많아지기도 합니다. 
아무것도 모르고, 어떻게 해야 할 지모를 때, 내딛는 한 걸음이 어렵고 쉽게 포기할까 고민될 때, 고민과 생각이 많아질수록 의지는 점점 나약해 집니다. 
고민은 떨쳐내시고 지금 해야겠다는 생각으로 제 손을 잡으신다면, 함께 즐거움을 찾고 그 즐거움이 원하시는 결과가 되도록 도와드리겠습니다.','tra03_img.jpg');

insert into gym_trainner(trainner_idx, trainner_int,  trainner_content, trainner_img) 
values (gym_trainner_seq.nextval, '굿초이스 휘트니스 트레이너 김광기 입니다.', ' 운동의 가치를 모르는 이들 대부분은 건강과의 거리가 멀 수 밖에 없습니다. 
부자들은 대부분 운동을 합니다. 건강을 위해서? 자기관리를 위해서? 기분의 좋아지니깐? 전부 정답입니다! 
운동을 하나의 습관으로 생각하면 삶의 질이 달라질수있습니다. 제가 도와드리겠습니다. 
저는 회원님들의 건강, 자기관리, 스트레스에서 뿐만 아니라 삶의 질을 높여드릴 수 있는 트레이너가 되고 싶습니다. 
저를 믿고 따라와주신다면 절대 배신하지 않겠습니다. 
항상 옆에서 지도자로써 이끌어 드리겠습니다! 운동은 하루를 짧게하지만, 인생을 길게 합니다! 감사합니다!','tra04_img.jpg');

  



-- 4. 김주원

-- 공지사항
drop table gym_notice;
create table gym_notice(
 notice_idx       number(4) primary key,
    notice_name      varchar2(20),
    notice_title     varchar2(100),
    notice_content   varchar2(1000),
    notice_date      date default sysdate,
    notice_hit       number(20) default 0
);

drop sequence gym_notice_seq;
create sequence gym_notice_seq;

-- 이벤트
drop table gym_event;
create table gym_event(
 	event_idx       number(4) primary key,
    event_name      varchar2(20),
    event_title     varchar2(100),
    event_content   varchar2(1000),
    event_date      date default sysdate,
    event_hit       number(20) default 0
);

drop sequence gym_event_seq;
create sequence gym_event_seq;

insert into gym_event(event_idx, event_name, event_title, event_content, event_date ) 
values (gym_event_seq.nextval, '홍길동', '글 제목1', '글 내용1', sysdate);

--이용 후기
drop table gym_review;
create table gym_review(
 	review_idx           number(10) primary key,
 	review_id            varchar2(20),
    review_name          varchar2(20),
    review_title         varchar2(200),
    review_content       varchar2(1000),
    review_date          date default sysdate,
    review_hit           number(20) default 0,
    review_reply_count   number(20) default 0,
    reviewMember_idx    number(4) references gym_member(member_idx) on delete cascade
);

drop sequence gym_review_seq;
create sequence gym_review_seq;

--이용후기 댓글
drop table gym_reReply;
create table gym_reReply(
    reReply_idx       number(10) primary key,
    reReply_id        varchar2(20),
    reReply_name      varchar2(20),
    reReply_content   varchar2(500),
    reReply_date      date default sysdate,
    reReply_review_idx number(10),
--    댓글 작성한 회원의 idx
    reReply_reviewMem_idx    number(4) references gym_member(member_idx),
--    본 게시물 작성한 회원의 idx
    reReply_reviewMem_idx2   number(4) references gym_member(member_idx) on delete cascade 
);

drop sequence gym_reReply_seq;
create sequence gym_reReply_seq;


--채용안내
drop table gym_recruitment;
create table gym_recruitment(
 	recruitment_idx       number(4) primary key,
    recruitment_name      varchar2(20),
    recruitment_title     varchar2(100),
    recruitment_content   varchar2(1000),
    recruitment_date      date default sysdate,
    recruitment_hit       number(20) default 0
);

drop sequence gym_recruitment_seq;
create sequence gym_recruitment_seq;







