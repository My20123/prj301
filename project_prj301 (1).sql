USE prj_train;


-- Create the Accounts table
CREATE TABLE Accounts (
	uID int   AUTO_INCREMENT PRIMARY KEY,
	uname varchar(255) NULL,
    umail varchar(255) NULL,
    pass varchar(255) NULL,
    uphone varchar(15) NULL,
	isStaff int NULL,
	isAdmin int NULL,
	cccd varchar(15) NULL,
    avatar varchar(50) Null
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE tokenForgetPassword (
    id int AUTO_INCREMENT PRIMARY KEY,
    token VARCHAR(255) NOT NULL,
    expiryTime TIMESTAMP NOT NULL,
	isUsed bit NOT NULL,
	userId int NOT NULL,
	FOREIGN KEY (userId) REFERENCES accounts(uID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
select * from accounts 
SET SQL_SAFE_UPDATES = 0;



 drop table Order_details;
 drop table Accounts
 drop table Tickets
 drop table Seats
drop table Cabins
 drop table Schedules
 drop table Trains
 drop table Routes_data
 drop table Routes


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
  cbid varchar(10),
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
 tcode varchar(8) NULL,
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
INSERT INTO Accounts ( uname, umail, pass, uphone , isStaff, isAdmin, cccd) VALUES ( 'Admin','admin1@gmail.com', '123456', '0912525769', 0,1,0),
('Trình', 'trinh@gmail.com', '123456', '0384572193', 1, 0,0),
('Long', 'long@gmail.com', '123456', '12345678',0, 1,0),
('Khánh', 'khanh@gmail.com', '123456', '12345678', 1, 1,0),
('My', 'my@gmail.com', '123456', '12345678',0, 0,0),
('Huyền', 'lethanhhuyen742004@gmai.com', '123456', '12345678', 1, 0,0),
('Customer1', 'customer1@gmail.com', '123456', '12345678', 0, 0,0),
('Customer2', 'customer2@gmail.com', '123456', '12345678', 0, 0,0),
('Customer3', 'customer3@gmail.com', '123456', '12345678', 0, 0,0),
('Customer4', 'customer4@gmail.com', '123456', '12345678', 0, 0,0),
('Customer5', 'customer5@gmail.com', '123456', '12345678', 0, 0,0)
;
=======
DECLARE @DefaultPassword NVARCHAR(50) = N'123456';

INSERT INTO Accounts ([user], [pass], [isSell], [isAdmin])
VALUES
    (N'Adam', N'1234', 1, 0),
    (N'Tuan', N'12345', 1, 0),
    (N'Kien', N'123456', 0, 1),
    (N'Tung', N'1234567', 1, 1),
    (N'My', N'12345678', 0, 0),
    (N'Huyen', N'123456789', 1, 0);
GO
>>>>>>> master

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
-- SELECT * FROM Schedules WHERE DATE(from_time) = '2025-02-22' and rid=1;

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
-- SELECT DISTINCT route_key FROM Routes_data;

-- select * from routes_data where id=1;
-- select  r.id,r.from_station,r.to_station from Routes r  join Routes_data rd on r.id=rd.id where rd.route_key in( 'Vinh','Hà Nội');
-- select  r.id,r.from_station,r.to_station from Routes r  join Routes_data rd on r.id=rd.id where (select value from Routes_data where route_key='Hà Nội')<(select value from Routes_data where route_key='Vinh')
-- select  r.id, r.from_station,r.to_station from Routes r join Routes_data rd on r.id=rd.id where r.id in
-- (SELECT rd1.id
-- FROM Routes_data rd1
-- JOIN Routes_data rd2 ON rd1.id = rd2.id
-- WHERE rd1.route_key like '%Hà Nội%'  AND rd1.value < rd2.value AND rd2.route_key like '%Sài Gòn%' );
-- select route_key,value from Routes_data where id=1;
-- select id, from_station, to_station from routes where id in (select rd1.id from routes_data rd1 join routes_data rd2 on rd1.id=rd2.id where rd1.route_key = 'Hà Nội' and rd1.value<rd2.value and rd2.route_key = 'Vinh')
-- select  r.id,r.from_station,r.to_station from Routes r  join Routes_data rd on r.id=rd.id where rd.value between 
-- (select value from Routes_data where route_key='Hà Nội')
-- and
-- (select value from Routes_data where route_key='Vinh') order by value
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

<<<<<<< HEAD
=======
-- Insert into the Products table
INSERT INTO Products( [name], [image], [price], [title], [description], [cateID], [sell_ID])
VALUES
    (N'Giày Sneaker Nữ Nike Cortez Leather - Trắng', 'https://supersports.com.vn/cdn/shop/files/DN1791-107-1.jpg?v=1728295224&width=1000', 2749000, N'GIÀY SNEAKER NỮ NIKE CORTEZ LEATHER', N'Xuất phát từ thiết kế dành riêng cho chạy bộ, Giày Sneaker Nữ Nike Cortez Leather trở thành hiện tượng thời trang bởi sức hấp dẫn cổ điển, mang đến sự tinh xảo từ thập kỷ này sang thập kỷ khác. Sự lặp kết hợp từ da và màu sắc hài hòa tạo cảm giác cổ điển cho đôi giày.',2,1),
    (N'Giày Thời Trang Unisex Converse Chuck Taylor All Star - Xanh Navy','https://supersports.com.vn/cdn/shop/products/M9697C-1.jpg?v=1700129720&width=1920', 1450000, N'GIÀY THỜI TRANG UNISEX CONVERSE CHUCK TAYLOR ALL STAR',N'Ra mắt lần đầu năm 1917 với tư cách là một đôi giày bóng rổ, giày Converse All Star ban đầu được bậc thầy bóng rổ Chuck Taylor quảng bá cho sự linh hoạt và lợi ích trên sân bóng. Tuy nhiên qua nhiều thập kỷ, một điều đáng kinh ngạc đã xảy ra: đôi giày thể thao với kiểu dáng mang phong cách vượt thời gian và logo đặc trưng ở mắt cá này đã được các nghệ sĩ, nhạc sĩ và những người nổi tiếng yêu thích và mang biểu diễn tạo nên cơn sốt trên toàn cầu – và chúng vẫn được yêu thích cho đến ngày nay.',5,1),
    (N'Giày Thời Trang Nam New Balance Xc-72 / Daydream - Trắng','https://supersports.com.vn/cdn/shop/files/UXC72DG-1.jpg?v=1695896969&width=1000', 1715400, N'GIÀY THỂ THAO NAM NEW BALANCE', N'TheXC-72 mang đến nguồn cảm hứng khám phá bất tận, với thiết kế bẻ cong thời gian được lấy ý tưởng từ bộ sưu tập xe hơi những năm 1970. Thiết kế đế ngoài đặc biệt hỗ trợ lực kéo tối đa và các đặc điểm góc cạnh được sử dụng tạo nên kiểu dáng độc đáo, thu hút ngay từ ánh nhìn đầu tiên. XC-72 là tương lai mà quá khứ mơ ước và đã được hiện thực hóa thành công.',6,1),
    (N'Giày Sneaker Unisex Fila Float Max - Trắng','https://supersports.com.vn/cdn/shop/files/1RM02855G-100-1.jpg?v=1729073731&width=1000', 2495000, N'GIÀY SNEAKER UNISEX FILA FLOAT MAX1',  N'Giày Sneaker Unisex Fila Float Max1 thuộc dòng FLOAT MAX với đệm vượt trội - phù hợp với chạy bộ hàng ngày. Mũ giày có lớp lưới thoáng khí, giúp bạn luôn thoải mái khi sử dụng thời gian dài.',7,1),
    (N'Giày Sneaker Unisex Fila Float Max - Đen','https://supersports.com.vn/cdn/shop/files/1RM02855G-001-1.jpg?v=1729073697&width=1000', 2495000, N'GIÀY SNEAKER UNISEX FILA FLOAT MAX2',   N'Giày Sneaker Unisex Fila Float Max2 thuộc dòng FLOAT MAX với đệm vượt trội - phù hợp với chạy bộ hàng ngày. Mũ giày có lớp lưới thoáng khí, giúp bạn luôn thoải mái khi sử dụng thời gian dài.',7,1),
    (N'Giày Sneaker Unisex Fila Float Max - Be','https://supersports.com.vn/cdn/shop/files/1RM02853G-920-1.jpg?v=1729073660&width=1000', 2495000, N'GIÀY SNEAKER UNISEX FILA FLOAT MAX3',  N'Giày Sneaker Unisex Fila Float Max3 thuộc dòng FLOAT MAX với đệm vượt trội - phù hợp với chạy bộ hàng ngày. Mũ giày có lớp lưới thoáng khí, giúp bạn luôn thoải mái khi sử dụng thời gian dài.',7,1),
    (N'Giày Sneaker Unisex Fila Replica Max - Đen','https://supersports.com.vn/cdn/shop/files/1RM02853G-002-1.jpg?v=1729073582&width=1000', 2495000,N'GIÀY SNEAKER UNISEX FILA REPLICA MAX4',   N'Giày Sneaker Unisex Fila Float Max4 thuộc dòng FLOAT MAX với đệm vượt trội - phù hợp với chạy bộ hàng ngày. Mũ giày có lớp lưới thoáng khí, giúp bạn luôn thoải mái khi sử dụng thời gian dài.',7,1),
    (N'Giày Sneaker Bé Trai Nike Court Legacy (Psv)', 'https://supersports.com.vn/cdn/shop/files/DA5381-124-1.jpg?v=1728295224&width=832', 1119000,N'GIÀY SNEAKER BÉ TRAI NIKE NIKE COURT LEGACY (PSV)',N'Giày Sneaker Bé Trai Nike Court Legacy (Psv) mang đến phong cách tennis cổ điển cho các bé. Chúng bền bỉ và thoải mái với các đường may mang dấu ấn di sản và logo Swoosh retro. Khi bé yêu của bạn xỏ chân vào đôi giày này—trận đấu bắt đầu và chiến thắng trong tầm tay.',2,1),
    (N'Giày Sneaker Unisex Fila Oakmont Tr V4 - Nâu', 'https://supersports.com.vn/cdn/shop/files/1RM02903G-200-1.jpg?v=1729073784&width=1000', 2795000, N'GIÀY SNEAKER UNISEX FILA OAKMONT TR V4_1', N'Giày Sneaker Unisex Fila Oakmont Tr V4_1 nổi bật với đế ngoài dày dặn - gợi nhớ đến các mẫu giày trekking. Thiết kế thân giày được phối từ tông nền trắng tinh tế, màu đen tối giản và nhấn nhá các lớp màu sắc; tạo nên vẻ ngoài độc đáo, khỏe khoắn và đậm chất dã ngoại.',7,1),
    (N'Giày Sneaker Unisex Fila Oakmont Tr V4 - Đen', 'https://supersports.com.vn/cdn/shop/files/1RM02903G-001-1.jpg?v=1729073760&width=1000', 2795000, N'GIÀY SNEAKER UNISEX FILA OAKMONT TR V4_2', N'Giày Sneaker Unisex Fila Oakmont Tr V4_2 nổi bật với đế ngoài dày dặn - gợi nhớ đến các mẫu giày trekking. Thiết kế thân giày được phối từ tông nền trắng tinh tế, màu đen tối giản và nhấn nhá các lớp màu sắc; tạo nên vẻ ngoài độc đáo, khỏe khoắn và đậm chất dã ngoại.',7,1),
    
    (N'Giày Luyện Tập Nam Nike Metcon 9 - Xám', 'https://supersports.com.vn/cdn/shop/files/DZ2617-002-1.jpg?v=1726563163&width=1000', 4519000, N'GIÀY LUYỆN TẬP NAM NIKE METCON 9', N'Không gì có thể ngăn cản hành trình tập luyện của bạn với Nike Metcon 9. Được cải tiến từ phiên bản Metcon 8 huyền thoại, Metcon 9 tiếp tục là người bạn đồng hành đáng tin cậy, giúp bạn chinh phục mọi thử thách.',2,2),
    (N'Giày Luyện Tập Nữ Nike Motiva - Be', 'https://supersports.com.vn/cdn/shop/files/DV1238-104-1.jpg?v=1726562996&width=1000', 2749000,N'GIÀY LUYỆN TẬP NỮ NIKE MOTIVA', N'The Nikon Z7 II is a full-frame mirrorless camera that offers exceptional image quality and performance. It features a 45.7-megapixel sensor and dual EXPEED 6 processors, providing fast processing speeds and superior image detail. The Z7 II includes a sophisticated autofocus system with 493 focus points, ensuring precise focus in any situation. It supports 4K UHD video recording and has dual card slots for added flexibility. The cameras robust build, weather sealing, and ergonomic design make it suitable for professional photographers who need a reliable and high-performing camera for various shooting conditions.',2,2),
    (N'Giày Luyện Tập Nam Nike Reax 8 - Đen', 'https://supersports.com.vn/cdn/shop/files/621716-020-1.jpg?v=1726562753&width=1000', 2749000, N'Giày Luyện Tập Nam Nike Reax 8', N'Giày Luyện Tập Nam Nike Reax 8 MEtalic là lựa chọn hoàn hảo cho buổi tập luyện hăng say. Với thiết kế kết hợp lớp đệm nhẹ và lớp đệm đàn hồi giúp hỗ trợ quá trình tập luyện và nâng cao hiệu suất.',2,2),
    (N'Giày Luyện Tập Nam Nike Air Max Alpha Trainer 6 - Xám', 'https://supersports.com.vn/cdn/shop/files/FQ1833-006-1.jpg?v=1726563762&width=1000', 2919000, N'Giày Luyện Tập Nam Nike Air Max Alpha Trainer 6', N'Giày Luyện Tập Nam Nike Air Max Alpha Trainer 6 kết hợp sự chắc chắn và thoải má, là lựa chọn hoàn hảo cho những buổi tập luyện căng thẳng. Thiết kế đế phẳng, rộng hỗ trợ đứng vững chắc suốt buổi tập. Gót giày có đệm "performance Air" mang đến sự ổn định tối ưu cho mỗi lần nâng tạ. Hãy để Giày Luyện Tập Nam Nike Air Max Alpha Trainer 6 đồng hành cùng bạn chinh phục mục tiêu tập luyện của mình.',2,2),
    (N'Giày Luyện Tập Nam Nike Air Max Alpha Trainer 6 - Đen', 'https://supersports.com.vn/cdn/shop/files/FQ1833-001-1.jpg?v=1726563708&width=1000', 2919000, N'Giày Luyện Tập Nam Nike Air Max Alpha Trainer 6', N'Giày Luyện Tập Nam Nike Air Max Alpha Trainer 6 kết hợp sự chắc chắn và thoải má, là lựa chọn hoàn hảo cho những buổi tập luyện căng thẳng. Thiết kế đế phẳng, rộng hỗ trợ đứng vững chắc suốt buổi tập. Gót giày có đệm "performance Air" mang đến sự ổn định tối ưu cho mỗi lần nâng tạ. Hãy để Giày Luyện Tập Nam Nike Air Max Alpha Trainer 6 đồng hành cùng bạn chinh phục mục tiêu tập luyện của mình.',2,2),
    (N'Giày Chạy Bộ Nữ Adidas Supernova Rise - Xanh Dương', 'https://supersports.com.vn/cdn/shop/files/ID3595-1.jpg?v=1726651554&width=1000', 3800000, N'GIÀY CHẠY BỘ NỮ ADIDAS SUPERNOVA RISE', N'Được Womens Health trao giải thưởng đôi giày chạy bộ "tốt nhất cho mọi cấp độ", Giày Chạy Bộ Nữ Adidas Supernova Rise luôn thoải mái trên mọi dặm đường. Với công nghệ Dreamstrike+, đế giữa sở hữu ​mút foam cải tiến siêu mềm mại. Hệ thống foam Support Rods truyền lực mượt mà tuyệt đối, từ gót chân đến mũi chân. Độ ôm gót chân chắc chắn nhờ vào thiết kế gót giày đặc biệt và vải dệt mềm mại.',1,2),
    (N'Giày Thể Thao Nam Adidas Ultraboost 1.0 - Đen', 'https://supersports.com.vn/cdn/shop/files/HQ4199-1.jpg?v=1717755517&width=1000', 3600000, N'GIÀY THỂ THAO NAM ADIDAS ULTRABOOST 1.0', N'Khi đi dạo trong công viên cũng như chạy bộ cuối tuần cùng bạn bè, đôi giày adidas Ultraboost 1.0 này sẽ giúp bạn luôn thoải mái. Thân giày adidas PRIMEKNIT ôm chân nhẹ nhàng, đồng thời đệm BOOST ở đế giữa nâng niu từ bước chân đầu tiên cho tới tận cây số cuối cùng. Đế ngoài Stretchweb linh hoạt tự nhiên cho sải bước tràn đầy năng lượng, cùng chất liệu cao su Continental™ Rubber tạo độ bám cần thiết để bạn luôn vững bước.',1,2),
    (N'Giày Chạy Bộ Nam Adidas Supernova Stride - Xanh Dương', 'https://supersports.com.vn/cdn/shop/files/IG8311-1.jpg?v=1706783520&width=1000', 2240000, N'GIÀY CHẠY BỘ NAM ADIDAS SUPERNOVA STRIDE', N'Đôi giày chạy bộ nam Adidas Supernova Stride chính là người bạn đồng hành lý tưởng, giúp bạn sải bước tự tin trên hành trình chinh phục những mục tiêu chạy bộ. Được thiết kế với công nghệ tiên tiến và vật liệu bền vững, Supernova Stride mang đến sự thoải mái, linh hoạt và hiệu suất tối ưu cho mọi buổi chạy của bạn. Sản phẩm này sử dụng ít nhất 20% chất liệu tái chế, góp phần giảm thiểu rác thải và bảo vệ tài nguyên thiên nhiên.',1,2),
    (N'Giày Tập Luyện Nữ Adidas Dropset 3 Trainer - Be', 'https://supersports.com.vn/cdn/shop/files/ID8635-1.jpg?v=1717755617&width=1000', 3150000, N'GIÀY TẬP LUYỆN NỮ ADIDAS DROPSET 3 TRAINER',N'Bất kể buổi tập của bạn đòi hỏi sức mạnh hay sức bền, đôi giày adidas này sẽ mang đến cho bạn sự hỗ trợ cần thiết để rèn luyện thể lực. Đế giữa mật độ kép giúp bàn chân duy trì ổn định khi nâng tạ, đồng thời vẫn đủ linh hoạt cho bài tập cardio. Công nghệ HEAT.RDY và thân giày thoáng khí hợp lực giúp đánh bật hơi nóng để bạn tập trung vào các rep tập. Kiểu dáng rộng chiều ngang đáp ứng tình trạng bàn chân nở ra, cùng đế ngoài Adiwear bám tốt trên mặt sàn để tăng cường hiệu năng tập luyện. Sản phẩm này có chứa tối thiểu 20% chất liệu tái chế. Bằng cách tái sử dụng các chất liệu đã được tạo ra, chúng tôi góp phần giảm thiểu lãng phí và hạn chế phụ thuộc vào các nguồn tài nguyên hữu hạn, cũng như giảm phát thải từ các sản phẩm mà chúng tôi sản xuất.',1,2),
    (N'Giày Sneaker Nữ Adidas Grand Court 2.0 - Hồng', 'https://supersports.com.vn/cdn/shop/files/ID3004-1.jpg?v=1716869851&width=1000', 1400000, N'GIÀY SNEAKER NỮ ADIDAS GRAND COURT 2.0', N'Nhẹ nhàng lướt qua những ngày dài bận rộn. Đôi giày sneaker adidas này giúp bạn vận động dễ dàng, với lót giày Cloudfoam Comfort tạo lớp đệm êm ái. Là phiên bản cải tiến của dòng giày Grand Courts iconic, đôi giày này khoe trọn di sản thể thao, từ 3 Sọc kinh điển tới đế cupsole bằng cao su classic. Sản phẩm này có chứa tối thiểu 20% chất liệu tái chế. Bằng cách tái sử dụng các chất liệu đã được tạo ra, chúng tôi góp phần giảm thiểu lãng phí và hạn chế phụ thuộc vào các nguồn tài nguyên hữu hạn, cũng như giảm phát thải từ các sản phẩm mà chúng tôi sản xuất.',1,2),
    
    (N'Giày Thời Trang Unisex Puma Slipstream Expedition - Vàng', 'https://supersports.com.vn/cdn/shop/files/39574702-1.jpg?v=1714987056&width=1000', 2169300, N'GIÀY THỜI TRANG UNISEX PUMA SLIPSTREAM EXPEDITION', N'Đưa phong cách đường phố của bạn lên một tầm cao mới với Giày Thời Trang Unisex Puma Slipstream Expedition. Sản phẩm kết hợp giữa chất liệu da thuộc cao cấp và thiết kế táo bạo, mang đến cho bạn vẻ ngoài năng động, cá tính và thời trang. Giày Slipstream Expedition đồng hành cùng bạn trong mọi cuộc phiêu lưu, khơi nguồn cảm hứng để bạn khám phá những điều mới mẻ và chinh phục mọi thử thách.',3,6),
    (N'Giày Thời Trang Unisex Puma Slipstream Bball - Trắng', 'https://supersports.com.vn/cdn/shop/files/39326606-1.jpg?v=1693889146&width=1000', 1919400, N'GIÀY THỜI TRANG UNISEX PUMA SLIPSTREAM EXPEDITION', N'Back in 1987, the PUMA Slipstream entered the scene as a high-flying, slam-dunking, statement-making basketball sneaker. With the Slipstream Bball, we are going back to its proud basketball roots. It features a leather upper with subtle pops of colour, as well as a synthetic PUMA Formstrip and synthetic underlays for a clean court-side look.',3,6),
    (N'Giày Sneaker Unisex Puma Rs-X Suede Sugared - Be', 'https://supersports.com.vn/cdn/shop/files/39117610-1.jpg?v=1716806448&width=1000', 2169300, N'GIÀY SNEAKER UNISEX PUMA RS-X SUEDE SUGARED', N'Giày Sneaker Unisex Puma Rs-X Suede Sugared đã trở lại với diện mạo và nguồn năng lượng tươi mới hơn! Đôi giày với sức mạnh khơi gợi sự sáng tạo không giới hạn trong bạn, không chỉ gây ấn tượng ở quá khứ và hiện tại mà còn tiềm ẩn nhiều thông điệp biểu tượng của tương lai. Thiết kế kết hợp hoàn hảo giữa phong cách cổ điển và những tiến bộ hiện đại, Giày Sneaker Unisex Puma Rs-X Suede Sugared mang đến một cái nhìn mới mẻ và sắc nét, phản ánh tinh thần thời đại và tính thẩm mỹ tiến bộ vượt bậc.',3,6),
    (N'Giày Sneaker Unisex Puma Rs-X 3D - Đỏ', 'https://supersports.com.vn/cdn/shop/files/39002507-1.jpg?v=1702289714&width=1000', 2099400, N'GIÀY SNEAKER UNISEX PUMA RS-X 3D', N'Hãy bứt phá mọi giới hạn của phong cách và tự tin thể hiện cá tính của bạn với Giày Sneaker Unisex Puma Rs-X 3D. Với thiết kế phá cách, họa tiết táo bạo và gam màu nổi bật, đôi giày này sẽ biến bạn thành tâm điểm chú ý và truyền cảm hứng cho những người xung quanh. Hãy sở hữu ngay Giày Sneaker Unisex Puma Rs-X 3D để bứt phá phong cách và tỏa sáng với cá tính riêng của bạn!',3,6),
    (N'Giày Thời Trang Nữ Puma Tevaris Nitro Metallic - Đen', 'https://supersports.com.vn/cdn/shop/files/39686302-1.jpg?v=1694399536&width=1000', 1979400, N'GIÀY NỮ PUMA BLACK- GOLD-SHADOW GRAY', N'Chiến thắng mọi thử thách với đôi Giày Nữ Puma Black-Gold-Shadow Gray. Sự kết hợp tinh tế giữa màu đen, vàng và xám tạo nên một phong cách độc đáo và cuốn hút, giúp bạn tỏa sáng trong mọi bước đi.',3,6),
    (N'Giày Sneaker Unisex Puma Rs-Trck Expeditions - Xanh Dương', 'https://supersports.com.vn/cdn/shop/files/39534401-1.jpg?v=1716806502&width=1000', 2309300, N'GIÀY SNEAKER UNISEX PUMA RS-TRCK EXPEDITIONS', N'Bứt phá mọi giới hạn với Giày Sneaker Unisex Puma Rs-Trck Expeditions. Với phom dáng ôm chân giúp bạn di chuyển tự tin và linh hoạt. Đế ngoài cao su chống trơn trượt, tăng cường khả năng bám đường. Trải nghiệm đôi giày Sneaker Unisex Puma Rs-Trck Expeditions được chế tạo để chinh phục mọi thử thách, giày đảm bảo sự bền bỉ và phong cách, giúp bạn tăng tốc mạnh mẽ trong mỗi bước chân.',3,6),
    (N'Giày Thời Trang Nữ Puma Puma-180 - Trắng', 'https://supersports.com.vn/cdn/shop/files/38926705-1.jpg?v=1695198487&width=1000', 1859400, N'GIÀY NỮ PUMA PUMA-180', N'Giày Puma Puma-180 là một bước tiến đột phá, phá vỡ mọi giới hạn và kết hợp văn hóa skateboard cùng với thời trang mới mẻ. Lấy cảm hứng từ các mẫu giày retro của PUMA từ thập kỷ 1990, phiên bản này vô cùng sáng tạo trong việc thể hiện văn hóa thể thao vượt thời gian của thương hiệu bằng ngôn ngữ thiết kế hiện đại. PUMA-180 kết hợp giữa yếu tố cổ điển và xu hướng. Bốn phiên bản giày với màu chủ đạo là xám sương, đen cổ điển, nâu đất và xanh dương hải quân đã ra mắt. Chúng không chỉ đem đến sự mới mẻ cho văn hóa skateboard, mà còn mở ra nhiều khả năng sáng tạo cho những người yêu thời trang đường phố.',3,6),
    (N'Giày Thể Thao Nữ Puma Cali Court Pure Luxe Wns - Đen', 'https://supersports.com.vn/cdn/shop/files/39527502-1.jpg?v=1711361105&width=1000', 1679400, N'GIÀY THỂ THAO NỮ PUMA CALI COURT PURE LUXE WNS', N'Puma Cali Court Pure Luxe Wns là sự kết hợp hoàn hảo giữa phong cách đường phố năng động và vẻ đẹp sang trọng. Đôi giày này phá vỡ các quy tắc bằng cách pha trộn các chi tiết công nghệ tương lai nổi bật với kiểu dáng tối giản siêu đẹp. Chất liệu cao cấp và cảm hứng xa hoa được kết hợp tinh tế để tạo nên một đôi giày độc đáo, thu hút mọi ánh nhìn.',3,6),
    (N'Giày Thời Trang Nữ Puma Teveris Nitro Metallic - Xám', 'https://supersports.com.vn/cdn/shop/files/39686301-1.jpg?v=1695378082&width=1000', 2039400, N'GIÀY THỂ THAO NỮ PUMA FEATHER ', N'Giày thể thao nữ Puma Feather là sự kết hợp tinh tế giữa phong cách thể thao và thời trang hiện đại. Với nguồn cảm hứng từ dòng sản phẩm chạy của PUMA trong những năm 2000, Teveris NITRO mang đến một diện mạo phù hợp cho cuộc sống năng động của bạn. Dòng sản phẩm này được tái tạo và trang bị công nghệ NITRO™ trên lớp đế giữa để tạo ra sự thoải mái tối đa, đồng thời sở hữu một upper bằng vải canvas kết hợp với lớp lót bằng da lông màu bạc tạo nên một vẻ ngoài độc đáo.',3,6),
    (N'Giày Sneaker Unisex Puma Spirex Speed Mist - Xám', 'https://supersports.com.vn/cdn/shop/files/39726302-1.jpg?v=1702289868&width=1000', 2579400, N'GIÀY SNEAKER UNISEX PUMA SPIREX SPEED MIST', N'Được lấy cảm hứng từ những biểu tượng tốc độ của PUMA, đây là sự tiếp nối của phong cách retro mang đến hơi thở mới mẻ. Hãy sở hữu ngay Giày Sneaker Unisex Puma Spirex Speed Mist để thêm nét cá tính táo bạo cho phong cách thời trang của bạn!',3,6)
    
  ;
GO
>>>>>>> master
