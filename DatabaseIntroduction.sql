CREATE DATABASE [Minions2]
GO

USE [Minions2]
GO

CREATE TABLE [Minions]
(
	  [Id] INT PRIMARY KEY
    , [Name] NVARCHAR(50) NOT NULL
	, [Age] INT NOT NULL
)
GO

CREATE TABLE [Towns]
(
	  [Id] INT PRIMARY KEY
	, [Name] NVARCHAR(50) NOT NULL
)
GO

ALTER TABLE [Minions]
DROP CONSTRAINT PK__Minions__3214EC078C26E4BE
GO

ALTER TABLE [Minions]
ADD CONSTRAINT PK_Minions PRIMARY KEY ([Id]);



INSERT INTO [Minions]([Id],[Name],[Age],[TownId])
	VALUES
	  (1,'Kevin',22,1)
	, (2,'Bob',15,3)
	, (3,'Steward',NULL,2)
GO

INSERT INTO [Towns]([Id],[Name])
	VALUES
	  (1,'Sofia')
	, (2,'Plovdiv')
	, (3,'Varna')
GO

TRUNCATE TABLE [Minons]
GO

DROP TABLE [Towns]
GO

DROP TABLE [Minions]
GO

CREATE TABLE [People]
(
	  [Id] INT PRIMARY KEY IDENTITY
	, [Name] NVARCHAR(200) NOT NULL
	, [Picture] VARBINARY(MAX)
	, CONSTRAINT CHK_Data_MaxSize CHECK (DATALENGTH([Picture]) <= 2000*1024)
	, [Height] DECIMAL(3,2) 
	, [Weight] DECIMAL(5,2)
	, [Gender] CHAR(1) NOT NULL
	, CONSTRAINT CHK_Gender CHECK (UPPER([Gender]) = 'M' OR UPPER([Gender]) = 'F')
	, [Birthdate] DATE NOT NULL
	, [Biography] NVARCHAR(MAX)
)
GO

INSERT INTO [People]([Name],[Picture],[Height],[Weight],[Gender],[Birthdate],[Biography])
	VALUES
	  ('Joey', NULL, 1.80, 82.5, 'm','1993-02-15', 'Love gym')
	, ('Cait', NULL, 1.70, 52.5, 'f','1996-03-15', 'Love gymnastic')
	, ('Suzan', NULL, 1.55, 52.5,'f', '1991-03-25', NULL)
	, ('Frank', NULL, 1.78, 72.5,'m', '1996-08-15', 'Love Math')
	, ('Ted', NULL, 1.10, 52.5, 'm','2004-04-15', 'Love music')

GO

CREATE TABLE [Users]
(
	  [Id] INT PRIMARY KEY IDENTITY
	, [Username] VARCHAR(30) NOT NULL
	, [Password] VARCHAR(26) NOT NULL
	, [ProfilePicture] VARBINARY(MAX)
	, CONSTRAINT CHK_Picutre_Size CHECK(DATALENGTH([ProfilePicture]) < 900*1024)
	, [LastLoginTime] DATETIME2
	, [IsDeleted] BIT NOT NULL
)
GO

INSERT INTO [Users]
	VALUES
	('user1', 'password1', NULL, '2024-05-21 09:00:00', 0),
	('user2', 'password2', NULL, '2024-05-20 15:30:00', 0),
	('user3', 'password3', NULL, '2024-05-19 12:45:00', 1),
	('user4', 'password4', NULL, '2024-05-18 08:20:00', 0),
	('user5', 'password5', NULL, '2024-05-17 17:10:00', 1);
GO

ALTER TABLE [Users]
DROP CONSTRAINT PK__Users__3214EC076FE17A3F 

ALTER TABLE [Users]
ADD CONSTRAINT PK_Users	PRIMARY KEY CLUSTERED ([Id],[Username]) 

ALTER TABLE [Users]
ADD CONSTRAINT CHK_Password_Length CHECK(LEN([Password]) > 5)

ALTER TABLE [Users]
ADD CONSTRAINT DF_LastloginTime DEFAULT GETDATE() FOR [LastLoginTime]

ALTER TABLE [Users]
DROP CONSTRAINT PK_Users

ALTER TABLE [Users]
DROP CONSTRAINT PK_Users

ALTER TABLE [Users]
ADD CONSTRAINT PK_Users PRIMARY KEY ([Id])

ALTER TABLE [Users]
ADD CONSTRAINT CHK_Username_Length CHECK(LEN(Username) >= 3)
GO

CREATE DATABASE [Movies2]
GO

USE [Movies2]
GO

CREATE TABLE [Directors]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[DircetorName] NVARCHAR(50) NOT NULL,
	[Notes] VARCHAR(MAX)
)
GO

INSERT INTO [Directors]([DircetorName],[Notes])
	VALUES
	  ('Vlado', 'Movie notes...'),
	  ('Gosho', NULL),
	  ('Tosho', NULL),
	  ('Kiro', NULL),
	  ('Ivo', NULL)
GO

CREATE TABLE [Genres]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[GenreName] NVARCHAR(50) NOT NULL,
	[Notes] VARCHAR(MAX)
)
GO

INSERT INTO [Genres]([GenreName],[Notes])
	VALUES
	('Movie1', 'Notes1'),
	('Movie2', 'Notes2'),
	('Movie3', 'Notes3'),
	('Movie4', 'Notes4'),
	('Movie5', 'Notes5')


CREATE TABLE [Categories]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryName] NVARCHAR(30) NOT NULL,
	[Notes] NVARCHAR(MAX)
)
GO

INSERT INTO [Categories]([CategoryName],[Notes])
	VALUES
	('Category1', 'CategoryNotes1'),
	('Category2', 'CategoryNotes2'),
	('Category3', 'CategoryNotes3'),
	('Category4', 'CategoryNotes4'),
	('Category5', 'CategoryNotes5')
GO

SELECT * FROM Categories

CREATE TABLE [Movies]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Title] NVARCHAR(30) NOT NULL,
	[DirectorId] INT,
	[CopyrightYear] DATE,
	[Length] DECIMAL(3,2),
	[GenreId] INT,
	[CategoryId] INT,
	[Rating] INT,
	[Notes] NVARCHAR(MAX) 
)
GO

INSERT INTO [Movies]([Title],[DirectorId],[CopyrightYear],[Length],[GenreId],[CategoryId],[Rating],[Notes])
	VALUES
	('Rambo',1 ,'1993-02-15', 1.57, 1, 1, 9,NULL),
	('Terminator',2 ,'1991-02-15', 1.47, 2, 2, 10,NULL),
	('Titanic',3 ,'1983-02-15', 2.07, 3, 3, 3,NULL),
	('The Baby sitter',4 ,'1993-02-15', 1.57, 1, 1, 9,NULL),
	('Fight club',1 ,'1993-02-15', 1.57, 1, 1, 9,NULL)
GO

SELECT * FROM [Movies]

ALTER TABLE [Movies]
ADD CONSTRAINT FK_Movies_Directors FOREIGN KEY ([DirectorId]) REFERENCES [Directors]([Id])

ALTER TABLE [Movies]
ADD CONSTRAINT FK_Movies_Genre FOREIGN KEY ([GenreId]) REFERENCES [Genres]([Id])

ALTER TABLE [Movies]
ADD CONSTRAINT FK_Movie_Category FOREIGN KEY ([CategoryId]) REFERENCES [Categories]([Id])

GO

--Car Rental Database
CREATE DATABASE [CarRental2]

USE [CarRental2]
GO

CREATE TABLE [Categories]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[CategoryName] VARCHAR(30) NOT NULL,
	[DailyRate] DECIMAL (6,2) NOT NULL,
	[WeeklyRate] DECIMAL(7,2) NOT NULL,
	[MonthlyRate] DECIMAL (8,2) NOT NULL,
	[WeekendRate] DECIMAL (7,2) NOT NULL
)
GO

INSERT INTO [Categories]
	VALUES
	('Suv',80.00,600.00,2000.00,140.00),
	('Van',70.00,500.00,1800.00,120.00),
	('Sedan',60.00,400.00,1500.00,100.00)

GO

CREATE TABLE [Cars]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[PlateNumber] VARCHAR(10) NOT NULL,
	[Manufacturer] VARCHAR(20) NOT NULL,
	[Model] VARCHAR(10) NOT NULL,
	[CarYear] DATE NOT NULL,
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories]([Id]),
	[Doors] INT CHECK([Doors] <= 5) NOT NULL,
	[Picture] VARBINARY(MAX) CHECK(DATALENGTH([Picture]) < 5000*1024),
	[Condition] VARCHAR(10),
	[Available] BIT NOT NULL
)
GO

INSERT INTO [Cars]
	VALUES
	('CB5633HA','BMW','X6','2020-03-15',1,5,NULL,'good',0),
	('CB6376HA','Mercedes-Benz','S63AMG','2018-03-15',3,5,NULL,'good',1),
	('CB3353HA','Opel','Vivaro','2016-03-15',2,5,NULL,'good',1)
GO

CREATE TABLE [Employees]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(30) NOT NULL,
	[LastName] NVARCHAR(30) NOT NULL,
	[Title] VARCHAR(15) NOT NULL,
	[Notes] NVARCHAR(MAX)
)
GO

INSERT INTO [Employees] ([FirstName], [LastName], [Title], [Notes])
VALUES
    ('Georgi', 'Ivanov', 'Sales', NULL),
    ('Todor', 'Georgiev', 'Customer', NULL),
    ('Ivan', 'Todorov', 'Mechanic', NULL);
GO

CREATE TABLE [Customers]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[DriverLicenceNumber] VARCHAR(20) NOT NULL,
	[FullName] NVARCHAR(70) NOT NULL,
	[Adress] NVARCHAR(150) NOT NULL,
	[City] NVARCHAR(50) NOT NULL,
	[ZIPCode] NVARCHAR(10) NOT NULL,
	[Notes] NVARCHAR(MAX)
)
GO


INSERT INTO [Customers] ([DriverLicenceNumber], [FullName], [Adress], [City], [ZIPCode], [Notes])
VALUES
    ('D123456789', 'John Doe', '123 Elm Street', 'Springfield', '12345', 'Regular customer'),
    ('D987654321', 'Jane Smith', '456 Oak Avenue', 'Riverdale', '67890', 'Prefers email contact'),
    ('D555666777', 'Alice Johnson', '789 Maple Lane', 'Centerville', '11223', 'VIP member');
GO

CREATE TABLE [RentalOrders]
(
	[Id] INT IDENTITY PRIMARY KEY,
	[EmployeeId] INT FOREIGN KEY REFERENCES [Employees]([Id]) NOT NULL,
	[CustomerId] INT FOREIGN KEY REFERENCES [Customers]([Id]) NOT NULL,
	[CarId] INT FOREIGN KEY REFERENCES [Cars]([Id]) NOT NULL,
	[TankLevel] INT NOT NULL,
	[KilometrageStart] INT NOT NULL,
	[KilometrageEnd] INT NOT NULL,
	[TotalKilometrage] INT NOT NULL,
	[StartDate] DATETIME2 NOT NULL,
	[EndDate] DATETIME2 NOT NULL,
	[TotalDays] INT NOT NULL,
	[RateApplied] INT NOT NULL,
	[TaxRate] INT NOT NULL,
	[OrderStatus] BIT NOT NULL,
	[Notes] NVARCHAR(MAX)
)


INSERT INTO [RentalOrders] ([EmployeeId], [CustomerId], [CarId], [TankLevel], [KilometrageStart], [KilometrageEnd], [TotalKilometrage], [StartDate], [EndDate], [TotalDays], [RateApplied], [TaxRate], [OrderStatus], [Notes])
VALUES
    (1, 1, 1, 100, 10000, 10250, 250, '2024-05-01 09:00:00', '2024-05-05 09:00:00', 4, 50, 5, 1, 'First rental order'),
    (2, 2, 2, 75, 20000, 20200, 200, '2024-05-10 10:00:00', '2024-05-15 10:00:00', 5, 60, 5, 1, 'Second rental order'),
    (3, 3, 3, 50, 30000, 30500, 500, '2024-05-20 11:00:00', '2024-05-25 11:00:00', 5, 55, 5, 1, 'Third rental order');

--Hotel Database
CREATE DATABASE [Hotel]
USE [Hotel];

CREATE TABLE [Employees]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[Title] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

INSERT INTO [Employees]([FirstName],[LastName],[Title])
	VALUES
	('Gerogi', 'Kostov','Developer'),
	('Sanq', 'Lekov','Manager'),
	('Trifon', 'Zarezanov','Sales Department')


CREATE TABLE [Customers]
(
	[AccountNumber] INT PRIMARY KEY IDENTITY,
	[FirstName]	 NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[PhoneNumber] DECIMAL(20) NOT NULL,
	CONSTRAINT CK_PhoneNumber CHECK([PhoneNumber] NOT LIKE '%[^0-9]%'),
	[EmergencyName] NVARCHAR(50),
	[EmergencyNumber] DECIMAL(20) NOT NULL,
	CONSTRAINT CK_EmergencyNumber CHECK([EmergencyNumber] NOT LIKE '%[^0-9]%'),
	[NOTES] NVARCHAR(MAX)
)

INSERT INTO [Customers]([FirstName],[LastName],[PhoneNumber],[EmergencyNumber])
	VALUES
	('Petur', 'Petrov',0988824096, 023495823492),
	('Georgi', 'Georgiev',09823423824096, 023492342392),
	('Simeon', 'Simeonov',023412324096, 075695885694)


CREATE TABLE [RoomStatus]
(
	[RoomStatus] VARCHAR(5) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

INSERT INTO [RoomStatus]([RoomStatus],[Notes])
	VALUES
	('taken', 'the clients are very loud and messy'),
	('free', 'room is cleaned and redy for clients'),
	('free', 'room minibar needs fixing')

CREATE TABLE [RoomTypes]
(
	[RoomType] VARCHAR(30) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

INSERT INTO [RoomTypes]([RoomType],[Notes])
	VALUES
	('Single bedroom','seaside view'),
	('Apartment','Top floor 360 degree view'),
	('Two beds bedroom','parking view charge extra')

CREATE TABLE [BedTypes]
(
	[BedType] VARCHAR(20) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

INSERT INTO [BedTypes]([BedType])
	VALUES
	('Single Bed'),
	('Double bed'),
	('King size bed')

CREATE TABLE[Rooms]
(
	[RoomNumber] TINYINT NOT NULL,
	[RoomType] VARCHAR(30) NOT NULL,
	[BedType] VARCHAR(20) NOT NULL,
	[Rate] DECIMAL NOT NULL,
	[RoomStatus] NVARCHAR(5) NOT NULL,
	[Notes] NVARCHAR(MAX)
)

INSERT INTO [Rooms]([RoomNumber],[RoomType],[BedType],[Rate],[RoomStatus])
	VALUES
	(11,'Single Bedroom', 'Single Bed',45.50,'taken'),
	(22,'Two beds bedroom', 'Double bed',65.50,'taken'),
	(35,'Apartment', 'King size bed',145.50,'free')


CREATE TABLE [Payments]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[EmployeeId] INT,
	[PaymentDate] DATETIME2 NOT NULL,
	[AccountNumber] DECIMAL(34) NOT NULL,
	[FirstDateOccupied] DATETIME2 NOT NULL,
	[LastDateOccupied] DATETIME2 NOT NULL,
	[TotalDays] INT NOT NULL,
	[AmountCharged] DECIMAL NOT NULL,
	[TaxRate] DECIMAL NOT NULL,
	[TaxAmount] DECIMAL NOT NULL,
	[PaymentTotal] DECIMAL NOT NULL,
	[Notes] NVARCHAR(MAX)
)

INSERT INTO [Payments]([EmployeeId],[PaymentDate],[AccountNumber],[FirstDateOccupied],[LastDateOccupied],[TotalDays],[AmountCharged],[TaxRate],[TaxAmount],[PaymentTotal])
	VALUES
	(2345,'2024-03-12', 1253423465435345,'2024-03-1','2024-03-12',11,480,20,120,600),
	(53445,'2024-03-12', 1253423465435345,'2024-03-1','2024-03-12',11,480,20,120,600),
	(5566,'2024-03-12', 1253333333435345,'2024-03-1','2024-03-12',11,480,20,120,600)

CREATE TABLE [Occupancies]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[EmployeeId] INT NOT NULL,
	[DateOccupied] DATETIME2 NOT NULL,
	[AccountNumber] DECIMAL(34) NOT NULL,
	[RoomNumber] TINYINT NOT NULL,
	[RateApplied] DECIMAL NOT NULL,
	[PhoneCharge] DECIMAL,
	[Notes] NVARCHAR(MAX)
)

INSERT INTO [Occupancies]([EmployeeId],[DateOccupied],[AccountNumber],[RoomNumber],[RateApplied],[PhoneCharge])
	VALUES
	(2345,'2024-03-21',2123534534,11,65,NULL),
	(2322,'2024-04-21',212534534534,14,80,20),
	(2345,'2024-03-21',21237657564534,12,100,30)

--Create SoftUni Database

CREATE DATABASE SoftUni2;
USE SoftUni2;

CREATE TABLE [Towns]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(100) NOT NULL
)


CREATE TABLE [Addresses]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Adress] NVARCHAR(100) NOT NULL,
	[Text] NVARCHAR(MAX),
	[TownId] INT
)


CREATE TABLE [Departments]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
)

CREATE TABLE [Employees]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(50) NOT NULL,
	[MiddleName] NVARCHAR(50),
	[LastName] NVARCHAR(50) NOT NULL,
	[JobTitle] NVARCHAR(50) NOT NULL,
	[DepartmentId] INT,
	[HireDate] DATE,
	[Salary] DECIMAL,
	[AddressId] INT

	INSERT INTO [Towns]([Name])
	VALUES
	('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas')

SELECT * FROM Towns;

INSERT INTO [Department]([Name])
	VALUES
		('Engineering'),
		('Sales'),
		('Marketing'),
		('Software Development'),
		('QualityAssurance')

INSERT INTO [Employees]([FirstName],[MiddleName],[LastName],[JobTitle],[DepartmentId],[HireDate],[Salary],[AddressId])
	VALUES
	('Ivan','Ivanov','Ivanov','.NET Developer',4,'2013-02-01',3500.00, NULL),
	('Petar','Petrov','Petrov','Senior Engineer',1,'2004-03-02',4000.00, NULL),
	('Maria','Petrova','Ivanova','Inter',5,'2016-08-28',525.25, NULL),
	('Georgi','Teziev','Ivanov','CEO',2,'2007-12-09',3000.00, NULL),
	('Peter','Pan','Pan','Intern',3,'2016-08-28',599.88, NULL)

-- Basic Select All Fields
SELECT * FROM [Towns];
SELECT * FROM [Departments];
SELECT * FROM [Employees];

--Basic select All Fields and Order Them

SELECT * FROM [Towns]
ORDER BY [Name] ASC;

SELECT * FROM [Departments]
ORDER BY [Name] ASC;

SELECT * FROM [Employees]
ORDER BY [Salary] DESC;

--Basic Select Some Fields

SELECT [Name]
FROM [Towns]
ORDER BY [Name] ASC;

SELECT [Name]
FROM [Departments]
ORDER BY [Name] ASC;


SELECT [FirstName], [LastName], [JobTitle], [Salary]
FROM [Employees]
ORDER BY [Salary] DESC;

GO
--Increase Employees Salary
UPDATE [Employees]
SET [Salary] *= 1.1;

SELECT [Salary]
FROM [Employees];
GO

--Decrease Tax Rate

UPDATE [Payments]
SET [TaxRate] *= 0.97

SELECT [TaxRate]
FROM [Payments];
GO

--Delete All Records
DELETE
[Occupancies];
