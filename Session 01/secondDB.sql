# Tao CSDL
create database if not exists QuanLyBanHang;

use QuanLyBanHang;

# Tao bang
create table Customer(
cId int auto_increment,
cName varchar(50) not null,
cAge int,

primary key pk_cutomer (cId)
);

create table `Order`(
oId int not null,
cId int not null,
oDate datetime not null,
oTotalPrice decimal(12,2),

primary key pk_order (oId),
constraint foreign key (cId) references Customer(cId) 
);

create table Product(
pId int auto_increment,
pName varchar(50) not null,
pPrice decimal(12,2),

primary key pk_product (pId)
);

create table OrderDetail(
oId int,
pId int,

primary key pk_orderDetail (oId,pId),
constraint foreign key (oId) references `Order`(oId),
constraint foreign key (pId) references Product(pId)
);

drop database QuanLyBanHang;



