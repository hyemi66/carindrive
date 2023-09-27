--car테이블의 c_ok 삭제 생각해볼것 , 렌트테이블,  결제정보테이블 재 배포

--시퀀스 1로 초기화
update c_car set c_num = '1';
update c_rental set cr_num = '1';
update c_order_info set id ='1';


commit; -- 설정 후 반드시 커밋하고 테스트 할 것

select * from c_rental;
select * from c_rental where cr_mid = 'zzzz';

UPDATE c_rental SET cr_cname = 'RAY' WHERE cr_mid = '고객 아이디';

UPDATE c_rental SET cr_cname = '차이름' WHERE cr_mid = '고객 아이디';

delete from c_rental where cr_num = 107;



--테스트ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
UPDATE c_car SET c_ok = 1 WHERE c_ok = 0; --차량의 상태를 모두 렌탈가능으로 되돌림

--차량 예약 가능 여부 확인
SELECT c_ok FROM c_car WHERE c_name = '레이';

--특정 시간대에 차량 예약 중복 여부 확인
SELECT COUNT(*) FROM c_rental WHERE '레이' = :selectedCarName AND 
      ((cr_sdate BETWEEN :desiredStartDate AND :desiredEndDate) OR 
       (cr_edate BETWEEN :desiredStartDate AND :desiredEndDate) OR
       (:desiredStartDate BETWEEN cr_sdate AND cr_edate) OR 
       (:desiredEndDate BETWEEN cr_sdate AND cr_edate));
       
--특정 시간대에 차량 예약 중복 여부 확인 4가지 조건중 1개라도 참이면 중복예약이므로 예약을 못함 중복예약일시 값이 0이어야 차량 렌트가능
SELECT COUNT(*) FROM c_rental WHERE cr_cname = '레이' AND 
      ((cr_sdate BETWEEN '2023-09-28 09:00' AND '2023-09-28 11:00') OR 
       (cr_edate BETWEEN '2023-09-28 09:00' AND '2023-09-28 11:00') OR
       ('2023-09-28 09:00' BETWEEN cr_sdate AND cr_edate) OR 
       ('2023-09-28 11:00' BETWEEN cr_sdate AND cr_edate));
    
       
--   <select id="getOverlappingRentals" resultType="int">
--        SELECT COUNT(*) 
--        FROM c_rental 
--        WHERE cr_cname = #{carName} AND 
--              ((cr_sdate BETWEEN #{startDate} AND #{endDate}) OR 
--               (cr_edate BETWEEN #{startDate} AND #{endDate}) OR
--               (#{startDate} BETWEEN cr_sdate AND cr_edate) OR 
--               (#{endDate} BETWEEN cr_sdate AND cr_edate))
--    </select>


--차량 예약 진행
  INSERT INTO c_rental (cr_num, cr_mid, cr_cname, cr_rdate, cr_sdate, cr_edate, cr_price)
VALUES (cr_seq.NEXTVAL, 'zzzz', '레이', '2023년 09월 26일 오전 10시 13분', '2023-09-29 10:13', '2023-09-30 10:13', 200000);

--차량 대여 상태 업데이트 c_ok를 0으로 변환
UPDATE c_car SET c_ok = 0 WHERE c_name = '레이';

--차량 반납 c_ok를 1로 되돌림
UPDATE c_car SET c_ok = 1 WHERE c_name = '레이';

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

--렌트 시간 추출 (해당차량)
SELECT 
    TO_CHAR(TO_DATE(cr_sdate, 'YYYY-MM-DD HH24:MI'), 'YYYY-MM-DD HH24:MI') AS start_date, 
    TO_CHAR(TO_DATE(cr_edate, 'YYYY-MM-DD HH24:MI'), 'YYYY-MM-DD HH24:MI') AS end_date
FROM c_rental
WHERE cr_cname = '레이'
ORDER BY start_date;

UPDATE c_rental 
SET cr_waittime = TO_CHAR(TO_TIMESTAMP(cr_edate, 'yyyy-mm-dd hh24:mi') + (3/24), 'yyyy-mm-dd hh24:mi') 
WHERE cr_order = 'merchant_1695789378075';

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--확인 코드
select * from c_member order by m_name asc; -- 사용자 확인
select * from c_car order by c_num asc; --차량 확인
select * from c_rental order by cr_num desc; --렌트 확인
select * from c_order_info order by id desc; --결제 정보 확인
merchant_1695602468086
select * from c_order_info where MERCHANT_ID = 'merchant_1695602937057';

select * from c_order_info where MERCHANT_ID = 'merchant_1695602468086';

select * from c_order_info where parent_merchant_id = 'merchant_1695632654275'; --부모의 주문번호를 이용해서 그의 자식을 찾음
select * from c_rental where cr_order = 'merchant_1695632654275';
select * from c_rental where cr_order = 'merchant_1695632899760';

UPDATE c_car SET c_ok = 1 WHERE c_ok = 0;
UPDATE c_car SET c_ok = 1 WHERE c_name = '캐스퍼' AND c_ok = 0;
UPDATE c_car SET c_ok = 0 WHERE c_name = '캐스퍼';


--시퀀스 생성
CREATE SEQUENCE cs_seq START WITH 1 INCREMENT BY 1 NOCACHE;  -- 공지사항 테이블 시퀀스
CREATE SEQUENCE cq_seq START WITH 1 INCREMENT BY 1 NOCACHE;  -- Q&A 테이블 시퀀스
CREATE SEQUENCE car_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- 차 정보 테이블 시퀀스
CREATE SEQUENCE cr_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- 예약(렌탈) 테이블 시퀀스
CREATE SEQUENCE co_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- 결제 정보 테이블 시퀀스


--시퀀스 삭제
drop SEQUENCE cs_seq;
drop SEQUENCE cq_seq;
drop SEQUENCE car_seq;
drop SEQUENCE cr_seq;
drop SEQUENCE co_seq;


--테이블 삭제
drop table c_rental;
drop table c_car;
drop table c_order_info;
drop table c_service;
drop table c_qna;
drop table c_member;

commit;

 --데이터 삭제
delete from c_member;
delete from c_car;
delete from c_rental; --차량 렌트 기록 삭제 --렌트기록은 0, 1로 결제 처리를 했는지 여부를 판단하고 차량과 연결지어서 예약 가능 불가능으로 나눠야함
delete from c_order_info; --결제 정보 삭제
commit;--삭제후 커밋해야 웹에 적용됨


--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--유저 정보 테이블
CREATE TABLE c_member (
    m_id VARCHAR2(30) PRIMARY KEY,
    m_pwd VARCHAR2(200),        --30에서 200으로 확장
    m_birth VARCHAR2(30),
    m_name VARCHAR2(30),
    m_email VARCHAR2(200),      --30에서 200으로 확장
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
    cs_cont VARCHAR2(4000),
    cs_date DATE DEFAULT SYSDATE,
    cs_hit INT,
    FOREIGN KEY (cs_id) REFERENCES c_member(m_id)
);



--Q&A 테이블
CREATE TABLE c_qna (
    cq_no int,
    cq_id VARCHAR2(20),
    cq_pwd VARCHAR2(400),
    cq_title VARCHAR2(200),
    cq_cont VARCHAR2(4000),
    cq_date DATE DEFAULT SYSDATE,
    cq_ment VARCHAR2(3000),
    cq_doc varchar2(400),
    FOREIGN KEY (cq_id) REFERENCES c_member(m_id)
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
CREATE TABLE c_rental (
    cr_num number PRIMARY KEY,                    -- 예약번호
    cr_mid VARCHAR2(30),                          -- 고객 아이디
    cr_cname VARCHAR2(200),                     --차 이름            --cr_cid를 cr_cname으로 바꿈
    cr_rdate VARCHAR2(200),                       --예약 일자
    cr_sdate VARCHAR2(200),                      --실제 대여일
    cr_edate VARCHAR2(200),                      --반납 일자
    cr_price number,                                       --렌트 비용
    cr_order VARCHAR2(100),                       --주문 번호
    cr_status VARCHAR2(30) DEFAULT 'wait' NOT NULL, --결제 상태 확인
    cr_paytime TIMESTAMP,
    cr_waittime VARCHAR2(200),
    FOREIGN KEY (cr_mid) REFERENCES c_member(m_id),
    FOREIGN KEY (cr_cname) REFERENCES c_car(c_name)
);




--결제 정보 저장 테이블
create table c_order_info (
    id number primary key,
    buyer_name varchar2(255),
    buyer_phone varchar2(20),
    member_email varchar2(255),
    buyer_address varchar2(500),
    buy_date varchar2(20),
    product_name varchar2(255),
    buy_id varchar2(255),
    merchant_id varchar2(255),
    pay_price number,
    card_num varchar2(255),
    pay_status varchar2(50),
    post_code number,
    refund varchar2(20),
    parent_merchant_id varchar2(255)
);



--차량추가

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

