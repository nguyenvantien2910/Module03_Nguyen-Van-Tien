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

#Insert Data
USE QuanLySinhVien;

#class
INSERT INTO Class
VALUES (1, 'A1', '2008-12-20', 1);
INSERT INTO Class
VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class
VALUES (3, 'B3', current_date, 0);

#Student
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Tien', 'Ha Noi', '0978813113', 1, 1);
INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);

#Subject
INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);

#mark
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);

#Hiển thị số lượng sinh viên theo từng địa chỉ nơi ở.
SELECT S.Address, count(distinct S.StudentId) AS 'Số lượng'
FROM Student S
GROUP BY S.Address;

#Hiển thị các thông tin môn học có điểm thi lớn nhất.
SELECT *, M.Mark
FROM subject S
         JOIN Mark M on S.SubId = M.SubId
WHERE Mark = (SELECT max(Mark) FROM Mark);

#Tính điểm trung bình các môn học của từng học sinh.
SELECT S.*, (SELECT AVG(Mark) FROM Mark WHERE StudentId = S.StudentId) AS `Diem Trung Binh`
FROM Student S;

#Hiển thị những bạn học viên có điểm trung bình các môn học nhỏ hơn bằng 70.
SELECT S.*, (SELECT AVG(Mark) FROM Mark WHERE StudentId = S.StudentId) AS `Diem Trung Binh`
FROM Student S
WHERE 'Diem Trung Binh' <= 70
ORDER BY `Diem Trung Binh` DESC;

#Hiển thị thông tin học viên có điểm trung bình các môn lớn nhất.
SELECT S.*,
       (SELECT AVG(Mark) FROM Mark WHERE StudentId = S.StudentId) AS `Diem Trung Binh`
FROM Student S
HAVING `Diem Trung Binh` = (SELECT MAX(AVGMark)
                            FROM (SELECT AVG(Mark) AS AVGMark
                                  FROM Mark
                                  GROUP BY StudentId) AS MaxAvgMarks);

#Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
SELECT S.*, (SELECT AVG(Mark) FROM Mark WHERE StudentId = S.StudentId) AS `Diem Trung Binh`
FROM Student S
ORDER BY `Diem Trung Binh` DESC;


