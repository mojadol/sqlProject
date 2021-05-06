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


CREATE TABLE BOOKING
(
    `Booking_ID`                                                      INT            NOT NULL    AUTO_INCREMENT COMMENT '예약ID', 
    `Booking_CheckInDate`                                             DATETIME(6)    NOT NULL    COMMENT '예약 체크인 날짜', 
    `Booking_CheckOutDate`                                            DATETIME(6)    NOT NULL    COMMENT '예약 체크아웃 날짜', 
    `Cust_ID`                                                         INT            NOT NULL    COMMENT '고객ID', 
    `People_No`                                                       INT            NOT NULL    COMMENT '고객 명수', 
    `Room_Choice`                                                     INT            NOT NULL    COMMENT '객실 선택', 
    `Bed_PlusState`                                                   VARCHAR(15)    NOT NULL    COMMENT '침대 추가', 
    `RoomPrice_ID`                                                    INT            NOT NULL    COMMENT '객실가격ID', 
    `Booking_TotalAmount[RoomPrice_Amount, Bed_PlusState, PeopleNo]`  INT            NOT NULL    COMMENT '예약 총금액', 
    `Banquet_ID`                                                      INT            NOT NULL    COMMENT '연회ID', 
    `Booking_method`                                                  VARCHAR(15)    NOT NULL    COMMENT '예약 수단', 
    CONSTRAINT  PRIMARY KEY (Booking_ID)
);

ALTER TABLE BOOKING COMMENT '예약';


CREATE TABLE BANQUET
(
    `Banquet_ID`        INT            NOT NULL    AUTO_INCREMENT COMMENT '연회ID', 
    `Banquet_ResState`  VARCHAR(15)    NULL        COMMENT '연회 이용현황', 
    `Banquet_AvailNo`   INT            NOT NULL    COMMENT '이용가능한 연회 번호', 
    `Banquet_Price`     INT            NOT NULL    COMMENT '연회 가격', 
    CONSTRAINT  PRIMARY KEY (Banquet_ID)
);

ALTER TABLE BANQUET COMMENT '연회';


CREATE TABLE CUSTOMER
(
    `Cust_ID`                                     INT            NOT NULL    AUTO_INCREMENT COMMENT '고객ID', 
    `Cust_Name`                                   VARCHAR(15)    NOT NULL    COMMENT '고객 이름', 
    `Cust_Contact`                                INT            NOT NULL    COMMENT '고객 전화번호', 
    `Cust_Email`                                  VARCHAR(30)    NOT NULL    COMMENT '고객 이메일', 
    `Cust_Address`                                VARCHAR(15)    NOT NULL    COMMENT '고객 주소', 
    `Cust_Password`                               INT            NOT NULL    COMMENT '고객 비밀번호', 
    `Cust_CurrentMile[Pay_amount, Cust_usedmile]` INT            NOT NULL    COMMENT '고객의 현재 마일리지', 
    `Cust_Usedmile`                               INT            NOT NULL    COMMENT '고객이 사용한 마일리지', 
    CONSTRAINT  PRIMARY KEY (Cust_ID)
);

ALTER TABLE CUSTOMER COMMENT '고객';


CREATE TABLE ROOMPRICE
(
    `RoomPrice_ID`  INT           NOT NULL    AUTO_INCREMENT COMMENT '객실가격ID', 
    `Room_Price`    INT           NOT NULL    COMMENT '객실 가격', 
    `Room_Week`     BIT(1)        NOT NULL    COMMENT '객실 - 주중/주말', 
    `Room_Peak`     BIT(1)        NOT NULL    COMMENT '객실 - 성수기/비성수기', 
    `Room_ID`       INT           NOT NULL    COMMENT '객실ID', 
    `Room_Type`     VarChar(15)   NOT NULL    COMMENT '객실 타입', 
    CONSTRAINT  PRIMARY KEY (RoomPrice_ID)
);

ALTER TABLE ROOMPRICE COMMENT '객실 가격';


CREATE TABLE ROOMSTATE
(
    `Room_ID`          INT       NOT NULL    AUTO_INCREMENT COMMENT '객실ID', 
    `RoomState_State`  BIT(1)    NULL        COMMENT '객실 이용현황', 
    `Cust_ID`          INT       NOT NULL    COMMENT '고객ID', 
    `Booking_ID`       INT       NOT NULL    COMMENT '예약ID', 
    `Service_ID`       INT       NOT NULL    COMMENT '서비스ID', 
    CONSTRAINT  PRIMARY KEY (Room_ID)
);

ALTER TABLE ROOMSTATE COMMENT '객실상태';


CREATE TABLE ROOM
(
    `Room_ID`        INT            NOT NULL    AUTO_INCREMENT COMMENT '객실ID', 
    `Room_Type`      VarChar(15)    NOT NULL    COMMENT '객실 타입', 
    `Room_Facility`  VarChar(15)    NOT NULL    COMMENT '객실 내 시설', 
    `Room_AvailNo.`  VarChar(15)    NOT NULL    COMMENT '이용가능한 객실 번호', 
    `Room_ResState`  VarChar(15)    NULL        COMMENT '객실 예약현황', 
    `Bed_ID`         INT            NOT NULL    COMMENT '침대ID', 
    CONSTRAINT  PRIMARY KEY (Room_ID)
);

ALTER TABLE ROOM COMMENT '객실';


CREATE TABLE FACILITY
(
    `Fac_ID`     INT        NOT NULL    AUTO_INCREMENT COMMENT '시설이름', 
    `Fac_Price`  INT        NOT NULL    COMMENT '시설가격', 
    `Fac_Type`   VARCHAR(10)    NOT NULL    COMMENT '시설유형', 
    CONSTRAINT  PRIMARY KEY (Fac_ID)
);

ALTER TABLE FACILITY COMMENT '시설';


CREATE TABLE FACILITYREQUIREMENT
(
    `FacReq_ID`           INT    NOT NULL    AUTO_INCREMENT COMMENT '시설요구이름', 
    `Fac_ID`              INT    NOT NULL    COMMENT '시설이름', 
    `Fac_Count`           INT    NOT NULL    COMMENT '시설 갯수', 
    `FacReq_TotalAmount`  INT    NOT NULL    COMMENT '시설요구의 총량', 
    `KEY_ID`              INT    NOT NULL    COMMENT '키이름', 
    `Cust_ID`             INT    NOT NULL    COMMENT '고객이름', 
    CONSTRAINT  PRIMARY KEY (FacReq_ID)
);

ALTER TABLE FACILITYREQUIREMENT COMMENT '시설요구';


CREATE TABLE FINE
(
    `Fine_ID`      INT        NOT NULL    AUTO_INCREMENT COMMENT '벌금이름', 
    `Fine_Amount`  INT      NOT NULL    COMMENT '벌금총량', 
    `Fine_reason`  VARCHAR(15)    NOT NULL    COMMENT '벌금이유', 
    `Cust_ID`      INT        NOT NULL    COMMENT '고객이름', 
    `Room_ID`      INT        NOT NULL    COMMENT '방이름', 
    CONSTRAINT  PRIMARY KEY (Fine_ID)
);

ALTER TABLE FINE COMMENT '벌금';


CREATE TABLE CARDKEY
(
    `KEY_ID`   INT    NOT NULL    AUTO_INCREMENT COMMENT '키이름', 
    `Room_ID`  INT    NOT NULL    COMMENT '방이름', 
    `Cust_ID`  INT    NOT NULL    COMMENT '고객이름', 
    CONSTRAINT  PRIMARY KEY (KEY_ID)
);

ALTER TABLE CARDKEY COMMENT '카드키';


CREATE TABLE RESTAURANT
(
    `Res_ID`          INT        NOT NULL    AUTO_INCREMENT COMMENT '식당이름', 
    `Res_Type`        VarChar(15)    NOT NULL    COMMENT '식당유형', 
    `Res_Menu`        VarChar(15)    NOT NULL    COMMENT '식당메뉴', 
    `Res_Menu_Price`  INT       NOT NULL    COMMENT '식당메뉴 가격', 
    CONSTRAINT  PRIMARY KEY (Res_ID, Res_Menu)
);

ALTER TABLE RESTAURANT COMMENT '식당';


-- CUSTOMER Table Create SQL
CREATE TABLE RESTAURANTORDER
(
    `ResOrder_ID`                                 INT         NOT NULL    AUTO_INCREMENT COMMENT '주문한 번호', 
    `ResOrder_Menu`                               VarChar(15)     NOT NULL    COMMENT '주문한 메뉴', 
    `ResOrder_Date`                               DATETIME(6)    NOT NULL    COMMENT '주문 날짜', 
    `RestOrder_TotalAmount[Res_Menu, Res_Price]`  INT         NOT NULL    COMMENT '주문의 총량', 
    `KEY_ID`                                      INT         NOT NULL    COMMENT '키 이름', 
    `Res_ID`                                      INT        NOT NULL    COMMENT '레스토랑 이름', 
    `Cust_ID`                                     INT        NOT NULL    COMMENT '고객 이름', 
    CONSTRAINT  PRIMARY KEY (ResOrder_ID, ResOrder_Date)
);

ALTER TABLE RESTAURANTORDER COMMENT '레스토랑 주문';

-- 주석 --

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

ALTER TABLE BOOKING
    ADD CONSTRAINT FK_BOOKING_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE BOOKING
    ADD CONSTRAINT FK_BOOKING_Banquet_ID_BANQUET_Banquet_ID FOREIGN KEY (Banquet_ID)
        REFERENCES BANQUET (Banquet_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE BOOKING
    ADD CONSTRAINT FK_BOOKING_RoomPrice_ID_ROOMPRICE_RoomPrice_ID FOREIGN KEY (RoomPrice_ID)
        REFERENCES ROOMPRICE (RoomPrice_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE ROOMPRICE
    ADD CONSTRAINT FK_ROOMPRICE_Room_ID_ROOMSTATE_Room_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOMSTATE (Room_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE ROOMSTATE
    ADD CONSTRAINT FK_ROOMSTATE_Room_ID_ROOM_Room_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOM (Room_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE ROOMSTATE
    ADD CONSTRAINT FK_ROOMSTATE_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE ROOMSTATE
    ADD CONSTRAINT FK_ROOMSTATE_Booking_ID_BOOKING_Booking_ID FOREIGN KEY (Booking_ID)
        REFERENCES BOOKING (Booking_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE ROOMSTATE
    ADD CONSTRAINT FK_ROOMSTATE_Service_ID_SERVICE_Service_ID FOREIGN KEY (Service_ID)
        REFERENCES SERVICE (Service_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;
        
ALTER TABLE ROOM
    ADD CONSTRAINT FK_ROOM_Bed_ID_BED_Bed_ID FOREIGN KEY (Bed_ID)
        REFERENCES BED (Bed_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;
        
ALTER TABLE FACILITYREQUIREMENT
    ADD CONSTRAINT FK_FACILITYREQUIREMENT_Fac_ID_FACILITY_Fac_ID FOREIGN KEY (Fac_ID)
        REFERENCES FACILITY (Fac_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE FACILITYREQUIREMENT
    ADD CONSTRAINT FK_FACILITYREQUIREMENT_KEY_ID_CARDKEY_KEY_ID FOREIGN KEY (KEY_ID)
        REFERENCES CARDKEY (KEY_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE FACILITYREQUIREMENT
    ADD CONSTRAINT FK_FACILITYREQUIREMENT_Cust_ID_BOOKING_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;
        
ALTER TABLE FINE
    ADD CONSTRAINT FK_FINE_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE FINE
    ADD CONSTRAINT FK_FINE_Room_ID_ROOMSTATE_Room_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOMSTATE (Room_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CARDKEY
    ADD CONSTRAINT FK_CARDKEY_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CARDKEY
    ADD CONSTRAINT FK_CARDKEY_Room_ID_ROOMSTATE_ROOM_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOMSTATE (Room_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;
        
ALTER TABLE RESTAURANTORDER
    ADD CONSTRAINT FK_RESTAURANTORDER_KEY_ID_CARDKEY_KEY_ID FOREIGN KEY (KEY_ID)
        REFERENCES CARDKEY (KEY_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE RESTAURANTORDER
    ADD CONSTRAINT FK_RESTAURANTORDER_Res_ID_RESTAURANT_Res_ID FOREIGN KEY (Res_ID)
        REFERENCES RESTAURANT (Res_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE RESTAURANTORDER
    ADD CONSTRAINT FK_RESTAURANTORDER_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- ★desc★ 하는법 --
desc 테이블이름;
desc customer;
