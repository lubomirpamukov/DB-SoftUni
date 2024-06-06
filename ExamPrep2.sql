﻿
-- 1. Create database structure

CREATE DATABASE TouristAgency
USE TouristAgency
GO

CREATE TABLE [Countries]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Destinations]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	[CountryId] INT REFERENCES [Countries]([Id]) NOT NULL
)

CREATE TABLE [Rooms]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Type] VARCHAR(40) NOT NULL,
	[Price] DECIMAL(18,2) NOT NULL,
	[BedCount] INT,
	CONSTRAINT CHK_BedCount CHECK([BedCount] > 0 AND [BedCount] <= 10)
)

CREATE TABLE [Hotels]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	[DestinationId] INT REFERENCES [Destinations]([Id]) NOT NULL,
)

CREATE TABLE [Tourists]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(80) NULL,
	[PhoneNumber] VARCHAR(20) NOT NULL,
	[Email] VARCHAR(80) NOT NULL,
	[CountryId] INT REFERENCES [Countries]([Id])
)

CREATE TABLE [Bookings]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[ArrivalDate] DATETIME2 NOT NULL,
	[Departuredate] DATETIME2 NOT NULL,
	[AdultsCount] INT NOT NULL,
	CONSTRAINT CHK_AdultCount CHECK([AdultsCount] > 0 AND [AdultsCount] <= 10),
	[ChildrenCount] INT NOT NULL,
	CONSTRAINT CHK_ChilderCount CHECK([ChildrenCount] >= 0 AND [ChildrenCount] <= 9),
	[TouristId] INT REFERENCES [Tourists]([Id]) NOT NULL,
	[HotelId] INT REFERENCES [Hotels]([Id]) NOT NULL,
	[RoomId] INT REFERENCES [Rooms]([Id]) NOT NULL
)

CREATE TABLE [HotelsRooms]
(
	[HotelId] INT REFERENCES [Hotels]([Id]),
	[RoomId] INT REFERENCES [Rooms]([Id]),
	PRIMARY KEY ([HotelId],[RoomId])
)


-- Insert data

---Table: Countries
SET IDENTITY_INSERT Countries ON
INSERT INTO Countries (Id, [Name]) VALUES
(1, 'Italy'),
(2, 'France'),
(3, 'Spain'),
(4, 'Germany'),
(5, 'Greece'),
(6, 'United Kingdom'),
(7, 'Austria'),
(8, 'Portugal'),
(9, 'Turkey'),
(10, 'Croatia')
SET IDENTITY_INSERT Countries OFF

---Table: Destinations
SET IDENTITY_INSERT Destinations ON
INSERT INTO Destinations (Id, [Name], CountryId) VALUES
(1, 'Lake Como', 1),
(2, 'Venice', 1),
(3, 'Paris', 2),
(4, 'Nice', 2),
(5, 'Barcelona', 3),
(6, 'Seville', 3),
(7, 'Bavaria', 4),
(8, 'Mecklenburg-Vorpommern', 4),
(9, 'Santorini', 5),
(10, 'Mykonos', 5),
(11, 'London', 6),
(12, 'Scotland', 6),
(13, 'Vienna', 7),
(14, 'Salzburg', 7),
(15, 'Madeira', 8),
(16, 'Lisbon', 8),
(17, 'Istanbul', 9),
(18, 'Cappadocia', 9),
(19, 'Dubrovnik', 10),
(20, 'Split', 10)
SET IDENTITY_INSERT Destinations OFF

---Table: Hotels
SET IDENTITY_INSERT Hotels ON
INSERT INTO Hotels (Id, [Name], DestinationId) VALUES
(1, 'Albergo Firenze',1),
(2, 'Rossovino Como',1),
(3, 'Antica Panada',2),
(4, 'Bonvecchiati',2),
(5, 'Saint Ouen Marche Aux Puces',3),
(6, 'Porte de Chatillon',3),
(7, 'Royal Promenade des Anglais',4),
(8, 'Byakko Nice',4),
(9, 'Acta Voraport',5),
(10, 'Catalonia Atenas',5),
(11, 'Silken Al-Andalaus Palace',6),
(12, 'Exe Sevilla Macarena',6),
(13, 'Das Regensburg',7),
(14, 'Liebesbier Urban Art & Smart Hotel',7),
(15, 'Anklamer Hof',8),
(16, 'Schloss Rattey',8),
(17, 'Nautilus Dome',9),
(18, 'Divino Kaldera',9),
(19, 'Cavo Tagoo',10),
(20, 'Kivotos',10),
(21, 'Zedwell Piccadilly Circus',11),
(22, 'Marlin Waterloo',11),
(23, 'Ocean Mist Leith',12),
(24, 'Ness Walk',12),
(25, 'Ruby Marie Vienna',13),
(26, 'Josefshof am Rathaus',13),
(27, 'Alstadt Hofwirt Salzburg',14),
(28, 'Leonardo Boutique Salzburg Gab',14),
(29, 'Aqua Natura Madeira',15),
(30, 'Quinta Do Furao',15),
(31, 'Tizoli Oriente Lisboa',16),
(32, 'Epic Sana Marques',16),
(33, 'Uranus Istanbul Topkapi',17),
(34, 'ISG Sabiha Gokcen',17),
(35, 'Goreme Reva',18),
(36, 'Guzide Cave',18),
(37, 'Rixos Premuim Dubrovnik',19),
(38, 'Lero',19),
(39, 'Dioklecijan Residence',20),
(40, 'Agava Split',20)
SET IDENTITY_INSERT Hotels OFF

---Table: Rooms
SET IDENTITY_INSERT Rooms ON
INSERT INTO Rooms (Id, [Type], Price, BedCount) VALUES
(1, 'Single Room', 110.50, 1),
(2, 'Double Room', 132.50, 2),
(3, 'Triple Room', 150.75, 3),
(4, 'Studio', 180.25, 4),
(5, 'One Bedroom Apartment', 205.50, 3),
(6, 'Two Bedroom Apartment', 280.50, 6),
(7, 'Studio Deluxe', 250.00, 3),
(8, 'VIP Apartment', 600.00, 4)
SET IDENTITY_INSERT Rooms OFF

---Table: Tourists
SET IDENTITY_INSERT Tourists ON
INSERT INTO Tourists (Id, [Name], PhoneNumber, Email, CountryId) VALUES
(1, 'Mario Rossi', '123-456-7890', 'mario.rossi@example.com', 1),
(2, 'Sophie Martin', '987-654-3210', 'sophie.martin@example.com', 2),
(3, 'Juan Rodriguez', '555-955-6555', 'juan.rodriguez@example.com', 3),
(4, 'Müller Schmidt', '444-744-4444', 'muller.schmidt@example.com', 4),
(5, 'Nikos Papadopoulos', '303-323-3333', 'nikos.papadopoulos@example.com', 5),
(6, 'Emily Smith', '202-202-2222', 'emily.smith@example.com', 6),
(7, 'Hans Müller', '111-181-1111', 'hans.muller@example.com', 7),
(8, 'Rui Silva', '999-199-9999', 'rui.silva@example.com', 8),
(9, 'Fatih Yılmaz', '777-727-7177', 'fatih.yilmaz@example.com', 9),
(10, 'Ivan Petrović', '888-878-8288', 'ivan.petrovic@example.com', 10),
(11, 'Marco Bianchi', '123-456-7890', 'marco.bianchi@example.com', 1),
(12, 'Camille Dupont', '987-654-3210', 'camille.dupont@example.com', 2),
(13, 'Elena Gonzalez', '355-585-5555', 'elena.gonzalez@example.com', 3),
(14, 'Friedrich Weber', '434-444-4414', 'friedrich.weber@example.com', 4),
(15, 'Maria Papadopoulou', '333-303-3333', 'maria.papadopoulou@example.com', 5),
(16, 'James Smith', '252-222-2222', 'james.smith@example.com', 6),
(17, 'Anna Müller', '111-141-1111', 'anna.muller@example.com', 7),
(18, 'Manuel Santos', '999-799-9999', 'manuel.santos@example.com', 8),
(19, 'Ahmet Yılmaz', '777-777-7707', 'ahmet.yilmaz@example.com', 9),
(20, 'Ivana Petrović', '808-888-8888', 'ivana.petrovic@example.com', 10)
SET IDENTITY_INSERT Tourists OFF

---Table: HotelsRooms
INSERT INTO HotelsRooms (HotelId, RoomId) VALUES
-- Hotel 1: Albergo Firenze
(1, 1),  -- Albergo Firenze has Single Room
(1, 2),  -- Albergo Firenze has Double Room
(1, 3),  -- Albergo Firenze has Triple Room

-- Hotel 2: Rossovino Como
(2, 1),  -- Rossovino Como has Single Room
(2, 2),  -- Rossovino Como has Double Room
(2, 4),  -- Rossovino Como has Studio

-- Hotel 3: Antica Panada
(3, 5),  -- Antica Panada has One Bedroom Apartment
(3, 6),  -- Antica Panada has Two Bedroom Apartment
(3, 8),  -- Antica Panada has VIP Apratment

-- Hotel 4: Bonvecchiati
(4, 3),  -- Bonvecchiati has Triple Room
(4, 4),  -- Bonvecchiati has Studio
(4, 5),  -- Bonvecchiati has One Bedroom Apartment

-- Hotel 5: Saint Ouen Marche Aux Puces
(5, 4),  -- Saint Ouen Marche Aux Puces has Studio
(5, 7),  -- Saint Ouen Marche Aux Puces has Studio Deluxe
(5, 8),  -- Saint Ouen Marche Aux Puces has VIP Apratment

-- Hotel 6: Porte de Chatillon
(6, 1),  -- Porte de Chatillon has Single Room
(6, 2),  -- Porte de Chatillon has Double Room
(6, 4),  -- Porte de Chatillon has Studio

-- Hotel 7: Royal Promenade des Anglais
(7, 1),  -- Royal Promenade des Anglais has Single Room
(7, 2),  -- Royal Promenade des Anglais has Double Room
(7, 3),  -- Royal Promenade des Anglais has Triple Room

-- Hotel 8: Byakko Nice
(8, 3),  -- Byakko Nice has Triple Room
(8, 4),  -- Byakko Nice has Studio
(8, 5),  -- Byakko Nice has One Bedroom Apartment

-- Hotel 9: Acta Voraport
(9, 5),  -- Acta Voraport has One Bedroom Apartment
(9, 6),  -- Acta Voraport has Two Bedroom Apartment
(9, 7),  -- Acta Voraport has Studio Deluxe

-- Hotel 10: Catalonia Atenas
(10, 1),  -- Catalonia Atenas has Single Room
(10, 2),  -- Catalonia Atenas has Double Room
(10, 4),  -- Catalonia Atenas has Studio

-- Hotel 11: Silken Al-Andalaus Palace
(11, 6),  -- Silken Al-Andalaus Palace has Two Bedroom Apartment
(11, 7),  -- Silken Al-Andalaus Palace has Studio Deluxe
(11, 8),  -- Silken Al-Andalaus Palace has VIP Apratment

-- Hotel 12: Exe Sevilla Macarena
(12, 2),  -- Exe Sevilla Macarena has Double Room
(12, 3),  -- Exe Sevilla Macarena has Triple Room
(12, 6),  -- Exe Sevilla Macarena has Two Bedroom Apartment

-- Hotel 13: Das Regensburg
(13, 1),  -- Das Regensburg has Single Room
(13, 3),  -- Das Regensburg has Triple Room
(13, 5),  -- Das Regensburg has One Bedroom Apartment

-- Hotel 14: Liebesbier Urban Art & Smart Hotel
(14, 2),  -- Liebesbier Urban Art & Smart Hotel has Double Room
(14, 4),  -- Liebesbier Urban Art & Smart Hotel has Studio
(14, 6),  -- Liebesbier Urban Art & Smart Hotel has Two Bedroom Apartment

-- Hotel 15: Anklamer Hof
(15, 1),  -- Anklamer Hof has Single Room
(15, 5),  -- Anklamer Hof has One Bedroom Apartment
(15, 7),  -- Anklamer Hof has Studio Deluxe

-- Hotel 16: Schloss Rattey
(16, 2),  -- Schloss Rattey has Double Room
(16, 6),  -- Schloss Rattey has Two Bedroom Apartment
(16, 8),  -- Schloss Rattey has VIP Apratment

-- Hotel 17: Nautilus Dome
(17, 1),  -- Nautilus Dome has Single Room
(17, 2),  -- Nautilus Dome has Double Room
(17, 4),  -- Nautilus Dome has Studio

-- Hotel 18: Divino Kaldera
(18, 1),  -- Divino Kaldera has Single Room
(18, 2),  -- Divino Kaldera has Double Room
(18, 3),  -- Divino Kaldera has Triple Room

-- Hotel 19: Cavo Tagoo
(19, 2),  -- Cavo Tagoo has Double Room
(19, 3),  -- Cavo Tagoo has Triple Room
(19, 7),  -- Cavo Tagoo has Studio Deluxe

-- Hotel 20: Kivotos
(20, 2),  -- Kivotos has Double Room
(20, 5),  -- Kivotos has One Bedroom Apartment
(20, 8)  -- Kivotos has VIP Apratment

---Table: Bookings
SET IDENTITY_INSERT Bookings ON
INSERT INTO Bookings (Id, ArrivalDate, DepartureDate, AdultsCount, ChildrenCount, TouristId, HotelId, RoomId) VALUES

---Bookings for Tourist 1:
    (1, '2023-11-01', '2023-11-05', 2, 0, 1, 20, 2),  -- Kivotos (Double Room)
    (2, '2023-11-15', '2023-11-20', 1, 0, 1, 1, 1),  -- Albergo Firenze (Single Room)
    (3, '2023-12-10', '2023-12-15', 3, 1, 1, 2, 4),  -- Rossovino Como (Studio)

-- Bookings for Tourist 2
	(4, '2023-10-02', '2023-10-06', 2, 0, 2, 2, 2),  -- Rossovino Como (Double Room)
	(5, '2023-11-16', '2023-11-21', 2, 1, 2, 4, 4),  -- Bonvecchiati (Studio)
	(6, '2023-12-11', '2023-12-16', 1, 3, 2, 6, 4),  -- Porte de Chatillon (Studio)

--- Bookings for Tourist 3
	(7, '2023-10-03', '2023-10-07', 3, 0, 3, 7, 3),  -- Royal Promenade des Anglais (Triple Room)
	(8, '2023-11-17', '2023-11-22', 2, 1, 3, 3, 7),  -- Saint Ouen Marche Aux Puces (Studio Deluxe)
	(9, '2023-12-12', '2023-12-17', 3, 0, 3, 8, 5),  -- Byakko Nice (One Bedroom Apartment)

--- Bookings for Tourist 4
	(10, '2023-10-05', '2023-10-09', 1, 2, 4, 9, 5),  -- Acta Voraport (Double Room)
	(11, '2023-11-19', '2023-11-24', 4, 2, 4, 11, 6),  -- Silken Al-Andalaus Palace (Two Bedroom Apartment)
	(12, '2023-12-15', '2023-12-20', 2, 0, 4, 15, 7),  -- Anklamer Hof (Studio Deluxe)

--- Bookings for Tourist 5
	(13, '2023-10-01', '2023-10-05', 2, 0, 5, 19, 2),  -- Cavo Tagoo (Single Room)
	(14, '2023-10-01', '2023-10-05', 2, 1, 5, 19, 3),  -- Cavo Tagoo (Double Room)
	(15, '2023-10-05', '2023-10-15', 3, 1, 5, 20, 8),  -- Kivotos (Triple Room)

--- Bookings for Tourist 6
	(16, '2023-10-01', '2023-10-05', 1, 0, 6, 18, 1),   -- Divino Kaldera (Single Room)
	(17, '2023-11-15', '2023-11-20', 2, 1, 6, 13, 3),   -- Das Regensburg (Triple Room)
	(18, '2023-12-10', '2023-12-15', 5, 1, 6, 14, 6),   -- Liebesbier Urban Art & Smart Hotel (Studio)

--- Bookings for Tourist 7
	(19, '2023-10-01', '2023-10-05', 2, 2, 7, 17, 4),   -- Nautilus Dome (Studio)
	(20, '2023-11-15', '2023-11-20', 1, 2, 7, 15, 5),   -- Anklamer Hof (One Bedroom Apartment)
	(21, '2023-12-10', '2023-12-15', 2, 2, 7, 16, 5),   -- Schloss Rattey (VIP Apratment)

--- Bookings for Tourist 8
	(22, '2023-10-01', '2023-10-05', 2, 0, 8, 11, 7),   -- Silken Al-Andalaus Palace (Studio Deluxe)
	(23, '2023-11-15', '2023-11-20', 2, 0, 8, 12, 3),   -- Exe Sevilla Macarena (Triple Room)
	(24, '2023-12-10', '2023-12-15', 2, 0, 8, 14, 4),   -- Liebesbier Urban Art & Smart Hotel (Single Room)

--- Bookings for Tourist 9
	(25, '2023-10-01', '2023-10-05', 1, 0, 9, 13, 1),   -- Das Regensburg (Single Room)
	(26, '2023-11-15', '2023-11-20', 2, 0, 9, 10, 2),   -- Catalonia Atenas (Double Room)
	(27, '2023-12-10', '2023-12-15', 2, 1, 9, 11, 7),   -- Silken Al-Andalaus Palace (Studio Deluxe)

--- Bookings for Tourist 10
	(28, '2023-10-01', '2023-10-05', 3, 0, 10, 9, 2),   -- Acta Voraport (One Bedroom Apartment)
	(29, '2023-10-01', '2023-10-05', 2, 1, 10, 9, 4),   -- Acta Voraport (One Bedroom Apartment)
	(30, '2023-10-01', '2023-10-05', 1, 2, 10, 9, 5),   -- Acta Voraport (One Bedroom Apartment)

--- Bookings for Tourist 11
	(31, '2023-11-15', '2023-11-20', 2, 2, 11, 8, 4),   -- Byakko Nice (Studio)
	(32, '2023-11-15', '2023-11-20', 3, 0, 11, 8, 3),   -- Byakko Nice (Triple Room)
	(33, '2023-12-10', '2023-12-15', 1, 2, 11, 6, 4),   -- Porte de Chatillon (One Bedroom Apartment)

--- Bookings for Tourist 12
	(34, '2023-11-10', '2023-11-15', 2, 0, 12, 5, 4),   -- Saint Ouen Marche Aux Puces (Studio)
	(35, '2023-11-10', '2023-11-15', 2, 0, 12, 5, 4),   -- Saint Ouen Marche Aux Puces (One Bedroom Apartment)
	(36, '2023-11-10', '2023-11-15', 2, 1, 12, 5, 4),   -- Saint Ouen Marche Aux Puces (Double Room)

--- Bookings for Tourist 13
	(37, '2023-11-01', '2023-11-20', 2, 0, 13, 4, 3),   -- Bonvecchiati (Triple Room)
	(38, '2023-11-01', '2023-11-20', 2, 0, 13, 4, 3),   -- Bonvecchiati (Triple Room)
	(39, '2023-11-01', '2023-11-20', 1, 0, 13, 4, 3),   -- Bonvecchiati (Triple Room)

--- Bookings for Tourist 15
	(40, '2023-10-01', '2023-10-05', 2, 0, 15, 2, 2),   -- Rossovino Como (Double Room)
	(41, '2023-11-15', '2023-11-20', 2, 0, 15, 4, 5),   -- Bonvecchiati (Studio)
	(42, '2023-12-10', '2023-12-15', 2, 0, 15, 5, 2),   -- Saint Ouen Marche Aux Puces (VIP Apartment)

--- Bookings for Tourist 17
	(43, '2023-10-01', '2023-10-05', 2, 0, 17, 19, 2),   -- Rossovino Como (Double Room)
	(44, '2023-11-15', '2023-11-20', 3, 0, 17, 19, 3),   -- Antica Panada (One Bedroom Apartment)
	(45, '2023-12-10', '2023-12-15', 2, 1, 17, 19, 7);   -- Saint Ouen Marche Aux Puces (Studio Deluxe)

SET IDENTITY_INSERT Bookings OFF


-- 2. Insert

INSERT INTO [Tourists]([Name],[PhoneNumber],[Email],[CountryId])
	VALUES
	('John Rivers', '653-551-1555', 'john.rivers@example.com',6),	
	('Adeline Aglaé', '122-654-8726', 'adeline.aglae@example.com',2),
	('Sergio Ramirez', '233-465-2876', 's.ramirez@example.com',3),
	('Johan Müller', '322-876-9826', 'j.muller@example.com',7),
	('Eden Smith', '551-874-2234', 'eden.smith@example.com',6)

INSERT INTO [Bookings]([ArrivalDate],[Departuredate],[AdultsCount],[ChildrenCount],[TouristId],[HotelId],[RoomId])
	VALUES
	('2024-03-01','2024-03-11',1,0,21,3,5),
	('2023-12-28','2024-01-06',2,1,22,13,3),
	('2023-11-15','2024-11-20',1,2,23,19,7),
	('2023-12-05','2024-12-09',4,0,24,6,4),
	('2024-05-01','2024-05-07',6,0,25,14,6)


-- 3 Update

UPDATE [Bookings]
SET [Departuredate] = DATEADD(DAY,1,[Departuredate])
WHERE [Departuredate] BETWEEN '2023-12-01' AND '2023-12-31'

UPDATE [Tourists]
SET [Email] = NULL
WHERE [Name] LIKE '%MA%'

-- 4 Delete

ALTER TABLE [Bookings]
ADD  FOREIGN KEY ([TouristId]) REFERENCES [Tourists]([Id]) ON DELETE CASCADE

DELETE FROM [Tourists]
WHERE [Name] LIKE '% Smith'


-- 5 Bookings by Price of Room and Arrival Date

SELECT 
		FORMAT([b].[ArrivalDate],'yyyy-MM-dd') AS [ArrivalDate],
		[b].[AdultsCount],
		[b].[ChildrenCount]
FROM [Bookings] AS [b]
JOIN [Rooms] AS [r] ON [b].RoomId = [r].[Id]
ORDER BY [r].[Price] DESC, [b].[ArrivalDate] ASC


-- 6. Hotels by Count of Bookings

SELECT [h].[Id],
	   [h].[Name]
FROM [Rooms] [r]
JOIN [HotelsRooms] [hr] ON [r].[Id] = [hr].[RoomId]
JOIN [Hotels] [h] ON [hr].[HotelId] = [h].[Id]
JOIN [Bookings] [b] ON [b].[HotelId] = [h].[Id]
WHERE [r].[Type] = 'VIP Apartment'
GROUP BY [h].[Id], [h].[Name]
ORDER BY COUNT([b].[Id]) DESC


-- 7. Tourists without Bookings

SELECT 
		[t].[Id],
		[t].[Name],
		[t].[PhoneNumber]
FROM [Tourists] AS [t]
LEFT JOIN [Bookings] AS [b] ON [b].[TouristId] = [t].[Id]
WHERE [b].[TouristId] IS NULL
ORDER BY [t].[Name] ASC


-- 8. First 10 Bookings

SELECT TOP 10
		[h].[Name] AS [HotelName],
		[d].[Name] AS [DestinationName],
		[c].[Name] AS [CountryName]
FROM [Bookings] AS [b]
JOIN [Hotels] AS [h] ON [b].[HotelId] = [h].[Id]
JOIN [Destinations] [d] ON [h].[DestinationId] = [d].[Id]
JOIN [Countries] AS [c] ON [d].[CountryId] = [c].[Id]
WHERE [b].[ArrivalDate] < '2023-12-31' AND [h].[Id] % 2 = 1
ORDER BY [c].[Name] ASC, [b].[ArrivalDate] ASC

SELECT *
FROM [Destinations]


-- 9. Tourists booked in Hotels

SELECT 
		[h].[Name] AS [HotelName],
		[r].[Price] AS [RoomPrice]
FROM [Tourists] AS [t]
JOIN [Bookings] AS [b] ON [t].[Id] = [b].[TouristId]
JOIN [Hotels] AS [h] ON [b].[HotelId] = [h].[Id]
JOIN [Rooms] AS [r] ON [b].[RoomId] = [r].[Id]
WHERE [t].[Name] NOT LIKE '%EZ'
ORDER BY [r].[Price] DESC


-- 10. Hotels Revenue


SELECT 
		[h].[Name],
		COUNT([b].[Id])
FROM [Hotels] AS [h]
JOIN [Bookings] AS [b] ON [b].[HotelId] = [h].[Id]
JOIN [Rooms] AS [r] ON [b].[RoomId] = [r].[Id]
GROUP BY [h].[Name]




SELECT 
		[h].[Name],
		SUM(DATEDIFF(DAY,[b].[ArrivalDate],[b].[Departuredate]) * [r].[Price]) AS [TotalRevenue]
FROM [Bookings] AS [b]
JOIN [Rooms] AS [r] ON [b].[RoomId] = [r].[Id]
JOIN [Hotels] AS [h] ON [h].[Id] = [b].[HotelId]
GROUP BY [h].[Name]
ORDER BY [TotalRevenue] DESC


-- 11. Rooms with Tourists

CREATE OR ALTER FUNCTION udf_RoomsWithTourists
	(@name VARCHAR(40))
RETURNS INT
AS
BEGIN
		DECLARE @result INT 
								SELECT 
										@result = SUM([b].[AdultsCount] + [b].[ChildrenCount])
								FROM [Rooms] AS [r]
								JOIN [Bookings] AS [b] ON [b].[RoomId] = [r].[Id]
								WHERE [r].[Type] = @name
		RETURN @result
END


-- 12. Search for Tourists from a Specific Country

CREATE OR ALTER PROCEDURE usp_SearchByCountry
    @country NVARCHAR(50)
AS
BEGIN
    SELECT 
        [t].[Name],
        [t].[PhoneNumber],
        [t].[Email],
        COUNT([b].[Id]) AS [CountOfBookings]
    FROM [Countries] AS [c]
    LEFT JOIN [Tourists] AS [t] ON [c].[Id] = [t].[CountryId]
    LEFT JOIN [Bookings] AS [b] ON [b].[TouristId] = [t].[Id]
    WHERE [c].[Name] = @country
    GROUP BY [t].[Name], [t].[PhoneNumber], [t].[Email]
    ORDER BY [t].[Name] ASC, [CountOfBookings] DESC;
END;
