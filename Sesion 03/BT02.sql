Create Database QuanLyDiem;
use QuanLyDiem;


/*=============DANH MUC KHOA==============*/
Create table DMKhoa
(
    MaKhoa  char(2) primary key,
    TenKhoa nvarchar(30) not null
);


/*==============DANH MUC SINH VIEN============*/
Create table DMSV
(
    MaSV     char(3)      not null primary key,
    HoSV     nvarchar(15) not null,
    TenSV    nvarchar(7)  not null,
    Phai     nchar(7),
    NgaySinh datetime     not null,
    NoiSinh  nvarchar(20),
    MaKhoa   char(2),
    HocBong  float
);


/*=================MON HOC====================*/
create table DMMH
(
    MaMH   char(2)      not null,
    TenMH  nvarchar(25) not null,
    SoTiet tinyint,
    Constraint DMMH_MaMH_pk primary key (MaMH)
);


/*===================KET QUA=================*/
Create table KetQua
(
    MaSV   char(3) not null,
    MaMH   char(2) not null,
    LanThi tinyint,
    Diem   decimal(4, 2),
    Constraint KetQua_MaSV_MaMH_LanThi_pk primary key (MaSV, MaMH, LanThi)
);
/*==============TAO KHOA NGOAI================*/
Alter table dmsv
    add Constraint DMKhoa_MaKhoa_fk foreign key (MaKhoa)
        References DMKhoa (MaKhoa);
Alter table KetQua
    add constraint KetQua_MaSV_fk foreign key (MaSV) references DMSV (MaSV);
Alter table KetQua
    add constraint DMMH_MaMH_fk foreign key (MaMH) references DMMH (MaMH);


/*===========NHAP DU LIEU BANG DMMH===========*/
Insert into DMMH(MaMH, TenMH, SoTiet)
values ('01', 'Cơ Sở Dữ Liệu', 45);
Insert into DMMH(MaMH, TenMH, SoTiet)
values ('02', 'Trí Tuệ Nhân Tạo', 45);
Insert into DMMH(MaMH, TenMH, SoTiet)
values ('03', 'Truyền Tin', 45);
Insert into DMMH(MaMH, TenMH, SoTiet)
values ('04', 'Đồ Họa', 60);
Insert into DMMH(MaMH, TenMH, SoTiet)
values ('05', 'Văn Phạm', 60);


/*==========NHAP DU LIEU BANG DMKHOA=========*/
Insert into DMKhoa(MaKhoa, TenKhoa)
values ('AV', 'Anh Văn');
Insert into DMKhoa(MaKhoa, TenKhoa)
values ('TH', 'Tin Học');
Insert into DMKhoa(MaKhoa, TenKhoa)
values ('TR', 'Triết');
Insert into DMKhoa(MaKhoa, TenKhoa)
values ('VL', 'Vật Lý');
/*===========NHAP DU LIEU BANG DMSV===========*/
Insert into DMSV
values ('A01', 'Nguyễn Thị', 'Hải', 'Nữ', '1990-03-20', 'Hà Nội', 'TH', 130000);
Insert into DMSV(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
values ('A02', 'Trần Văn', 'Chính', 'Nam', '1992-12-24', 'Bình Định', 'VL', 150000);
Insert into DMSV(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
values ('A03', 'Lê Thu Bạch', 'Yến', 'Nữ', '1990-02-21', 'TP Hồ Chí Minh', 'TH', 170000);
Insert into DMSV(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
values ('A04', 'Trần Anh', 'Tuấn', 'Nam', '1990-12-20', 'Hà Nội', 'AV', 80000);
Insert into DMSV(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
values ('B01', 'Trần Thanh', 'Mai', 'Nữ', '1991-08-12', 'Hải Phòng', 'TR', 0);
Insert into DMSV(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
values ('B02', 'Trần Thị Thu', 'Thủy', 'Nữ', '1991-01-02', 'TP Hồ Chí Minh', 'AV', 0);
/*===========NHAP DU LIEU BANG KET QUA===========*/
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A01', '01', 1, 3);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A01', '01', 2, 6);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A01', '02', 2, 6);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A01', '03', 1, 5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A02', '01', 1, 4.5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A02', '01', 2, 7);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A02', '03', 1, 10);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A02', '05', 1, 9);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A03', '01', 1, 2);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A03', '01', 2, 5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A03', '03', 1, 2.5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A03', '03', 2, 4);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('A04', '05', 2, 10);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('B01', '01', 1, 7);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('B01', '03', 1, 2.5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('B01', '03', 2, 5);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('B02', '02', 1, 6);
Insert into KetQua(MaSV, MaMH, LanThi, Diem)
values ('B02', '04', 1, 10);

#Danh sách các sinh viên gồm thông tin sau: Mã sinh viên, họ tên sinh viên,Phái, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự Nam/Nữ.
SELECT MaSV, HoSV, TenSV, Phai, NgaySinh
FROM DMSV
ORDER BY CASE WHEN Phai = 'Nam' THEN 1 ELSE 2 END, HoSV, TenSV;

#Thông tin các sinh viên gồm : Họ tên sinh viên, Ngày sinh, Học bổng. Thông tin sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần.
SELECT HoSV, TenSV, NgaySinh, HocBong
FROM DMSV
ORDER BY NgaySinh ASC, HocBong DESC;

#Liệt kê danh sách những sinh viên có chữ cái cuối cùng trong tên là I, gồm các thông tin: Họ tên sinh viên, Ngày sinh, Phái.
SELECT HoSV, TenSV, NgaySinh, Phai
FROM DMSV
WHERE TenSV LIKE '%i';

#Liệt kê những sinh viên mà họ có chứa chữ Thị
SELECT HoSV, TenSV, NgaySinh, Phai
FROM DMSV
WHERE DMSV.HoSV LIKE '%Thị%';

#Cho biết những sinh viên có tuổi lớn hơn 20, thông tin gồm: Họ tên sinh viên, Tuổi,Học bổng.
SELECT HoSV, TenSV, HocBong, (YEAR(now()) - YEAR(DMSV.NgaySinh)) AS 'Tuổi'
FROM DMSV
WHERE (YEAR(now()) - YEAR(DMSV.NgaySinh)) > 20;

#Cho biết tổng sinh viên và tổng sinh viên nữ.
SELECT count(MaSV) 'Tổng sinh viên', count(Phai = 'Nữ') AS 'Số SV nữ'
FROM DMSV;

#Cho biết tổng số sinh viên của từng khoa.
SELECT MaKhoa, COUNT(MaSV) AS TotalStudents
FROM DMSV
GROUP BY MaKhoa;

#Cho biết số lượng sinh viên theo từng độ tuổi.
SELECT (YEAR(NOW()) - YEAR(NgaySinh)) AS 'Độ tuổi', COUNT(MaSV) AS TotalStudents
FROM DMSV
GROUP BY (YEAR(NOW()) - YEAR(NgaySinh));

#Cho biết học bổng cao nhất của mỗi khoa.
SELECT MaKhoa, MAX(HocBong) AS 'Học Bổng cao nhất'
FROM DMSV
GROUP BY MaKhoa;


