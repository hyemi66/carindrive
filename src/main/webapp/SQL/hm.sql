-- ���� ���� ���̺�
create table c_member(
    m_id VARCHAR2(200) PRIMARY KEY, --���� ID
    m_pwd VARCHAR2(400) not null, --����� ��й�ȣ
    m_birth VARCHAR2(200) not null, --����� ����
    m_name VARCHAR2(200) not null, --������̸�
    m_email VARCHAR2(200) not null, --����� �̸���
    m_tel VARCHAR2(200) not null, --����� ��Ż�
    m_phone VARCHAR2(200) not null, --����� ��ȭ��ȣ
    m_state Number not null, -- ����ȸ���̸� 1, Ż��ȸ���̸� 2
    m_regdate date -- ȸ������ ��¥
);
-- �� ���� ���̺�
create table c_car(
    c_num number not null, -- ���� �ڵ��ȣ
    c_name varchar2(200) primary key, -- ���� �̸�
    c_brand varchar2(200)not null, -- ���� �귣��
    c_year varchar2(200) not null, -- ���� ���
    c_color varchar2(200) not null, -- ���� ����
    c_type varchar2(200) not null, -- ���� ������
    c_type2 varchar2(200) not null, -- ���� ����
    c_oil varchar2(200) not null, -- ���� �⸧
    c_price number not null, -- ���� ����
    c_ok int default 1, -- ���� ���� ����
    c_img varchar2(200) not null -- ���� �̹���
);
-- ���� ���̺�
create table c_rental(
     cr_num INT PRIMARY KEY, -- �����ȣ
    cr_mid VARCHAR2(30), --  ���� ���̵�
    cr_cname VARCHAR2(200), -- ���� ���̵�(���� ���� �ڵ��ȣ)
    cr_rdate VARCHAR2(200), -- ���� ����
    cr_sdate VARCHAR2(200), -- ���� �뿩��
    cr_edate VARCHAR2(200), -- �ݳ� ����
    cr_price INT, -- ��Ʈ ���
    cr_order VARCHAR2(100), -- �ֹ� ��ȣ0
    FOREIGN KEY (cr_mid) REFERENCES c_member(m_id),
    FOREIGN KEY (cr_cname) REFERENCES c_car(c_name)
);
--���� ���� ���� ���̺�
CREATE TABLE c_order_info (
    ID NUMBER PRIMARY KEY,      -- ������
    BUYER_NAME VARCHAR2(255),      -- ������ ���̵�
    BUYER_PHONE VARCHAR2(20),      -- ������ ����ȣ
    MEMBER_EMAIL VARCHAR2(255),      -- ������ �̸���
    BUYER_ADDRESS VARCHAR2(500),   -- ������ �ּ�
    BUY_DATE VARCHAR2(20),      -- ���� ����
    PRODUCT_NAME VARCHAR2(255),      -- ������ ���� �̸�
    BUY_ID VARCHAR2(255),      -- ���Ź�ȣ
    MERCHANT_ID VARCHAR2(255),      -- �ֹ���ȣ
    PAY_PRICE NUMBER,         -- ����
    CARD_NUM VARCHAR2(255),      -- ī���ȣ
    PAY_STATUS VARCHAR2(50),      -- ��������
    POST_CODE NUMBER         -- 
);
-- �������� ���̺�
CREATE TABLE C_SERVICE (
    "CS_NO" NUMBER(*,0),
    "CS_TITLE" VARCHAR2(200 BYTE), 
    "CS_CONT" VARCHAR2(4000 BYTE), 
    "CS_DATE" DATE DEFAULT SYSDATE, 
    "CS_TYPE" VARCHAR2(20 BYTE),
    cs_hit int default 0
);
--Q&A ���̺�
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

-- ���� ���� ���̺� ������
create sequence car_seq
start with 1
increment by 1
nocache;
-- ���� ���̺� ������
create sequence cr_seq
start with 1
increment by 1
nocache;
-- ���� ���� ���̺� ������
create sequence co_seq
start with 1
increment by 1
nocache;
-- �������� ���̺� ������
create sequence cs_seq
start with 1
increment by 1
nocache;
-- Q&A ���̺� ������
create sequence cq_seq
start with 1
increment by 1
nocache;

-- �ڵ��� insert
-- ����
insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '����', 'KIA', '���� RV', '����', '���ָ�', '2023', 'WHITE', 100, 'Gcar01.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '���', 'KIA', '���� ��ġ��', '����', '���ָ�', '2023', 'WHITE', 100, 'Gcar02.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, 'ĳ����', '����', '���� SUV', '����', '���ָ�', '2023', 'BLUE', 200, 'Gcar03.JPG');

-- ����
insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '��ġ��', 'MINI', '���� ��ġ��', '����', '���ָ�', '2024', 'RED', 200, 'Scar01.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '�ڳ�', '����', '���� SUV', '����', '���ָ�', '2023', 'GRAY', 200, 'Scar02.JPG');

-- ���� ����
insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, 'K5', 'KIA', '���� ����', '���� ����', 'LPG, ���ָ�', '2022', 'BLACK', 250, 'Jcar01.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '�Ÿ', '����', '���� ����', '���� ����', 'LPG, ���ָ�', '2019', 'LIGHTGRAY', 250, 'Jcar02.JPG');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '3 �ø���', 'BMW', '���� ����', '���� ����', '���ָ�, ����', '2019', 'WHITE', 300, 'Jcar03.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '���׿�', '�����ٰ�', '���� ����', '���� ����', '����', '2019', 'BLUE', 300, 'Jcar04.JPG');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, 'A4', '�ƿ��', '���� ����', '���� ����', '���ָ�, ����', '2019', 'BLACK', 300, 'Jcar05.png');

-- ���� SUV
insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '��Ÿ�� ���̺긮��', '����', '���� SUV', '���� SUV', '���ָ�, ���̺긮��', '2023', 'WHITE', 350, 'Jcar06.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '���', 'KIA', '���� SUV', '���� SUV', '���ָ�, ����', '2023', 'WHITE', 350, 'Jcar07.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, 'GV70', '���׽ý�', '���� SUV', '���� SUV', '���ָ�, ����', '2022', 'BLACK', 350, 'Jcar08.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, 'X3', 'BMW', '���� SUV', '���� SUV', '���ָ�, ����', '2022', 'BLACK', 350, 'Jcar09.png');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, 'SQ5', '�ƿ��', '���� SUV', '���� SUV', '���ָ�', '2021', 'WHITE', 350, 'Jcar10.png');

-- ������
insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '�ڳ� Electric', '����', '���� SUV', '������', '����', '2023', 'RED', 400, 'Icar01.JPG');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '���̿���6', '����', '���� ����', '������', '����', '2023', 'GRAY', 400, 'Icar02.JPG');

insert into c_car(c_num, c_name, c_brand, c_type, c_type2, c_oil, c_year, c_color, c_price, c_img)
values(car_seq.nextval, '�Ϸ� EV', 'KIA', '���� SUV', '������', '����', '2024', 'RED', 400, 'Icar03.png');

-- admin���� �߰�
insert into c_member (m_id,m_birth,m_email,m_name,m_phone,m_pwd,m_state,m_tel,regdate)
values('admin01','','','','','admin01',9,'',sysdate);

select * from c_member;
select * from c_car;
select * from c_rental;
select * from c_service;

commit;
