CREATE DATABASE IF NOT EXISTS Exam_SQL_TongHop1;
USE Exam_SQL_TongHop1;

CREATE TABLE IF NOT EXISTS Department
(
    Id   int auto_increment not null,
    Name varchar(100)       not null unique,

    PRIMARY KEY (Id),
    CONSTRAINT checkNameLength CHECK ( CHAR_LENGTH(Name) >= 6 )

);

CREATE TABLE IF NOT EXISTS Levels
(
    Id              int auto_increment not null,
    Name            varchar(100)       not null unique,
    BasicSalary     float              not null,
    AllowanceSalary float default 500000,

    PRIMARY KEY (Id),
    CONSTRAINT checkBasicSalary CHECK ( BasicSalary >= 3500000 )
);

CREATE TABLE IF NOT EXISTS Employee
(
    Id           int auto_increment not null,
    Name         varchar(150)       not null,
    Email        varchar(150)       not null unique,
    Phone        varchar(50)        not null unique,
    Address      varchar(255),
    Gender       tinyint            not null,
    BirthDay     date               not null,
    LevelId      int                not null,
    DepartmentID int                not null,

    PRIMARY KEY (Id, LevelId, DepartmentID),
    CONSTRAINT checkEmailFormat CHECK (Email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT checkInputGender CHECK ( Gender IN (0, 1, 2))
);

CREATE TABLE IF NOT EXISTS Timesheets
(
    Id             int auto_increment not null,
    AttendanceDate date               not null default (CURDATE()),
    EmployeeId     int                not null,
    Value          float              not null default 1,

    PRIMARY KEY (Id, EmployeeId),
    CONSTRAINT checkValue CHECK ( Value IN (0, 0.5, 1))
);

CREATE TABLE IF NOT EXISTS Salary
(
    Id          int auto_increment not null,
    EmployeeId  int                not null,
    BonusSalary float default 0,
    Insurrance  float default null,

    PRIMARY KEY (Id, EmployeeId)
);

ALTER TABLE Employee
    ADD CONSTRAINT employee_level_pk foreign key (LevelId) references Levels (Id),
    ADD CONSTRAINT employee_department_pk foreign key (DepartmentID) references Department (Id);

ALTER TABLE Timesheets
    ADD CONSTRAINT timesheets_employee_pk foreign key (EmployeeId) references Employee (Id);

ALTER TABLE Salary
    ADD CONSTRAINT salary_employee_pk foreign key (EmployeeId) references Employee (Id);

DELIMITER &&
CREATE TRIGGER auto_Fill_Insurrence_Salary
    BEFORE INSERT
    ON Salary
    FOR EACH ROW
BEGIN
    DECLARE employeeBasicSalary FLOAT;
    IF NEW.Insurrance IS NULL THEN
        SELECT BasicSalary
        INTO employeeBasicSalary
        FROM Levels L
                 JOIN Employee E on L.Id = E.LevelId
        WHERE E.Id = NEW.EmployeeId;
        SET NEW.Insurrance = 0.1 * employeeBasicSalary;
    END IF;
END &&
DELIMITER ;

#Yêu cầu dữ liệu mẫu ( Sử dụng lệnh SQL để thêm mới ):
#1.	Bảng Department ít nhất là 3 bản ghi dữ liệu phù hợp
INSERT INTO Department(Name) VALUE ('Marketing');
INSERT INTO Department(Name) VALUE ('Accounting');
INSERT INTO Department(Name) VALUE ('Tuyển dụng');
INSERT INTO Department(Name) VALUE ('Vận hành');
INSERT INTO Department(Name) VALUE ('Giáo vụ');

#2.	Bảng Levels ít nhất là 3 bản ghi dữ liệu phù hợp
INSERT INTO Levels(Name, BasicSalary) VALUE ('Fresher', 3500000.0);
INSERT INTO Levels(Name, BasicSalary) VALUE ('Intern', 7000000.0);
INSERT INTO Levels(Name, BasicSalary) VALUE ('Junier', 12000000.0);
INSERT INTO Levels(Name, BasicSalary) VALUE ('Senier', 15000000.0);

#3.	Bảng Employee Ít nhất 15 bản ghi dữ liệu phù hợp
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Nguyen Van Tien',
                                                                                                  'abc@gmail.com',
                                                                                                  '0987654321',
                                                                                                  'Ha Noi', 0,
                                                                                                  '1994-10-29', 4, 3);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Nguyen Van Liem',
                                                                                                  'abcxyz@abc.com',
                                                                                                  '0984754321',
                                                                                                  'Ha Nam', 1,
                                                                                                  '1995-10-29', 1, 2);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Nguyen Van Hung',
                                                                                                  'vanhung@gmail.com',
                                                                                                  '0987354321',
                                                                                                  'Ninh Binh', 2,
                                                                                                  '1996-10-29', 3, 4);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Nguyen Thi Thuy Tien',
                                                                                                  'tien@gmail.com',
                                                                                                  '098754321',
                                                                                                  'Da Nang', 0,
                                                                                                  '1997-10-29', 1, 1);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Hoang Van Dat',
                                                                                                  'dat@gmail.com',
                                                                                                  '0357654321', 'Hue',
                                                                                                  1, '1992-10-29', 2,
                                                                                                  3);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Le Quang Dao',
                                                                                                  'dao@gmail.com',
                                                                                                  '0357654312',
                                                                                                  'Lao Cai', 2,
                                                                                                  '1991-10-29', 3, 2);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Nguyen Huu Hung',
                                                                                                  'huuhung@gmail.com',
                                                                                                  '0987854312',
                                                                                                  'Quang Nam', 0,
                                                                                                  '1990-10-29', 4, 3);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Nguyen Van Tu',
                                                                                                  'tu@gmail.com',
                                                                                                  '0981354321',
                                                                                                  'Thanh Hoa', 1,
                                                                                                  '1990-10-29', 3, 3);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Ho Xuan Hung',
                                                                                                  'hung@gmail.com',
                                                                                                  '0987989321',
                                                                                                  'Vung Tau', 1,
                                                                                                  '1991-10-29', 4, 1);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Nguyen Thi Ngoc Anh',
                                                                                                  'anh@gmail.com',
                                                                                                  '0983454321',
                                                                                                  'Nghe An', 2,
                                                                                                  '1992-10-29', 4, 2);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Le Thu Hoai',
                                                                                                  'hoai@gmail.com',
                                                                                                  '09833564321',
                                                                                                  'Ha Tin', 2,
                                                                                                  '1993-10-29', 3, 4);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Nguyen Van Anh',
                                                                                                  'vananh@gmail.com',
                                                                                                  '098789321', 'Ha Noi',
                                                                                                  0, '1995-10-29', 2,
                                                                                                  3);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Hoang Quynh Anh',
                                                                                                  'quynhanh@gmail.com',
                                                                                                  '09876784321',
                                                                                                  'Ha Nam', 0,
                                                                                                  '1999-10-29', 2, 1);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Nguyan Dang Anh Ton',
                                                                                                  'ton@gmail.com',
                                                                                                  '09876678321',
                                                                                                  'Ha Tay', 0,
                                                                                                  '2000-10-29', 2, 3);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Nguyen Trung Hieu',
                                                                                                  'hieu@gmail.com',
                                                                                                  '09876656721',
                                                                                                  'Hoa Binh', 1,
                                                                                                  '2001-10-29', 4, 2);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Tran Thi Thuy',
                                                                                                  'thuy@gmail.com',
                                                                                                  '09876534541',
                                                                                                  'Bac Ninh', 0,
                                                                                                  '2001-10-29', 4, 1);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Le Thu Trang',
                                                                                                  'tran@gmail.com',
                                                                                                  '09876546789', 'HCM',
                                                                                                  1, '2002-10-29', 4,
                                                                                                  4);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Le Dang Luu',
                                                                                                  'luu@gmail.com',
                                                                                                  '098765498745', 'HCm',
                                                                                                  1, '2004-10-29', 2,
                                                                                                  2);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Nguyen Manh Ha',
                                                                                                  'ha@gmail.com',
                                                                                                  '0987634512',
                                                                                                  'Ha Noi', 0,
                                                                                                  '1999-10-29', 3, 3);
INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID) VALUE ('Tran Thuy Hang',
                                                                                                  'hang@gmail.com',
                                                                                                  '03367867875',
                                                                                                  'Quang Nam', 2,
                                                                                                  '1998-10-29', 4, 4);

#5.	Bảng Salary ít nhất 3 bản ghi dữ liệu phù hợp
INSERT INTO Salary(employeeid) VALUE (9);
INSERT INTO Salary(employeeid) VALUE (2);
INSERT INTO Salary(employeeid) VALUE (3);
INSERT INTO Salary(employeeid) VALUE (5);
INSERT INTO Salary(employeeid) VALUE (7);
INSERT INTO Salary(employeeid) VALUE (16);
INSERT INTO Salary(employeeid) VALUE (14);
INSERT INTO Salary(employeeid) VALUE (19);
INSERT INTO Salary(employeeid) VALUE (6);

#4.	Bảng Timesheets ít nhất 30 bản ghi dữ liệu phù hợp
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-19', 6, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2021-02-20', 7, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2022-03-29', 8, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-04-19', 9, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-12-23', 10, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-12', 1, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-23', 2, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-02', 3, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-08', 4, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-06', 5, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-04', 6, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-03', 7, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-03', 8, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-02', 13, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-10', 16, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-12', 2, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-13', 5, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-14', 9, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-15', 10, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-16', 11, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-17', 12, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-18', 13, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-30', 9, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-26', 8, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-23', 7, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-11', 5, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-11', 4, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-12', 3, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-14', 2, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-16', 1, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-17', 4, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-18', 3, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-21', 9, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-22', 16, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-23', 14, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-24', 12, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-25', 11, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-08', 10, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-09', 8, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-06', 6, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-04', 5, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-01-05', 4, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-03-03', 3, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-02-02', 2, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-03-01', 1, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-03-19', 3, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-03-23', 5, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-03-15', 2, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-03-30', 6, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-12-26', 8, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-12-25', 9, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-24', 10, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-19', 4, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-01-21', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-02-11', 3, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-02-22', 2, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-21', 1, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-03-20', 7, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-09-15', 8, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-16', 9, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-05-12', 3, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-04-12', 4, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-11', 14, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2024-03-19', 13, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-09-19', 12, 0);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-19', 11, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2022-11-19', 8, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2022-12-19', 6, 0.5);

INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-01', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-02', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-03', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-04', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-05', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-06', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-07', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-08', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-09', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-10', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-11', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-12', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-13', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-14', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-15', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-16', 6, 0.5);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-17', 6, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-18', 6, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-19', 6, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-20', 6, 1);
INSERT INTO Timesheets(AttendanceDate, EmployeeId, Value) VALUE ('2023-10-21', 6, 1);

UPDATE Timesheets
SET Value = 1
WHERE EmployeeId = 6;

SELECT *
FROM salary;
#Yêu cầu 1 ( Sử dụng lệnh SQL để truy vấn cơ bản ):
#1.	Lấy ra danh sách Employee có sắp xếp tăng dần theo Name gồm các cột sau: Id, Name, Email, Phone, Address, Gender, BirthDay, Age, DepartmentName, LevelName
SELECT E.Id,
       E.Name,
       E.Email,
       E.Phone,
       E.Address,
       E.Gender,
       E.BirthDay,
       (YEAR(NOW()) - YEAR(E.BirthDay)) AS 'Age',
       D.Name,
       L.Name
FROM (Employee E JOIN Department D on E.DepartmentID = D.Id)
         JOIN Levels L ON E.LevelId = L.Id;

#2.	Lấy ra danh sách Salary gồm: Id, EmployeeName, Phone, Email, BaseSalary,  BasicSalary, AllowanceSalary, BonusSalary, Insurrance, TotalSalary
SELECT E.Id,
       E.Name,
       E.Phone,
       E.Address,
       E.Email,
       L.BasicSalary,
       L.AllowanceSalary,
       S.BonusSalary,
       S.Insurrance,
       (L.BasicSalary + L.AllowanceSalary + S.BonusSalary - S.Insurrance) AS 'TotalSalary'
FROM (Employee E JOIN Levels L ON E.LevelId = L.Id)
         JOIN salary S ON E.Id = S.EmployeeId;

#3.	Truy vấn danh sách Department gồm: Id, Name, TotalEmployee
SELECT D.Id, D.Name, count(E.Id) AS 'TotalEmployee'
FROM Department D
         JOIN Employee E ON D.Id = E.DepartmentID
GROUP BY D.Id, D.Name
ORDER BY D.Id;

#4.	Cập nhật cột BonusSalary lên 10% cho tất cả các Nhân viên có số ngày công >= 20 ngày trong tháng 10 năm 2020
SELECT *
FROM salary
WHERE EmployeeId = 6;

UPDATE Salary
SET BonusSalary = 10
WHERE EmployeeId IN (SELECT EmployeeId
                     FROM (SELECT EmployeeId, SUM(Value) AS TotalDaysWorked
                           FROM Timesheets
                           WHERE YEAR(AttendanceDate) = 2023
                             AND MONTH(AttendanceDate) = 10
                             AND DATE(AttendanceDate) BETWEEN 1 AND 31
                           GROUP BY EmployeeId
                           HAVING TotalDaysWorked >= 20) AS EmployeesWithAtLeast20Days);

SELECT *
FROM salary
WHERE EmployeeId = 6;

#5.	Truy vấn xóa Phòng ban chưa có nhân viên nào
DELETE
FROM department
WHERE Id IN (SELECT Id
             FROM (SELECT D.Id
                   FROM Department D
                            LEFT JOIN Employee E ON D.Id = E.DepartmentID
                   WHERE E.DepartmentID IS NULL) AS DepartmentsWithoutEmployees);


#Yêu cầu 2 ( Sử dụng lệnh SQL tạo View )
#1.	View v_getEmployeeInfo thực hiện lấy ra danh sách Employee  gồm: Id, Name, Email, Phone, Address, Gender, BirthDay, DepartmentName, LevelName, Trong đó cột Gender hiển thị như sau:
#a.	0 là nữ
#b.	1 là nam
CREATE VIEW v_getEmployeeInfo AS
SELECT E.Id,
       E.Name  AS EmployeeName,
       E.Email,
       E.Phone,
       E.Address,
       CASE
           WHEN E.Gender = 0 THEN 'Nữ'
           WHEN E.Gender = 1 THEN 'Nam'
           WHEN E.Gender = 2 THEN 'Khac'
           END AS Gender,
       E.BirthDay,
       D.Name  AS DepartmentName,
       L.Name  AS LevelName
FROM (Employee E
    JOIN Levels L on E.LevelId = L.Id)
         JOIN department D ON E.DepartmentID = D.Id
ORDER BY E.Id;

SELECT *
FROM v_getEmployeeInfo;

#2.	View v_getEmployeeSalaryMax hiển thị danh sách nhân viên có số ngày công trong một tháng bất kỳ > 18 gòm: Id, Name, Email, Phone, Birthday, TotalDay (TotalDay là tổng số ngày công trong tháng đó)
CREATE VIEW v_getEmployeeTotalDayInOctober2023 AS
SELECT E.Id, E.Name, E.Email, E.Phone, E.BirthDay, COUNT(T.EmployeeId) AS TotalDay
FROM Employee E
         JOIN Timesheets T ON E.Id = T.EmployeeId
WHERE YEAR(T.AttendanceDate) = 2023
  AND MONTH(T.AttendanceDate) = 10
GROUP BY E.Id, E.Name, E.Email, E.Phone, E.BirthDay
ORDER BY E.Id, E.Name;

SELECT *
FROM v_getEmployeeTotalDayInOctober2023;


#Yêu cầu 3 ( Sử dụng lệnh SQL tạo thủ tục Stored Procedure )
#1.	Thủ tục addEmployeetInfo thực hiện thêm mới nhân viên, khi gọi thủ tục truyền đầy đủ các giá trị của bảng Employee ( Trừ cột tự động tăng )
DELIMITER $$
CREATE PROCEDURE addEmployeetInfo(Name_IN varchar(150), Email_IN varchar(150), Phone_IN varchar(50),
                                  Address_IN varchar(255), Gender_IN tinyint, BirthDay_IN date, LevelId_IN int,
                                  DepartmentId_IN int)
BEGIN
    INSERT INTO Employee(Name, Email, Phone, Address, Gender, BirthDay, LevelId, DepartmentID)
        VALUE (Name_IN, Email_IN, Phone_IN, Address_IN, Gender_IN, BirthDay_IN, LevelId_IN, DepartmentId_IN);
END $$
DELIMITER ;

CALL addEmployeetInfo('Trinh Tuan Binh', 'binh@abc.com', '0123456789', 'Ha Noi', '2', '1999-10-10', 2, 4);

SELECT *
FROM Employee
WHERE Name = 'Trinh Tuan Binh';

#2.	Thủ tục getSalaryByEmployeeId hiển thị danh sách các bảng lương từng nhân viên theo id của nhân viên gồm: Id, EmployeeName, Phone, Email, BaseSalary,  BasicSalary, AllowanceSalary, BonusSalary, Insurrance, TotalDay, TotalSalary (trong đó TotalDay là tổng số ngày công, TotalSalary là tổng số lương thực lãnh)
#Khi gọi thủ tục truyền vào id của nhân viên

DELIMITER $$
CREATE PROCEDURE getSalaryByEmployeeId(IN EmployeeID_IN int)
BEGIN
    SELECT E.Id,
           E.Name,
           E.Phone,
           E.Email,
           L.BasicSalary,
           L.AllowanceSalary,
           S.BonusSalary,
           S.Insurrance,
           (L.BasicSalary + L.AllowanceSalary + S.BonusSalary - S.Insurrance) AS 'TotalSalary',
           TotalDay
    FROM (Employee E JOIN Levels L ON E.LevelId = L.Id)
             JOIN Salary S
                  ON E.Id = S.EmployeeId
             JOIN (SELECT EmployeeId, COUNT(EmployeeId) AS TotalDay
                   FROM Timesheets
                   WHERE YEAR(AttendanceDate) = YEAR(now())
                   GROUP BY EmployeeId) AS T ON E.Id = T.EmployeeId

    WHERE E.Id = EmployeeID_IN;
END $$
DELIMITER ;

CALL getSalaryByEmployeeId(16);


#3.	Thủ tục getEmployeePaginate lấy ra danh sách nhân viên có phân trang gồm: Id, Name, Email, Phone, Address, Gender, BirthDay, Khi gọi thủ tuc truyền vào limit và page
DELIMITER $$
CREATE PROCEDURE getEmployeePaginate(limit_val int, page_val int)
BEGIN
    DECLARE offset_val int default 0;
    SET offset_val = (page_val - 1) * limit_val;

    SELECT Id,
           Name,
           Email,
           Phone,
           Address,
           CASE
               WHEN Gender = 0 THEN 'Nữ'
               WHEN Gender = 1 THEN 'Nam'
               WHEN Gender = 2 THEN 'Khac'
               END AS Gender,
           BirthDay
    FROM Employee
    LIMIT limit_val OFFSET offset_val;
END$$
DELIMITER ;

CALL getEmployeePaginate(10, 3);

#Yêu cầu 4 ( Sử dụng lệnh SQL tạo Trigger )
#1.	Tạo trigger tr_Check_ Insurrance_value sao cho khi thêm hoặc sửa trên bảng Salary nếu cột Insurrance có giá trị != 10% của BasicSalary
# thì không cho thêm mới hoặc chỉnh sửa và in thông báo ‘Giá trị cảu Insurrance phải = 10% của BasicSalary
DELIMITER $$
CREATE TRIGGER tr_Check_Insurrance_value
    BEFORE INSERT
    ON Salary
    FOR EACH ROW

BEGIN
    DECLARE employeeBasicSalay float;
    IF NEW.Insurrance IS NOT NULL THEN
        SELECT L.BasicSalary
        INTO employeeBasicSalay
        FROM Levels L
                 JOIN Employee E ON E.LevelId = L.Id
        WHERE E.Id = NEW.EmployeeId;

        IF NEW.Insurrance != (0.1 * employeeBasicSalay) THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Giá trị cảu Insurrance phải = 10% của BasicSalary';
        END IF;
    END IF;
END $$
DELIMITER ;