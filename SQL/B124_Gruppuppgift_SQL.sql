--Change superuser
USE [PopulationDatabase]
EXEC sp_changedbowner 'sa'
GO


--Script
SET NOCOUNT ON
GO

USE master
GO

IF EXISTS(SELECT * FROM sys.databases WHERE name = 'PopulationDatabase')
BEGIN
	ALTER DATABASE PopulationDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE PopulationDatabase
END

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'PopulationDatabase')
BEGIN
	CREATE DATABASE PopulationDatabase
	COLLATE Latin1_General_CI_AS
END

USE PopulationDatabase
GO

-- Create tables
CREATE TABLE Households (
    HouseholdID INT PRIMARY KEY IDENTITY(1,1),
    Address NVARCHAR(50),
    ZipCode NVARCHAR(5),
    City NVARCHAR(50)
);

CREATE TABLE Statuses (
    StatusID INT PRIMARY KEY IDENTITY(1,1),
    StatusName NVARCHAR(50)
);

CREATE TABLE Persons (
    PersonID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100),
	LastName NVARCHAR(100),
    DateOfBirth DATE NOT NULL,
    Gender NVARCHAR(10),
    HouseholdID INT, 
	Income DECIMAL(10, 2),
	FOREIGN KEY (StatusID) REFERENCES Statuses(StatusID),
	StatusID INT,
	FOREIGN KEY (HouseholdID) REFERENCES Households(HouseholdID),
    Parent1ID INT NULL,
	FOREIGN KEY (Parent1ID) REFERENCES Persons(PersonID),
    Parent2ID INT NULL,
    FOREIGN KEY (Parent2ID) REFERENCES Persons(PersonID)
);

INSERT INTO Statuses (StatusName)
VALUES 
	('Anst�lld'),
	('Pension�r'),
	('Sjukskriven'),
	('Studerande'),
	('Arbetsl�s'),
	('Barn');

INSERT INTO Households (Address, ZipCode, City) 
VALUES
	('Storgatan 12', '12345', 'Testk�ping'),
	('Lilla V�gen 5', '12456', 'Testk�ping'),
	('S�dra Torggatan 8', '12567', 'Testk�ping'),
	('Bj�rkv�gen 19', '12678', 'Testk�ping'),
	('Kungsall�n 22', '12789', 'Testk�ping'),
	('Parkv�gen 11', '12890', 'Testk�ping'),
	('�ngsgatan 34', '12901', 'Testk�ping'),
	('H�galidsgatan 45', '13012', 'Testk�ping'),
	('Havsv�gen 6', '13123', 'Testk�ping'),
	('Fyrv�gen 4', '13234', 'Testk�ping'),
	('Vikingagatan 25', '13345', 'Testk�ping'),
	('Skogsv�gen 9', '13456', 'Testk�ping'),
	('Soltorget 2', '13567', 'Testk�ping'),
	('�stergatan 17', '13678', 'Testk�ping'),
	('V�stergatan 3', '13789', 'Testk�ping'),
	('M�larv�gen 18', '13890', 'Testk�ping'),
	('Eklunden 7', '13901', 'Testk�ping'),
	('J�rnv�gsgatan 10', '14012', 'Testk�ping'),
	('Skogsbrynet 21', '14123', 'Testk�ping'),
	('L�nggatan 13', '14234', 'Testk�ping'),
	('Flodgatan 4', '14345', 'Testk�ping'),
	('Hagv�gen 8', '14456', 'Testk�ping'),
	('V�stra Lilla V�g 17', '14567', 'Testk�ping'),
	('Sundsv�gen 20', '14678', 'Testk�ping'),
	('Tegelgatan 12', '14789', 'Testk�ping'),
	('Kronv�gen 27', '14890', 'Testk�ping'),
	('Nyhemsv�gen 5', '14901', 'Testk�ping'),
	('Tornv�gen 15', '15012', 'Testk�ping'),
	('L�vstr�ket 22', '15123', 'Testk�ping'),
	('Bergsgatan 14', '15234', 'Testk�ping');

SELECT *
FROM Households;

SELECT *
FROM Statuses;

USE PopulationDatabase
GO 

INSERT INTO Persons (
	FirstName, 
	LastName, 
	Gender, 
	Income, 
	DateOfBirth,
	StatusID,
	HouseholdID, 
	Parent1ID, 
	Parent2ID)
VALUES
	('Anna', 'Johansson', 'Kvinna', 45000.00, '1992-03-14', 1, 1, NULL, NULL),
	('Erik', 'Johansson', 'Man', 52000.00, '1985-11-30', 1, 1, NULL, NULL),
	('Elin', 'Johansson', 'Kvinna', 0.00, '2012-07-15', 6, 1, 1, 2),
	('Elsa', 'Johansson', 'Kvinna', 0.00, '2014-07-15', 6, 1, 1, 2),
	('Eila', 'Johansson', 'Kvinna', 0.00, '2016-07-15', 6, 1, 1, 2),
	('Karin', 'Nilsson', 'Kvinna', 48000.00, '1980-08-25', 1, 2, NULL, NULL),
	('Mats', 'Nilsson', 'Man', 54000.00, '1978-01-12', 1, 2, NULL, NULL),
	('Nils', 'Nilsson', 'Man', 0.00, '2009-10-10', 6, 2, 6, NULL),
	('Maria', 'Lindstr�m', 'Kvinna', 0.00, '1952-03-29', 2, 3, NULL, NULL),
	('Per', 'Lindstr�m', 'Man', 12000.00, '1950-07-13', 2, 3, NULL, NULL),
	('Emma', 'Berg', 'Kvinna', 47000.00, '1987-06-14', 1, 4, NULL, NULL),
	('Fredrik', 'Berg', 'Man', 58000.00, '1985-09-18', 1, 4, NULL, NULL),
	('Olivia', 'Berg', 'Kvinna', 0.00, '2014-11-22', 6, 4, 11, 12),
	('Ottilia', 'Berg', 'Kvinna', 0.00, '2010-11-22', 6, 4, 11, 12),
	('David', 'Nystr�m', 'Man', 5000.00, '1989-01-17', 5, 5, NULL, NULL),
	('Ebba', 'Nystr�m', 'Kvinna', 46000.00, '1991-02-26', 1, 5, NULL, NULL),
	('Sofia', 'Eriksson', 'Kvinna', 42000.00, '1994-11-05', 4, 6, NULL, NULL),
	('Anton', 'Eriksson', 'Man', 50000.00, '1990-12-20', 1, 6, NULL, NULL),
	('Isabella', 'Eriksson', 'Kvinna', 0.00, '2007-05-18', 6, 6, 17, 18),
	('Filip', 'Eriksson', 'Man', 0.00, '2009-09-01', 6, 6, 17,18),
	('Freddie', 'Eriksson', 'Man', 0.00, '2011-06-03', 6, 6, 17,18),
	('Agnes', 'Larsson', 'Kvinna', 48000.00, '1988-10-15', 1, 7, NULL, NULL),
	('Lisa', 'Larsson', 'Kvinna', 0.00, '2019-08-24', 6, 7, 22, NULL),
	('Therese', 'Svensson', 'Kvinna', 45000.00, '1986-03-14', 1, 8, NULL, NULL),
	('H�kan', 'Svensson', 'Man', 53000.00, '1983-12-09', 1, 8, NULL, NULL),
	('Sara', 'Svensson', 'Kvinna', 0.00, '2011-08-24', 6, 8, 24, 25),
	('Stina', 'Svensson', 'Kvinna', 0.00, '2011-08-24', 6, 8, 24, 25),
	('Victor', 'Holm', 'Man', 47000.00, '1995-01-19', 1, 9, NULL, NULL),
	('Matilda', 'Holm', 'Kvinna', 44000.00, '1996-04-30', 1, 9, NULL, NULL),
	('Vilgot','Holm', 'Man',0.00,'2019-01-28', 6, 9, 28, 29),
	('Simon','Larsson','Man', 52000.00, '1985-06-21', 1, 10, NULL, NULL),
	('Gustav', 'Str�m', 'Man', 54000.00, '1980-02-18', 1, 11, NULL, NULL),
	('Emelie', 'Str�m', 'Kvinna', 45000.00, '1982-07-27', 1, 11, NULL, NULL),
	('Signe', 'Str�m', 'Kvinna', 0.00, '2008-10-08', 6, 11, 32, 33),
	('Elliot', 'Str�m', 'Man', 0.00, '2010-05-03', 6, 11, 32, 33),
	('Elias', 'Str�m', 'Man', 0.00, '2012-05-03', 6, 11, 32, 33),
	('David', 'Nystr�m', 'Man', 50000.00, '1989-01-17', 1, 12, NULL, NULL),
	('Ebba', 'Nystr�m', 'Kvinna', 46000.00, '1991-02-26', 1, 12, NULL, NULL),
	('Frans', 'Nystr�m', 'Man', 0.00, '2019-05-03', 6, 12, 38, 39),
	('Ella', 'Nystr�m', 'Kvinna', 0.00, '2021-11-08', 6, 12, 38, 39),
	('Mattias', 'Mattsson', 'Man', 38000.00, '1955-06-29', 2, 13, NULL, NULL),
	('Niklas', 'Nitrat', 'Man', 2000.00, '1984-02-23', 5, 14, NULL, NULL),
	('Alex', 'Sand', 'Man', 53000.00, '1984-10-02', 1, 15, NULL, NULL),
	('Anna', 'Sand', 'Kvinna', 3200.00, '1983-04-11', 5, 15, NULL, NULL),
	('Leia', 'Sand', 'Kvinna', 0.00, '2019-09-30', NULL, 15, 44, 45),
	('Henrik', 'Blom', 'Man', 11000.00, '1955-12-07', 2, 16, NULL, NULL),
	('Eva', 'Blom', 'Kvinna', 14000.00, '1958-03-03', 2, 16, NULL, NULL),
	('Axel', 'Sandberg', 'Man', 53000.00, '1984-06-02', 1, 17, NULL, NULL),
	('Hanna', 'Sandberg', 'Kvinna', 52000.00, '1983-03-11', 1, 17, NULL, NULL),
	('Wilma', 'Sandberg', 'Kvinna', 0.00, '2014-12-11', NULL, 17, 49, 50),
	('Liam', 'Sandberg', 'Man', 0.00, '2021-08-10', NULL, 17, 49, 50),
	('Livia', 'Sandberg', 'Kvinna', 0.00, '2019-05-29', 6, 17, 49, 50),
	('Joel', 'Ek', 'Man', 48000.00, '1988-04-10', 1, 18, NULL, NULL),
	('Tilda', 'Ek', 'Kvinna', 14000.00, '2004-11-03', 4, 18, NULL, NULL),
	('Cecilia', 'Fransson', 'Kvinna', 24000.00, '1987-07-23', 1, 19, NULL, NULL),
	('Alice', 'Fransson', 'Kvinna', 0.00, '2013-01-29',6, 19, 56, NULL),
	('Lasse', 'Svensson', 'Man', 51000.00, '1967-06-21', 1, 20, NULL, NULL),
	('Daniel', 'Berg', 'Man', 58000.00, '1989-01-17', 1, 21, NULL, NULL),
	('Emma', 'Berg', 'Kvinna', 14300.00, '1991-02-26', 5, 21, NULL, NULL),
	('Elias', 'Berg', 'Man', 0.00, '2019-06-06', 6, 21, 59, 60),
	('Elin', 'Berg', 'Kvinna', 0.00, '2021-12-23', 6, 21, 59, 60),
	('Marcus', 'Gren', 'Man', 74000.00, '1984-01-14', 1, 22, NULL, NULL),
	('Malin', 'Gren', 'Kvinna', 38000.00, '1984-01-28', 1, 22, NULL, NULL),
	('Love', 'Gren', 'Man', 0.00, '2009-05-29', 6, 22, 63, 64),
	('Jonathan', 'Gren', 'Man', 0.00, '2011-08-10', 6, 22, 63, 64),
	('Li', 'Gren', 'Kvinna', 0.00, '2019-12-11', 6, 22, 63, 64),
	('Theo', 'Gren', 'Man', 0.00, '2022-02-02', 6, 22, 63, 64),
	('Anton', 'Hallin', 'Man', 53000.00, '1988-02-02', 1, 23, NULL, NULL),
	('Anna', 'Hallin', 'Kvinna', 52000.00, '1983-03-11', 1, 23, NULL, NULL),
	('Molly', 'Hallin', 'Kvinna', 0.00, '2013-03-27', 6, 23, 69, 70),
	('Dick', 'Ring', 'Man', 58000.00, '1989-01-17', 1, 24, NULL, NULL),
	('Ingela', 'Ring', 'Kvinna', 43000.00, '1991-02-26', 1, 24, NULL, NULL),
	('Casper', 'Ring', 'Man', 0.00, '2017-08-08', 6, 24, 72, 73),
	('Myh', 'Ring', 'Kvinna', 0.00, '2019-09-17', 6, 24, 72, 73),
	('Viktor', 'Malmberg', 'Man', 48000.00, '1987-05-31', 1, 25, NULL, NULL),
	('Lowisa', 'Malmberg', 'Kvinna', 28000.00, '1990-04-01', 1, 25, NULL, NULL),
	('Malva', 'Malmberg', 'Kvinna', 0.00, '2015-12-16', 6, 25, 76, 77),
	('Alfred', 'Malmberg', 'Man', 0.00, '2017-05-01', 6, 25, 76, 77),
	('Leia', 'Malmberg', 'Kvinna', 0.00, '2019-01-13', 6, 25, 76, 77),
	('Peter', 'Haaga', 'Man', 60000.00, '1981-12-28', 1, 26, NULL, NULL),
	('Maria', 'Haaga', 'Kvinna', 40000.00, '1982-06-03', 1, 26, NULL, NULL),
	('Linnea', 'Haaga', 'Kvinna', 0.00, '2013-03-27', 6, 26, 81,82),
	('Johan', 'Sj�gren', 'Man', 68000.00, '1982-02-14', 1, 27, NULL, NULL),
	('Lina', 'Sj�gren', 'Kvinna', 42000.00, '1984-11-28', 1, 27, NULL, NULL),
	('Oliver', 'Sj�gren', 'Man', 0.00, '2010-08-29', 6, 27, 84, 85),
	('Johannes', 'Sj�gren', 'Man', 0.00, '2011-09-10', 6, 27, 84, 85),
	('Maja', 'Sj�gen', 'Kvinna', 0.00, '2015-12-20', 6, 27, 84, 85),
	('Alex', 'Sj�gren', 'Man', 0.00, '2019-01-14', 6, 27, 84, 85),
	('Pelle', 'Ekberg', 'Man', 62000.00, '1983-03-28', 1, 28, NULL, NULL),
	('Maria', 'Ekberg', 'Kvinna', 39000.00, '1982-02-06', 1, 28, NULL, NULL),
	('Sanna', 'Ekberg', 'Kvinna', 0.00, '2010-04-27', 6, 28, 90, 91),
	('Affe', 'Holm', 'Man', 55000.00, '1988-03-18', 1, 29, NULL, NULL),
	('Moa', 'Holm', 'Kvinna', 40000.00, '1989-07-03', 1, 29, NULL, NULL),
	('Adrian', 'Holm', 'Man', 0.00, '2015-03-27', 6, 29, 93, 94),
	('Didrik', 'Falk', 'Man', 46000.00, '1992-06-16', 1, 30, NULL, NULL),
	('Ebba', 'Falk', 'Kvinna', 43000.00, '1990-09-24', 1, 30, NULL, NULL),
	('Frodo', 'Falk', 'Man', 0.00, '2011-10-10', 6, 30, 96, 97),
	('Freja', 'Falk', 'Kvinna', 0.00, '2012-10-17', 6, 30, 96, 97),
	('Fora', 'Falk', 'Kvinna', 0.00, '2015-04-20', 6, 30, 96, 97),
	('Flip', 'Falk', 'Man', 0.00, '2016-01-20',6, 30, 96, 97);

SELECT *
FROM Persons;

--Gruppuppgift - Svar
-- 1--� Hur m�nga pojkar och flickor kommer b�rja skolan �r X? (SQL Query)
-- (x) Schoolyear 2025 birthyear -6 f�dd 2019

SELECT Gender, COUNT(*) AS Count
FROM dbo.Persons
WHERE YEAR(DateOfBirth) = '2019'
GROUP BY Gender;

--2--� Ta fram en lista p� deras f�r�ldrar s� man kan skicka ut post till dom (STORED PROC)

GO
CREATE OR ALTER PROCEDURE GetParentsMail @BirthYear INT
AS
BEGIN
    SELECT 
        ch.FirstName + ' ' + ch.LastName AS Child,
        p1.FirstName + ' ' + p1.LastName AS [Parent 1],
		p2.FirstName + ' ' + p2.LastName AS [Parent 2],
        h.Address,
        h.ZipCode + ' ' + h.City AS [Mailing Address]
    FROM Persons AS ch
    LEFT JOIN Persons AS p1 ON ch.Parent1ID = p1.PersonID
    LEFT JOIN Persons AS p2 ON ch.Parent2ID = p2.PersonID
    LEFT JOIN Households AS h ON ch.HouseholdID = h.HouseholdID
    WHERE YEAR(ch.DateOfBirth) = @BirthYear
	ORDER BY ch.DateOfBirth
END
GO

EXEC GetParentsMail 2019;

-- 3--� Ta fram lista p� alla som kommer bli �lderspension�rer (fylla 67) �r X (SQL Query)

SELECT FirstName + ' ' + LastName AS FullName, 
	DateOfBirth,
	YEAR(DateOfBirth) + 67 AS RetirementYear
FROM Persons
WHERE YEAR(DateOfBirth) + 67 = 2025
ORDER BY DateOfBirth;

--4--� Hur m�nga hush�ll best�r av minst X personer (SQL Query)

SELECT *
FROM Households;

SELECT 
	p.HouseholdID, 
	h.Address, COUNT(*) AS [Numbers In Household]
FROM Persons p
INNER JOIN Households h ON p.HouseholdID = h.HouseholdID
GROUP BY p.HouseholdID, h.Address
HAVING COUNT(*) >= 3
ORDER BY [Numbers In Household] DESC;

--5--� Hur m�nga hush�ll har minst en medlem som �r arbetsl�s (VIEW)
 
GO
CREATE OR ALTER VIEW HouseHoldUnemployed AS
	SELECT DISTINCT 
	h.HouseholdID, 
	h.Address, 
	p.FirstName + ' ' + p.LastName AS FullName
	FROM Households h
	INNER JOIN Persons p ON h.HouseholdID = p.HouseholdID
	INNER JOIN Statuses es ON p.StatusID = es.StatusID
	WHERE p.StatusID = (
		SELECT StatusID
		FROM Statuses
		WHERE StatusName = 'Arbetsl�s'
	)
GO

SELECT *
FROM HouseholdUnemployed;

SELECT COUNT(*) AS NumberUnemployed
FROM HouseholdUnemployed;

SELECT *, COUNT(*) OVER() AS TotalCountForAll
FROM HouseholdUnemployed;

--6--� Hur m�nga hush�ll tj�nar totalt mindre �n X kronor, dvs. kan vara aktuella f�r socialbidrag 

SELECT COUNT(*) AS HouseholdsWithLowIncome
FROM (
    SELECT HouseholdID, SUM(Income) AS [TotalIncome]
    FROM Persons
    GROUP BY HouseholdID
	) 
AS HouseholdIncomes
WHERE TotalIncome < 40000;

SELECT 
    h.HouseholdID,
    h.Address,
	h.ZipCode,
    h.City,  
    SUM(p.Income) AS [TotalIncome]
FROM Persons p
JOIN Households h ON p.HouseholdID = h.HouseholdID
GROUP BY h.HouseholdID, h.Address, h.City, h.ZipCode
HAVING SUM(p.Income) < 60000;