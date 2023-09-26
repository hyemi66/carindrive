--테스트 데이터 추가
insert into cid_members values(1,'zzz',1,1,1,1,1,1); --아이디 zzz 비밀번호 1
insert into cid_members values(2,'z',1,'0307','조성관','zaq3195@naver.com','LG U+','010-1234-1234'); --아이디 zzz 비밀번호 1
insert into cid_cars values(1,'ray','kia','2023','white',500,0);    --고유번호 1번의 레이차량 등록

commit;

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
select * from cid_members order by m_name asc; -- 사용자 확인
select * from cid_cars order by car_name desc; --차량 확인
select * from cid_rentals order by rental_id desc; --렌트 확인
select * from cid_order_info order by id asc; --결제 정보 확인
select * from cid_order_info order by buyer_name asc; --결제 정보 확인

 
delete from cid_members;
delete from cid_cars;
delete from cid_rentals; --차량 렌트 기록 삭제 --렌트기록은 0, 1로 결제 처리를 했는지 여부를 판단하고 차량과 연결지어서 예약 가능 불가능으로 나눠야함
delete from cid_order_info; --결제 정보 삭제


--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--시퀀스 생성
CREATE SEQUENCE m_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE cars_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE rentals_seq START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE order_seq START WITH 1 INCREMENT BY 1 NOCACHE;

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--member 테이블
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


-- cars 테이블
CREATE TABLE cid_cars (
  car_id NUMBER PRIMARY KEY,    --차량 고유 코드번호
  car_name varchar2(30),
  car_brand VARCHAR2(30),
  car_year NUMBER,
  car_color VARCHAR2(30),
  car_price NUMBER(10, 2),
  car_availability NUMBER
);

-- cid_rentals 테이블 수정
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
CREATE TABLE cid_order_info (
    ID NUMBER PRIMARY KEY,
    BUYER_NAME VARCHAR2(255),
    BUYER_PHONE VARCHAR2(20),
    MEMBER_EMAIL VARCHAR2(255),
    BUYER_ADDRESS VARCHAR2(500),
    BUY_DATE VARCHAR2(20), -- TIMESTAMP 혹은 DATE 형식을 추천하나, 클래스에서 String 으로 되어 있어서 VARCHAR2 사용
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
DROP TABLE PAYMENT_INFO;

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


