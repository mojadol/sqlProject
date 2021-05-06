CREATE DATABASE dasan_resort;
use dasan_resort;

<<<<<<< Updated upstream
CREATE TABLE `dasan_resort`.`card key` (
  `Key_ID` INT(10) NOT NULL AUTO_INCREMENT,
  `Room_ID` INT(10) NOT NULL,
  `Cust_ID` INT(10) NOT NULL,
  PRIMARY KEY (`Key_ID`));
  
  
=======
CREATE TABLE RESTAURANT 
(
`Res_ID` INT(10) NOT NULL AUTO_INCREMENT COMMENT 'Res_ID',
`Res_Type` VARCHAR(15) NOT NULL COMMENT 'Res_Type',
`Res_Menu` VARCHAR(15) NOT NULL COMMENT 'Res_Menu',
`Res_Menu_Price` INT(15) NOT NULL COMMENT 'Res_Menu_Price',
CONSTRAINT PRIMARY KEY (Res_ID, Res_Menu));

CREATE TABLE ROOM PRICE (
`RoomPrice_ID` INT(10) NOT NULL AUTO_INCREMENT COMMENT 'RoomPrice_ID',
`Room_Price` INT(15) NOT NULL COMMENT 'Room_Price',
`Room_Week` BOOL(1) NOT NULL COMMENT 'Room_Week',
`Room_Peak` BOOL(1) NOT NULL COMMENT 'Room_Peak',
`Room_ID` INT(10) NOT NULL COMMENT 'Room_ID',
`Room_Type` VARCHAR(15) NOT NULL COMMENT 'Room_Type',
CONSTRAINT PRIMARY KEY (RoomPrice_ID));
>>>>>>> Stashed changes
