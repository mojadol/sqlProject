CREATE DATABASE dasan_resort;
use dasan_resort;


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
    ADD CONSTRAINT FK_ROOM PRICE_Room_ID_ROOMSTATE_Room_ID FOREIGN KEY (Room_ID)
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
