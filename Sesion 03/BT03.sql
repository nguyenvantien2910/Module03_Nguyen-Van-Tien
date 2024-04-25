CREATE DATABASE IF NOT EXISTS QuanLiVatTuVatLieu;

USE QuanLiVatTuVatLieu;

#Phieu xuat
CREATE TABLE PhieuXuat
(
    soPX     int      not null primary key,
    ngayXuat datetime not null
);

#Phieu xuat chi tiet
CREATE TABLE PhieuXuatChiTiet
(
    soPX        int not null,
    maVt        int not null,
    donGiaXuat  double,
    soLuongXuat int,

    PRIMARY KEY (soPX, maVT)
);

#Vat Tu
CREATE TABLE VatTu
(
    maVt  int not null primary key,
    tenVt varchar(255)
);

#Don Dat Hang
CREATE TABLE DonDatHang
(
    soDH   int not null primary key,
    maNCC  int not null,
    ngayDH datetime
);

#Chi Tiet Don Hang
CREATE TABLE chiTietDonHang
(
    maVt int not null,
    soDH int not null,

    PRIMARY KEY (soDH, maVt)
);

#Nha Cung Cap
CREATE TABLE NhaCungCap
(
    maNCC  int not null primary key,
    tenNCC varchar(255),
    diaChi varchar(255),
    soDT   varchar(11)
);

#Phieu Nhap
CREATE TABLE PhieuNhap
(
    soPN     int not null primary key,
    ngayNhap datetime
);

#PhieuNhapChiTiet
CREATE TABLE PhieuNhapChiTiet
(
    soPN        int not null,
    maVt        int not null,
    donGiaNhap  double,
    soLuongNhap int,

    PRIMARY KEY (soPN, maVt)
);

# Constraint
ALTER TABLE PhieuXuatChiTiet
    ADD CONSTRAINT PhieuXuatChiTiet_PhieuXuat_fk foreign key (soPX) references PhieuXuat (soPX),
    ADD CONSTRAINT PhieuXuatChiTiet_VatTu_fk foreign key (maVt) references VatTu (maVt);

ALTER TABLE chiTietDonHang
    ADD CONSTRAINT chiTietDonHang_VatTu_fk foreign key (maVt) references VatTu (maVt);

ALTER TABLE PhieuNhapChiTiet
    ADD CONSTRAINT PhieuNhapChiTiet_VatTu_fk foreign key (maVt) references VatTu (maVt),
    ADD CONSTRAINT PhieuNhapChiTiet_PhieuNhap_fk foreign key (soPN) references PhieuNhap (soPN);

ALTER TABLE DonDatHang
    ADD CONSTRAINT DonDatHang_ChiTietDonDatHang_fk foreign key (soDH) references chiTietDonHang (soDH),
    ADD CONSTRAINT DonDatHang_NhaCungCap_fk foreign key (maNCC) references NhaCungCap (maNCC);

-- Insert data into PhieuXuat
INSERT INTO PhieuXuat (soPX, ngayXuat)
VALUES (1, '2024-04-22 08:00:00'),
       (2, '2024-04-23 09:00:00'),
       (3, '2024-04-24 10:00:00'),
       (4, '2024-04-25 11:00:00'),
       (5, '2024-04-26 12:00:00');

-- Insert data into PhieuXuatChiTiet
INSERT INTO PhieuXuatChiTiet (soPX, maVt, donGiaXuat, soLuongXuat)
VALUES (1, 1, 1000, 5),
       (1, 2, 1500, 3),
       (2, 3, 2000, 2),
       (3, 4, 1200, 4),
       (4, 5, 1800, 6);

-- Insert data into VatTu
INSERT INTO VatTu (maVt, tenVt)
VALUES (1, 'VatTu1'),
       (2, 'VatTu2'),
       (3, 'VatTu3'),
       (4, 'VatTu4'),
       (5, 'VatTu5');

-- Insert data into DonDatHang
INSERT INTO DonDatHang (soDH, maNCC, ngayDH)
VALUES (1, 1, '2024-04-22'),
       (2, 2, '2024-04-23'),
       (3, 3, '2024-04-24'),
       (4, 4, '2024-04-25'),
       (5, 5, '2024-04-26');

-- Insert data into chiTietDonHang
INSERT INTO chiTietDonHang (maVt, soDH)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);

-- Insert data into NhaCungCap
INSERT INTO NhaCungCap (maNCC, tenNCC, diaChi, soDT)
VALUES (1, 'NhaCungCap1', 'DiaChi1', '1234567890'),
       (2, 'NhaCungCap2', 'DiaChi2', '0987654321'),
       (3, 'NhaCungCap3', 'DiaChi3', '1231231234'),
       (4, 'NhaCungCap4', 'DiaChi4', '4564564567'),
       (5, 'NhaCungCap5', 'DiaChi5', '7897897890');

-- Insert data into PhieuNhap
INSERT INTO PhieuNhap (soPN, ngayNhap)
VALUES (1, '2024-04-22 08:00:00'),
       (2, '2024-04-23 09:00:00'),
       (3, '2024-04-24 10:00:00'),
       (4, '2024-04-25 11:00:00'),
       (5, '2024-04-26 12:00:00');

-- Insert data into PhieuNhapChiTiet
INSERT INTO PhieuNhapChiTiet (soPN, maVt, donGiaNhap, soLuongNhap)
VALUES (1, 1, 1000, 5),
       (1, 2, 1500, 3),
       (2, 3, 2000, 2),
       (3, 4, 1200, 4),
       (4, 5, 1800, 6);

#Hiển thị tất cả vật tự dựa vào phiếu xuất có số lượng lớn hơn 10
SELECT VT.tenVt, PX.ngayXuat, PXCT.soLuongXuat
FROM VatTu VT
         JOIN (PhieuXuat PX JOIN PhieuXuatChiTiet PXCT on PX.soPX = PXCT.soPX)
WHERE PXCT.soLuongXuat > 5;

#Hiển thị tất cả vật tư mua vào ngày 25/04/2024
SELECT VT.tenVt, PN.soPN, PNCT.soLuongNhap, PNCT.donGiaNhap
FROM VatTu VT
         JOIN (PhieuNhap PN JOIN PhieuNhapChiTiet PNCT on PN.soPN = PNCT.soPN)
WHERE DATE(ngayNhap) = '2024-04-25';

#Hiển thị tất cả vật tư được nhập vào với đơn giá lớn hơn 1500
SELECT VT.tenVt, PN.soPN, PNCT.soLuongNhap, PNCT.donGiaNhap
FROM VatTu VT
         JOIN (PhieuNhap PN JOIN PhieuNhapChiTiet PNCT on PN.soPN = PNCT.soPN)
WHERE donGiaNhap > 1500
ORDER BY soPN;

#Hiển thị tất cả vật tư được dựa vào phiếu xuất có số lượng lớn hơn 5
SELECT VT.tenVt, PX.soPX, PXCT.soLuongXuat
FROM VatTu VT
         JOIN (PhieuXuat PX JOIN PhieuXuatChiTiet PXCT on PX.soPX = PXCT.soPX)
WHERE soLuongXuat > 5;

#Hiển thị tất cả nhà cung cấp ở  'DiaChi3', có SoDienThoai bắt đầu với 12
SELECT *
FROM NhaCungCap
WHERE diaChi = 'DiaChi3'
  AND soDT LIKE '12%';

