drop DATABASE dasan_resort;
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
    `Pay_Type`                                                                      VARCHAR(15)     CHECK (Pay_Type IN ('신용카드','현금','수표','마일리지'))    NOT NULL    COMMENT '지불 수단', 
    `KEY_ID`                                                                        INT             NOT NULL    COMMENT '카드키 ID', 
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
    `Bed_Type`       VarChar(15)    CHECK (Bed_Type IN ('더블','킹'))    NOT NULL    COMMENT '침대 유형', 
    `Bed_State`      VarChar(15)    CHECK (Bed_State IN ('부서짐','수리필요','사용가능'))    NULL        COMMENT '침대 상태', 
    `Room_ID`        INT            NULL    COMMENT '객실 번호',
    CONSTRAINT  PRIMARY KEY (Bed_ID)
);

ALTER TABLE BED COMMENT '침대 테이블';


CREATE TABLE BOOKING
(
    `Booking_ID`                                                      INT            NOT NULL    AUTO_INCREMENT COMMENT '예약ID', 
    `Booking_CurrentDate`                                             DATETIME(6)    NOT NULL    COMMENT '예약 접수 날짜 및 시간',
    `Booking_CheckInDate`                                             DATE           NOT NULL    COMMENT '예약 체크인 날짜', 
    `Booking_CheckOutDate`                                            DATE           NOT NULL    COMMENT '예약 체크아웃 날짜', 
    `Cust_ID`                                                         INT            NOT NULL    COMMENT '고객ID', 
    `People_No`                                                       INT            NOT NULL    COMMENT '고객 명수', 
    `Room_Choice`                                                     VARCHAR(15)    CHECK (Room_Choice IN('디럭스룸','비즈니스룸','수페리어룸','디럭스룸 suite','비즈니스룸 suite', '수페리어룸 suite'))    NOT NULL    COMMENT '객실 선택', 
    `Bed_PlusState`                                                   INT            NOT NULL    COMMENT '침대 추가', 
    `RoomPrice_ID`                                                    INT            NOT NULL    COMMENT '객실가격ID', 
    `Booking_TotalAmount`                                             INT            NOT NULL    DEFAULT 0   COMMENT '예약 총금액[RoomPrice_Amount, Bed_PlusState, PeopleNo]', 
    `Booking_method`                                                  VARCHAR(15)    CHECK (Booking_method IN ('홈페이지','전화','방문'))    NOT NULL    COMMENT '예약 수단',
    `shuttle_yesno`											          BOOL 			 NOT NULL    DEFAULT 0  COMMENT '공항 -> 리조트 셔틀 이용여부',
    CONSTRAINT  PRIMARY KEY (Booking_ID)
);

ALTER TABLE BOOKING COMMENT '예약 테이블';



CREATE TABLE ROOMPRICE
(
    `RoomPrice_ID`  INT           NOT NULL    AUTO_INCREMENT COMMENT '객실가격ID', 
    `Room_Price`    INT           NOT NULL    COMMENT '객실 가격', 
    `Room_Week`     BOOL          NOT NULL    DEFAULT 0   COMMENT '객실 - 주중/주말', 
    `Room_Peak`     BOOL          NOT NULL    DEFAULT 0   COMMENT '객실 - 성수기/비성수기', 
    `Room_Type`     VarChar(15)   NOT NULL    COMMENT '객실 타입', 
    CONSTRAINT  PRIMARY KEY (RoomPrice_ID)
);

ALTER TABLE ROOMPRICE COMMENT '객실 가격 테이블';


CREATE TABLE ROOMSTATE
(
    `RoomState_ID`          INT       NOT NULL   AUTO_INCREMENT  COMMENT '객실ID', 
    `Room_ID`          INT       NOT NULL    COMMENT '객실ID', 
    `RoomState_State`  BOOL      NULL        COMMENT '객실 이용현황', 
    `Cust_ID`          INT       NULL    COMMENT '고객ID', 
    `Booking_ID`       INT       NULL    COMMENT '예약ID', 
    CONSTRAINT  PRIMARY KEY (Roomstate_ID)
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
    `Fine_reason`  VARCHAR(15)    CHECK (Fine_reason IN ('취사','흡연','카드키 분실', '퇴실 지연'))    NOT NULL    COMMENT '벌금 사유', 
    `Cust_ID`      INT        NOT NULL    COMMENT '고객이름', 
    `Room_ID`      INT        NOT NULL    COMMENT '방이름', 
    CONSTRAINT  PRIMARY KEY (Fine_ID)
);

ALTER TABLE FINE COMMENT '벌금';


CREATE TABLE CARDKEY
(
    `KEY_ID`   INT    NOT NULL    AUTO_INCREMENT   COMMENT '키이름', 
    `Room_ID`  INT    NULL    COMMENT '방이름', 
    `Cust_ID`  INT    NULL    COMMENT '고객이름', 
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
    `Res_ID`                                      INT        NOT NULL    COMMENT '레스토랑ID', 
    `ResOrder_Menu`                               VarChar(15)     CHECK (ResOrder_Menu IN ('짜장면','우동','비빔밥','파스타','칵테일','맥주','바삭한 치킨'))    NOT NULL    COMMENT '주문 메뉴', 
	`ResOrder_Count`                              INT    NOT NULL    COMMENT '주문요청 회수', 
    `ResOrder_TotalAmount`                       INT         NOT NULL    DEFAULT 0   COMMENT '주문 총액, [Res_Menu, Res_Price]', 
    `KEY_ID`                                      INT         NOT NULL    COMMENT '키ID', 
    `Cust_ID`                                     INT        NOT NULL    COMMENT '고객ID', 
    CONSTRAINT  PRIMARY KEY (ResOrder_ID)
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
    `Can_Currentdate`                               DATE    NOT NULL    COMMENT '취소 날짜', 
    `Can_Datedif`                       INT         NOT NULL    DEFAULT 0   COMMENT '취소와 날짜차이', 
    `Can_Refund`                                      INT         NOT NULL    COMMENT '취소 환불총액', 
    `Booking_ID`                                      INT        NOT NULL    COMMENT '예약 번호', 
    `Pol_ID`                                     INT        NOT NULL    COMMENT '정책 번호', 
    `Cust_ID`                                     INT        NOT NULL    COMMENT '고객ID',
    CONSTRAINT  PRIMARY KEY (Can_ID)
);

ALTER TABLE BOOKCANCEL COMMENT '예약취소 테이블';

CREATE TABLE CANCELPOLICY
(
    `Pol_ID`                                 INT         NOT NULL    AUTO_INCREMENT COMMENT '정책 번호', 
    `Pol_Datedif`                            INT         NOT NULL    COMMENT '날짜차이 정의', 
    `Pol_RefundRate`                         float         NOT NULL    COMMENT '환불 비율', 
    CONSTRAINT  PRIMARY KEY (Pol_ID)
);

ALTER TABLE CANCELPOLICY COMMENT '노쇼 정책 테이블';



-- 주석 --

ALTER TABLE PAYMENT
    ADD CONSTRAINT FK_PAYMENT_KEY_ID_CARDKEY_KEY_ID FOREIGN KEY (KEY_ID)
        REFERENCES CARDKEY (KEY_ID) ON DELETE CASCADE ON UPDATE CASCADE;

-- bALTER TABLE PAYMENT
--    ADD CONSTRAINT FK_PAYMENT_ResOrder_ID_RESTAURANTORDER_ResOrder_ID FOREIGN KEY (ResOrder_ID)
--        REFERENCES RESTAURANTORDER (ResOrder_ID) ON DELETE CASCADE ON UPDATE CASCADE;

-- ALTER TABLE PAYMENT
--    ADD CONSTRAINT FK_PAYMENT_SerReq_ID_SERVICEREQUIREMENT_SerReq_ID FOREIGN KEY (SerReq_ID)
--        REFERENCES SERVICEREQUIREMENT (SerReq_ID) ON DELETE CASCADE ON UPDATE CASCADE;

-- ALTER TABLE PAYMENT
--    ADD CONSTRAINT FK_PAYMENT_FacReq_ID_FACILITYREQUIREMENT_FacReq_ID FOREIGN KEY (FacReq_ID)
--        REFERENCES FACILITYREQUIREMENT (FacReq_ID) ON DELETE CASCADE ON UPDATE CASCADE;

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

-- ALTER TABLE ROOMPRICE
--    ADD CONSTRAINT FK_ROOMPRICE_Room_ID_ROOM_Room_ID FOREIGN KEY (Room_ID)
--        REFERENCES ROOM (Room_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ROOMSTATE
    ADD CONSTRAINT FK_ROOMSTATE_Room_ID_ROOM_Room_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOM (Room_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ROOMSTATE
    ADD CONSTRAINT FK_ROOMSTATE_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ROOMSTATE
    ADD CONSTRAINT FK_ROOMSTATE_Booking_ID_BOOKING_Booking_ID FOREIGN KEY (Booking_ID)
        REFERENCES BOOKING (Booking_ID) ON DELETE CASCADE ON UPDATE CASCADE;

-- ALTER TABLE ROOMSTATE
--     ADD CONSTRAINT FK_ROOMSTATE_Service_ID_SERVICE_Service_ID FOREIGN KEY (Service_ID)
--        REFERENCES SERVICE (Service_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
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
    ADD CONSTRAINT FK_CARDKEY_Cust_ID_ROOMSTATE_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES ROOMSTATE (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE CARDKEY
    ADD CONSTRAINT FK_CARDKEY_Room_ID_ROOM_ROOM_ID FOREIGN KEY (Room_ID)
        REFERENCES ROOM (Room_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE RESTAURANTORDER
    ADD CONSTRAINT FK_RESTAURANTORDER_KEY_ID_CARDKEY_KEY_ID FOREIGN KEY (KEY_ID)
        REFERENCES CARDKEY (KEY_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE RESTAURANTORDER
    ADD CONSTRAINT FK_RESTAURANTORDER_Res_ID_RESTAURANT_Res_ID FOREIGN KEY (Res_ID)
        REFERENCES RESTAURANT (Res_ID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE RESTAURANTORDER
    ADD CONSTRAINT FK_RESTAURANTORDER_Cust_ID_CUSTOMER_Cust_ID FOREIGN KEY (Cust_ID)
        REFERENCES CUSTOMER (Cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;

-- ALTER TABLE BOOKING
--    ADD CONSTRAINT FK_BOOKING_BOOKING_ID_SHUTTLE_SHUTTLE_ID FOREIGN KEY (Shuttle_ID)
--        REFERENCES SHUTTLE (Shuttle_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
-- ALTER TABLE BOOKCANCEL
--    ADD CONSTRAINT FK_BOOKCANCEL_Booking_ID_BOOKING_Booking_ID FOREIGN KEY (Booking_ID)
--        REFERENCES BOOKING (Booking_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE BOOKCANCEL
    ADD CONSTRAINT FK_BOOKCANCEL_Room_ID_ROOMSTATE_cust_ID FOREIGN KEY (cust_ID)
        REFERENCES customer (cust_ID) ON DELETE CASCADE ON UPDATE CASCADE;
        
ALTER TABLE BOOKCANCEL
    ADD CONSTRAINT FK_BOOKCANCEL_Pol_ID_CANCELPOLICY_Pol_ID FOREIGN KEY (Pol_ID)
        REFERENCES CANCELPOLICY (Pol_ID) ON DELETE CASCADE ON UPDATE CASCADE;

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

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$

CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 100 DO
        INSERT INTO ROOM(`Room_ID`, `Room_Type`, `Room_AvailNo`, `Room_ResState`)
          VALUES(i, '디럭스룸', 2, 0);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 101;
        
    WHILE i <= 200 DO
        INSERT INTO ROOM(`Room_ID`, `Room_Type`, `Room_AvailNo`, `Room_ResState`)
          VALUES(i, '비즈니스룸', 2, 0);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 201;
        
    WHILE i <= 300 DO
        INSERT INTO ROOM(`Room_ID`, `Room_Type`, `Room_AvailNo`, `Room_ResState`)
          VALUES(i, '수페리어룸', 2, 0);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 301;
        
    WHILE i <= 367 DO
        INSERT INTO ROOM(`Room_ID`, `Room_Type`, `Room_AvailNo`, `Room_ResState`)
          VALUES(i, '디럭스룸 suite', 2, 0);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 368;
        
    WHILE i <= 434 DO
        INSERT INTO ROOM(`Room_ID`, `Room_Type`, `Room_AvailNo`, `Room_ResState`)
          VALUES(i, '비즈니스룸 suite', 2, 0);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 435;
        
    WHILE i <= 500 DO
        INSERT INTO ROOM(`Room_ID`, `Room_Type`, `Room_AvailNo`, `Room_ResState`)
          VALUES(i, '수페리어룸 suite', 2, 0);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert(); 

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
('ketchup','당구대','010-1299-5513','mystery@naver.com','경기도 수원시','an151',20000,0),
('dooly','당연히','010-4568-9547','dool@naver.com','경기도 화성시','sq9512',3000,0),
('comit','자이제','010-9534-5665','comit@naver.com','경기도 수원시','spd156',5000,5000),
('toli','이성연','010-9814-5212','toli@naver.com','전남 부안군','ffnfd98',3000,0),
('rucio','박민재','010-1994-7364','rucio@naver.com','경상남도 울릉군','sek237',3000,5000),
('doompi','박재정','010-4236-1145','lovmpin@naver.com','충청남도 태안군','hg98d34',6000,0),
('phara','윤미래','010-7364-3122','lolephad@naver.com','경기도 연천군','sq98434',0,0),
('reinhert','김비지','010-8756-8118','lorein@naver.com','경기도 포천군','spdfjg89',0,0),
('zart','초시계','010-1203-5007','zart@naver.com','서울특별시','s36yehd',3000,0),
('roadhog','두나무','010-7035-1004','roadhog@naver.com','서울특별시','dogiuy12',3000,100000),
('pyklod','신만두','010-1986-0296','overwatch@naver.com','서울특별시','stodkq',8000,7000),
('phara','김경호','010-6436-1256','businessstrategy@ajou.ac.kr','경기도 수원시','youaref',0,0),
('reinhert','김다연','010-6654-8031','ekdusWkd12@naver.com','경기도 수원시','ekdusdl12@',0,0),
('zart','신승범','010-5223-6547','math1ta@etoos.com','서울특별시','icecream12',0,0),
('roadhog','다산관','010-7745-6341','hakgyogagosipda@ajou.ac.kr','경기도 수원시','dogiuy12',7000,0),
('pyklod','고라니','010-9888-9888','Guwekguweek@mountain.com','어느 깊은 산속','danggundanggun',10000,0),
('dasan','김다산','010-1389-0893','ajoudasan@gmail.com','경기도 수원시','ektks1000',0,0),
('apple','한지민','010-8900-6547','jimin@gmail.com','경상남도 부산시','wlals90',0,0),
('mango','이수민','010-3467-6895','sumin@gmail.com','경기도 파주시','tnals88',0,0),
('strawberry','정다정','010-3654-1354','jdaj@gmail.com','경기도 용인시','wjdekwjd000',0,0),
('mandarin','조혜연','010-0543-7780','hyehye@gmail.com','경기도 수원시','whgpdus567',0,0),
('jongbell','정종훈','010-1455-2234','jonghoon@gmail.com','강원도 강릉시','whdgns0204',0,0),
('jjiwon','윤지원','010-3657-6879','jiwon@gmail.com','인천광역시','wldnjs010',0,0),
('peace','김주형','010-4356-3546','juhyung@gmail.com','경기도 파주시','wngud444',0,0),
('great','성규현','010-1345-6643','sunggyu@gmail.com','경상남도 대구시','rbgus0807',0,0),
('grape','이동현','010-2424-4563','leedong@gmail.com','경상남도 창원시','ehdgus625',0,0),
('present','김지후','010-5656-8700','jihoo@gmail.com','서울특별시','wlgn99',0,0),
('pear','김아름','010-3478-9877','beauty@gmail.com','경기도 고양시','dkfma123',0,0),
('starlove','도민준','010-9675-3785','dodomin@gmail.com','경기도 수원시','ehalswns1004',0,0),
('lion','전현재','010-7768-4950','hyunjae@gmail.com','전라북도 전주시','guswo678',30000,0),
('coffee','김형진','010-0338-2246','jinhk@gmail.com','강원도 춘천시','higudwls1389',20000,40000),
('ddore', '김규민', '010-2394-3483', 'feuhhid@naver.com', '경기도 하남시', 'efesf', 0, 0),
('isbp', '김태영', '010-2345-2634', 'isbp@naver.com','서울특별시 강남구', 'foeie', 200, 0),
('fheku', '이기광', '010-2353-7975', 'dlrlrhkd@naver.com', '서울특별시 강동구', 'jkuj',0,0),
('gorjg', '강호동', '010-5232-2344', 'rkdghehd@gmail.com', '서울특별시 서초구', 'fesfssg12', 0, 0),
('stone', '홍은지', '010-7403-2840', 'ghddmswl@naver.com', '부산광역시', 'rerrrd2', 0, 0),
('gsrgsfs', '김현동', '010-6944-2947', 'vleij@naver.com', '경기도 수원시', 'rerrrd3', 0, 0),
('segsef','오세왕', '010-7403-2840', '2ewfwe@naver.com', '부산광역시', 'rerrrd4',0, 0),
('jkrij', '앵무새', '010-2104-5797', 'ydddd@naver.com', '부산광역시', 'rerrrd5',0, 0),
('thptjkt', '최태철', '010-1252-9634', 'nrdjnf87@naver.com', '서울특별시', 'rerrrd6',0, 0),
('bjnrur', '호랑이', '010-8762-2746', 'nfgbnf86@naver.com', '서울특별시', 'rerrrd7',0, 0),
('ipadjoa', '김호찬', '010-7968-2748', '12htddrg@naver.com', '울산광역시', 'rerrrd8',0, 0),
('majinjoa', '하미라', '010-1305-4570', 'mgngyj97@naver.com', '경기도 파주시', 'rerrrd9',0, 0),
('donjoa', '지환후', '010-2345-7812', 'vdfytkjyh@naver.com', '경기도 운천시', 'rerrrd10',0, 0),
('gonjjajoa', '김나오', '010-7574-0922', '12fsnjygf@naver.com', '전라북도 전주시', 'rerrrd11',0, 0),
('fesffs', '지전철', '010-9575-8667', '86ynfgdd@naver.com', '광주광역시', 'rerrrd12',0, 0),
('apple','김사과','010-1234-5678','apple@naver.com','경기도 화성시','tkrhk1',5000,0),
('banana','바나나','010-1234-5679','banana@naver.com','경기도 수원시','qksksk2',1000,0),
('grape','이포도','010-1234-5680','grape@naver.com','경기도 하남시','vheh3',300,0),
('watermelon','박수박','010-1234-5681','watemelon@naver.com','경기도 안산시,','tnqkr4',10000,0),
('melon','최멜론','010-1234-5682','melon@naver.com','경기도 평택시','apffhs5',300,0),
('strawberries','김딸기','010-1234-5683','strawberries@naver.com','경기도 고양시','ekfrl6',700,0),
('lemon','나레몬','010-1234-5684','lemon@naver.com','경기도 광주시','fpahs7',8500,0),
('grapefriot','김자몽','010-1234-5685','grapefruit@naver.com','경기도 광명시','wkahd8',50,0),
('pomegranate','박석류','010-1234-5686','pomegranate@naver.com','경기도 과천시','tjrfb9',40000,0),
('pear','김배','010-1234-5687','pear@naver.com','경기도 부천시','rlaqo10',5000,0),
('plum','이자두','010-1234-5688','plum@naver.com','경기도 동두천시','wken11',100,0),
('orange','오렌지','010-1234-5689','orange@naver.com','경기도 이천시','dhfpswl12',30,0),
('kiwi','최키위','010-1234-5690','kiwi@naver.com','경기도 의정부시','zldnl13',500,0),
('lime','김라임','010-1234-5691','lime@naver.com','경기도 여주시','fkdla14',5000,0),
('apricot','이살구','010-1234-5692','apricot@naver.com','경기도 양주시','tkfrn15',600,0),
('spring', '김보미','010-8974-5623','spring@naver.com', '경기도 용인시','fgfg12',12000,0),
('summer','이여름','010-7512-6530','summer@naver.com', '경상남도 거제시','fer4142',23000,2000),
('fall','박가을','010-5423-9545','fall@daum.net','경기도 화성시','7efgb8',5200,500),
('winter','서겨울','010-7832-0012','winter@gamil.com','전라북도 전주시','vre3r4',5600,0),
('dream','윤드림','010-8653-2230','dream@gmail.com','전라북도 군산시','vf4be15',5000,100),
('silverstone','김은석','010-7853-2645','silverstone@daum.net','경상북도 구미시','eferi8952',1000,0),
('delay','박지연','010-8425-6550','delay12@naver.com','부산광역시','vr89522we',2000,0),
('local','서현지','010-7894-3256','local@naver.com','경기도 부천시','veffwe48',8000,0),
('seoul','박서울','010-8878-5695','seoul58@gamil.com','경기도 과천시','sefe58',900,0),
('mountain','박도산','010-5188-8525','mountain@naver.com','경기도 광주시','erfr895',7000,0),
('west','이은서','010-8569-0256','west12@naver.com','경기도 성남시','jujtd84',0,0),
('east','박동수','010-5896-0058','east89@naver.com','경기도 파주시','tdes7rg',500,0),
('south','남유민','010-0058-5895','south50@gamil.com','경기도 하남시','trgwt80g',0,0),
('flower','이윤화','010-1898-5620','flower7@daum.net','경기도 가평시','46rfgre',0,0),
('kite','연지수','010-8950-7784','kite8@naver.com','경기도 김포시','48nhnu8',0,0),
('googoo', '김동현', '010-2085-5987', 'qwerty@gmail.com', '경기도 수원시', 'abc123', 2000, 0),
('igoigo', '김지만', '010-5746-1575', 'asdfg@gmail.com', '경기도 용인시', 'ing159', 10000, 0),
('eguegu', '이산', '010-4970-5959', 'zxcvb@gmail.com', '경기도 화성시', 'apple115', 50000, 6000),
('moooomb02', '강유진', '010-9988-7456', 'oioi10@gmail.com', '경기도 의정부시', 'vnvn153', 7000, 1000),
('nope9', '김산', '010-9155-7937', '083ing@gmail.com', '경기도 수원시', 'gui78123!', 20000, 4000),
('sadf2', '김민성', '010-2248-5451', '029yi@gmail.com', '경기도 수원시', 'fsda827', 30000, 8000),
('kkkp099', '김건우', '010-9764-9997', 'kkwoo@gmail.com', '경기도 수원시', 'bnmd088', 25000, 4000),
('eeemn0', '김연우', '010-4770-5959', 'zxcvv@gmail.com', '경기도 화성시', 'apple115!', 50000, 6000),
('you2oo', '김유준', '010-4970-5559', 'lxcvb@gmail.com', '경기도 수원시', 'appleel115', 50000, 6000),
('10number', '이서진', '010-4123-5959', 'zdcvb@gmail.com', '경기도 용인시', 'appeele115', 20000, 6000),
('11qjsWo', '이도윤', '010-4800-5959', 'zxcdlvb@gmail.com', '경기도 화성시', 'ap22ple115', 40000, 0),
('12qjsWo', '이준', '010-4900-5959', 'zxcvddb@gmail.com', '경기도 의정부시', 'baapple115', 10000, 1000),
('13qjsWo', '박지호', '010-5000-5959', 'zxeeecvb@gmail.com', '경기도 화성시', 'qweapple115', 49000, 0),
('14qjsWo', '이수호', '010-5100-5959', 'zxcvbnm@gmail.com', '경기도 화성시', 'apeeeple115', 58000, 10000),
('moonstar97', '문종현', '010-5200-5759', '0803whdgus@gmail.com', '서울특별시', 'opppapple115', 20000, 0);


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

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 50 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '더블', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 51;
        
    WHILE i <= 100 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '킹', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 101;
        
    WHILE i <= 150 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '더블', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 151;
        
    WHILE i <= 200 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '킹', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 201;
        
    WHILE i <= 250 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '더블', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 251;
        
    WHILE i <= 300 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '킹', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 301;
        
    WHILE i <= 333 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '더블', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 334;
        
    WHILE i <= 367 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '킹', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 368;
        
    WHILE i <= 401 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '더블', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 402;
        
    WHILE i <= 434 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '킹', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 435;
        
    WHILE i <= 467 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '더블', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 468;
        
    WHILE i <= 500 DO
        INSERT INTO BED (Bed_ID, Bed_Type, Bed_State, Room_ID) 
          VALUES(i, '킹', '사용가능', i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL loopInsert();

-- 3번 순서 --

INSERT INTO ROOMPRICE (Room_Price, Room_Week, Room_Peak, Room_Type) VALUES 
('200000', '0', '0', '디럭스룸'),('200000', '1', '0', '디럭스룸'),('200000', '0', '1', '디럭스룸'),('200000', '1', '1', '디럭스룸'),
('300000', '0', '0', '비즈니스룸'),('300000', '1', '0', '비즈니스룸'),('300000', '0', '1', '비즈니스룸'),('300000', '1', '1', '비즈니스룸'),
('400000', '0', '0', '수페리어룸'),('400000', '1', '0', '수페리어룸'),('400000', '0', '1', '수페리어룸'),('400000', '1', '1', '수페리어룸'),
('500000', '0', '0', '디럭스룸 suite'),('500000', '1', '0', '디럭스룸 suite'),('500000', '0', '1', '디럭스룸 suite'),('500000', '1', '1', '디럭스룸 suite'),
('600000', '0', '0', '비즈니스룸 suite'),('600000', '1', '0', '비즈니스룸 suite'),('600000', '0', '1', '비즈니스룸 suite'),('600000', '1', '1', '비즈니스룸 suite'),
('700000', '0', '0', '수페리어룸 suite'),('700000', '1', '0', '수페리어룸 suite'),('700000', '0', '1', '수페리어룸 suite'),('700000', '1', '1', '수페리어룸 suite');

set sql_safe_updates=0;

UPDATE roomprice
SET roomprice.room_price = roomprice.room_price + 50000
where room_week = 1;

UPDATE roomprice
SET roomprice.room_price = roomprice.room_price + 50000
where room_peak = 1;

select * from roomprice;


INSERT INTO BOOKING (Booking_CurrentDate,Booking_CheckInDate, Booking_CheckOutDate, Cust_ID, People_No, Room_Choice, Bed_PlusState, RoomPrice_ID, Booking_TotalAmount, Booking_method)
VALUE
('2021-06-08 12:11:55','2021-06-16', '2021-06-11', '1', '2', '디럭스룸', '0', '1', '200000', '홈페이지'),
('2021-06-08 13:12:01','2021-06-16', '2021-06-17', '2',  '2', '디럭스룸', '0', '1', '200000', '전화'),
('2021-06-08 15:52:33','2021-06-16', '2021-06-17', '5',  '4', '비즈니스룸', '0', '5', '320000', '홈페이지'),
('2021-06-09 07:11:12','2021-06-17', '2021-06-18', '7',  '4', '비즈니스룸', '1', '5', '340000', '홈페이지'),
('2021-06-08 08:51:23','2021-06-17', '2021-06-18', '9',  '4', '비즈니스룸', '0', '5', '320000', '전화'),
('2021-06-08 10:33:59','2021-06-17', '2021-06-18', '11',  '2', '디럭스룸', '0', '5', '200000', '홈페이지'),
('2021-06-09 17:39:07','2021-06-17', '2021-06-18', '12',  '2', '디럭스룸', '0', '5', '200000', '홈페이지'),
('2021-06-10 13:16:41','2021-06-19', '2021-06-20', '13',  '6', '수페리어룸', '1', '10', '460000', '홈페이지'),
('2021-06-13 16:43:26','2021-06-19', '2021-06-20', '17',  '2', '디럭스룸', '0', '2', '200000', '방문'),
('2021-06-14 12:33:15','2021-06-19', '2021-06-20', '19',  '4', '비즈니스룸', '1', '6', '340000', '홈페이지'),
('2021-06-12 22:15:42','2021-06-20', '2021-06-21', '20',  '2', '디럭스룸', '0', '2', '200000', '홈페이지'),
('2021-06-14 23:39:53','2021-06-20', '2021-06-21', '22',  '2', '디럭스룸 suite', '0', '14', '500000', '홈페이지'),
('2021-06-10 03:43:13','2021-06-20', '2021-06-21', '23',  '2', '디럭스룸', '0', '2', '200000', '방문'),
('2021-06-15 14:05:11','2021-06-20', '2021-06-21', '24',  '6', '수페리어룸', '1', '10', '460000', '방문'),
('2021-06-15 17:25:40','2021-06-20', '2021-06-21', '27',  '6', '수페리어룸 suite', '2', '21', '760000', '홈페이지'),
('2021-06-13 05:23:52','2021-06-23', '2021-06-24', '29',  '2', '디럭스룸', '0', '1', '200000', '홈페이지'),
('2021-06-16 11:32:51','2021-06-24', '2021-06-25', '32',  '4', '비즈니스룸 suite', '1', '5', '340000', '전화'),
('2021-06-08 13:52:12','2021-06-24', '2021-06-25', '34',  '2', '디럭스룸', '0', '1', '200000', '전화'),
('2021-06-19 15:36:32','2021-06-26', '2021-06-27', '35',  '2', '디럭스룸', '0', '2', '200000', '전화'),
('2021-06-20 19:37:41','2021-06-27', '2021-06-28', '36',  '2', '디럭스룸', '0', '2', '200000', '방문'),
('2021-06-21 06:53:30','2021-06-27', '2021-06-28', '37',  '6', '수페리어룸', '1', '10', '460000', '방문'),
('2021-06-22 16:33:22','2021-06-27', '2021-06-28', '39',  '6', '수페리어룸', '1', '10', '460000', '홈페이지'),
('2021-06-20 13:52:41','2021-06-27', '2021-06-28', '42',  '6', '수페리어룸', '1', '10', '460000', '홈페이지'),
('2021-06-21 12:51:33','2021-05-18', '2021-06-28', '45',  '6', '수페리어룸', '1', '10', '460000', '방문'),
('2021-06-23 02:12:12','2021-06-28', '2021-06-29', '46',  '2', '디럭스룸', '0', '5', '200000', '홈페이지'),
('2021-06-13 18:23:21','2021-06-15 ','2021-06-16', '48', '2', '디럭스룸', '0', '6', '200000', '홈페이지'),
('2021-06-12 15:34:35','2021-06-17', '2021-06-18', '49', '2', '디럭스룸 suite', '0', '14', '500000', '홈페이지'),
('2021-06-24 12:43:24','2021-06-29', '2021-06-30', '52','6','수페리어룸 suite', '2', '21', '760000', '홈페이지'),
('2021-06-24 18:25:23','2021-06-29', '2021-06-30', '53', '6', '수페리어룸', '1', '10', '460000', '방문'),
('2021-06-25 11:43:52','2021-06-30', '2021-07-01', '54', '4', '비즈니스룸', '0', '5', '320000', '홈페이지'),
('2021-06-25 19:23:23','2021-06-30', '2021-07-01', '56','4', '비즈니스룸', '0', '5', '320000', '홈페이지'),
('2021-06-25 09:08:12','2021-06-30', '2021-07-01', '59','4', '비즈니스룸', '0', '5', '320000', '홈페이지'),
('2021-06-10 10:11:30','2021-06-16','2021-06-18','61','1','디럭스룸','0','1','400000','홈페이지'),
('2021-06-11 11:14:31','2021-06-17','2021-06-18','62','2','디럭스룸 suite','0','14','50000','전화'),
('2021-06-11 20:15:58','2021-06-22','2021-06-23','63','3','비즈니스룸','1','6','330000','방문'),
('2021-06-13 09:03:15','2021-06-22','2021-06-24','64','1','수페리어룸 suite','0','22','1400000','홈페이지'),
('2021-06-14 08:58:39','2021-06-23','2021-06-24','65','5','수페리어룸 suite','1','22','750000','전화'),
('2021-06-20 21:33:33','2021-06-20','2021-06-21','66','1','디럭스룸 suite','0','15','500000','방문'),
('2021-06-20 23:29:46','2021-06-25','2021-06-27','67','4','비즈니스룸 suite','1','18','1230000','홈페이지'),
('2021-06-22 03:45:29','2021-06-27','2021-06-28','68','6','수페리어룸 suite','1','22','760000','홈페이지'),
('2021-06-08 20:48:12', '2021-06-15', '2021-06-16', '76', '2', '디럭스룸', '0', '1', '200000', '홈페이지'),
('2021-06-10 15:45:38', '2021-06-15', '2021-06-16', '78', '4', '비즈니스룸', '1', '5', '340000', '홈페이지'), 
('2021-06-13 23:45:08', '2021-06-15', '2021-06-16', '80', '6', '수페리어룸', '2', '9', '480000', '전화'),
('2021-06-17 10:56:35', '2021-06-17', '2021-06-18', '81', '2', '비즈니스룸', '0', '5', '300000', '방문'),
('2021-06-19 18:34:59', '2021-06-22', '2021-06-23', '83', '4', '디럭스룸', '1', '1', '240000', '홈페이지'),
('2021-06-16 19:38:29', '2021-06-19', '2021-06-20', '85', '2', '수페리어룸', '0', '10', '400000', '홈페이지'),
('2021-06-23 11:30:30', '2021-06-24', '2021-06-25', '89', '6', '디럭스룸', '2', '1', '280000', '홈페이지'),
('2021-06-21 21:05:08', '2021-06-23', '2021-06-24', '90', '4', '수페리어룸', '1', '9', '440000', '전화'),
('2021-07-12 15:20:45', '2021-08-02', '2021-08-04', '91', '5', '디럭스룸', '1', '3', '300000', '홈페이지'),
('2021-07-13 15:25:45', '2021-08-02', '2021-08-05', '92', '2', '비즈니스룸', '1', '7', '370000', '홈페이지'),
('2021-07-18 15:49:02', '2021-08-10', '2021-08-12', '93', '4', '디럭스룸 suite', '1', '15', '600000', '홈페이지'),
('2021-07-18 16:20:30', '2021-08-10', '2021-08-12', '94', '2', '디럭스룸', '0', '3', '250000', '홈페이지'),
('2021-07-18 16:23:22', '2021-08-10', '2021-08-12', '95', '3', '수페리어룸', '1', '11', '480000', '홈페이지'),
('2021-07-18 17:33:22', '2021-08-10', '2021-08-13', '96', '2', '수페리어룸 suite', '0', '23', '750000', '홈페이지'),
('2021-07-18 18:13:22', '2021-08-11', '2021-08-13', '97', '2', '비즈니스룸 suite', '0', '19', '650000', '홈페이지'),
('2021-07-18 21:23:22', '2021-08-11', '2021-08-15', '98', '3', '디럭스룸', '1', '3', '280000', '전화');

-- 4번 순서 --


INSERT INTO BOOKCANCEL (Can_Reason, Can_CurrentDate, Can_Datedif, Can_Refund, Booking_ID, Pol_ID, cust_id)
(select '코로나', current_date(), datediff(Booking_CheckInDate, current_date()) as dif,
	booking_totalamount *
	(select pol_refundRate from cancelpolicy where pol_id = if(dif <= 1, '1', if(dif <= 3, '2', if(dif <= 5, '3', 4)))), 
		booking.booking_id, pol_id, cust_id from booking, cancelpolicy
			where pol_id = if(datediff(Booking_CheckInDate, current_date()) <= 1, '1', if(datediff(Booking_CheckInDate, current_date()) <= 3, '2', if(datediff(Booking_CheckInDate, current_date()) <= 5, '3', 4)))
				and booking_id 
                
                in (1,3));

delete from booking where booking_id in (select booking_id from bookcancel);



INSERT INTO ROOMSTATE(Room_ID, RoomState_State, Cust_ID, Booking_ID)
VALUE 
('11','1','17','9'),
('106','1','19','10'),
('15','1','22','11'),
('43','1','23','12'),
('58','1','24','13'),
('380','1','32','17'),
('33','1','34','18'),
('45','1','35','19'),
('70','1','36','20'),
('220','1','39','22'),
('1','1','1','10'),
('2','1','2','2'),
('101','1','5','2'),
('102','1','7','4'),
('103','1','9','5'),
('46', '1','46', '25'),
('74', '1','48', '26'),
('34', '1','49', '27'),
('44', '1','52', '28'),
('59', '1','53', '29'),
('3','1','61','33'),
('305','1','62','34'),
('114','1','63','35'),
('495','1','64','36'),
('500','1','65','37'),
('304','1','66','38'),
('410','1','67','39'),
('487','1','68','40'),
('108','1','81','44'),
('54','1','83','45'),
('230','1','85','46'),
('78','1','89','47'),
('203','1','90','48'),
('65', '1', '91', '49'),
('67', '1', '94', '52'),
('88', '1', '98', '56'),
('285', '1', '95', '53'),
('107', '1', '92', '50');

-- test --
-- INSERT INTO ROOMSTATE(Room_ID, RoomState_State, Cust_ID, Booking_ID)
-- (select room_id, '0', null, null from room);
--

UPDATE roomstate
INNER JOIN roomstate ON cardkey.room_id = roomstate.room_id 
    AND roomstate.roomstate_state =1 
SET cardkey.cust_id=roomstate.cust_id;


select * from roomstate;
select * from cardkey;

-- 5번 순서 --
INSERT INTO cardkey(room_id, cust_id)
(select room_id, null
	from room);

UPDATE cardkey
INNER JOIN roomstate ON cardkey.room_id = roomstate.room_id 
    AND roomstate.roomstate_state =1 
SET cardkey.cust_id=roomstate.cust_id;

-- 6번 순서 --


INSERT INTO SERVICEREQUIREMENT(Service_ID, SerReq_Count, SerReq_TotalAmount, KEY_ID, Cust_ID)
	(select service_id,
			(floor(rand() * 5)) as randnum,
				(select * from (select service_price * randnum) as temp),
					key_id, cust_id
						from service, cardkey
							where not (cust_id is null)); 



INSERT INTO FACILITYREQUIREMENT (Fac_ID, Fac_Count, FacReq_TotalAmount, KEY_ID, Cust_ID)
	(select fac_id,
			(floor(rand() * 5)) as randnum,
				(select * from (select fac_price * randnum) as temp),
					key_id, cust_id
						from facility, cardkey
                        where not (cust_id is null)); 



INSERT INTO RESTAURANTORDER (Res_ID, ResOrder_Menu, ResOrder_count, ResOrder_TotalAmount, KEY_ID, Cust_ID)
	(select res_id, res_menu,
			(floor(rand() * 5)) as randnum,
				(select * from (select res_menu_price * randnum) as temp),
					key_id, cust_id
						from restaurant, cardkey
							where not (cust_id is null)); 


-- 7번 순서 --

INSERT INTO PAYMENT (Pay_TotalAmount, Pay_Date, Pay_Type, KEY_ID, CUST_id)
(select s1+s2+s3, t4.booking_checkoutdate, 
if(rand() > 0.5, '신용카드', if (rand() > 0.7, '수표', '현금'))
, t1.key_id, t1.cust_id from
			(select cust_id,key_id,sum(serreq_totalamount) s1
                from servicerequirement
                    group by key_id) t1
						INNER JOIN 
            (select cust_id,key_id,sum(facreq_totalamount) s2
                from facilityrequirement
                    group by key_id) t2 ON t1.key_id = t2.key_id
						INNER JOIN
            (select cust_id,key_id,sum(resorder_totalamount) s3
                from restaurantorder
                    group by key_id) t3 ON t2.key_id = t3.key_id
						INNER JOIN
			(select cust_id, booking_checkoutdate,
					(case when booking_checkoutdate 
						then 
						date_add(
							date_add(
								date_add(booking_checkoutdate,
								INTERVAL rand() * 24 hour),
								INTERVAL rand() * 60 minute),
								INTERVAL floor(rand() * 60) second)
							end)
								from booking) t4 on t1.cust_id = t4.cust_id
                    );
                    
                    
select * from payment;
