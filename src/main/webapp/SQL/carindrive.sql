--테스트 데이터 추가
insert into c_member (m_id, m_pwd, m_name, m_phone)values('z','1','홍길동','12345'); --아이디 z 비밀번호 1
insert into cid_members values(2,'z',1,'0307','조성관','zaq3195@naver.com','LG U+','010-1234-1234'); --아이디 zzz 비밀번호 1

INSERT INTO c_car (c_num, c_name, c_brand, c_year, c_color, c_type, c_oil, c_price, c_ok, c_img) --차량등록
VALUES (car_seq.nextval, 'ray', '기아', '2023', '흰색', '경차', '가솔린', 500, 0, 'ray.jpg');
update c_car set c_num = '1';

INSERT INTO c_rental (cr_num, cr_mid, cr_cid, cr_rdate, cr_sdate, cr_edate, cr_price)
VALUES (cr_seq.NEXTVAL, 'z', '1', '1월1일', '1월2일', '1월3일', 3000);

INSERT INTO c_rental (cr_num, cr_mid, cr_cid, cr_rdate, cr_sdate, cr_edate, cr_price)
VALUES (cr_seq.NEXTVAL, 'z', 'ray', '1월1일', '1월2일', '1월3일', 3000);



commit;

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
select * from c_member order by m_name asc; -- 사용자 확인
select * from c_car order by c_name desc; --차량 확인
select * from c_rental order by cr_num desc; --렌트 확인
select * from c_order_info order by id asc; --결제 정보 확인

 
delete from cid_members;
delete from cid_cars;
delete from cid_rentals; --차량 렌트 기록 삭제 --렌트기록은 0, 1로 결제 처리를 했는지 여부를 판단하고 차량과 연결지어서 예약 가능 불가능으로 나눠야함
delete from cid_order_info; --결제 정보 삭제


--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--시퀀스 생성
CREATE SEQUENCE cs_seq START WITH 1 INCREMENT BY 1 NOCACHE;  -- 공지사항 테이블 시퀀스
CREATE SEQUENCE cq_seq START WITH 1 INCREMENT BY 1 NOCACHE;  -- Q&A 테이블 시퀀스
CREATE SEQUENCE car_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- 차 정보 테이블 시퀀스
CREATE SEQUENCE cr_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- 예약(렌탈) 테이블 시퀀스
CREATE SEQUENCE co_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- 결제 정보 테이블 시퀀스
CREATE SEQUENCE cm_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- 멤버 테이블 시퀀스 (테스트용)

drop table c_rental;
drop table c_car;
drop table c_order_info;
drop table c_service;
drop table c_qna;
drop table c_member;




--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--유저 정보 테이블
CREATE TABLE c_member (
    m_id VARCHAR2(30) PRIMARY KEY,
    m_pwd VARCHAR2(30),
    m_brith VARCHAR2(30),
    m_name VARCHAR2(30),
    m_email VARCHAR2(30),
    m_tel VARCHAR2(30),
    m_phone VARCHAR2(30),
    m_state NUMBER,
    m_regdate DATE
);


--공지사항 테이블
CREATE TABLE c_service (
    cs_no int,
    cs_id VARCHAR2(20),
    cs_pwd VARCHAR2(400),
    cs_title VARCHAR2(200),
    cs_cont VARCHAR2(3000),
    cs_date DATE DEFAULT SYSDATE,
    cs_hit INT,
    FOREIGN KEY (cs_id) REFERENCES c_member(m_id)
);



--Q&A 테이블
CREATE TABLE c_qna (
    cq_id VARCHAR2(20),
    cq_pwd VARCHAR2(400),
    cq_title VARCHAR2(200),
    cq_cont VARCHAR2(3000),
    cq_date DATE DEFAULT SYSDATE,
    cq_ment VARCHAR2(3000),
    FOREIGN KEY (cq_id) REFERENCES c_member(m_id)
);


drop table cid_members;
--member 테이블 (안씀 참고용)
CREATE TABLE cid_members (
  m_num NUMBER,
  m_id VARCHAR2(30) PRIMARY KEY, --유저 ID
  m_pwd VARCHAR2(30),
  m_birth VARCHAR2(30),
  m_name VARCHAR2(30),
  m_email VARCHAR2(30),
  user_hp_type VARCHAR2(30),
  m_phone VARCHAR2(30)
);

--차량 정보 테이블
CREATE TABLE c_car (
    c_num INT PRIMARY KEY,         -- 차 코드번호
    c_name VARCHAR2(200) UNIQUE, -- 차 이름
    c_brand VARCHAR2(200),          -- 차 브랜드
    c_year VARCHAR2(200),             -- 차 연식
    c_color VARCHAR2(200),            -- 차 색상
    c_type varchar2(200),                -- 차 타입 (경형, RV)
    c_oil   varchar2(200),                  --연료 종류
    c_price number,                            --차 1분당 렌트비용         --int를 number로 바꿈
    c_ok number,                                --렌트 가능 여부
    c_img VARCHAR2(200)             --차량 이미지파일
);


-- cars 테이블(안씀 참고용)
CREATE TABLE cid_cars (
  car_id NUMBER PRIMARY KEY,    --차량 고유 코드번호
  car_name varchar2(30),
  car_brand VARCHAR2(30),
  car_year NUMBER,
  car_color VARCHAR2(30),
  car_price NUMBER(10, 2),
  car_availability NUMBER
);
commit;

-- 예약 테이블
CREATE TABLE c_rental (
    cr_num INT PRIMARY KEY,     -- 예약번호
    cr_mid VARCHAR2(30),            -- 유저 아이디
    cr_cid VARCHAR2(200),           --차량 아이디(차량 고유 코드번호)    --cr_cid를 cr_name으로 바꾸는것 추천
    cr_rdate VARCHAR2(200),                      --예약 일자
    cr_sdate VARCHAR2(200),                      --실제 대여일
    cr_edate VARCHAR2(200),                      --반납 일자
    cr_price INT,                           --렌트 비용
    cr_order VARCHAR2(100),            --주문 번호
    FOREIGN KEY (cr_mid) REFERENCES c_member(m_id),
    FOREIGN KEY (cr_cid) REFERENCES c_car(c_name)
);


-- cid_rentals 테이블 수정 (안씀 참고용)
CREATE TABLE cid_rentals (
  rental_id NUMBER PRIMARY KEY,
  m_id VARCHAR2(30), -- 유저 ID
  car_id NUMBER, -- 차량 고유번호
  reservation_date varchar2(50), -- 렌트 신청일
  rental_date_time varchar2(50) , -- 실제 대여일
  return_date_time varchar2(50), -- 반납 날짜
  rental_cost NUMBER, -- 렌트 가격
  merchantId varchar2(100), --주문번호
  CONSTRAINT fk_m_id FOREIGN KEY (m_id) REFERENCES cid_members(m_id),
  CONSTRAINT fk_car_id FOREIGN KEY (car_id) REFERENCES cid_cars(car_id)
);

--결제 정보 저장 테이블
CREATE TABLE c_order_info (
    ID NUMBER PRIMARY KEY,
    BUYER_NAME VARCHAR2(255),
    BUYER_PHONE VARCHAR2(20),
    MEMBER_EMAIL VARCHAR2(255),
    BUYER_ADDRESS VARCHAR2(500),
    BUY_DATE VARCHAR2(20),
    PRODUCT_NAME VARCHAR2(255),
    BUY_ID VARCHAR2(255),
    MERCHANT_ID VARCHAR2(255),
    PAY_PRICE NUMBER,
    CARD_NUM VARCHAR2(255),
    PAY_STATUS VARCHAR2(50),
    POST_CODE NUMBER
);

select * from cid_order_info;

DROP TABLE cid_order_info;

-------------------------------------------------------------------------------------
--삭제관련 명령어

-- members 테이블의 외래 키 제약 조건 해제
ALTER TABLE cid_rentals DROP CONSTRAINT fk_m_id;

-- cars 테이블의 외래 키 제약 조건 해제
ALTER TABLE cid_rentals DROP CONSTRAINT fk_car_id;

DROP TABLE cid_members;
DROP TABLE cid_cars;
DROP TABLE cid_rentals;
DROP TABLE cid_order_info;

DROP SEQUENCE m_seq;
DROP SEQUENCE cars_seq;
DROP SEQUENCE rentals_seq;


--테스트
CREATE TABLE PAYED_LIST (
    IMP_UID VARCHAR2(255) PRIMARY KEY,
    MERCHANT_UID VARCHAR2(255) NOT NULL,
    BIZ_EMAIL VARCHAR2(255) NOT NULL,
    PAY_DATE DATE NOT NULL,
    AMOUNT NUMBER NOT NULL,
    CARD_NO VARCHAR2(50) NOT NULL,
    REFUND VARCHAR2(50) NOT NULL
);
drop table PAYED_LIST;


commit;



CREATE TABLE ORDER_INFO (
    ID NUMBER,
    BUYER_NAME VARCHAR2(255),
    BUYER_PHONE VARCHAR2(20),
    MEMBER_EMAIL VARCHAR2(255),
    BUYER_ADDRESS VARCHAR2(500),
    BUY_DATE VARCHAR2(20), -- TIMESTAMP 혹은 DATE 형식을 추천하나, 클래스에서 String 으로 되어 있어서 VARCHAR2 사용
    PRODUCT_NAME VARCHAR2(255),
    BUY_ID VARCHAR2(255),
    MERCHANT_ID VARCHAR2(255) PRIMARY KEY,
    PAY_PRICE NUMBER,
    CARD_NUM VARCHAR2(255),
    PAY_STATUS VARCHAR2(50),
    SOME_NUMBER NUMBER
);

select * from ORDER_INFO;

drop table ORDER_INFO;


