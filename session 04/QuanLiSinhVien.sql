-- Bước 1: Tạo CSDL QuanLySinhVien
CREATE DATABASE QuanLySinhVien;
-- Bước 2: Chọn Database QuanLySinhVien để thao tác với cơ sở dữ liệu này:
USE QuanLySinhVien;
-- Bước 3: Tiếp theo sử dụng câu lệnh Create Table để tạo bảng Class với các trường ClassId, ClassName, StartDate, Status như sau:
CREATE TABLE Class
(
    ClassID   INT AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);
-- Bước 4: Tạo bảng Student với các thuộc tính StudentId, StudentName, Address, Phone, Status, ClassId với rằng buộc như sau:
CREATE TABLE Student
(
    StudentId   INT AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);
-- Bước 5: Tạo bảng Subject với các thuộc tính SubId, SubName, Credit, Status với các ràng buộc như sau :
CREATE TABLE Subject
(
    SubId   INT AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);
-- Bước 6: Tạo bảng Mark với các thuộc tính MarkId, SubId, StudentId, Mark, ExamTimes với các ràng buộc như sau :
CREATE TABLE Mark
(
    MarkId    INT AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

#insert data
#Bảng class
INSERT INTO Class (ClassID, ClassName, StartDate, Status) VALUE (1, 'A1', '2018-07-16 12:56:37', 1);
INSERT INTO Class (ClassID, ClassName, StartDate, Status) VALUE (2, 'A2', '2019-07-16 12:56:37', 1);
INSERT INTO Class (ClassID, ClassName, StartDate, Status) VALUE (3, 'A3', '2017-07-16 12:56:37', 0);
INSERT INTO Class (ClassID, ClassName, StartDate, Status) VALUE (4, 'A4', '2016-07-16 12:56:37', 1);
INSERT INTO Class (ClassID, ClassName, StartDate, Status) VALUE (5, 'A5', '2015-07-16 12:56:37', 0);

#Bảng student
INSERT INTO Student (StudentId, StudentName, Address, Phone, Status, ClassId) VALUE (1, 'Nguyen Van Liem', 'Ha Noi', '0987654321', 1, 3);
INSERT INTO Student (StudentId, StudentName, Address, Phone, Status, ClassId) VALUE (2, 'Lee Qwang Dao', 'Ha Nam', '0987666321', 1, 3);
INSERT INTO Student (StudentId, StudentName, Address, Phone, Status, ClassId) VALUE (5, 'Nguyen Van Hung', 'Ha Noi', '06877654321', 1, 3);
INSERT INTO Student (StudentId, StudentName, Address, Phone, Status, ClassId) VALUE (7, 'Nguyen Truong Giang', 'Hung Yen', '03587654321', 1, 3);
INSERT INTO Student (StudentId, StudentName, Address, Phone, Status, ClassId) VALUE (4, 'Nguyen Viet Dat', 'Bac Ninh', '09834654321', 1, 3);
INSERT INTO Student (StudentId, StudentName, Address, Phone, Status, ClassId) VALUE (9, 'Nguyen Van Ánh', 'Ha Nam', '0467654321', 1, 3);

#bảng subject
INSERT INTO Subject (SubId, SubName, Credit, Status) VALUE (1, 'Toán', 1, 1);
INSERT INTO Subject (SubId, SubName, Credit, Status) VALUE (3, 'Lý', 99, 1);
INSERT INTO Subject (SubId, SubName, Credit, Status) VALUE (6, 'Hóa', 5, 0);
INSERT INTO Subject (SubId, SubName, Credit, Status) VALUE (8, 'Văn', 7, 1);
INSERT INTO Subject (SubId, SubName, Credit, Status) VALUE (4, 'Sử', 89, 0);

#bảng mark
INSERT INTO Mark (MarkId, SubId, StudentId, Mark, ExamTimes) VALUE (1, 3, 7, 99.0, 1);
INSERT INTO Mark (MarkId, SubId, StudentId, Mark, ExamTimes) VALUE (5, 4, 5, 98.0, 1);
INSERT INTO Mark (MarkId, SubId, StudentId, Mark, ExamTimes) VALUE (6, 1, 4, 77.0, 1);
INSERT INTO Mark (MarkId, SubId, StudentId, Mark, ExamTimes) VALUE (2, 6, 9, 66.0, 1);
INSERT INTO Mark (MarkId, SubId, StudentId, Mark, ExamTimes) VALUE (7, 8, 2, 67.0, 1);
INSERT INTO Mark (MarkId, SubId, StudentId, Mark, ExamTimes) VALUE (3, 6, 1, 65.0, 1);

#Update data
UPDATE subject
SET Credit = 99
WHERE SubId = 6;

#	Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất
SELECT max(S.Credit)
FROM Subject S;

#	Hiển thị các thông tin môn học có điểm thi lớn nhất.
SELECT S.SubId,S.SubName,S.Credit,M.Mark
    FROM Mark M join Subject S ON M.SubId = S.SubId
WHERE M.Mark = (SELECT max(Mark) FROM Mark);

#	Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
SELECT S.*, (SELECT AVG(Mark) FROM Mark WHERE StudentId = S.StudentId) AS `Diem Trung Binh`
FROM Student S
ORDER BY `Diem Trung Binh` DESC;



