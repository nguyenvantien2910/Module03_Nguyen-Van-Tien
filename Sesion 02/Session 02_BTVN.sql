#Tạo database
create database if not exists BTVN01;

#Sử dụng database
use BTVN01;

#Tạo bảng

create table KHACHHANG
(
    MaKH     varchar(4),
    TenKH    varchar(30) not null,
    Diachi   varchar(50),
    NgaySinh date,
    SoDT     varchar(15),

    primary key pk_KH (MaKH)
);

create table NHANVIEN
(
    MaNV       varchar(4),
    HoTen      varchar(30) not null,
    GioiTinh   bit         not null,
    DiaChi     varchar(50) not null,
    NgaySinh   date        not null,
    DienThoai  varchar(15),
    Email      text,
    NoiSinh    varchar(20) not null,
    NgayVaoLam date,
    MaNQL      varchar(4),

    primary key pk_NV (MaNV)
);

create table NHACUNGCAP
(
    MaNCC     varchar(5),
    TenNCC    varchar(50) not null,
    Diachi    varchar(50) not null,
    Dienthoai varchar(15) not null,
    Email     varchar(50) not null,
    Website   varchar(30),

    primary key pk_NCC (MaNCC)
);

create table LOAISP
(
    MaloaiSP  varchar(4),
    TenloaiSP varchar(30)  not null,
    Ghichu    varchar(100) not null,

    primary key pk_loaisp (MaloaiSP)
);

create table SANPHAM
(
    MaSP      varchar(4),
    MaloaiSP  varchar(4)  not null,
    TenSP     varchar(50) not null,
    Donvitinh varchar(10) not null,
    Ghichu    varchar(100),

    primary key pk_sp (MaSP)
);

create table PHIEUNHAP
(
    SoPN     varchar(5),
    MaNV     varchar(4) not null,
    MaNCC    varchar(5) not null,
    Ngaynhap date       not null,
    Ghichu   varchar(100),

    primary key pk_PN (SoPN)
);

create table CTPHIEUNHAP
(
    MaSP    varchar(4),
    SoPN    varchar(5),
    Soluong smallint not null,
    Gianhap decimal  not null,

    primary key pk_ctphieunhap (MaSP, SoPN)
);

create table PHIEUXUAT
(
    SoPX    varchar(5),
    MaNV    varchar(4) not null,
    MaKH    varchar(4) not null,
    NgayBan date       not null,
    GhiChu  text,

    primary key pk_phieuxuat (SoPX)
);

create table CTPHIEUXUAT
(
    SoPX    varchar(5),
    MaSP    varchar(4),
    SoLuong smallint not null,
    Giaban  decimal,

    primary key pk_ctphieunhap (SoPX, MaSP)
);

#Constraint - BT2
ALTER TABLE PHIEUNHAP
    add foreign key (MaNCC) references NHACUNGCAP (MaNCC),
    add foreign key (MaNV) references NHANVIEN (MaNV);

ALTER TABLE CTPHIEUNHAP
    add foreign key (MaSP) references SANPHAM (MaSP),
    add foreign key (SoPN) references PHIEUNHAP (SoPN);

ALTER TABLE SANPHAM
    add foreign key (MaloaiSP) references LOAISP (MaloaiSP);

ALTER TABLE PHIEUXUAT
    add foreign key (MaNV) references NHANVIEN (MaNV),
    add foreign key (MaKH) references KHACHHANG (MaKH);

ALTER TABLE CTPHIEUXUAT
    add foreign key (SoPX) references PHIEUXUAT (SoPX),
    add foreign key (MaSP) references SANPHAM (MaSP);


#BT03
#Nhan vien
INSERT INTO NHANVIEN (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam, MaNQL) VALUE
    ('NV01', 'Nguyen Van Tien', 1, 'Dong Anh, Ha Noi', '1994-04-19', '0987654321', 'abc@abc.com', 'Ha Noi',
     '2022-12-12', 'NV99');
INSERT INTO NHANVIEN (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam) VALUE
    ('NV99', 'Nguyen Trung Hieu', 1, 'Kim Ma, Ha Noi', '1995-04-19', '0987654321', 'abc@abc.com', 'Ha Noi',
     '2022-12-12');
INSERT INTO NHANVIEN (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam) VALUE
    ('NV05', 'Nguyen Van Hung', 1, 'Me Tri, Ha Noi', '1996-04-19', '0987654321', 'abc@abc.com', 'Ha Noi',
     '2022-12-12');

#Khách hàng
INSERT INTO KHACHHANG(MaKH, TenKH, Diachi, NgaySinh, SoDT) VALUE
    ('KH68', 'Le Quang Dao', 'Ha Nam', '2000-12-30', '0987654321');

INSERT INTO KHACHHANG(MaKH, TenKH, Diachi, NgaySinh, SoDT) VALUE
    ('KH10', 'Nguyen Van Liem', 'Hai Phong', '2002-12-30', '0987654321');

#Loại Sp
INSERT INTO LOAISP(MaloaiSP, TenloaiSP, Ghichu) VALUE
    ('L001', 'Áo', 'Đây là ghi chú');
INSERT INTO LOAISP(MaloaiSP, TenloaiSP, Ghichu) VALUE
    ('L002', 'Quần', 'Đây là ghi chú');

#MCC
INSERT INTO NHACUNGCAP(MaNCC, TenNCC, Diachi, Dienthoai, Email) VALUE
    ('NCC1', 'Việt Tiến', 'Ha Noi', '0352288776', 'abc@gmail.com');

INSERT INTO NHACUNGCAP(MaNCC, TenNCC, Diachi, Dienthoai, Email) VALUE
    ('NCC4', 'May 10', 'Ha Noi', '0352288776', 'may10@gmail.com');


#Sản phẩm
INSERT INTO SANPHAM(MaSP, MaloaiSP, TenSP, Donvitinh) VALUE
    ('SP03', 'L001', 'Áo thun', 'VND');

INSERT INTO SANPHAM(MaSP, MaloaiSP, TenSP, Donvitinh) VALUE
    ('SP06', 'L001', 'Áo cộc', 'VND');

INSERT INTO SANPHAM(MaSP, MaloaiSP, TenSP, Donvitinh) VALUE
    ('SP09', 'L001', 'Áo ba lỗ', 'VND');

INSERT INTO SANPHAM(MaSP, MaloaiSP, TenSP, Donvitinh) VALUE
    ('SP08', 'L001', 'Áo dài', 'VND');

INSERT INTO SANPHAM(MaSP, MaloaiSP, TenSP, Donvitinh) VALUE
    ('SP78', 'L002', 'Quần dùi', 'VND');

INSERT INTO SANPHAM(MaSP, MaloaiSP, TenSP, Donvitinh) VALUE
    ('SP45', 'L002', 'Quần bò', 'VND');
INSERT INTO SANPHAM(MaSP, MaloaiSP, TenSP, Donvitinh) VALUE
    ('SP15', 'L002', 'Quần dài', 'VND');

#Phieu xuat + Ct phieu xuat
#1
INSERT INTO PHIEUXUAT (SoPX, MaNV, MaKH, NgayBan, GhiChu) VALUE
    ('X001', 'NV01', 'KH68', now(), 'KH VIP PRO');
INSERT INTO CTPHIEUXUAT (SoPX, MaSP, SoLuong, Giaban) VALUE
    ('X001', 'SP03', 99, 50000);

INSERT INTO CTPHIEUXUAT (SoPX, MaSP, SoLuong, Giaban) VALUE
    ('X001', 'SP06', 66, 20000);

INSERT INTO CTPHIEUXUAT (SoPX, MaSP, SoLuong, Giaban) VALUE
    ('X001', 'SP09', 33, 10000);

#2
INSERT INTO PHIEUXUAT (SoPX, MaNV, MaKH, NgayBan, GhiChu) VALUE
    ('X002', 'NV01', 'KH68', now(), 'KH VIP PRO');

INSERT INTO CTPHIEUXUAT(SoPX, MaSP, SoLuong, Giaban) VALUE
    ('X002', 'SP78', 77, 88888);

INSERT INTO CTPHIEUXUAT(SoPX, MaSP, SoLuong, Giaban) VALUE
    ('X002', 'SP45', 12, 98888);

INSERT INTO CTPHIEUXUAT(SoPX, MaSP, SoLuong, Giaban) VALUE
    ('X002', 'SP08', 88, 58888);

#Phieu nhập + ct phiếu nhập
INSERT INTO PHIEUNHAP (SoPN, MaNV, MaNCC, Ngaynhap, Ghichu) VALUE
    ('N001', 'NV99', 'NCC1', now(), 'Xuat di Mỹ (Tho)');

INSERT INTO CTPHIEUNHAP(MaSP, SoPN, Soluong, Gianhap) VALUE
    ('SP78', 'N001', 40, 10000);

INSERT INTO CTPHIEUNHAP(MaSP, SoPN, Soluong, Gianhap) VALUE
    ('SP06', 'N001', 30, 60000);

INSERT INTO PHIEUNHAP (SoPN, MaNV, MaNCC, Ngaynhap, Ghichu) VALUE
    ('N010', 'NV01', 'NCC4', now(), 'Xuat di Pháp (Vân)');

INSERT INTO CTPHIEUNHAP(MaSP, SoPN, Soluong, Gianhap) VALUE
    ('SP03', 'N010', 40, 90000);

INSERT INTO CTPHIEUNHAP(MaSP, SoPN, Soluong, Gianhap) VALUE
    ('SP08', 'N010', 20, 50000);

#BT 04
#1
UPDATE KHACHHANG
SET SoDT = '0862681368'
WHERE MaKH = 'KH10';
SELECT *
FROM KHACHHANG;

#2
UPDATE NHANVIEN
SET DiaChi = 'Trung Kinh, Ha Noi'
WHERE MaNV = 'NV05';
SELECT *
FROM NHANVIEN;

#BT05
#1
DELETE
FROM NHANVIEN
WHERE MaNV = 'NV05';
SELECT *
FROM NHANVIEN;

#2
SELECT *
FROM SANPHAM;
DELETE
FROM SANPHAM
WHERE MaSP = 'SP15';
SELECT *
FROM SANPHAM;

#Bt06
#1
SELECT *
FROM NHANVIEN
ORDER BY current_time - NgaySinh;

#2
SELECT *
FROM PHIEUNHAP
WHERE Ngaynhap BETWEEN '2018-6-01' AND '2018-06-31';

#3
SELECT *
FROM SANPHAM
WHERE Donvitinh = 'chai';

#4
SELECT *
FROM CTPHIEUNHAP
         JOIN PHIEUNHAP PN on CTPHIEUNHAP.SoPN = PN.SoPN
WHERE EXTRACT(MONTH FROM PN.Ngaynhap) = EXTRACT(MONTH FROM CURRENT_DATE)
  AND EXTRACT(YEAR FROM PN.Ngaynhap) = EXTRACT(YEAR FROM CURRENT_DATE)
ORDER BY PN.SoPN;

#5
SELECT *
FROM NHACUNGCAP
         JOIN PHIEUNHAP PN on NHACUNGCAP.MaNCC = PN.MaNCC
WHERE EXTRACT(MONTH FROM PN.Ngaynhap) = EXTRACT(MONTH FROM CURRENT_DATE)
  AND EXTRACT(YEAR FROM PN.Ngaynhap) = EXTRACT(YEAR FROM CURRENT_DATE)
ORDER BY PN.Ngaynhap;

#6
SELECT *
FROM CTPHIEUXUAT CTPX
         JOIN PHIEUXUAT PX ON PX.SoPX = CTPX.SoPX
WHERE PX.NgayBan >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
ORDER BY PX.NgayBan;

#7
SELECT *
FROM KHACHHANG
WHERE EXTRACT(MONTH FROM NgaySinh) = EXTRACT(MONTH FROM CURRENT_DATE)
  AND EXTRACT(YEAR FROM NgaySinh) = EXTRACT(YEAR FROM CURRENT_DATE)
ORDER BY MaKH;

#8
SELECT *
FROM PHIEUXUAT
WHERE NgayBan BETWEEN '2018-04-15' AND '2018-05-15';

#9
SELECT *
FROM PHIEUXUAT
         JOIN KHACHHANG K on PHIEUXUAT.MaKH = K.MaKH;

#10
SELECT count(SoLuong)
FROM CTPHIEUXUAT
         JOIN PHIEUXUAT P on CTPHIEUXUAT.SoPX = P.SoPX
WHERE MaSP = 'SP001'
  AND DATE_FORMAT(NgayBan, '%c') BETWEEN 1 AND 6;

#11
SELECT *
FROM KHACHHANG
         JOIN PHIEUXUAT P on KHACHHANG.MaKH = P.MaKH
GROUP BY EXTRACT(MONTH FROM P.NgayBan);

#12
SELECT *
FROM PHIEUXUAT
         JOIN CTPHIEUXUAT C on PHIEUXUAT.SoPX = C.SoPX
WHERE NgayBan BETWEEN '2018-05-01' AND '2018-06-31';

#13
SELECT *
FROM CTPHIEUXUAT
         JOIN PHIEUXUAT P on CTPHIEUXUAT.SoPX = P.SoPX
WHERE MaSP = 'SP001'
  AND DATE_FORMAT(NgayBan, '%c') BETWEEN 1 AND 6
GROUP BY EXTRACT(MONTH FROM P.NgayBan);

#14
SELECT EXTRACT(YEAR FROM P.NgayBan)  AS Nam,
       EXTRACT(MONTH FROM P.NgayBan) AS Thang,
       SUM(CTP.SoLuong * CTP.Giaban)
FROM PHIEUXUAT P
         JOIN CTPHIEUXUAT CTP ON P.SoPX = CTP.SoPX
WHERE EXTRACT(MONTH FROM P.NgayBan) BETWEEN 5 AND 6
  AND EXTRACT(YEAR FROM P.NgayBan) = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY EXTRACT(YEAR FROM P.NgayBan), EXTRACT(MONTH FROM P.NgayBan);

#15
SELECT PX.SoPX,
       KH.MaKH,
       KH.TenKH,
       NV.HoTen,
       PX.NgayBan,
       SUM(CTPHIEUXUAT.SoLuong * CTPHIEUXUAT.Giaban) AS Tong
FROM ((PHIEUXUAT PX
    JOIN KHACHHANG KH ON PX.MaKH = KH.MaKH)
    JOIN NHANVIEN NV ON PX.MaNV = NV.MaNV)
         JOIN CTPHIEUXUAT ON PX.SoPX = CTPHIEUXUAT.SoPX
WHERE PX.NgayBan = CURRENT_DATE
GROUP BY PX.SoPX, KH.MaKH, KH.TenKH, NV.HoTen, PX.NgayBan;

#16 Thống kê doanh số bán hàng theo từng nhân viên, gồm thông tin: mã nhân viên, họ tên nhân viên, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số lượng.
SELECT NV.MaNV, NV.HoTen, SP.TenSP, SP.Donvitinh, SUM(C.SoLuong)
FROM NHANVIEN NV
         JOIN (PHIEUXUAT PX
    JOIN CTPHIEUXUAT C ON PX.SoPX = C.SoPX
    JOIN SANPHAM SP ON C.MaSP = SP.MaSP)
              ON NV.MaNV = PX.MaNV
GROUP BY NV.MaNV, NV.HoTen, SP.TenSP, SP.Donvitinh;

#17. Liệt kê các hóa đơn bán hàng cho khách vãng lai (KH01) trong quý 2/2018, thông tin gồm số phiếu xuất, ngày bán, mã sản phẩm, tên sản phẩm, đơn vị tính, số lượng, đơn giá, thành tiền.
SELECT PX.SoPX,
       PX.NgayBan,
       C.MaSP,
       S.TenSP,
       S.Donvitinh,
       SUM(C.SoLuong),
       C.Giaban,
       (C.SoLuong * C.Giaban) AS `Thanh Tien`
FROM KHACHHANG KH
         JOIN (PHIEUXUAT PX
    JOIN CTPHIEUXUAT C ON PX.SoPX = C.SoPX
    JOIN SANPHAM S ON C.MaSP = S.MaSP)
              ON KH.MaKH = PX.MaKH
WHERE MONTH(PX.NgayBan) BETWEEN 4 AND 6
  AND KH.MaKH = 'KH01'
GROUP BY PX.SoPX, PX.NgayBan, C.MaSP, S.TenSP, S.Donvitinh, C.Giaban, C.SoLuong, C.Giaban;

#18 Liệt kê các sản phẩm chưa bán được trong 6 tháng đầu năm 2018, thông tin gồm: mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính.
SELECT SP.MaSP, SP.TenSP, LSP.TenloaiSP, SP.Donvitinh
FROM SANPHAM SP
         RIGHT JOIN (PHIEUXUAT PX JOIN CTPHIEUXUAT C ON PX.SoPX = C.SoPX) ON SP.MaSP = C.MaSP
         JOIN LOAISP LSP ON SP.MaloaiSP = LSP.MaloaiSP
WHERE SP.MaSP NOT IN (SELECT SP.MaSP
                      FROM SANPHAM SP
                               JOIN (PHIEUXUAT PX JOIN CTPHIEUXUAT C ON PX.SoPX = C.SoPX) ON SP.MaSP = C.MaSP);

#19. Liệt kê danh sách nhà cung cấp không giao dịch mua bán với cửa hàng trong quý 2/2018, gồm thông tin: mã nhà cung cấp, tên nhà cung cấp, địa chỉ, số điện thoại.
SELECT NCC.MaNCC, NCC.TenNCC, NCC.Diachi, NCC.Dienthoai
FROM NHACUNGCAP NCC
         RIGHT JOIN PHIEUNHAP P on NCC.MaNCC = P.MaNCC
WHERE NCC.MaNCC NOT IN (SELECT MaNCC
                        FROM PHIEUNHAP PN
                                 JOIN CTPHIEUNHAP C on PN.SoPN = C.SoPN)
  AND DATE_FORMAT(P.Ngaynhap, '%c') BETWEEN 4 AND 6;

#20. Cho biết khách hàng có tổng trị giá đơn hàng lớn nhất trong 6 tháng đầu năm 2018.
SELECT *, (ctp.SoLuong * Giaban) AS Tong
FROM khachhang
         JOIN (phieuxuat px JOIN ctphieuxuat ctp ON px.SoPX = ctp.SoPX) ON khachhang.MaKH = px.MaKH
WHERE DATE_FORMAT(px.NgayBan, '%c') BETWEEN 1 AND 6
  AND (ctp.SoLuong * Giaban) = (SELECT MAX(TongValue)
                                FROM (SELECT SUM(ctp.SoLuong * Giaban) AS TongValue
                                      FROM phieuxuat px
                                               JOIN ctphieuxuat ctp ON px.SoPX = ctp.SoPX
                                      WHERE DATE_FORMAT(px.NgayBan, '%c') BETWEEN 1 AND 6
                                      GROUP BY px.MaKH) AS MaxTongValue);

#21 Cho biết mã khách hàng và số lượng đơn đặt hàng của mỗi khách hàng.
SELECT KH.MaKH, COUNT(PX.SoPX) AS SoLuongDonDatHang
FROM KHACHHANG KH
         JOIN PHIEUXUAT PX ON KH.MaKH = PX.MaKH
GROUP BY KH.MaKH;

#22. Cho biết mã nhân viên, tên nhân viên, tên khách hàng kể cả những nhân viên không đại diện bán hàng.

#23. Cho biết số lượng nhân viên nam, số lượng nhân viên nữ
SELECT NV.GioiTinh, COUNT(NV.GioiTinh) AS 'Số lượng'
FROM NHANVIEN NV
GROUP BY NV.GioiTinh;

#24. Cho biết mã nhân viên, tên nhân viên, số năm làm việc của những nhân viên có thâm niên cao nhất.
SELECT NV.MaNV, NV.HoTen, (YEAR(NOW()) - YEAR(NV.NgayVaoLam)) AS SoNamLamViec
FROM NHANVIEN NV
WHERE (YEAR(NOW()) - YEAR(NV.NgayVaoLam)) = (SELECT MAX(YEAR(NOW()) - YEAR(NgayVaoLam))
                                             FROM NHANVIEN);

#25. Hãy cho biết họ tên của những nhân viên đã đến tuổi về hưu (nam:60 tuổi, nữ: 55 tuổi)
SELECT NV.HoTen
FROM NHANVIEN NV
WHERE (NV.GioiTinh = 1 AND DATEDIFF(NOW(), NV.NgaySinh) >= 60 * 365)
   OR (NV.GioiTinh = 0 AND DATEDIFF(NOW(), NV.NgaySinh) >= 55 * 365);

#26. Hãy cho biết họ tên của nhân viên và năm về hưu của họ.
SELECT NV.HoTen,
       CASE NV.GioiTinh
           WHEN 1 THEN YEAR(NV.NgaySinh) + 60
           ELSE YEAR(NV.NgaySinh) + 55 END AS NamVeHuu
FROM NHANVIEN NV;

#27. Cho biết tiền thưởng tết dương lịch của từng nhân viên. Biết rằng - thâm
# niên <1 năm thưởng 200.000 - 1 năm <= thâm niên < 3 năm thưởng
# 400.000 - 3 năm <= thâm niên < 5 năm thưởng 600.000 - 5 năm <= thâm
# niên < 10 năm thưởng 800.000 - thâm niên >= 10 năm thưởng 1.000.000

SELECT NV.HoTen,
       CASE
           WHEN YEAR(NOW() - NV.NgayVaoLam) < 1 THEN 200.000
           WHEN YEAR(NOW() - NV.NgayVaoLam) <= 1 AND YEAR(NOW() - NV.NgayVaoLam) < 3 THEN 400000
           WHEN YEAR(NOW() - NV.NgayVaoLam) <= 3 AND YEAR(NOW() - NV.NgayVaoLam) < 5 THEN 600000
           WHEN YEAR(NOW() - NV.NgayVaoLam) <= 5 AND YEAR(NOW() - NV.NgayVaoLam) < 10 THEN 800000
           ELSE 1000000 END AS TienThuong
FROM NHANVIEN NV;

#c2
SELECT
    NV.HoTen,
    CASE
        WHEN DATEDIFF(NOW(), NV.NgayVaoLam) < 365 THEN 200000
        WHEN DATEDIFF(NOW(), NV.NgayVaoLam) < 365*3 THEN 400000
        WHEN DATEDIFF(NOW(), NV.NgayVaoLam) < 365*5 THEN 600000
        WHEN DATEDIFF(NOW(), NV.NgayVaoLam) < 365*10 THEN 800000
        ELSE 1000000
        END AS TienThuong
FROM NHANVIEN NV;

#28. Cho biết những sản phẩm thuộc ngành hàng Hóa mỹ phẩm
SELECT SP.TenSP
FROM SANPHAM SP JOIN LOAISP L on SP.MaloaiSP = L.MaloaiSP
WHERE L.TenloaiSP = 'Hóa mỹ phẩm';

#29. Cho biết những sản phẩm thuộc loại Quần áo.
SELECT SP.TenSP
FROM SANPHAM SP JOIN LOAISP L on SP.MaloaiSP = L.MaloaiSP
WHERE L.TenloaiSP = 'Quần áo';

#30. Cho biết số lượng sản phẩm loại Quần áo.
SELECT SP.MaSP,COUNT(SP.MaSP) 'Số lương'
FROM SANPHAM SP JOIN LOAISP L on SP.MaloaiSP = L.MaloaiSP
WHERE L.TenloaiSP = 'Quần áo'
GROUP BY SP.MaSP;

#31. Cho biết số lượng loại sản phẩm ngành hàng Hóa mỹ phẩm.
SELECT SP.MaSP,COUNT(SP.MaSP) 'Số lương'
FROM SANPHAM SP JOIN LOAISP L on SP.MaloaiSP = L.MaloaiSP
WHERE L.TenloaiSP = 'Hàng hóa mỹ phẩm'
GROUP BY SP.MaSP;

#32. Cho biết số lượng sản phẩm theo từng loại sản phẩm.
SELECT SP.MaSP,COUNT(SP.MaSP) 'Số lương'
FROM SANPHAM SP JOIN LOAISP L on SP.MaloaiSP = L.MaloaiSP
GROUP BY SP.MaSP;






