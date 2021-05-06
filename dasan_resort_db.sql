CREATE DATABASE dasan_resort;
use dasan_resort;

CREATE TABLE CUSTOMER
(
    `Cust_ID`                                     INT            NOT NULL    AUTO_INCREMENT COMMENT '고객 ID', 
    `Cust_Name`                                   VARCHAR(15)    NOT NULL    COMMENT '고객 이름', 
    `Cust_Contact`                                INT            NOT NULL    COMMENT '고객 연락처', 
    `Cust_Email`                                  VARCHAR(30)    NOT NULL    COMMENT '고객 이메일', 
    `Cust_Address`                                VARCHAR(15)    NOT NULL    COMMENT '고객 주소', 
    `Cust_Password`                               INT            NOT NULL    COMMENT '고객 비밀번호', 
    `Cust_CurrentMile[Pay_amount,Cust_usedmile]`  INT            NOT NULL    COMMENT '고객 현재 마일리지[지불금액*0.01-기사용 마일리지]', 
    `Cust_Usedmile`                               INT            NOT NULL    COMMENT '고객 기사용 마일리지', 
    CONSTRAINT  PRIMARY KEY (Cust_ID)
);

ALTER TABLE CUSTOMER COMMENT '고객 정보 테이블';

-- CUSTOMER Table Create SQL
CREATE TABLE PAYMENT
(
    `Pay_ID`                                                                        INT             NOT NULL    AUTO_INCREMENT COMMENT '지불 ID', 
    `Pay_TotalAmount[skip]`                                                         INT             NOT NULL    COMMENT '지불 총 금액[식당 주문 총 금액 + 서비스 이용 총 금액 + 시설 이용 총 금액]', 
    `Pay_Date`                                                                      DATETIME(6)     NOT NULL    COMMENT '지불 날짜', 
    `Pay_Type`                                                                      VarChar(15)     NOT NULL    COMMENT '지불 수단', 
    `KEY_ID`                                                                        INT             NOT NULL    COMMENT '카드키 ID', 
    `ResOrder_ID`                                                                   INT             NOT NULL    COMMENT '식당 주문 ID', 
    `SerReq_ID`                                                                     INT             NOT NULL    COMMENT '서비스 요청 ID', 
    `FacReq_ID`                                                                     INT             NOT NULL    COMMENT '시설 이용 ID', 
    `Cust_ID`                                                                       INT             NOT NULL    COMMENT '고객 ID', 
    CONSTRAINT  PRIMARY KEY (Pay_ID)
);

ALTER TABLE PAYMENT COMMENT '지불 테이블';

-- CUSTOMER Table Create SQL
CREATE TABLE SERVICE
(
    `Service_ID`     INT            NOT NULL    AUTO_INCREMENT COMMENT '서비스 ID', 
    `Service_Type`   INT            NOT NULL    COMMENT '서비스 유형', 
    `Service_Price`  VarChar(15)    NOT NULL    COMMENT '서비스 가격', 
    CONSTRAINT  PRIMARY KEY (Service_ID)
);

ALTER TABLE SERVICE COMMENT '서비스 테이블';

-- CUSTOMER Table Create SQL
CREATE TABLE SERVICEREQUIREMENT
(
    `SerReq_ID`                                                         INT        NOT NULL    AUTO_INCREMENT COMMENT '서비스 요청 ID', 
    `Service_ID`                                                        INT        NOT NULL    COMMENT '서비스 ID', 
    `SerReq_Count`                                                      INT        NOT NULL    COMMENT '서비스 요청 횟수', 
    `SerReq_TotalAmount[Service_Type,Service_Price,Service_UsedCount]`  INT        NOT NULL    COMMENT '서비스 이용 총 금액[]', 
    `KEY_ID`                                                            INT        NOT NULL    COMMENT '카드키 ID', 
    `Cust_ID`                                                           INT        NOT NULL    COMMENT '고객 ID', 
    CONSTRAINT  PRIMARY KEY (SerReq_ID)
);

ALTER TABLE SERVICEREQUIREMENT COMMENT '고객 서비스 요청 테이블';

-- CUSTOMER Table Create SQL
CREATE TABLE BED
(
    `Bed_ID`         INT            NOT NULL    AUTO_INCREMENT COMMENT '침대 ID', 
    `Bed_Type`       VarChar(15)    NOT NULL    COMMENT '침대 유형', 
    `Bed_State`      VarChar(15)    NULL        COMMENT '침대 상태', 
    `Bed_Available`  INT            NOT NULL    COMMENT '침대 이용 가능 숫자', 
    CONSTRAINT  PRIMARY KEY (Bed_ID)
);

ALTER TABLE BED COMMENT '침대 테이블';


ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_KEY_ID_CARDKEY_KEY_ID FOREIGN KEY (KEY_ID)
        REFERENCES CARDKEY (KEY_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_ResOrder_ID_RESTAURANTORDER_ResOrder_ID FOREIGN KEY (ResOrder_ID)
        REFERENCES RESTAURANTORDER (ResOrder_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_SerReq_ID_SERVICEREQUIREMENT_SerReq_ID FOREIGN KEY (SerReq_ID)
        REFERENCES SERVICEREQUIREMENT (SerReq_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_FacReq_ID_FACILITYREQUIREMENT_FacReq_ID FOREIGN KEY (FacReq_ID)
        REFERENCES FACILITYREQUIREMENT (FacReq_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE SERVICEREQUIREMENT
    ADD CONSTRAINT FK_SERVICEREQUIREMENT_Service_ID_SERVICE_Service_ID FOREIGN KEY (Service_ID)
        REFERENCES SERVICE (Service_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE SERVICEREQUIREMENT
    ADD CONSTRAINT FK_SERVICEREQUIREMENT_KEY_ID_CARDKEY_KEY_ID FOREIGN KEY (KEY_ID)
        REFERENCES CARDKEY (KEY_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE SERVICEREQUIREMENT
    ADD CONSTRAINT FK_SERVICEREQUIREMENT_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

