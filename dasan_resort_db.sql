CREATE DATABASE dasan_resort;
use dasan_resort;

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