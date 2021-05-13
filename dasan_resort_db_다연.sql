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
    `Service_Price`  VarChar(15)    CHECK(Service_Price IN ('3000', '50000','30000','40000','60000','70000','20000'))    NOT NULL    COMMENT '서비스 가격', 
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
    `Room_ID`        INT            NULL    COMMENT '객실 번호',
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
    `Bed_PlusState`                                                   INT            NOT NULL    COMMENT '침대 추가', 
    `RoomPrice_ID`                                                    INT            NOT NULL    COMMENT '객실가격ID', 
    `Booking_TotalAmount`                                             INT            NOT NULL    DEFAULT 0   COMMENT '예약 총금액[RoomPrice_Amount, Bed_PlusState, PeopleNo]', 
    `Booking_method`                                                  VARCHAR(15)    CHECK (Booking_method IN ('홈페이지','전화','방문'))    NOT NULL    COMMENT '예약 수단', 
	`Shuttle_ID`                                                      INT            NOT NULL    COMMENT '셔틀 번호 (신청)', 
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

ALTER TABLE BOOKING
    ADD CONSTRAINT FK_BOOKING_BOOKING_ID_SHUTTLE_SHUTTLE_ID FOREIGN KEY (Shuttle_ID)
        REFERENCES SHUTTLE (Shuttle_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE BOOKCANCEL
    ADD CONSTRAINT FK_BOOKCANCEL_Booking_ID_BOOKING_Booking_ID FOREIGN KEY (Booking_ID)
        REFERENCES BOOKING (Booking_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE BOOKCANCEL
    ADD CONSTRAINT FK_BOOKCANCEL_Room_ID_ROOMSTATE_Room_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOM (Room_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE BOOKCANCEL
    ADD CONSTRAINT FK_BOOKCANCEL_Pol_ID_CANCELPOLICY_Pol_ID FOREIGN KEY (Pol_ID)
        REFERENCES CANCELPOLICY (Pol_ID) ON DELETE CASCADE ON UPDATE CASCADE;
       
	11111111111
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

INSERT INTO RESTAURANT (Res_Type, Res_Menu, Res_Menu_Price) VALUES 
('중식당', '짜장면', '5000'),
('일식당', '우동', '4000'),
('한식당', '비빔밥', '6000'),
('이탈리안식당', '파스타', '15000'),
('바', '칵테일', '10000'),
('노래주점', '맥주', '4500'),
('치킨집', '바삭한 치킨', '20000');

INSERT INTO SERVICE (Service_Type, Service_Price) VALUES 
('떡 만들기', '20000'),
('슈샤인', '3000'),
('수원 전통주 체험', '50000'),
('수원 화성 투어', '60000'),
('다도체험', '40000'),
('농장 체험', '70000'),
('광교호 둘레길 투어', '30000');

INSERT INTO ROOM (Room_Type, Room_AvailNo, Room_ResState) VALUE 
('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),
('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),
('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('디럭스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),
('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),
('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),('비즈니스룸', '2', '0'),
('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),
('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('수페리어룸','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),
('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),
('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('디럭스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),
('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),
('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),
('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('비즈니스룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),
('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0'),('수페리어룸 suite','2','0');

INSERT INTO CUSTOMER(Cust_webID,Cust_Name,Cust_Contact,Cust_Email,Cust_Address,Cust_Password,Cust_CurrentMile,Cust_Usedmile) 
Values 
('choco','이성규','010-4906-8347','loveleemoon@naver.com','경기도 화성시','sg1234',3000,0),
('cool','이상윤','010-1234-5677','lldn@naver.com','경기도 수원시','sk7895',5000,5000),
('malu','이성우','010-7894-5612','love@naver.com','전남 부안군','fkfk9898',3000,0),
('cpzp','이리우','010-1254-7894','leoon@naver.com','경상남도 울릉군','sg1237',3000,5000),
('chol','라이언','010-4356-5545','lovmeoon@naver.com','충청남도 태안군','hgp1234',6000,0),
('hong','비비탄','010-7894-3652','lolelvjfd@naver.com','경기도 연천군','s456d34',0,0),
('jolo','콩콩이','010-4956-8978','lovekognn@naver.com','경기도 포천군','sgkfg89',0,0),
('chicken','아이유','010-1234-5617','loveyoutoo@naver.com','서울특별시','sg1dkdk334',3000,0),
('kong','아이언','010-7895-1234','loveleestar@naver.com','서울특별시','shhoh',3000,100000),
('ldld','스페셜','010-1236-5896','lovelkognl@naver.com','서울특별시','sg9898',8000,7000),
('dongmul','김동률','010-1278-5396','howmuch@naver.com','대전광역시','tjdrb56',7000,7000),
('wanggook','산다라','010-1536-5951','nojam@naver.com','대전광역시','wkdwkd15',300,7000),
('towel','김구라','010-1643-1530','ggoljam@naver.com','대구광역시','4567dkd',1000,9000),
('bonus','유재석','010-9991-0549','hackggoljam@naver.com','대구광역시','aktdltek12',10000,0),
('ketchup','당구대','010-1299-5513','mystery@naver.com','경기도 수원시','an151',20000,0);

INSERT INTO FACILITY(Fac_Price,Fac_Type) VALUES 
('500', '슈퍼마켓'),
('1000', '슈퍼마켓'),
('2000', '슈퍼마켓'),
('15000', '마사지룸'),
('5000', '사우나'),
('7000', '수영장'),
('0', '헬스클럽'),
('2000', '눈썰매장'),
('10000', '빙어낚시'),
('10000', '바베큐'),
('8000', '별보기');

INSERT INTO CANCELPOLICY(Pol_Datedif,Pol_RefundRate) VALUES 
('1', '0.2'),
('3', '0.5'),
('5', '0.7'),
('7', '1');

-- 2번 순서 --

INSERT INTO SHUTTLE (Shuttle_Type, Shuttle_Depart, Shuttle_Arrive, Shuttle_DepartTime) 
VALUE ('버스', '리조트', '공항', '10:00'),
('버스', '공항', '리조트', '9:00'),
('버스', '리조트', '화성행궁', '10:00'),
('버스', '화성행궁', '리조트', '20:00');


INSERT INTO BED (Bed_Type, Bed_State, Room_ID) 
VALUE
('킹', '사용가능', '1'),('킹', '사용가능', '2'),('킹', '사용가능', '3'),('킹', '사용가능', '4'),('킹', '사용가능', '5'),('킹', '사용가능', '6'),('킹', '사용가능', '7'),('킹', '사용가능', '8'),('킹', '사용가능', '9'),('킹', '사용가능', '10'),('킹', '사용가능', '11'),('킹', '사용가능', '12'),('킹', '사용가능', '13'),('킹', '사용가능', '14'),('킹', '사용가능', '15'),('킹', '사용가능', '16'),('킹', '사용가능', '17'),('킹', '사용가능', '18'),('킹', '사용가능', '19'),('킹', '사용가능', '20'),('킹', '사용가능', '21'),('킹', '사용가능', '22'),('킹', '사용가능', '23'),('킹', '사용가능', '24'),('킹', '사용가능', '25'),('킹', '사용가능', '26'),('킹', '사용가능', '27'),('킹', '사용가능', '28'),('킹', '사용가능', '29'),('킹', '사용가능', '30'),('킹', '사용가능', '31'),('킹', '사용가능', '32'),('킹', '사용가능', '33'),('킹', '사용가능', '34'),('킹', '사용가능', '35'),('킹', '사용가능', '36'),('킹', '사용가능', '37'),('킹', '사용가능', '38'),('킹', '사용가능', '39'),('킹', '사용가능', '40'),
('킹', '사용가능', '41'),('킹', '사용가능', '42'),('킹', '사용가능', '43'),('킹', '사용가능', '44'),('킹', '사용가능', '45'),('킹', '사용가능', '46'),('킹', '사용가능', '47'),('킹', '사용가능', '48'),('킹', '사용가능', '49'),('킹', '사용가능', '50'),('더블', '사용가능', '51'),('더블', '사용가능', '52'),('더블', '사용가능', '53'),('더블', '사용가능', '54'),('더블', '사용가능', '55'),('더블', '사용가능', '56'),('더블', '사용가능', '57'),('더블', '사용가능', '58'),('더블', '사용가능', '59'),('더블', '사용가능', '60'),('더블', '사용가능', '61'),('더블', '사용가능', '62'),('더블', '사용가능', '63'),('더블', '사용가능', '64'),('더블', '사용가능', '65'),('더블', '사용가능', '66'),('더블', '사용가능', '67'),('더블', '사용가능', '68'),('더블', '사용가능', '69'),('더블', '사용가능', '70'),('더블', '사용가능', '71'),('더블', '사용가능', '72'),('더블', '사용가능', '73'),('더블', '사용가능', '74'),('더블', '사용가능', '75'),('더블', '사용가능', '76'),('더블', '사용가능', '77'),('더블', '사용가능', '78'),('더블', '사용가능', '79'),('더블', '사용가능', '80'),
('더블', '사용가능', '81'),('더블', '사용가능', '82'),('더블', '사용가능', '83'),('더블', '사용가능', '84'),('더블', '사용가능', '85'),('더블', '사용가능', '86'),('더블', '사용가능', '87'),('더블', '사용가능', '88'),('더블', '사용가능', '89'),('더블', '사용가능', '90'),('더블', '사용가능', '91'),('더블', '사용가능', '92'),('더블', '사용가능', '93'),('더블', '사용가능', '94'),('더블', '사용가능', '95'),('더블', '사용가능', '96'),('더블', '사용가능', '97'),('더블', '사용가능', '98'),('더블', '사용가능', '99'),('더블', '사용가능', '100'),('킹', '사용가능', '101'),('킹', '사용가능', '102'),('킹', '사용가능', '103'),('킹', '사용가능', '104'),('킹', '사용가능', '105'),('킹', '사용가능', '106'),('킹', '사용가능', '107'),('킹', '사용가능', '108'),('킹', '사용가능', '109'),('킹', '사용가능', '110'),('킹', '사용가능', '111'),('킹', '사용가능', '112'),('킹', '사용가능', '113'),('킹', '사용가능', '114'),('킹', '사용가능', '115'),('킹', '사용가능', '116'),('킹', '사용가능', '117'),('킹', '사용가능', '118'),('킹', '사용가능', '119'),('킹', '사용가능', '120'),('킹', '사용가능', '121'),('킹', '사용가능', '122'),('킹', '사용가능', '123'),('킹', '사용가능', '124'),('킹', '사용가능', '125'),('킹', '사용가능', '126'),('킹', '사용가능', '127'),('킹', '사용가능', '128'),('킹', '사용가능', '129'),('킹', '사용가능', '130'),('킹', '사용가능', '131'),('킹', '사용가능', '132'),('킹', '사용가능', '133'),('킹', '사용가능', '134'),('킹', '사용가능', '135'),('킹', '사용가능', '136'),('킹', '사용가능', '137'),('킹', '사용가능', '138'),('킹', '사용가능', '139'),('킹', '사용가능', '140'),('킹', '사용가능', '141'),('킹', '사용가능', '142'),('킹', '사용가능', '143'),
('킹', '사용가능', '144'),('킹', '사용가능', '145'),('킹', '사용가능', '146'),('킹', '사용가능', '147'),('킹', '사용가능', '148'),('킹', '사용가능', '149'),('킹', '사용가능', '150'),('더블', '사용가능', '151'),('더블', '사용가능', '152'),('더블', '사용가능', '153'),('더블', '사용가능', '154'),('더블', '사용가능', '155'),('더블', '사용가능', '156'),('더블', '사용가능', '157'),('더블', '사용가능', '158'),('더블', '사용가능', '159'),('더블', '사용가능', '160'),('더블', '사용가능', '161'),('더블', '사용가능', '162'),('더블', '사용가능', '163'),('더블', '사용가능', '164'),('더블', '사용가능', '165'),('더블', '사용가능', '166'),('더블', '사용가능', '167'),('더블', '사용가능', '168'),('더블', '사용가능', '169'),('더블', '사용가능', '170'),('더블', '사용가능', '171'),('더블', '사용가능', '172'),('더블', '사용가능', '173'),('더블', '사용가능', '174'),('더블', '사용가능', '175'),('더블', '사용가능', '176'),('더블', '사용가능', '177'),('더블', '사용가능', '178'),('더블', '사용가능', '179'),('더블', '사용가능', '180'),('더블', '사용가능', '181'),('더블', '사용가능', '182'),('더블', '사용가능', '183'),('더블', '사용가능', '184'),('더블', '사용가능', '185'),('더블', '사용가능', '186'),('더블', '사용가능', '187'),('더블', '사용가능', '188'),('더블', '사용가능', '189'),('더블', '사용가능', '190'),('더블', '사용가능', '191'),('더블', '사용가능', '192'),('더블', '사용가능', '193'),('더블', '사용가능', '194'),('더블', '사용가능', '195'),('더블', '사용가능', '196'),('더블', '사용가능', '197'),('더블', '사용가능', '198'),('더블', '사용가능', '199'),('더블', '사용가능', '200'),('킹', '사용가능', '201'),('킹', '사용가능', '202'),('킹', '사용가능', '203'),('킹', '사용가능', '204'),('킹', '사용가능', '205'),('킹', '사용가능', '206'),('킹', '사용가능', '207'),
('킹', '사용가능', '208'),('킹', '사용가능', '209'),('킹', '사용가능', '210'),('킹', '사용가능', '211'),('킹', '사용가능', '212'),('킹', '사용가능', '213'),('킹', '사용가능', '214'),('킹', '사용가능', '215'),('킹', '사용가능', '216'),('킹', '사용가능', '217'),('킹', '사용가능', '218'),('킹', '사용가능', '219'),('킹', '사용가능', '220'),('킹', '사용가능', '221'),('킹', '사용가능', '222'),('킹', '사용가능', '223'),('킹', '사용가능', '224'),('킹', '사용가능', '225'),('더블', '사용가능', '226'),('더블', '사용가능', '227'),('더블', '사용가능', '228'),('더블', '사용가능', '229'),('더블', '사용가능', '230'),('더블', '사용가능', '231'),('더블', '사용가능', '232'),('더블', '사용가능', '233'),('더블', '사용가능', '234'),('더블', '사용가능', '235'),('더블', '사용가능', '236'),('더블', '사용가능', '237'),('더블', '사용가능', '238'),('더블', '사용가능', '239'),('더블', '사용가능', '240'),('더블', '사용가능', '241'),('더블', '사용가능', '242'),('더블', '사용가능', '243'),('더블', '사용가능', '244'),('더블', '사용가능', '245'),('더블', '사용가능', '246'),('더블', '사용가능', '247'),('더블', '사용가능', '248'),('더블', '사용가능', '249'),('더블', '사용가능', '250'),('킹', '사용가능', '251'),('킹', '사용가능', '252'),('킹', '사용가능', '253'),('킹', '사용가능', '254'),('킹', '사용가능', '255'),('킹', '사용가능', '256'),('킹', '사용가능', '257'),('킹', '사용가능', '258'),('킹', '사용가능', '259'),('킹', '사용가능', '260'),('킹', '사용가능', '261'),('킹', '사용가능', '262'),('킹', '사용가능', '263'),('킹', '사용가능', '264'),('킹', '사용가능', '265'),('킹', '사용가능', '266'),('킹', '사용가능', '267'),('킹', '사용가능', '268'),('킹', '사용가능', '269'),('킹', '사용가능', '270'),('킹', '사용가능', '271'),
('킹', '사용가능', '272'),('킹', '사용가능', '273'),('킹', '사용가능', '274'),('킹', '사용가능', '275'),('킹', '사용가능', '276'),('킹', '사용가능', '277'),('킹', '사용가능', '278'),('킹', '사용가능', '279'),('킹', '사용가능', '280'),('킹', '사용가능', '281'),('킹', '사용가능', '282'),('킹', '사용가능', '283'),('킹', '사용가능', '284'),('킹', '사용가능', '285'),('킹', '사용가능', '286'),('킹', '사용가능', '287'),('킹', '사용가능', '288'),('킹', '사용가능', '289'),('킹', '사용가능', '290'),('킹', '사용가능', '291'),('킹', '사용가능', '292'),('킹', '사용가능', '293'),('킹', '사용가능', '294'),('킹', '사용가능', '295'),('킹', '사용가능', '296'),('킹', '사용가능', '297'),('킹', '사용가능', '298'),('킹', '사용가능', '299'),('킹', '사용가능', '300'),('더블', '사용가능', '301'),('더블', '사용가능', '302'),('더블', '사용가능', '303'),('더블', '사용가능', '304'),('더블', '사용가능', '305'),('더블', '사용가능', '306'),('더블', '사용가능', '307'),('더블', '사용가능', '308'),('더블', '사용가능', '309'),('더블', '사용가능', '310'),('더블', '사용가능', '311'),('더블', '사용가능', '312'),('더블', '사용가능', '313'),('더블', '사용가능', '314'),('더블', '사용가능', '315'),('더블', '사용가능', '316'),('더블', '사용가능', '317'),('더블', '사용가능', '318'),('더블', '사용가능', '319'),
('더블', '사용가능', '320'),('더블', '사용가능', '321'),('더블', '사용가능', '322'),('더블', '사용가능', '323'),('더블', '사용가능', '324'),('더블', '사용가능', '325'),('더블', '사용가능', '326'),('더블', '사용가능', '327'),('더블', '사용가능', '328'),('더블', '사용가능', '329'),('더블', '사용가능', '330'),('더블', '사용가능', '331'),('더블', '사용가능', '332'),('더블', '사용가능', '333'),('더블', '사용가능', '334'),('더블', '사용가능', '335'),('더블', '사용가능', '336'),('더블', '사용가능', '337'),('더블', '사용가능', '338'),('더블', '사용가능', '339'),('더블', '사용가능', '340'),('더블', '사용가능', '341'),('더블', '사용가능', '342'),('더블', '사용가능', '343'),('더블', '사용가능', '344'),('더블', '사용가능', '345'),('더블', '사용가능', '346'),('더블', '사용가능', '347'),('더블', '사용가능', '348'),('더블', '사용가능', '349'),('더블', '사용가능', '350'),('킹', '사용가능', '351'),
('킹', '사용가능', '352'),('킹', '사용가능', '353'),('킹', '사용가능', '354'),('킹', '사용가능', '355'),('킹', '사용가능', '356'),('킹', '사용가능', '357'),('킹', '사용가능', '358'),('킹', '사용가능', '359'),('킹', '사용가능', '360'),('킹', '사용가능', '361'),('킹', '사용가능', '362'),('킹', '사용가능', '363'),('킹', '사용가능', '364'),('킹', '사용가능', '365'),('킹', '사용가능', '366'),('킹', '사용가능', '367'),('킹', '사용가능', '368'),('킹', '사용가능', '369'),('킹', '사용가능', '370'),('킹', '사용가능', '371'),('킹', '사용가능', '372'),('킹', '사용가능', '373'),('킹', '사용가능', '374'),('킹', '사용가능', '375'),('킹', '사용가능', '376'),('킹', '사용가능', '377'),('킹', '사용가능', '378'),('킹', '사용가능', '379'),('킹', '사용가능', '380'),('킹', '사용가능', '381'),('킹', '사용가능', '382'),('킹', '사용가능', '383'),
('킹', '사용가능', '384'),('킹', '사용가능', '385'),('킹', '사용가능', '386'),('킹', '사용가능', '387'),('킹', '사용가능', '388'),('킹', '사용가능', '389'),('킹', '사용가능', '390'),('킹', '사용가능', '391'),('킹', '사용가능', '392'),('킹', '사용가능', '393'),('킹', '사용가능', '394'),('킹', '사용가능', '395'),('킹', '사용가능', '396'),('킹', '사용가능', '397'),('킹', '사용가능', '398'),('킹', '사용가능', '399'),('킹', '사용가능', '400'),('더블', '사용가능', '401'),('더블', '사용가능', '402'),('더블', '사용가능', '403'),('더블', '사용가능', '404'),('더블', '사용가능', '405'),('더블', '사용가능', '406'),('더블', '사용가능', '407'),('더블', '사용가능', '408'),('더블', '사용가능', '409'),('더블', '사용가능', '410'),('더블', '사용가능', '411'),('더블', '사용가능', '412'),('더블', '사용가능', '413'),('더블', '사용가능', '414'),('더블', '사용가능', '415'),
('더블', '사용가능', '416'),('더블', '사용가능', '417'),('더블', '사용가능', '418'),('더블', '사용가능', '419'),('더블', '사용가능', '420'),('더블', '사용가능', '421'),('더블', '사용가능', '422'),('더블', '사용가능', '423'),('더블', '사용가능', '424'),('더블', '사용가능', '425'),('더블', '사용가능', '426'),('더블', '사용가능', '427'),('더블', '사용가능', '428'),('더블', '사용가능', '429'),('더블', '사용가능', '430'),('더블', '사용가능', '431'),('더블', '사용가능', '432'),('더블', '사용가능', '433'),('더블', '사용가능', '434'),('더블', '사용가능', '435'),('더블', '사용가능', '436'),('더블', '사용가능', '437'),('더블', '사용가능', '438'),('더블', '사용가능', '439'),('더블', '사용가능', '440'),('더블', '사용가능', '441'),('더블', '사용가능', '442'),('더블', '사용가능', '443'),('더블', '사용가능', '444'),('더블', '사용가능', '445'),('더블', '사용가능', '446'),('더블', '사용가능', '447'),
('더블', '사용가능', '448'),('더블', '사용가능', '449'),('더블', '사용가능', '450'),('킹', '사용가능', '451'),('킹', '사용가능', '452'),('킹', '사용가능', '453'),('킹', '사용가능', '454'),('킹', '사용가능', '455'),('킹', '사용가능', '456'),('킹', '사용가능', '457'),('킹', '사용가능', '458'),('킹', '사용가능', '459'),('킹', '사용가능', '460'),('킹', '사용가능', '461'),('킹', '사용가능', '462'),('킹', '사용가능', '463'),('킹', '사용가능', '464'),('킹', '사용가능', '465'),('킹', '사용가능', '466'),('킹', '사용가능', '467'),('킹', '사용가능', '468'),('킹', '사용가능', '469'),('킹', '사용가능', '470'),('킹', '사용가능', '471'),('킹', '사용가능', '472'),('킹', '사용가능', '473'),('킹', '사용가능', '474'),('킹', '사용가능', '475'),('킹', '사용가능', '476'),('킹', '사용가능', '477'),('킹', '사용가능', '478'),('킹', '사용가능', '479'),
('킹', '사용가능', '480'),('킹', '사용가능', '481'),('킹', '사용가능', '482'),('킹', '사용가능', '483'),('킹', '사용가능', '484'),('킹', '사용가능', '485'),('킹', '사용가능', '486'),('킹', '사용가능', '487'),('킹', '사용가능', '488'),('킹', '사용가능', '489'),('킹', '사용가능', '490'),('킹', '사용가능', '491'),('킹', '사용가능', '492'),('킹', '사용가능', '493'),('킹', '사용가능', '494'),('킹', '사용가능', '495'),('킹', '사용가능', '496'),('킹', '사용가능', '497'),('킹', '사용가능', '498'),('킹', '사용가능', '499'),('킹', '사용가능', '500'),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),
('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),
('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '수리필요',Null),('킹', '부서짐',Null),('킹', '부서짐',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),
('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '수리필요',Null),('더블', '부서짐',Null),('더블', '부서짐',Null);


-- 3번 순서 --

INSERT INTO ROOMPRICE (Room_Price, Room_Week, Room_Peak, Room_ID, Room_Type) VALUES 
('200000', '0', '0', '1', '디럭스룸'),('200000', '0', '1', '2', '디럭스룸'),('200000', '1', '0', '3', '디럭스룸'),('200000', '1', '1', '4', '디럭스룸'),
('300000', '0', '0', '5', '비즈니스룸'),('300000', '0', '1', '6', '비즈니스룸'),('300000', '1', '0', '7', '비즈니스룸'),('300000', '1', '1', '8', '비즈니스룸'),
('400000', '0', '0', '9', '수페리어룸'),('400000', '0', '1', '10', '수페리어룸'),('400000', '1', '0', '11', '수페리어룸'),('400000', '1', '1', '12', '수페리어룸'),
('500000', '0', '0', '13', '디럭스룸 suite'),('500000', '0', '1', '14', '디럭스룸 suite'),('500000', '1', '0', '15', '디럭스룸 suite'),('500000', '1', '1', '16', '디럭스룸 suite'),
('600000', '0', '0', '17', '비즈니스룸 suite'),('600000', '0', '1', '18', '비즈니스룸 suite'),('600000', '1', '0', '19', '비즈니스룸 suite'),('600000', '1', '1', '20', '비즈니스룸 suite'),
('700000', '0', '0', '21', '수페리어룸 suite'),('700000', '0', '1', '22', '수페리어룸 suite'),('700000', '1', '0', '23', '수페리어룸 suite'),('700000', '1', '1', '24', '수페리어룸 suite');

INSERT INTO BOOKING (Booking_CheckInDate, Booking_CheckOutDate, Cust_ID, People_No, Room_Choice, Bed_PlusState, RoomPrice_ID, Booking_TotalAmount, Booking_method) 
VALUE
('2021-06-04 15:00:00', '2021-06-06 11:00:00', '1',  '2', '디럭스룸', '0', '1', '200000', '홈페이지'),
('2021-06-04 16:00:00', '2021-06-06 12:00:00', '2',  '2', '디럭스룸', '0', '2', '200000', '전화'),
('2021-06-04 17:00:00', '2021-06-06 13:00:00', '3',  '4', '비즈니스룸', '0', '3', '320000', '홈페이지'),
('2021-06-04 18:00:00', '2021-06-06 14:00:00', '4',  '4', '비즈니스룸', '1', '4', '340000', '홈페이지'),
('2021-06-05 15:00:00', '2021-06-06 11:00:00', '5',  '4', '비즈니스룸', '0', '5', '320000', '전화'),
('2021-06-05 16:00:00', '2021-06-06 12:00:00', '6',  '2', '디럭스룸', '0', '5', '200000', '홈페이지'),
('2021-06-05 17:00:00', '2021-06-06 13:00:00', '7',  '2', '디럭스룸', '0', '6', '200000', '홈페이지'),
('2021-06-05 18:00:00', '2021-06-06 14:00:00', '8',  '6', '수페리어룸', '2', '6', '480000', '홈페이지'),
('2021-06-05 18:30:00', '2021-06-06 14:30:00', '9',  '2', '디럭스룸', '0', '6', '200000', '방문'),
('2021-06-09 10:00:00', '2021-06-10 10:00:00', '10',  '4', '비즈니스룸', '1', '1', '340000', '홈페이지'),
('2021-06-09 12:00:00', '2021-06-06 10:00:00', '11',  '2', '디럭스룸', '0', '2', '200000', '홈페이지'),
('2021-06-09 13:00:00', '2021-06-06 17:00:00', '12',  '2', '디럭스룸', '0', '3', '200000', '홈페이지'),
('2021-06-09 18:00:00', '2021-06-06 18:00:00', '13',  '2', '디럭스룸', '0', '4', '200000', '방문'),
('2021-06-10 10:00:00', '2021-06-06 19:00:00', '14',  '6', '수페리어룸', '2', '3', '480000', '방문'),
('2021-06-10 11:00:00', '2021-06-06 11:00:00', '15',  '6', '수페리어룸', '2', '1', '480000', '홈페이지');

-- 4번 순서 --

INSERT INTO BOOKCANCEL (Can_Reason, Can_date, Can_Datedif, Can_Refund, Booking_ID, Pol_ID, Room_ID) VALUES 
('코로나', '2021-07-01', '3', '100000', '1', '1', '1'),
('개인사유', '2021-07-03', '3', '150000', '2', '2', '2'),
('수술', '2021-07-02', '3', '200000', '3', '3', '3'),
('교통사고', '2021-07-04', '3', '250000', '4', '4', '4'),
('기타', '2021-07-01', '3', '300000', '5', '5', '5'),
('기타', '2021-07-05', '3', '350000', '6', '6', '6'),
('코로나', '2021-07-06', '5', '140000', '7', '7', '1'),
('코로나', '2021-07-02', '5', '210000', '8', '8', '2'),
('코로나', '2021-07-04', '5', '280000', '9', '9', '3'),
('병원', '2021-07-05', '1', '100000', '10', '10', '4'),
('기타', '2021-07-03', '1', '120000', '11', '11', '5'),
('코로나', '2021-07-02', '1', '140000', '12', '12', '6'),
('코로나', '2021-07-01', '7', '200000', '13', '13', '1'),
('기타', '2021-07-05', '7', '300000', '14', '14', '2'),
('개인사유', '2021-07-04', '7', '400000', '15', '15', '3');

INSERT INTO ROOMSTATE(Room_ID, RoomState_State, Cust_ID, Booking_ID, Service_ID)
VALUE 
('1','1','1','1','1'),
('2','1','2','2','2'),
('3','1','3','3','3'),
('4','1','4','4','4'),
('5','0','5','5','4'),
('6','1','6','6','4'),
('7','1','7','7','5'),
('8','1','8','8','5'),
('9','1','9','9','5'),
('10','0','10','10','5'),
('11','1','11','11','6'),
('12','1','12','12','6'),
('13','1','13','13','7'),
('14','1','14','14','7'),
('15','1','15','15','7');

-- 5번 순서 --

INSERT INTO CARDKEY(Room_ID, Cust_ID) VALUE ('1', '1');

-- 6번 순서 --

INSERT INTO SERVICEREQUIREMENT(Service_ID, SerReq_Count, SerReq_TotalAmount, KEY_ID, Cust_ID) VALUE ('1','1','1','1','1');

INSERT INTO FACILITYREQUIREMENT (Fac_ID, Fac_Count, FacReq_TotalAmount, KEY_ID, Cust_ID) VALUE ('1', '3', '30000', '1', '1');

INSERT INTO RESTAURANTORDER (ResOrder_Menu, ResOrder_Date, ResOrder_TotalAmount, KEY_ID, Res_ID, Cust_ID) VALUE('비빔밥', '2021-06-05 19:00:00', '6000', '1', '1', '1');

-- 7번 순서 --

INSERT INTO PAYMENT (Pay_TotalAmount, Pay_Date, Pay_Type, KEY_ID, ResOrder_ID, SerReq_ID, FacReq_ID, Cust_ID) VALUE ('36000', '2021-06-05 19:00:00', '카드키', '1', '1', '1', '1', '1');

