CREATE DATABASE dasan_resort;
use dasan_resort;

CREATE TABLE `CARD KEY`(
  `KEY_ID` INT NOT NULL AUTO_INCREMENT COMMENT '키 ID',
  `Room_ID` INT NOT NULL COMMENT '방 ID',
  `Cust_ID` INT NOT NULL COMMENT '고객 ID',
  PRIMARY KEY (`Key_ID`));
  
ALTER TABLE `CARD KEY` COMMENT = '카드키 정보 테이블';

CREATE TABLE `SERVICE REQUIREMENT`(
`SerReq_ID` INT NOT NULL AUTO_INCREMENT COMMENT '서비스 요구 ID',
`Service_ID` INT NOT NULL COMMENT '서비스 ID',
`SerReq_Count` INT NOT NULL COMMENT '서비스 요구 횟수',
`SerReq_TotalAmount` INT NOT NULL COMMENT '서비스 총 금액',
`KEY_ID` INT NOT NULL COMMENT '키 ID',
`Cust_ID` INT NOT NULL COMMENT '고객 ID',
PRIMARY KEY (`SerReq_ID`));

ALTER TABLE `SERVICE REQUIREMENT` COMMENT = '서비스 요구 테이블';

CREATE TABLE `ROOM STATE` (
`Room_ID` INT NOT NULL AUTO_INCREMENT COMMENT '객실 ID',
`RoomState_State` BOOL NULL COMMENT '객실 사용 가능 여부',
`Cust_ID` INT NOT NULL COMMENT '고객 ID',
`Booking_ID` INT NOT NULL COMMENT '예약 ID',
`Service_ID` INT NOT NULL COMMENT '서비스 ID',
PRIMARY KEY (`Room_ID`));

ALTER TABLE `ROOM STATE` COMMENT = '객실 상태 테이블';

CREATE TABLE `RESTAUANT` (
   `Res_ID` INT NOT NULL AUTO_INCREMENT COMMENT '레스토랑 ID',
   `Res_Type` VARCHAR(15) NOT NULL COMMENT '레스토랑 종류',
   `Res_Menu` VARCHAR(15) NOT NULL COMMENT '레스토랑 메뉴',
   `Res_Menu_Price` INT NOT NULL COMMENT '레스토랑 메뉴 가격',
   PRIMARY KEY (`Res_ID`, `Res_Menu`));

    ALTER TABLE `RESTAUANT` COMMENT = '레스토랑 정보 테이블';

CREATE TABLE `ROOM PRICE` (
   `RoomPrice_ID` INT NOT NULL AUTO_INCREMENT COMMENT '룸 가격 ID',
   `Room_Price` INT NOT NULL COMMENT '룸 가격',
   `Room_Week` BOOL NOT NULL COMMENT '주중/주말 여부',
   `Room_Peak` BOOL NOT NULL COMMENT '성수기/비성수기 여부',
   `Room_ID` INT NOT NULL COMMENT '룸 ID',
   `Room_Type` VARCHAR(15) NOT NULL COMMENT '룸 종류',
   PRIMARY KEY (`RoomPrice_ID`));

    ALTER TABLE `ROOM PRICE` COMMENT = '룸 가격 테이블';
    
CREATE TABLE SERVICE(
`Service_ID` INT NOT NULL AUTO_INCREMENT COMMENT '서비스ID',
`Service_Type` INT NOT NULL COMMENT '서비스 종류',
`Service_Price` VARCHAR(15) NOT NULL COMMENT '서비스 가격',
PRIMARY KEY (`Service_ID`));

ALTER TABLE SERVICE COMMENT '서비스';

CREATE TABLE RESTAURANT_ORDER(
`ResOrder_ID` INT NOT NULL AUTO_INCREMENT COMMENT '레스토랑 주문 ID',
`ResOrder_Menu` VARCHAR(15) NOT NULL COMMENT '레스토랑 주문 메뉴',
`ResOrder_Date` DATETIME NOT NULL COMMENT '레스토랑 주문 날짜',
`ResOrder_Time` INT NOT NULL COMMENT '레스토랑 주문 시각',
`RestOrder_TotalAmount` INT NOT NULL COMMENT '레스토랑 총 주문 가격',
`KEY_ID` INT NOT NULL COMMENT '카드키 ID',
`Res_ID` INT NOT NULL COMMENT '레스토랑 ID',
`Cust_ID` INT NOT NULL COMMENT '고객 ID',
PRIMARY KEY (`ResOrder_ID`,`ResOrder_Date`));

ALTER TABLE RESTAURANT_ORDER COMMENT '레스토랑 주문';

CREATE TABLE BED (
`Bed_ID` INT NOT NULL AUTO_INCREMENT COMMENT '침대 ID',
`Bed_Type` VARCHAR(15) NOT NULL COMMENT '침대 종류',
`Bed_State` VARCHAR(15) NULL COMMENT '침대 상태',
`Bed_Available` INT NOT NULL COMMENT '이용가능한 침대',
`Bed_Price`  INT NOT NULL COMMENT '침대 이용료',
CONSTRAINT PRIMARY KEY(BED_ID));

ALTER TABLE `BED` COMMENT='침대 정보 테이블'; 

CREATE TABLE ROOM (
`Room_ID` INT NOT NULL AUTO_INCREMENT COMMENT '방 ID',
`Room_Type` VARCHAR(15) NOT NULL COMMENT '방 종류',
`Room_Facility` VARCHAR(15) NOT NULL COMMENT '방 시설',
`Room_AvailableNO` VARCHAR(15) NOT NULL COMMENT '이용가능한 방 개수',
`Room_ResState` VARCHAR(15) NULL  COMMENT '방 예약 현황',
`Bed_ID` INT NOT NULL COMMENT '침대 ID',
CONSTRAINT PRIMARY KEY(Room_ID));

ALTER TABLE `ROOM` COMMENT='방 정보 테이블';