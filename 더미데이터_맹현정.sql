use dasan_resort;
INSERT INTO CUSTOMER(Cust_webID,Cust_Name,Cust_Contact,Cust_Email,Cust_Address,Cust_Password,Cust_CurrentMile,Cust_Usedmile)
Values 
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
('apricot','이살구','010-1234-5692','apricot@naver.com','경기도 양주시','tkfrn15',600,0);

INSERT INTO BOOKING (Booking_CurrentDate,Booking_CheckInDate, Booking_CheckOutDate, Cust_ID, People_No, Room_Choice, Bed_PlusState, RoomPrice_ID, Booking_TotalAmount, Booking_method) 
VALUES
('2021-06-10 10:11:30','2021-06-16','2021-06-18','61','1','디럭스룸','0','1','400000','홈페이지'),
('2021-06-11 11:14:31','2021-06-17','2021-06-18','62','2','디럭스룸 suite','0','14','50000','전화'),
('2021-06-11 20:15:58','2021-06-22','2021-06-23','63','3','비즈니스룸','1','6','330000','방문'),
('2021-06-13 09:03:15','2021-06-22','2021-06-24','64','1','수페리어룸 suite','0','22','1400000','홈페이지'),
('2021-06-14 08:58:39','2021-06-23','2021-06-24','65','5','수페리어룸 suite','1','22','750000','전화'),
('2021-06-20 21:33:33','2021-06-20','2021-06-21','66','1','디럭스룸 suite','0','15','500000','방문'),
('2021-06-20 23:29:46','2021-06-25','2021-06-27','67','4','비즈니스룸 suite','1','18','1230000','홈페이지'),
('2021-06-22 03:45:29','2021-06-27','2021-06-28','68','6','수페리어룸 suite','1','22','760000','홈페이지');

INSERT INTO ROOMSTATE(Room_ID, RoomState_State, Cust_ID, Booking_ID)
VALUE
(3,1,61,33),
(305,1,62,34),
(114,1,63,35),
(495,1,64,36),
(500,1,65,37),
(304,1,66,38),
(410,1,67,39),
(487,1,68,40);