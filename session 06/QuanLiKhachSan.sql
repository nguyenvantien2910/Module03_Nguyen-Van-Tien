create database if not exists QuanLiKhachSan;
use QuanLiKhachSan;

create table if not exists Category
(
    Id     int auto_increment  not null,
    Name   varchar(100) unique not null,
    Status tinyint default 1 check ( Status IN (0, 1)),

    primary key (Id)
);

create table if not exists Room
(
    Id         int auto_increment not null,
    Name       varchar(150)       not null,
    Status     tinyint default 1 check ( Status in (0, 1)),
    Price      float              not null check ( Price >= 100000 ),
    SalePrice  float   default 0,
    CreateDate date    default (curdate()),
    CategoryId int                not null,

    primary key (Id, CategoryId),
    constraint check ( SalePrice <= Price )
);

create table if not exists Customer
(
    Id         int auto_increment,
    Name       varchar(150) not null,
    Email      varchar(150) not null unique check ( Email regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    Phone      varchar(50)  not null unique,
    Address    varchar(255),
    CreateDate date default (curdate()),
    Gender     tinyint      not null check ( Gender in (0, 1, 2)),
    BirthDay   date         not null,

    primary key (Id)
);

delimiter $$
create trigger check_CreateDate
    before insert
    on Customer
    for each row
begin
    if NEW.CreateDate < CURDATE() then
        signal sqlstate '45000'
            set message_text = 'Ngày tạo không được lớn hơn ngày hiện tại';
    end if;
end $$
delimiter ;

create table Booking
(
    Id          int auto_increment not null,
    CutomerId   int                not null,
    Status      tinyint  default 1 check ( Status in (0, 1, 2, 3)),
    BookingDate datetime default (curdate()),

    primary key (Id, CutomerId)
);

create table BookingDetail
(
    BookingId int auto_increment not null,
    RoomId    int                not null,
    Price     float              not null,
    StartDate datetime           not null,
    EndDate   datetime           not null,

    primary key (BookingId, RoomId),
    constraint check ( EndDate >= StartDate )
);

#constraint
alter table Room
    add constraint room_category_pk foreign key (CategoryId) references Category (Id);

alter table Booking
    add constraint booking_customer_pk foreign key (CutomerId) references customer (Id);

alter table BookingDetail
    add constraint bookingDetail_booking_pk foreign key (BookingId) references Booking (Id),
    add constraint bookingDetail_room_pk foreign key (BookingId) references Room (Id);


#insert data
#category
insert into Category(Name, Status) VALUE ('Eco', 1), ('Plus', 1), ('Normal', 1), ('Luxury', 1), ('President', 1);

#room
insert into Room(Name, Price, SalePrice, CategoryId) VALUE ('Phòng 1', 150000, 50000, 1),
    ('Phòng 2', 250000, 10000, 2),
    ('Phòng 3', 350000, 20000, 3),
    ('Phòng 4', 450000, 30000, 4),
    ('Phòng 5', 550000, 40000, 5),
    ('Phòng 6', 150000, 50000, 1),
    ('Phòng 7', 250000, 60000, 2),
    ('Phòng 8', 350000, 10000, 3),
    ('Phòng 9', 450000, 20000, 4),
    ('Phòng 10', 550000, 30000, 5),
    ('Phòng 11', 650000, 40000, 1),
    ('Phòng 12', 150000, 50000, 2),
    ('Phòng 13', 250000, 20000, 3),
    ('Phòng 14', 350000, 20000, 4),
    ('Phòng 15', 450000, 10000, 5),
    ('Phòng 16', 450000, 10000, 1);

#Customer
insert into Customer(Name, Email, Phone, Address, Gender, BirthDay) value
    ('Nguyễn Văn Tiến', 'tien@gmail.com', '0987654321', 'Ha Noi', 0, '1994-10-29'),
    ('Nguyễn Văn Liêm', 'liem@gmail.com', '0987654421', 'Ha Noi', 0, '1995-11-28'),
    ('Nguyễn Văn Tự', 'tu@gmail.com', '0987654320', 'Ha Noi', 0, '1993-12-27'),
    ('Nguyễn Văn Hung', 'hung@gmail.com', '0987674321', 'Ha Noi', 0, '1992-1-26'),
    ('Nguyễn Trung Hiếu', 'hieu@gmail.com', '0988654321', 'Ha Noi', 0, '1991-8-25');

#booking
insert into Booking(cutomerid) value (5),(4),(3),(2),(1);

#bookingdetail
insert into BookingDetail(BookingId, RoomId, Price, StartDate, EndDate) value
    (1, 16, 250000, '2024-04-26 14:00:00', '2024-04-29 12:00:00'),
    (1, 15, 350000, '2024-04-26 14:00:00', '2024-04-29 12:00:00'),
    (1, 14, 550000, '2024-04-26 14:00:00', '2024-04-29 12:00:00'),
    (2, 13, 150000, '2024-03-26 14:00:00', '2024-04-29 12:00:00'),
    (2, 12, 250000, '2024-03-26 14:00:00', '2024-04-29 12:00:00'),
    (2, 11, 350000, '2024-03-26 14:00:00', '2024-04-29 12:00:00'),
    (3, 10, 450000, '2024-02-26 14:00:00', '2024-04-29 12:00:00'),
    (3, 9, 550000, '2024-02-26 14:00:00', '2024-04-29 12:00:00'),
    (3, 8, 650000, '2024-02-26 14:00:00', '2024-04-29 12:00:00'),
    (4, 7, 250000, '2024-02-26 14:00:00', '2024-04-29 12:00:00'),
    (4, 6, 150000, '2024-01-26 14:00:00', '2024-04-29 12:00:00'),
    (4, 5, 450000, '2024-01-26 14:00:00', '2024-04-29 12:00:00'),
    (5, 4, 250000, '2024-02-26 14:00:00', '2024-04-29 12:00:00'),
    (5, 3, 150000, '2024-04-26 14:00:00', '2024-04-29 12:00:00'),
    (5, 2, 650000, '2024-05-26 14:00:00', '2024-05-29 12:00:00');



#Yêu cầu 1 ( Sử dụng lệnh SQL để truy vấn cơ bản ):
#1.	Lấy ra danh phòng có sắp xếp giảm dần theo Price gồm các cột sau: Id, Name, Price, SalePrice, Status, CategoryName, CreatedDate
select r.Id         'ID',
       r.Name       'Name',
       r.Price      'Price',
       r.SalePrice  'SalePrice',
       r.Status     'Status',
       c.Name       'CategoryName',
       r.CreateDate 'CreateDate'
from room r
         join category c on r.CategoryId = c.Id
order by Price DESC;

#2.	Lấy ra danh sách Category gồm: Id, Name, TotalRoom, Status (Trong đó cột Status nếu = 0, Ẩn, = 1 là Hiển thị )
select c.Id ID, c.Name Name, count(r.Id) 'TotalRoom'
from category c
         join Room R on c.Id = R.CategoryId
where c.Status = 1
group by c.Id;

#3.	Truy vấn danh sách Customer gồm: Id, Name, Email, Phone, Address, CreatedDate, Gender, BirthDay, Age (Age là cột suy ra từ BirthDay, Gender nếu = 0 là Nam, 1 là Nữ,2 là khác )
select Id,
       Name,
       Email,
       Phone,
       Address,
       CreateDate,
       case
           when Gender = 0 then 'Nam'
           when Gender = 1 then 'Nữ'
           else 'Khác' end as         Gender,
       BirthDay,
       (year(now()) - YEAR(BirthDay)) 'Age'
from Customer
order by Id;

#4.	Truy vấn xóa các sản phẩm chưa được bán


#5.	Cập nhật Cột SalePrice tăng thêm 10% cho tất cả các phòng có Price >= 250000
select *
from Room
where Price >= 250000;

update Room
set SalePrice = SalePrice * 1.1
where Price >= 250000;

select *
from Room
where Price >= 250000;

#Yêu cầu 2 ( Sử dụng lệnh SQL tạo View )
#1.	View v_getRoomInfo Lấy ra danh sách của 10 phòng có giá cao nhất
delimiter $$
create view v_getRoomInfo as
select *
from Room
order by Price DESC
limit 10;
delimiter ;

select *
from v_getRoomInfo;

#2.	View v_getBookingList hiển thị danh sách phiếu đặt hàng gồm: Id, BookingDate, Status, CusName, Email, Phone,TotalAmount ( Trong đó cột Status nếu = 0 Chưa duyệt, = 1  Đã duyệt, = 2 Đã thanh toán, = 3 Đã hủy )
DELIMITER $$

CREATE VIEW v_getBookingList AS
SELECT b.Id          AS Id,
       b.BookingDate AS BookingDate,
       CASE
           WHEN b.Status = 0 THEN 'Chưa duyệt'
           WHEN b.Status = 1 THEN 'Đã duyệt'
           WHEN b.Status = 2 THEN 'Đã thanh toán'
           WHEN b.Status = 3 THEN 'Đã hủy'
           END       AS Status,
       c.Name        AS CusName,
       c.Email       AS Email,
       c.Phone       AS Phone,
       SUM(bd.Price) AS TotalAmount
FROM booking AS b
         JOIN bookingdetail AS bd ON b.Id = bd.BookingId
         JOIN Customer AS c ON b.CutomerId = c.Id
GROUP BY b.Id,
         b.BookingDate,
         b.Status,
         c.Name,
         c.Email,
         c.Phone;

DELIMITER ;


select *
from v_getBookingList;

#Yêu cầu 3 ( Sử dụng lệnh SQL tạo thủ tục Stored Procedure )
#1.	Thủ tục addRoomInfo thực hiện thêm mới Room, khi gọi thủ tục truyền đầy đủ các giá trị của bảng Room ( Trừ cột tự động tăng )
delimiter $$
create procedure addRoomInfo(name_IN varchar(150), status_IN tinyint, Price_IN float, categoryId_IN int)
begin
    insert into Room(Name, Status, Price, CategoryId) value (name_IN, status_IN, Price_IN, categoryId_IN);
end$$
delimiter ;

call addRoomInfo('Phòng 17', 0, 650000, 5);

select *
from Room
where Name = 'Phòng 17';

#2.	Thủ tục getBookingByCustomerId hiển thị danh sách phieus đặt phòng của khách hàng theo Id khách hàng gồm: Id, BookingDate, Status, TotalAmount (Trong đó cột Status nếu = 0 Chưa duyệt, = 1  Đã duyệt,, = 2 Đã thanh toán, = 3 Đã hủy), Khi gọi thủ tục truyền vào id cảu khách hàng
delimiter $$
create procedure getBookingByCustomerId(cusID_IN int)
begin
    select b.Id          Id,
           b.BookingDate BookingDate,
           case
               when b.Status = 0 then 'Chưa duyệt'
               when b.Status = 1 then 'Đã duyệt'
               when b.Status = 2 then 'Đã thanh toán'
               else 'Đã hủy'
               end as    Status,
           sum(bd.Price) TotalAmount
    from booking b
             join bookingdetail bd on b.Id = bd.BookingId
    where b.Id = cusID_IN
    group by b.Id, b.BookingDate, b.Status;
end $$
delimiter ;

call getBookingByCustomerId(3);

#3.	Thủ tục getRoomPaginate lấy ra danh sách phòng có phân trang gồm: Id, Name, Price, SalePrice, Khi gọi thủ tuc truyền vào limit và page
delimiter $$
create procedure getRoomPaginate(limit_val int, page_val int)
begin
    declare offset_val int default 0;
    set offset_val = (page_val - 1) * limit_val;

    select Id, Name, Price, SalePrice
    from Room
    limit limit_val offset offset_val;

end $$
delimiter ;

call getRoomPaginate(1,17);

#Yêu cầu 4 ( Sử dụng lệnh SQL tạo Trigger )
#1.	Tạo trigger tr_Check_Price_Value sao cho khi thêm hoặc sửa phòng Room nếu nếu giá trị của cột Price > 5000000 thì tự động chuyển về 5000000 và in ra thông báo ‘Giá phòng lớn nhất 5 triệu’
delimiter $$
create trigger tr_Check_Price_Value
    before insert on Room
    for each row
    begin

    end $$
delimiter ;
#2.	Tạo trigger tr_check_Room_NotAllow khi thực hiện đặt pòng, nếu ngày đến (StartDate) và ngày đi (EndDate) của đơn hiện tại mà phòng đã có người đặt rồi thì báo lỗi “Phòng này đã có người đặt trong thời gian này, vui lòng chọn thời gian khác”









