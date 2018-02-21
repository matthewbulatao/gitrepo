INSERT INTO APPLICATION_PROPERTIES(max_children_per_booking,max_adult_per_booking,entrance_fee_child,entrance_fee_adult,down_payment_percentage,vat_percentage) VALUES(10,10,100,300,50,20);

INSERT INTO ROLE(code,name) VALUES('ROLE_ADMIN','ADMIN');
INSERT INTO ROLE(code,name) VALUES('ROLE_STAFF','STAFF');

INSERT INTO USER(first_name,last_name,user_name,password,status) VALUES('Default ADMIN','ADMIN','admin','$2a$11$AZq/jKbivgqMyAgw9tvHZewCDQroopork6SgrE/UFfaOYtmIH.iCS','A');
INSERT INTO USER(first_name,last_name,user_name,password,status) VALUES('Default STAFF','STAFF','staff','$2a$11$CktRdgq67Idvpryu1wW.sekjo4e2aUbUPxUmaISVnF1JGKiSKLZNO','A');

INSERT INTO USER_ROLES(user_id,roles_id) VALUES(1,1);
INSERT INTO USER_ROLES(user_id,roles_id) VALUES(2,2);

INSERT INTO ROOM_TYPE(name) VALUES('STANDARD');
INSERT INTO ROOM_TYPE(name) VALUES('DELUXE');
INSERT INTO ROOM_TYPE(name) VALUES('DORM ROOM');
INSERT INTO ROOM_TYPE(name) VALUES('HOTEL ROOM');
INSERT INTO ROOM_TYPE(name) VALUES('VILLA');

INSERT INTO ROOM(name,type,code,capacity,capacity_children,rate,status,description) VALUES('Villa Guevara','VILLA','10VIL1',15,5,2000.00,'A','5 double-deck beds and air-conditioning');

INSERT INTO ROOM(name,type,code,capacity,capacity_children,rate,status,description) VALUES('CE Hotel Room A','HOTEL ROOM','2HOT1',2,1,700.00,'A','1 queen size bed, bathroom and air-conditioning');
INSERT INTO ROOM(name,type,code,capacity,capacity_children,rate,status,description) VALUES('CE Hotel Room B','HOTEL ROOM','2HOT2',2,1,700.00,'A','1 queen size bed, bathroom and air-conditioning');
INSERT INTO ROOM(name,type,code,capacity,capacity_children,rate,status,description) VALUES('CE Hotel Room C','HOTEL ROOM','2HOT3',2,1,700.00,'A','1 queen size bed, bathroom and air-conditioning');

INSERT INTO ROOM(name,type,code,capacity,capacity_children,rate,status,description) VALUES('Overnight Room A','STANDARD','3STA1',3,1,500.00,'A','1 queen size bed w/ upper deck and air-conditioning');
INSERT INTO ROOM(name,type,code,capacity,capacity_children,rate,status,description) VALUES('Overnight Room B','STANDARD','3STA2',3,1,500.00,'A','1 queen size bed w/ upper deck and air-conditioning');

INSERT INTO ROOM(name,type,code,capacity,capacity_children,rate,status,description) VALUES('Family Room','DELUXE','5DEL1',5,2,1000.00,'A','2 queen size beds and air-conditioning');
INSERT INTO ROOM(name,type,code,capacity,capacity_children,rate,status,description) VALUES('Deluxe Room','DELUXE','5DEL2',5,2,1500.00,'A','2 queen size beds, bathroom and air-conditioning');

INSERT INTO ROOM(name,type,code,capacity,capacity_children,rate,status,description) VALUES('Suite Dorm Room','DORM ROOM','7DOR1',7,2,1200.00,'A','1 queen size bed + 1 double-deck and air-conditioning');
INSERT INTO ROOM(name,type,code,capacity,capacity_children,rate,status,description) VALUES('Deluxe Dorm Room','DORM ROOM','10DOR1',10,2,1500.00,'A','3 double-deck beds and air-conditioning');

INSERT INTO MISCELLANEOUS(code,name,rate) VALUES('MISC_KARA','Karaoke',300);
INSERT INTO MISCELLANEOUS(code,name,rate) VALUES('MISC_BASK','Basketball Court',100);
INSERT INTO MISCELLANEOUS(code,name,rate) VALUES('MISC_EXTR','Extra Matress',100);
INSERT INTO MISCELLANEOUS(code,name,rate) VALUES('MISC_BARB','Barbeque Grill',0);
INSERT INTO MISCELLANEOUS(code,name,rate) VALUES('MISC_CHAR','Charcoal',20);