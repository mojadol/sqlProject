CREATE DATABASE dasan_resort;
use dasan_resort;

CREATE TABLE CUSTOMER
(
    `Cust_ID`                                     INT            NOT NULL    AUTO_INCREMENT COMMENT '고객 ID', 
    `Cust_webID`                                  VARCHAR(15)    NOT NULL    COMMENT '고객 홈페이지 ID',
    `Cust_Name`                                   VARCHAR(15)    NOT NULL    COMMENT '고객 이름', 
    `Cust_Contact`                                VARCHAR(15)            NOT NULL    COMMENT '고객 연락처', 
    `Cust_Email`                                  VARCHAR(30)    NOT NULL    COMMENT '고객 이메일', 
    `Cust_Address`                                VARCHAR(50)    NOT NULL    COMMENT '고객 주소', 
    `Cust_Password`                               varchar(15)            NOT NULL    COMMENT '고객 비밀번호', 
    `Cust_CurrentMile`                            INT            NOT NULL    DEFAULT 0   COMMENT '고객 현재 마일리지[지불금액*0.01-기사용 마일리지]', 
    `Cust_Usedmile`                               INT            NOT NULL    DEFAULT 0   COMMENT '고객 기사용 마일리지', 
    CONSTRAINT  PRIMARY KEY (Cust_ID)
);

ALTER TABLE CUSTOMER COMMENT '고객 정보 테이블';

-- CUSTOMER Table Create SQL
CREATE TABLE PAYMENT
(
    `Pay_ID`                                                                        INT             NOT NULL    AUTO_INCREMENT COMMENT '지불 ID', 
    `Pay_TotalAmount`                                                               INT             NOT NULL    DEFAULT 0   COMMENT '지불 총 금액[식당 주문 총 금액 + 서비스 이용 총 금액 + 시설 이용 총 금액]', 
    `Pay_Date`                                                                      DATETIME(6)     NOT NULL    COMMENT '지불 날짜 및 시간', 
    `Pay_Type`                                                                      VARCHAR(15)     CHECK (Pay_Type IN ('카드키','신용카드','현금','수표'))    NOT NULL    COMMENT '지불 수단', 
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
    `Service_Type`   VarChar(15)    CHECK(Service_Type IN ('슈샤인','수원 전통주 체험', '광교호 둘레길 투어','다도체험','수원 화성 투어','농장 체험','떡 만들기'))    NOT NULL    COMMENT '서비스 유형', 
    `Service_Price`  VarChar(15)    CHECK(Service_Price IN ('3000', '50000','30000','40000','60000'))    NOT NULL    COMMENT '서비스 가격', 
    CONSTRAINT  PRIMARY KEY (Service_ID)
);

ALTER TABLE SERVICE COMMENT '서비스 테이블';

-- CUSTOMER Table Create SQL
CREATE TABLE SERVICEREQUIREMENT
(
    `SerReq_ID`                                                         INT        NOT NULL    AUTO_INCREMENT COMMENT '서비스 요청 ID', 
    `Service_ID`                                                        INT        NOT NULL    COMMENT '서비스 ID', 
    `SerReq_Count`                                                      INT        NOT NULL    DEFAULT 0   COMMENT '서비스 요청 횟수', 
    `SerReq_TotalAmount`                                                INT        NOT NULL    DEFAULT 0   COMMENT '서비스 이용 총 금액[Service_Type,Service_Price,Service_UsedCount]', 
    `KEY_ID`                                                            INT        NOT NULL    COMMENT '카드키 ID', 
    `Cust_ID`                                                           INT        NOT NULL    COMMENT '고객 ID', 
    CONSTRAINT  PRIMARY KEY (SerReq_ID)
);

ALTER TABLE SERVICEREQUIREMENT COMMENT '고객 서비스 요청 테이블';

-- CUSTOMER Table Create SQL
CREATE TABLE BED
(
    `Bed_ID`         INT            NOT NULL    AUTO_INCREMENT COMMENT '침대 ID', 
    `Bed_Type`       VarChar(15)    CHECK (Bed_Type IN ('더블베드','킹'))    NOT NULL    COMMENT '침대 유형', 
    `Bed_State`      VarChar(15)    CHECK (Bed_State IN ('부서짐','수리필요','사용가능'))    NULL        COMMENT '침대 상태', 
    `Bed_Available`  INT            NOT NULL    COMMENT '침대 이용 가능 숫자',
    `Room_ID`        INT            NOT NULL    COMMENT '객실 번호',
    CONSTRAINT  PRIMARY KEY (Bed_ID)
);

ALTER TABLE BED COMMENT '침대 테이블';


CREATE TABLE BOOKING
(
    `Booking_ID`                                                      INT            NOT NULL    AUTO_INCREMENT COMMENT '예약ID', 
    `Booking_CheckInDate`                                             DATETIME(6)    NOT NULL    COMMENT '예약 체크인 날짜 및 시간', 
    `Booking_CheckOutDate`                                            DATETIME(6)    NOT NULL    COMMENT '예약 체크아웃 날짜 및 시간', 
    `Cust_ID`                                                         INT            NOT NULL    COMMENT '고객ID', 
    `People_No`                                                       INT            NOT NULL    COMMENT '고객 명수', 
    `Room_Choice`                                                     VARCHAR(15)    CHECK (Room_Choice IN('디럭스룸','비즈니스룸','수페리어룸','디럭스룸 suite','비즈니스룸 suite', '수페리어룸 suite'))    NOT NULL    COMMENT '객실 선택', 
    `Bed_PlusState`                                                   VARCHAR(15)    CHECK (Bed_PlusState IN ('추가 가능','추가 불가능'))    NOT NULL    COMMENT '침대 추가', 
    `RoomPrice_ID`                                                    INT            NOT NULL    COMMENT '객실가격ID', 
    `Booking_TotalAmount`                                             INT            NOT NULL    DEFAULT 0   COMMENT '예약 총금액[RoomPrice_Amount, Bed_PlusState, PeopleNo]', 
    `Booking_method`                                                  VARCHAR(15)    CHECK (Booking_method IN ('홈페이지','전화','방문'))    NOT NULL    COMMENT '예약 수단', 
    CONSTRAINT  PRIMARY KEY (Booking_ID)
);

ALTER TABLE BOOKING COMMENT '예약 테이블';



CREATE TABLE ROOMPRICE
(
    `RoomPrice_ID`  INT           NOT NULL    AUTO_INCREMENT COMMENT '객실가격ID', 
    `Room_Price`    INT           Check (Room_Price IN('200000','300000','400000','500000','600000','700000'))   NOT NULL    COMMENT '객실 가격', 
    `Room_Week`     BOOL          NOT NULL    DEFAULT 0   COMMENT '객실 - 주중/주말', 
    `Room_Peak`     BOOL          NOT NULL    DEFAULT 0   COMMENT '객실 - 성수기/비성수기', 
    `Room_ID`       INT           NOT NULL    COMMENT '객실ID', 
    `Room_Type`     VarChar(15)   NOT NULL    COMMENT '객실 타입', 
    CONSTRAINT  PRIMARY KEY (RoomPrice_ID)
);

ALTER TABLE ROOMPRICE COMMENT '객실 가격 테이블';


CREATE TABLE ROOMSTATE
(
    `Room_ID`          INT       NOT NULL   COMMENT '객실ID', 
    `RoomState_State`  BOOL      NULL        COMMENT '객실 이용현황', 
    `Cust_ID`          INT       NOT NULL    COMMENT '고객ID', 
    `Booking_ID`       INT       NOT NULL    COMMENT '예약ID', 
    `Service_ID`       INT       NOT NULL    COMMENT '서비스ID', 
    CONSTRAINT  PRIMARY KEY (Room_ID)
);

ALTER TABLE ROOMSTATE COMMENT '객실상태 테이블';


CREATE TABLE ROOM
(
    `Room_ID`        INT            NOT NULL    AUTO_INCREMENT COMMENT '객실ID', 
    `Room_Type`      VarChar(15)    CHECK (Room_Type IN('디럭스룸','비즈니스룸','수페리어룸','디럭스룸 suite','비즈니스룸 suite', '수페리어룸 suite'))    NOT NULL    COMMENT '객실 타입', 
    `Room_AvailNo`  INT    NOT NULL    COMMENT '이용가능한 사람 수', 
    `Room_ResState`  BOOL         NULL        DEFAULT 0   COMMENT '객실 예약현황', 
    CONSTRAINT  PRIMARY KEY (Room_ID)
);

ALTER TABLE ROOM COMMENT '객실 테이블';


CREATE TABLE FACILITY
(
    `Fac_ID`     INT        NOT NULL    AUTO_INCREMENT COMMENT '시설ID', 
    `Fac_Price`  INT        NOT NULL    COMMENT '시설가격', 
    `Fac_Type`   VARCHAR(10)    CHECK (Fac_Type IN ('슈퍼마켓','마사지룸','사우나','수영장','헬스클럽','눈썰매장','빙어낚시','워터파크','바베큐','별보기'))    NOT NULL    COMMENT '시설유형', 
    CONSTRAINT  PRIMARY KEY (Fac_ID)
);

ALTER TABLE FACILITY COMMENT '시설 테이블';


CREATE TABLE FACILITYREQUIREMENT
(
    `FacReq_ID`           INT    NOT NULL    AUTO_INCREMENT COMMENT '시설요청ID', 
    `Fac_ID`              INT    NOT NULL    COMMENT '시설 이름', 
    `Fac_Count`           INT    NOT NULL    COMMENT '시설요청 회수', 
    `FacReq_TotalAmount`  INT    NOT NULL    DEFAULT 0   COMMENT '시설 요청의 총액', 
    `KEY_ID`              INT    NOT NULL    COMMENT '키이름', 
    `Cust_ID`             INT    NOT NULL    COMMENT '고객이름', 
    CONSTRAINT  PRIMARY KEY (FacReq_ID)
);

ALTER TABLE FACILITYREQUIREMENT COMMENT '시설 요청 테이블';


CREATE TABLE FINE
(
    `Fine_ID`      INT        NOT NULL    AUTO_INCREMENT COMMENT '벌금ID', 
    `Fine_Amount`  INT      NOT NULL    DEFAULT 0   COMMENT '벌금액', 
    `Fine_reason`  VARCHAR(15)    CHECK (Fine_reason IN ('취사','흡연','카드키 분실'))    NOT NULL    COMMENT '벌금 사유', 
    `Cust_ID`      INT        NOT NULL    COMMENT '고객이름', 
    `Room_ID`      INT        NOT NULL    COMMENT '방이름', 
    CONSTRAINT  PRIMARY KEY (Fine_ID)
);

ALTER TABLE FINE COMMENT '벌금';


CREATE TABLE CARDKEY
(
    `KEY_ID`   INT    NOT NULL    AUTO_INCREMENT   COMMENT '키이름', 
    `Room_ID`  INT    NOT NULL    COMMENT '방이름', 
    `Cust_ID`  INT    NOT NULL    COMMENT '고객이름', 
    CONSTRAINT  PRIMARY KEY (KEY_ID)
);

ALTER TABLE CARDKEY COMMENT '카드키 테이블';


CREATE TABLE RESTAURANT
(
    `Res_ID`          INT            NOT NULL    AUTO_INCREMENT COMMENT '식당이름', 
    `Res_Type`        VarChar(15)    CHECK (Res_Type IN ('중식당','일식당','한식당','이탈리안식당','바','노래주점','치킨집'))    NOT NULL    COMMENT '식당유형', 
    `Res_Menu`        VarChar(15)    CHECK (Res_Menu IN ('짜장면','우동','비빔밥','파스타','칵테일','맥주','바삭한 치킨'))      NOT NULL    COMMENT '식당메뉴', 
    `Res_Menu_Price`  INT            CHECK (Res_Menu_Price IN ('5000','4000','6000','15000','10000','4500','20000'))      NOT NULL    COMMENT '식당메뉴 가격', 
    CONSTRAINT  PRIMARY KEY (Res_ID, Res_Menu)
);

ALTER TABLE RESTAURANT COMMENT '식당 테이블';


-- CUSTOMER Table Create SQL
CREATE TABLE RESTAURANTORDER
(
    `ResOrder_ID`                                 INT         NOT NULL    AUTO_INCREMENT COMMENT '주문 번호', 
    `ResOrder_Menu`                               VarChar(15)     CHECK (ResOrder_Menu IN ('짜장면','우동','비빔밥','파스타','칵테일','맥주','바삭한 치킨'))    NOT NULL    COMMENT '주문 메뉴', 
    `ResOrder_Date`                               DATETIME(6)    NOT NULL    COMMENT '주문 날짜 및 시간', 
    `ResOrder_TotalAmount`                       INT         NOT NULL    DEFAULT 0   COMMENT '주문 총액, [Res_Menu, Res_Price]', 
    `KEY_ID`                                      INT         NOT NULL    COMMENT '키ID', 
    `Res_ID`                                      INT        NOT NULL    COMMENT '레스토랑ID', 
    `Cust_ID`                                     INT        NOT NULL    COMMENT '고객ID', 
    CONSTRAINT  PRIMARY KEY (ResOrder_ID, ResOrder_Date)
);

ALTER TABLE RESTAURANTORDER COMMENT '레스토랑 주문 테이블';

CREATE TABLE SHUTTLE
(
    `Shuttle_ID`                                 INT         NOT NULL    AUTO_INCREMENT COMMENT '셔틀 번호', 
    `Shuttle_Type`                               VarChar(15) CHECK (Shuttle_Type IN ('버스'))    NOT NULL    COMMENT '셔틀 타입', 
	`Shuttle_Depart`                       VarChar(15)   CHECK (Shuttle_Depart IN ('리조트','공항','화성행궁'))    NOT NULL    DEFAULT 0   COMMENT '셔틀 출발지', 
    `Shuttle_Arrive`                                      VarChar(15)   CHECK (Shuttle_Arrive IN ('리조트','공항','화성행궁'))      NOT NULL    COMMENT '셔틀 도착지', 
    `Shuttle_DepartTime`                                      TIME    CHECK (Shuttle_DepartTime IN ('09:00','10:00','20:00'))    NOT NULL    COMMENT '셔틀 출발시간', 
    `Cust_ID`                                     INT        NOT NULL    COMMENT '고객ID', 
    CONSTRAINT  PRIMARY KEY (Shuttle_ID)
);

ALTER TABLE SHUTTLE COMMENT '셔틀버스 테이블';

CREATE TABLE BOOKCANCEL
(
    `Can_ID`                                 INT         NOT NULL    AUTO_INCREMENT COMMENT '취소 번호', 
    `Can_Reason`                               VarChar(15)     NOT NULL    COMMENT '취소 이유', 
    `Can_date`                               DATETIME(6)    NOT NULL    COMMENT '취소 날짜', 
    `Can_Datedif`                       INT         NOT NULL    DEFAULT 0   COMMENT '취소와 날짜차이', 
    `Can_Refund`                                      INT         NOT NULL    COMMENT '취소 환불총액', 
    `Booking_ID`                                      INT        NOT NULL    COMMENT '예약 번호', 
    `Pol_ID`                                     INT        NOT NULL    COMMENT '정책 번호', 
    `Room_ID`        INT            NOT NULL    NOT NULL COMMENT '객실ID',
    CONSTRAINT  PRIMARY KEY (Can_ID)
);

ALTER TABLE BOOKCANCEL COMMENT '예약취소 테이블';

CREATE TABLE CANCELPOLICY
(
    `Pol_ID`                                 INT         NOT NULL    AUTO_INCREMENT COMMENT '정책 번호', 
    `Pol_Datedif`                            INT         NOT NULL    COMMENT '날짜차이 정의', 
    `Pol_RefundRate`                         INT         NOT NULL    COMMENT '환불 비율', 
    CONSTRAINT  PRIMARY KEY (Pol_ID)
);

ALTER TABLE CANCELPOLICY COMMENT '노쇼 정책 테이블';



-- 주석 --

ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_KEY_ID_CARDKEY_KEY_ID FOREIGN KEY (KEY_ID)
        REFERENCES CARDKEY (KEY_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_ResOrder_ID_RESTAURANTORDER_ResOrder_ID FOREIGN KEY (ResOrder_ID)
        REFERENCES RESTAURANTORDER (ResOrder_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_SerReq_ID_SERVICEREQUIREMENT_SerReq_ID FOREIGN KEY (SerReq_ID)
        REFERENCES SERVICEREQUIREMENT (SerReq_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_FacReq_ID_FACILITYREQUIREMENT_FacReq_ID FOREIGN KEY (FacReq_ID)
        REFERENCES FACILITYREQUIREMENT (FacReq_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE SERVICEREQUIREMENT
    ADD CONSTRAINT FK_SERVICEREQUIREMENT_Service_ID_SERVICE_Service_ID FOREIGN KEY (Service_ID)
        REFERENCES SERVICE (Service_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE SERVICEREQUIREMENT
    ADD CONSTRAINT FK_SERVICEREQUIREMENT_KEY_ID_CARDKEY_KEY_ID FOREIGN KEY (KEY_ID)
        REFERENCES CARDKEY (KEY_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE SERVICEREQUIREMENT
    ADD CONSTRAINT FK_SERVICEREQUIREMENT_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE BOOKING
    ADD CONSTRAINT FK_BOOKING_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE BOOKING
    ADD CONSTRAINT FK_BOOKING_RoomPrice_ID_ROOMPRICE_RoomPrice_ID FOREIGN KEY (RoomPrice_ID)
        REFERENCES ROOMPRICE (RoomPrice_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ROOMPRICE
    ADD CONSTRAINT FK_ROOMPRICE_Room_ID_ROOM_Room_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOM (Room_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ROOMSTATE
    ADD CONSTRAINT FK_ROOMSTATE_Room_ID_ROOM_Room_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOM (Room_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ROOMSTATE
    ADD CONSTRAINT FK_ROOMSTATE_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ROOMSTATE
    ADD CONSTRAINT FK_ROOMSTATE_Booking_ID_BOOKING_Booking_ID FOREIGN KEY (Booking_ID)
        REFERENCES BOOKING (Booking_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ROOMSTATE
    ADD CONSTRAINT FK_ROOMSTATE_Service_ID_SERVICE_Service_ID FOREIGN KEY (Service_ID)
        REFERENCES SERVICE (Service_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE BED
    ADD CONSTRAINT FK_Bed_ROOM_ID_ROOM_Room_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOM (ROOM_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE FACILITYREQUIREMENT
    ADD CONSTRAINT FK_FACILITYREQUIREMENT_Fac_ID_FACILITY_Fac_ID FOREIGN KEY (Fac_ID)
        REFERENCES FACILITY (Fac_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE FACILITYREQUIREMENT
    ADD CONSTRAINT FK_FACILITYREQUIREMENT_KEY_ID_CARDKEY_KEY_ID FOREIGN KEY (KEY_ID)
        REFERENCES CARDKEY (KEY_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE FACILITYREQUIREMENT
    ADD CONSTRAINT FK_FACILITYREQUIREMENT_Cust_ID_BOOKING_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE FINE
    ADD CONSTRAINT FK_FINE_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE FINE
    ADD CONSTRAINT FK_FINE_Room_ID_ROOMSTATE_Room_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOMSTATE (Room_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE CARDKEY
    ADD CONSTRAINT FK_CARDKEY_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE CARDKEY
    ADD CONSTRAINT FK_CARDKEY_Room_ID_ROOMSTATE_ROOM_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOMSTATE (Room_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE RESTAURANTORDER
    ADD CONSTRAINT FK_RESTAURANTORDER_KEY_ID_CARDKEY_KEY_ID FOREIGN KEY (KEY_ID)
        REFERENCES CARDKEY (KEY_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE RESTAURANTORDER
    ADD CONSTRAINT FK_RESTAURANTORDER_Res_ID_RESTAURANT_Res_ID FOREIGN KEY (Res_ID)
        REFERENCES RESTAURANT (Res_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE RESTAURANTORDER
    ADD CONSTRAINT FK_RESTAURANTORDER_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE SHUTTLE
    ADD CONSTRAINT FK_SHUTTLE_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE BOOKCANCEL
    ADD CONSTRAINT FK_BOOKCANCEL_Booking_ID_BOOKING_Booking_ID FOREIGN KEY (Booking_ID)
        REFERENCES BOOKING (Booking_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE BOOKCANCEL
    ADD CONSTRAINT FK_BOOKCANCEL_Room_ID_ROOMSTATE_Room_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOM (Room_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE BOOKCANCEL
    ADD CONSTRAINT FK_BOOKCANCEL_Pol_ID_CANCELPOLICY_Pol_ID FOREIGN KEY (Pol_ID)
        REFERENCES CANCELPOLICY (Pol_ID) ON DELETE CASCADE ON UPDATE CASCADE;
       
	
-- ★desc★ 하는법 --
desc bed;
desc booking;
desc cardkey;
desc customer;
desc facility;
desc facilityrequirement;
desc fine;
desc payment;
desc restaurant;
desc restaurantorder;
desc room;
desc roomprice;
desc roomstate;
desc service;
desc servicerequirement;

-- 1번 순서 --

INSERT INTO RESTAURANT (Res_Type, Res_Menu, Res_Menu_Price) VALUE ('한식당', '비빔밥', '6000');

INSERT INTO SERVICE (Service_Type, Service_Price) VALUE ('떡 만들기', '60000');

INSERT INTO ROOM (Room_Type, Room_AvailNo, Room_ResState) VALUE ('디럭스룸', '2', '1');

INSERT INTO CUSTOMER(Cust_webID,Cust_Name,Cust_Contact,Cust_Email,Cust_Address,Cust_Password,Cust_CurrentMile,Cust_Usedmile) 
Values ('choco','이성규','010-4906-8347','loveleemoon@naver.com','경기도 화성시','sg1234',3000,0);

INSERT INTO FACILITY(Fac_Price,Fac_Type) Values ('30000','슈퍼마켓');

INSERT INTO CANCELPOLICY(Pol_Datedif,Pol_RefundRate) Values ('1', '0.2');

-- 2번 순서 --

INSERT INTO SHUTTLE (Shuttle_Type, Shuttle_Depart, Shuttle_Arrive, Shuttle_DepartTime, Cust_ID) VALUE ('버스', '공항', '리조트', '10:00', '1');

INSERT INTO BED (Bed_Type, Bed_State, Bed_Available, Room_ID) VALUE ('킹', '사용가능', '250', '1');

-- 3번 순서 --

INSERT INTO ROOMPRICE (Room_Price, Room_Week, Room_Peak, Room_ID, Room_Type) VALUE ('200000', '0', '1', '1', '디럭스룸');

INSERT INTO BOOKING (Booking_CheckInDate, Booking_CheckOutDate, Cust_ID, People_No, Room_Choice, Bed_PlusState, RoomPrice_ID, Booking_TotalAmount, Booking_method) VALUE ('2021-06-04 15:00:00', '2021-06-06 11:00:00', '1',  '2', '디럭스룸', '추가 불가능', '1', '400000', '홈페이지');

-- 4번 순서 --

INSERT INTO BOOKCANCEL (Can_Reason, Can_date, Can_Datedif, Can_Refund, Booking_ID, Pol_ID, Room_ID) VALUE ('코로나', '2021-07-01', '3', '10000', '1', '1', '1');

INSERT INTO ROOMSTATE(Room_ID, RoomState_State, Cust_ID, Booking_ID, Service_ID) VALUE ('1','1','1','1','1');

-- 5번 순서 --

INSERT INTO CARDKEY(Room_ID, Cust_ID) VALUE ('1', '1');

-- 6번 순서 --

INSERT INTO SERVICEREQUIREMENT(Service_ID, SerReq_Count, SerReq_TotalAmount, KEY_ID, Cust_ID) VALUE ('1','1','1','1','1');

INSERT INTO FACILITYREQUIREMENT (Fac_ID, Fac_Count, FacReq_TotalAmount, KEY_ID, Cust_ID) VALUE ('1', '3', '30000', '1', '1');

INSERT INTO RESTAURANTORDER (ResOrder_Menu, ResOrder_Date, ResOrder_TotalAmount, KEY_ID, Res_ID, Cust_ID) VALUE('비빔밥', '2021-06-05 19:00:00', '6000', '1', '1', '1');

-- 7번 순서 --

INSERT INTO PAYMENT (Pay_TotalAmount, Pay_Date, Pay_Type, KEY_ID, ResOrder_ID, SerReq_ID, FacReq_ID, Cust_ID) VALUE ('36000', '2021-06-05 19:00:00', '카드키', '1', '1', '1', '1', '1');

