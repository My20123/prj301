USE prj_train;



-- Create the Accounts table
CREATE TABLE Accounts (
	uID int   AUTO_INCREMENT PRIMARY KEY,
	uname varchar(255) NULL,
    umail varchar(255) NULL,
    pass varchar(255) NULL,
    uphone varchar(15) NULL,
	isStaff int NULL,
	isAdmin int NULL	
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- drop table Order_details;
-- drop table Accounts
-- drop table Tickets
-- drop table Seats
-- drop table Cabins
-- drop table Trains
-- drop table Routes
-- drop table Trips

-- Create the Route table 
CREATE TABLE Routes(
 id int AUTO_INCREMENT PRIMARY KEY,
 from_station varchar(200) NULL,
 to_station varchar(200) NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- drop table Routes_data
CREATE TABLE Routes_data (
    id INT,
    route_key varchar(100),
    value int,
    FOREIGN KEY (id) REFERENCES Routes(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create the Train table with foreign key to Route table
CREATE TABLE Trains(
id varchar(5) PRIMARY KEY,
status int  NULL, -- 1 là available, 0 là not available
number_seat int NULL,
number_cabin int NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create the Schedules table
CREATE TABLE Schedules(
id int AUTO_INCREMENT PRIMARY KEY,
rid int,
trid varchar(5),
from_time datetime,
FOREIGN KEY (trid) REFERENCES Trains(id),
FOREIGN KEY (rid) REFERENCES Routes(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create the Cabins table 
CREATE TABLE Cabins(
id varchar(10) PRIMARY KEY,
number_seat int NUll,
status int NULL,
trid varchar(5),
ctype varchar(100),
FOREIGN KEY (trid) REFERENCES Trains(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create the Seats table
CREATE TABLE Seats(
  id int  AUTO_INCREMENT PRIMARY KEY,
  status int NULL,
  price int NULL,
  cbid varchar(10) ,
  FOREIGN KEY (cbid) REFERENCES Cabins(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create the Tickets table
CREATE TABLE Tickets(
 id int  AUTO_INCREMENT PRIMARY KEY,
 from_station varchar(200) NULL,
 to_station varchar(200) NULL,
 from_date datetime NULL,
 to_date datetime NULL,
 ttype int NULL,
 -- 1 là 1 chiều, 2 là khứ hồi
 trid varchar(5),
 sid int,
 rid int,
 cbid varchar(10),
 FOREIGN KEY (cbid) REFERENCES Cabins(id),
 FOREIGN KEY (trid) REFERENCES Trains(id),
 FOREIGN KEY (sid) REFERENCES Seats(id),
 FOREIGN KEY (rid) REFERENCES Routes(id)
 )ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Create the Order_details table with foreign keys to Products and Orders table
CREATE TABLE Order_details (
  id int  AUTO_INCREMENT PRIMARY KEY,
  tid int ,
  cid int ,
  status int  NULL,
  total_price int  NULL,
  payment_type int  NULL,
  payment_date  DATE,
  FOREIGN KEY (cid) REFERENCES Accounts(uid),
  FOREIGN KEY (tid) REFERENCES Tickets(id)
);




USE prj_train;
-- Insert into the Accounts table
INSERT INTO Accounts ( uname, umail, pass, uphone , isStaff, isAdmin) VALUES ( 'Admin','admin1@gmail.com', '123456', '0912525769', 0,1),
('Trình', 'trinh@gmail.com', '123456', '0384572193', 1, 0),
('Long', 'long@gmail.com', '123456', '12345678',0, 1),
('Khánh', 'khanh@gmail.com', '123456', '12345678', 1, 1),
('My', 'my@gmail.com', '123456', '12345678',0, 0),
('Huyền', 'huyen@gmail.com', '123456', '12345678', 1, 0),
('Customer1', 'customer1@gmail.com', '123456', '12345678', 0, 0),
('Customer2', 'customer2@gmail.com', '123456', '12345678', 0, 0),
('Customer3', 'customer3@gmail.com', '123456', '12345678', 0, 0),
('Customer4', 'customer4@gmail.com', '123456', '12345678', 0, 0),
('Customer5', 'customer5@gmail.com', '123456', '12345678', 0, 0)
;

-- Insert into the Routes table

INSERT INTO Routes ( from_station, to_station) VALUES ('Hà Nội','Sài Gòn'),
('Hà Nội','Đà Nẵng'),
('Hà Nội','Vinh'),
('Hà Nội','Hải Phòng'),
('Hà Nội','Lào Cai'),
('Sài Gòn','Hà Nội'),
('Sài Gòn','Đà Nẵng'),
('Sài Gòn','Nha Trang'),
('Sài Gòn','Phan Thiết'),
('Sài Gòn','Quy Nhơn'),
('Gia Lâm','Nam Ninh'),
('Gia Lâm','Đồng Đăng'),
('Gia Lâm','Bắc Kinh Tây'),
('Yên Viên','Hạ Long'),
('Đà Lạt','Trại Mát'),
('Vũng Áng','Mụ Giạ'),
('Biên Hòa','Vũng Tàu'),
('Đà Nẵng','Quy Nhơn')
;

-- Create data for Routes
INSERT INTO Routes_data (id, route_key, value) VALUES 
(1, 'Hà Nội', 0), (1, 'Phủ Lý', 60), (1, 'Nam Định',105),(1, 'Ninh Bình',145),(1, 'Thanh Hóa',210),(1, 'Vinh',345),(1, 'Hương Phố',425),(1, 'Đồng Hới',585),(1, 'Đông Hà',690),(1, 'Huế',765),(1, 'Đà Nẵng',915),(1, 'Tam Kỳ',1015),(1, 'Quảng Ngãi',1085),(1, 'Diêu Trì',1255),(1, 'Tuy Hòa',1365),(1, 'Nha Trang',1490),(1, 'Bình Thuận',1725),(1, 'Biên Hòa',1885),(1, 'Dĩ An',1905),(1, 'Sài Gòn',1950),
(2, 'Hà Nội',0),(2, 'Nam Định',100),(2, 'Ninh Bình',140),(2, 'Thanh Hóa',210),(2, 'Vinh',365),(2, 'Đồng Hới',605),(2, 'Đông Hà',730),(2, 'Huế',805),(2, 'Đà Nẵng',980),
(4,'Hà Nội',0),(4,'Gia Lâm',15),(4,'Cẩm Giàng',60),(4,'Hải Dương',85),(4,'Phú Thái',115),(4,'Thượng Lý',145),(4,'Hải Phòng',160),
(5,'Hà Nội',0),(5,'Gia Lâm',15),(5,'Yên Viên',30),(5,'Đông Anh',55),(5,'Vĩnh Yên',95),(5,'Yên Bái',240),(5,'Trái Hút',310),(5,'Lang Khay',340),(5,'Bảo Hà',375),(5,'Phố Lu',420),(5,'Lào Cai',485),
(6,'Sài Gòn',0),(6,'Biên Hòa',35),(6,'Bình Thuận',190),(6,'Tháp Chàm',320),(6,'Nha Trang',410),(6,'Tuy Hòa',530),(6,'Diêu Trì',630),(6,'Quảng Ngãi',790),(6,'Tam Kỳ',855),(6,'Đà Nẵng',930),(6,'Huế',1080),(6,'Đông Hà',1155),(6,'Đồng Hới',1260),(6,'Đồng Lê',1360),(6,'Hương Phố',1425),(6,'Vinh',1505),(6,'Thanh Hóa',1660),(6,'Ninh Bình',1725),(6,'Nam Định',1760),(6,'Phủ Lý',1795),(6,'Hà Nội',1865)
;
-- drop table Routes_data;
-- drop table Trains

-- Insert into the Trains table
INSERT INTO Trains ( id, status, number_seat, number_cabin) VALUES 
('SE1',1,374,10), 
('SE2',1,360,10), 
('SE3',1,464,11),
('SE4',1,464,11), 
('SE5',1,360,10), 
('SE6',1,360,10), 
('SE7',1,408,11), 
('SE8',1,464,11), 
('SE9',1,472,11),
('SE10',1,472,11),
('SE12',1,464,11),
('SE19',1,280,10),
('SE23',0,210,10), -- tàu hỏng, mất khoang
('SE24',1,376,10),
('HP1',1,760,12),
('SP3',1,282,11),
('SP7',1,268,11)
;

-- Insert into the Schedules table
INSERT INTO  Schedules (rid, trid, from_time) values (1,'SE1','2025-02-22 10:30:00'),
(6,'SE2','2025-02-22 10:30:00'),
(1,'SE3','2025-02-22 10:30:00'),
(6,'SE4','2025-02-22 10:30:00'),
(1,'SE5','2025-02-22 10:30:00'),
(6,'SE6','2025-02-22 10:30:00'),
(1,'SE7','2025-02-22 10:30:00'),
(6,'SE8','2025-02-22 10:30:00'), 
(1,'SE9','2025-02-22 10:30:00'),
(6,'SE10','2025-02-22 10:30:00'),
(6,'SE12','2025-02-22 10:30:00'),
(6,'SE24','2025-02-22 10:30:00'),
(2,'SE19','2025-02-22 10:30:00'),
(2,'SE3','2025-02-22 10:30:00'),
(2,'SE5','2025-02-22 10:30:00'),
(2,'SE7','2025-02-22 10:30:00'),
(2,'SE9','2025-02-22 10:30:00'),
(2,'SE23','2025-02-22 10:30:00'),
(4,'HP1','2025-02-22 10:30:00'),
(5,'SP3','2025-02-22 10:30:00'),
(5,'SP7','2025-02-22 10:30:00')
;

-- SELECT
--    s.id AS schedule_id,
 --   rd.route_key AS station,
--    ADDTIME(s.departure_time, CONCAT(rd.value, ' MINUTE')) AS arrival_time
-- FROM
--    Schedules s
-- INNER JOIN Routes_data rd ON s.rid = rd.id
-- WHERE
--    s.id = 1;  -- Thay 1 bằng ID của lịch trình bạn muốn xem

-- Insert into the Cabins table
INSERT INTO Cabins(id, number_seat, status, trid, ctype) value
('SE1/1',56,1,'SE1','A56LV'),('SE1/2',56,1,'SE1','A56LV'),('SE1/3',42,1,'SE1','Bn42LM'),('SE1/4',42,1,'SE1','Bn42LM'),('SE1/5',28,1,'SE1','An28LMV'),('SE1/6',28,1,'SE1','An28LMV'),('SE1/7',28,1,'SE1','An28LMV'),('SE1/8',28,1,'SE1','An28LMV'),('SE1/9',28,1,'SE1','An28LMV'),('SE1/10',24,1,'SE1','An24LV2M'),
('SE3/1',64,1,'SE3','A64LV'),('SE3/2',64,1,'SE3','A64LV'),('SE3/3',56,1,'SE3','A56LV'),('SE3/4',42,1,'SE3','Bn42L'),('SE3/5',42,1,'SE3','Bn42L'),('SE3/6',42,1,'SE3','Bn42L'),('SE3/7',42,1,'SE3','Bn42L'),('SE3/8',28,1,'SE3','An28LV'),('SE3/9',28,1,'SE3','An28LV'),('SE3/10',28,1,'SE3','An28LV'),('SE3/11',28,1,'SE3','An28LV'),
('SE5/1',56,1,'SE5','A56LV'),('SE5/2',56,1,'SE5','A56LV'),('SE5/3',42,1,'SE5','Bn42LM'),('SE5/4',42,1,'SE5','Bn42LM'),('SE5/5',28,1,'SE5','An28LMV'),('SE5/6',28,1,'SE5','An28LMV'),('SE5/7',28,1,'SE5','An28LMV'),('SE5/8',28,1,'SE5','An28LMV'),('SE5/9',28,1,'SE5','An28LMV'),('SE5/10',24,1,'SE5','An24LV2M')
;

-- Insert into the Seats table
INSERT INTO Seats (status, price, cbid) VALUE (1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1'),(1,1022000,'SE1/1')
;

-- Insert into the Tickets table
INSERT INTO Tickets (from_station, to_station, from_date, to_date, ttype, trid,sid,rid,cbid) VALUE ('Hà Nội','Sài Gòn','2025-02-22 10:30:00','2025-02-22 10:30:00',1,'SE1',1,1,'SE1/1')
;

-- Insert into the Order_details table
INSERT INTO Order_details (tid,cid,status,total_price,payment_type,payment_date) VALUE (1,5,1,1022000,1,'2025-02-21');

