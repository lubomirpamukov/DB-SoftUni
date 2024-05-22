--Find All the Information About Departments
SELECT *
FROM [Departments];
GO

--Find all Department Names
SELECT [Name]
FROM [Departments];
GO

--Find salary of each Employee
SELECT [FirstName], [LastName], [Salary]
FROM [Employees];
GO

--Find Full Name of Each Employee
SELECT [FirstName], [MiddleName], [LastName]
FROM [Employees];
GO

--Find Email Address of Each Employee
SELECT [FirstName] + '.' + [LastName] + '@softuni.bg' AS [Full Email Address]
FROM [Employees];
GO

--Find All Different Employees Salaries
SELECT DISTINCT [Salary] AS [Salary]
FROM [Employees];
GO

--Find All Information About Employees
SELECT *
FROM [Employees]
WHERE [JobTitle] = 'Sales Representative';
GO

--Find names of all employees by salary in range
SELECT [FirstName], [LastName], [JobTitle]
FROM [Employees]
WHERE [Salary] BETWEEN 20000 AND 30000;
GO

--Find names of all employees
SELECT [FirstName] + ' ' + [MiddleName] + ' ' + [LastName] AS [Full Name]
FROM [Employees]
WHERE [Salary] IN (25000,14000,12500,23600);
GO

SELECT* FROM [Employees];
--Find all employees without a manager
SELECT [FirstName], [LastName]
FROM [Employees]
WHERE [ManagerID] IS NULL;
GO

--Find all employees with salary more than 50 000
SELECT [FirstName], [LastName], [Salary]
FROM [Employees]
WHERE [Salary] > 50000
ORDER BY [Salary] DESC;
GO

--Find 5 best paid employees
SELECT TOP(5) [FirstName], [LastName]
FROM [Employees]
ORDER BY [Salary] DESC;
GO

--Find all employees except marketing
SELECT [FirstName], [LastName]
FROM [Employees]
WHERE [DepartmentID] <> 4;
GO

--Sort employees table
SELECT *
FROM [Employees]
ORDER BY [Salary] DESC, [FirstName] ASC, [LastName] DESC, [MiddleName] ASC;
GO

--Create view employees with slaries
CREATE VIEW V_EmployeesSalaries AS
SELECT [FirstName], [LastName], [Salary]
FROM [Employees];
GO

--Create view Employees with job titles
CREATE VIEW V_EmployeeNameJobTitle AS
SELECT [FirstName] + ' ' + ISNULL([MiddleName], '')+ ' ' + [LastName] AS [Full Name], [JobTitle]
FROM [Employees];
GO

--Distinct job titles
SELECT DISTINCT [JobTitle]
FROM [Employees];
GO

--Find first 10 started projects
SELECT TOP(10) *
FROM [Projects]
ORDER BY [StartDate] ASC, [Name];
GO

--Last 7 hired employees
SELECT TOP(7) [FirstName], [LastName], [HireDate]
FROM [Employees]
ORDER BY [HireDate] DESC;
GO

--Increase slaries /not working

UPDATE [Employees]
SET [Salary] *= 1.12
WHERE [DepartmentID] IN (12,4,46,42);

SELECT [Salary]
FROM [Employees];

UPDATE [Employees]
SET [Salary] *= 0.88
WHERE [DepartmentID] IN (12,4,46,42);
GO

--All Mountain Peaks
SELECT [PeakName]
FROM [Peaks]
ORDER BY [PeakName] ASC;
GO

--Biggest country by population
SELECT TOP(30) [CountryName], [Population]
FROM [Countries]
WHERE [ContinentCode] = 'EU'
ORDER BY [Population] DESC, [CountryName] ASC;
GO

--COUNTRIES AND CURRENCY (EURO/NOT EURO)
SELECT  [CountryName],
		[CountryCode],
		CASE 
		WHEN[CurrencyCode] = 'EUR' THEN 'Euro'
		ELSE 'Not Euro'
		END AS [Currency]
FROM [Countries]
ORDER BY [CountryName] ASC;
GO

--All diablo characters

SELECT
	[Name]
FROM [Characters]
ORDER BY [Name] ASC;