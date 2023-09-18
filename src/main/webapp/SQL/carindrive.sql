--테스트 데이터 추가
insert into c_member (m_id, m_pwd, m_name, m_phone)values('z','1','홍길동','010-1111-2222'); --아이디 z 비밀번호 1

INSERT INTO c_car (c_num, c_name, c_brand, c_year, c_color, c_type, c_oil, c_price, c_ok, c_img) --차량추가
VALUES (car_seq.nextval, '레이', '기아', '2023', '흰색', '경차', '가솔린', 500, 0, 'Gcar01.png');
INSERT INTO c_car (c_num, c_name, c_brand, c_year, c_color, c_type, c_oil, c_price, c_ok, c_img) --차량추가
VALUES (car_seq.nextval, '모닝', '기아', '2023', '검정색', '경차', '가솔린', 500, 0, 'Gcar02.png');
update c_car set c_num = '1';
update c_rental set cr_num = '1';
update c_order_info set id ='1';

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS current_datetime FROM DUAL;

select * from c_rental where cr_mid = 'zzzz';

commit; -- 설정 후 반드시 커밋하고 테스트 할 것
SELECT * FROM c_rental WHERE cr_mid = 'zzzz';
SELECT * FROM c_rental WHERE cr_cname = 'ray';

select * from c_car where c_name = '모닝';
SELECT * FROM c_car
WHERE c_name LIKE '%모닝%';

update c_order_info set refund = '환불완료' where merchant_Id = 'merchant_1694756834113';


select * from c_car where c_name =
--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
select * from c_member order by m_name asc; -- 사용자 확인
select * from c_car order by c_num asc; --차량 확인
select * from c_rental order by cr_num desc; --렌트 확인
select * from c_order_info order by id desc; --결제 정보 확인
select * from c_rental where cr_order = 'merchant_1694430815754';

select * from c_member where m_id = 'zzzz';
select * from c_rental where cr_mid ='zzzz';
SELECT *FROM c_rental WHERE cr_mid = 'zzzz' AND cr_num = (
    SELECT MAX(cr_num)
    FROM c_rental
    WHERE cr_mid = 'zzzz'
);
SELECT * FROM c_rental WHERE cr_mid = #{cr_mid} ORDER BY cr_rdate DESC FETCH FIRST 1 ROW ONLY;
SELECT *FROM c_rental WHERE cr_mid = 'zzzz' AND cr_num = (SELECT MAX(cr_num) FROM c_rental WHERE cr_mid = 'zzzz');

select * from c_rental where cr_order = 'merchant_1694684830756';
 
delete from c_member;
delete from c_car;
delete from c_rental; --차량 렌트 기록 삭제 --렌트기록은 0, 1로 결제 처리를 했는지 여부를 판단하고 차량과 연결지어서 예약 가능 불가능으로 나눠야함
delete from c_order_info; --결제 정보 삭제
commit;--삭제후 커밋해야 웹에 적용됨


select * from c_order_info where buyer_name = 'zzzz';


update c_order_info set refund = '환불완료'


select * from c_order_info where buyer_name = 'z';
--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--시퀀스 생성
CREATE SEQUENCE cs_seq START WITH 1 INCREMENT BY 1 NOCACHE;  -- 공지사항 테이블 시퀀스
CREATE SEQUENCE cq_seq START WITH 1 INCREMENT BY 1 NOCACHE;  -- Q&A 테이블 시퀀스
CREATE SEQUENCE car_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- 차 정보 테이블 시퀀스
CREATE SEQUENCE cr_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- 예약(렌탈) 테이블 시퀀스
CREATE SEQUENCE co_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- 결제 정보 테이블 시퀀스
CREATE SEQUENCE cm_seq START WITH 1 INCREMENT BY 1 NOCACHE; -- 멤버 테이블 시퀀스 (테스트용)


--테이블 삭제
drop table c_rental;
drop table c_car;
drop table c_order_info;
drop table c_service;
drop table c_qna;
drop table c_member;

commit;


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
    regdate DATE
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



--차량 정보 테이블
CREATE TABLE c_car (
    c_num number PRIMARY KEY,         -- 차 코드번호
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
drop table c_car;


-- 예약 테이블
CREATE TABLE c_rental (
    cr_num INT PRIMARY KEY,                    -- 예약번호
    cr_mid VARCHAR2(30),                         -- 유저 아이디
    cr_cname VARCHAR2(200),                    --차량 아이디(차량 고유 코드번호)    --cr_cid를 cr_cname으로 바꿈
    cr_rdate VARCHAR2(200),                      --예약 일자
    cr_sdate VARCHAR2(200),                      --실제 대여일
    cr_edate VARCHAR2(200),                      --반납 일자
    cr_price INT,                           --렌트 비용
    cr_order VARCHAR2(100),            --주문 번호0
    FOREIGN KEY (cr_mid) REFERENCES c_member(m_id),
    FOREIGN KEY (cr_cname) REFERENCES c_car(c_name)
);
drop table c_rental;


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
    POST_CODE NUMBER,
    refund varchar2(20)
);


