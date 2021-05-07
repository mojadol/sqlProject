CREATE DATABASE dasan_resort;

use dasan_resort;

CREATE TABLE SERVICE(
'Service_ID' INT NOT NULL AUTO_INCREMENT COMMENT '서비스ID',
'Service_Type' INT NOT NULL COMMENT '서비스 종류',
'Service_Price' VARCHAR NOT NULL COMMENT '서비스 가격',
PRIMARY KEY (Service_ID)
);
ALTER TABLE SERVICE COMMENT '서비스';

CREATE TABLE RESTAURANT_ORDER(
'ResOrder_ID' INT NOT NULL AUTO_INCREMENT COMMENT '에스토랑 주문 ID'
'ResOrder_Menu' VARCHAR NOT NULL COMMENT '레스토랑 주문 메뉴',
'ResOrder_Date' DATETIME NOT NULL COMMENT '레스토랑 주문 날짜',
'ResOrder_Time' INT NOT NULL COMMENT '레스토랑 주문 시각',
'RestOrder_TotalAmount[Res_Menu, Res_Price]' INT(15) NOT NULL COMMENT '레스토랑 총 주문 가격'
'KEY_ID' INT NOT NULL COMMENT '카드키 ID',
'Res_ID' INT NOT NULL COMMENT '레스토랑 ID',
'Cust_ID' INT NOT NULL COMMENT ' 고객 ID',
PRIMARY KEY ('ResOrder_ID','ResOrder_Date')
FOREIGN KEY (
);
ALTER TABLE RESTAURANT_ORDER COMMENT '레스토랑 주문';





