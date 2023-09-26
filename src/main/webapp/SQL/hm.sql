-- 유저 정보 테이블
create table c_member(
    m_id VARCHAR2(200) PRIMARY KEY, --유저 ID
    m_pwd VARCHAR2(400) not null, --사용자 비밀번호
    m_birth VARCHAR2(200) not null, --사용자 생일
    m_name VARCHAR2(200) not null, --사용자이름
    m_email VARCHAR2(200) not null, --사용자 이메일
    m_tel VARCHAR2(200) not null, --사용자 통신사
    m_phone VARCHAR2(200) not null, --사용자 전화번호
    m_state Number not null, -- 가입회원이면 1, 탈퇴회원이면 2
    m_regdate date -- 회원가입 날짜
);
-- 차 정보 테이블
create table c_car(
    c_num number not null, -- 차량 코드번호
    c_name varchar2(200) primary key, -- 차량 이름
    c_brand varchar2(200)not null, -- 차량 브랜드
    c_year varchar2(200) not null, -- 차량 년식
    c_color varchar2(200) not null, -- 차량 색상
    c_type varchar2(200) not null, -- 차량 상세차종
    c_type2 varchar2(200) not null, -- 차량 차종
    c_oil varchar2(200) not null, -- 차량 기름
    c_price number not null, -- 차량 가격
    c_ok int default 1, -- 차량 가능 여부
    c_img varchar2(200) not null -- 차량 이미지
);
-- 예약 테이블
create table c_rental(
     cr_num INT PRIMARY KEY, -- 예약번호
    cr_mid VARCHAR2(30), --  유저 아이디
    cr_cname VARCHAR2(200), -- 차량 아이디(차량 고유 코드번호)
    cr_rdate VARCHAR2(200), -- 예약 일자
    cr_sdate VARCHAR2(200), -- 실제 대여일
    cr_edate VARCHAR2(200), -- 반납 일자
    cr_price INT, -- 렌트 비용
    cr_order VARCHAR2(100), -- 주문 번호0
    FOREIGN KEY (cr_mid) REFERENCES c_member(m_id),
    FOREIGN KEY (cr_cname) REFERENCES c_car(c_name)
);
--결제 정보 저장 테이블
CREATE TABLE c_order_info (
    ID NUMBER PRIMARY KEY,      -- 시퀀스
    BUYER_NAME VARCHAR2(255),      -- 구매자 아이디
    BUYER_PHONE VARCHAR2(20),      -- 구매자 폰번호
    MEMBER_EMAIL VARCHAR2(255),      -- 구매자 이메일
    BUYER_ADDRESS VARCHAR2(500),   -- 구매자 주소
    BUY_DATE VARCHAR2(20),      -- 예약 일자
    PRODUCT_NAME VARCHAR2(255),      -- 예약한 차량 이름
    BUY_ID VARCHAR2(255),      -- 구매번호
    MERCHANT_ID VARCHAR2(255),      -- 주문번호
    PAY_PRICE NUMBER,         -- 가격
    CARD_NUM VARCHAR2(255),      -- 카드번호
    PAY_STATUS VARCHAR2(50),      -- 결제여부
    POST_CODE NUMBER         -- 
);
-- 공지사항 테이블
CREATE TABLE C_SERVICE (
    "CS_NO" NUMBER(*,0),
    "CS_TITLE" VARCHAR2(200 BYTE), 
    "CS_CONT" VARCHAR2(4000 BYTE), 
    "CS_DATE" DATE DEFAULT SYSDATE, 
    "CS_TYPE" VARCHAR2(20 BYTE),
    cs_hit int default 0
);
--Q&A 테이블
create table c_qna(
    cq_id VARCHAR2(20),
    cq_pwd VARCHAR2(400),
    cq_title VARCHAR2(200),
    cq_cont VARCHAR2(4000),
    cq_date DATE DEFAULT SYSDATE,
    cq_ment VARCHAR2(3000),
    cq_doc varchar2(400),
    FOREIGN KEY (cq_id) REFERENCES c_member(m_id)
);

-- 차량 정보 테이블 시퀀스
create sequence car_seq
start with 1
increment by 1
nocache;
-- 예약 테이블 시퀀스
create sequence cr_seq
start with 1
increment by 1
nocache;
-- 결제 정보 테이블 시퀀스
create sequence co_seq
start with 1
increment by 1
nocache;
-- 공지사항 테이블 시퀀스
create sequence cs_seq
start with 1
increment by 1
nocache;
-- Q&A 테이블 시퀀스
create sequence cq_seq
start with 1
increment by 1
nocache;

-- 자동차 insert
-- 경형
insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '레이', 'KIA', '경형 RV', '경형', '가솔린', '2023', 'WHITE', 100, 'Gcar01.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '모닝', 'KIA', '경형 해치백', '경형', '가솔린', '2023', 'WHITE', 100, 'Gcar02.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '캐스퍼', '현대', '경형 SUV', '경형', '가솔린', '2023', 'BLUE', 200, 'Gcar03.JPG');

-- 소형
insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '해치백', 'MINI', '소형 해치백', '소형', '가솔린', '2024', 'RED', 200, 'Scar01.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '코나', '현대', '소형 SUV', '소형', '가솔린', '2023', 'GRAY', 200, 'Scar02.JPG');

-- 중형 세단
insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, 'K5', 'KIA', '중형 세단', '중형 세단', 'LPG, 가솔린', '2022', 'BLACK', 250, 'Jcar01.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '쏘나타', '현대', '중형 세단', '중형 세단', 'LPG, 가솔린', '2019', 'LIGHTGRAY', 250, 'Jcar02.JPG');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '3 시리즈', 'BMW', '중형 세단', '중형 세단', '가솔린, 디젤', '2019', 'WHITE', 300, 'Jcar03.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '아테온', '폭스바겐', '중형 세단', '중형 세단', '디젤', '2019', 'BLUE', 300, 'Jcar04.JPG');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, 'A4', '아우디', '중형 세단', '중형 세단', '가솔린, 디젤', '2019', 'BLACK', 300, 'Jcar05.png');

-- 중형 SUV
insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '싼타페 하이브리드', '현대', '중형 SUV', '중형 SUV', '가솔린, 하이브리드', '2023', 'WHITE', 350, 'Jcar06.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '쏘렌토', 'KIA', '중형 SUV', '중형 SUV', '가솔린, 디젤', '2023', 'WHITE', 350, 'Jcar07.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, 'GV70', '제네시스', '중형 SUV', '중형 SUV', '가솔린, 디젤', '2022', 'BLACK', 350, 'Jcar08.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, 'X3', 'BMW', '중형 SUV', '중형 SUV', '가솔린, 디젤', '2022', 'BLACK', 350, 'Jcar09.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, 'SQ5', '아우디', '중형 SUV', '중형 SUV', '가솔린', '2021', 'WHITE', 350, 'Jcar10.png');

-- 전기차
insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '코나 Electric', '현대', '소형 SUV', '전기차', '전기', '2023', 'RED', 400, 'Icar01.JPG');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '아이오닉6', '현대', '중형 세단', '전기차', '전기', '2023', 'GRAY', 400, 'Icar02.JPG');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '니로 EV', 'KIA', '소형 SUV', '전기차', '전기', '2024', 'RED', 400, 'Icar03.png');

-- admin계정 추가
insert into c_member (m_id,m_birth,m_email,m_name,m_phone,m_pwd,m_state,m_tel,regdate)
values('admin01','','','','','admin01',9,'',sysdate);

select * from c_member;
select * from c_car;
select * from c_rental;
select * from c_service;

commit;
