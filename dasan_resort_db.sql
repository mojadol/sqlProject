CREATE DATABASE dasan_resort;
use dasan_resort;

CREATE TABLE `dasan_resort`.`card key` (
  `Key_ID` INT(10) NOT NULL AUTO_INCREMENT,
  `Room_ID` INT(10) NOT NULL,
  `Cust_ID` INT(10) NOT NULL,
  PRIMARY KEY (`Key_ID`));