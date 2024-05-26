USE [SoftUni]
GO

-- 01. Employee Address
	SELECT 
		TOP (5)
		[e].[EmployeeId]
	  , [e].[JobTitle]
	  , [a].[AddressID]
	  , [a].[AddressText]
	FROM [Employees] 
	  AS [e]
	JOIN [Addresses] 
	  AS [a]
	ON [e].[AddressID] = [a].[AddressID]
	ORDER BY [a].[AddressID] ASC;

-- 02. Addresses with Towns

SELECT 
TOP 50
		[e].[FirstName],
		[e].[LastName],
		[t].[Name],
		[a].[AddressText]
FROM [Employees]
AS [e]
JOIN [Addresses]
AS [a]
ON [e].[AddressID] = [a].[AddressID]
JOIN [Towns]
AS [t]
ON [a].[TownID] = [t].[TownID]
ORDER BY [e].[FirstName] ASC, [e].[LastName] ASC;

-- 03. Sales Employee

SELECT 
		[e].[EmployeeID],
		[e].[FirstName],
		[e].[LastName],
		[d].[Name]
FROM [Employees] AS [e]
JOIN [Departments] AS [d] ON [e].[DepartmentID] = [d].[DepartmentID]
WHERE [d].[Name] = 'Sales'
ORDER BY [e].[EmployeeID] ASC;

-- 04. Employee Departments

SELECT 
TOP 5
		[e].[EmployeeID],
		[e].[FirstName],
		[e].[Salary],
		[d].[Name]
FROM [Employees] AS [e]
JOIN [Departments] AS [d] ON [e].[DepartmentID] = [d].DepartmentID
WHERE [e].[Salary] > 15000
ORDER BY [d].[DepartmentID] ASC;

-- 05. Employees Without Project

SELECT 
TOP 3
		[e].[EmployeeID],
		[e].[FirstName]
FROM [Employees] AS [e]
LEFT JOIN [EmployeesProjects] AS [ep] ON [e].[EmployeeID] = [ep].[EmployeeID]
WHERE [ep].[ProjectID] IS NULL
ORDER BY [e].[EmployeeID] ASC;


-- 06. Employees Hired After

SELECT 
		[e].[FirstName],
		[e].[LastName],
		[e].[HireDate],
		[d].[Name]
FROM [Employees] AS [e]
JOIN [Departments] AS [d] ON [e].[DepartmentID] = [d].[DepartmentID]
WHERE [e].[HireDate] > '1999-01-01' AND [d].[Name] IN ('Sales','Finance')
ORDER BY [e].[HireDate] ASC;

-- 07. Employees with Project

SELECT
TOP 5
		[e].EmployeeID,
		[e].[FirstName],
		[p].[Name]
FROM [Employees] AS [e]
JOIN [EmployeesProjects] AS [ep] ON [e].[EmployeeID] = [ep].[EmployeeID]
JOIN [Projects] AS [p] ON [ep].[ProjectID] = [p].ProjectID
WHERE [p].[StartDate] > '2002-08-13' AND [p].[EndDate] IS NULL
ORDER BY [e].[EmployeeID];


-- 08. Employee 24

SELECT 
		[e].EmployeeID,
		[e].[FirstName],
		[p].[Name],
		CASE
			WHEN YEAR([p].[StartDate]) >= 2005 THEN NULL
			ELSE [p].[Name]
		END AS [ProjectName]
FROM [Employees] AS [e]
JOIN [EmployeesProjects] AS [ep] ON [e].[EmployeeID] = [ep].[EmployeeID]
JOIN [Projects] AS [p] ON [ep].[ProjectID] = [p].[ProjectID]
WHERE [e].[EmployeeID] = 24;


-- 09. Employee Manager

SELECT 
		[e].[EmployeeID],
		[e].[FirstName],
		[e].[ManagerID],
		[m].[FirstName] AS [ManagerName]
FROM [Employees] AS [e]
JOIN [Employees] AS [m] ON [e].[ManagerID] = [m].[EmployeeID]
WHERE [e].ManagerID IN (3,7)
ORDER BY [e].[EmployeeID] ASC;


-- 10. Employees Summary

SELECT 
TOP 50
		[e].[EmployeeId],
		CONCAT_WS(' ',[e].[FirstName], [e].[LastName]) AS [EmployeeName],
		CONCAT_WS(' ',[m].[FirstName], [m].[LastName]) AS [ManagerName],
		[d].[Name] AS [DepartmentName]
FROM [Employees] AS [e]
JOIN [Employees] AS [m] ON [e].[ManagerID] = [m].[EmployeeID]
JOIN [Departments] AS [d] ON [e].[DepartmentID] = [d].DepartmentID
ORDER BY [e].[EmployeeID];


-- 11. Min Average Salary

SELECT
TOP 1
		AVG([e].[Salary]) AS [MinAverageSalary]
FROM [Employees] AS [e]
JOIN [Departments] AS [d] ON [e].DepartmentID = [d].[DepartmentID]
GROUP BY [d].[DepartmentID]
ORDER BY AVG([e].[Salary]) ASC;
GO

USE [Geography]
GO


-- 12. Highest Peaks in Bulgaria

SELECT 
		[mc].[CountryCode],
		[m].[MountainRange],
		[p].[PeakName],
		[p].[Elevation]
FROM [Peaks] AS [p]
JOIN [Mountains] AS [m] ON [P].MountainId = [m].[Id]
JOIN [MountainsCountries] AS [mc] ON [m].[Id] = [mc].[MountainId]
WHERE [p].[Elevation] > 2835 AND [mc].[CountryCode] = 'BG'
ORDER BY [p].[Elevation] DESC;


-- 13. Count Mountain Ranges

SELECT 
		[mc].[CountryCode],
		COUNT([mc].[CountryCode]) AS [MountainRanges]
FROM [Mountains] AS [m]
JOIN [MountainsCountries] AS [mc] ON [m].[Id] = [mc].[MountainId]
WHERE [mc].[CountryCode] IN ('BG', 'RU', 'US')
GROUP BY [mc].[CountryCode];


-- 14. Countries With or Without Rivers

SELECT
TOP 5
		[c].[CountryName],
		[r].[RiverName]
FROM [Countries] AS [c]
LEFT JOIN [CountriesRivers] AS [cr] ON [c].[CountryCode] = [cr].[CountryCode]
LEFT JOIN [Rivers] AS [r] ON [cr].[RiverId] = [r].[Id]
LEFT JOIN [Continents] AS [co] ON [c].[ContinentCode] = [co].[ContinentCode]
WHERE [co].[ContinentName] = 'Africa'
ORDER BY [c].[CountryName] ASC;


-- 15*. Continents and Currencies

SELECT 
		[g].[ContinentCode],
		[g].[CurrencyCode],
		[g].[CurrencyUsage]
FROM(
	SELECT 
		[ContinentCode],
		[CurrencyCode],
		COUNT([CurrencyCode]) AS [CurrencyUsage],
		DENSE_RANK() OVER (PARTITION BY [ContinentCode] ORDER BY COUNT([CurrencyCode]) DESC) AS [Rank]
	FROM [Countries]
	GROUP BY [ContinentCode],[CurrencyCode]
) AS [g]
WHERE g.[Rank] = 1 and g.[CurrencyUsage] > 1





-- 16. Countries Without Any Mountains

SELECT	
COUNT(*) AS [Count]
FROM [Countries] as [c]
LEFT JOIN [MountainsCountries] AS [mc] ON [c].[CountryCode] = [mc].[CountryCode]
WHERE [mc].[MountainId] IS NULL;


-- 17. Highest Peak and Longest River by Country

SELECT
TOP 5
	[c].[CountryName],
	MAX([p].[Elevation]) AS [PeakElevation],
	MAX([r].[Length]) AS [RiverLength]
FROM [Countries] AS [c]
	 LEFT JOIN [MountainsCountries] AS [mc] ON [c].CountryCode = [mc].[CountryCode]
	 LEFT JOIN [Mountains] AS [m] ON [mc].MountainId = [m].[Id]
	 LEFT JOIN [Peaks] AS [p] ON [m].[Id] = [p].[MountainId]
	 LEFT JOIN [CountriesRivers] AS [cr] ON [c].[CountryCode] = [cr].[CountryCode]
	 LEFT JOIN [Rivers] AS [r] ON [cr].[RiverId] = [r].[Id]
GROUP BY [c].[CountryName]
ORDER BY [PeakElevation] DESC, [RiverLength] DESC, [c].[CountryName] ASC


--	18. Highest Peak Name and Elevation by Country

SELECT 
TOP 5
		[rankData].[CountryName],
		ISNULL([rankData].[PeakName], '(no highest peak)') AS [Highest Peak Name],
		ISNULL([rankData].[Elevation], '0') AS [Highest Peak Elevation],
		ISNULL([rankData].[MountainRange], '(no mountain)') AS [Mountain]
FROM (
		SELECT 
			[c].[CountryName],
			DENSE_RANK() OVER (PARTITION BY [c].[CountryName] ORDER BY [p].[Elevation] DESC) AS [HighestPeak],
			[m].[MountainRange],
			[p].[PeakName],
			[p].[Elevation]
		FROM 
		 [Countries] AS [c]
		 LEFT JOIN [MountainsCountries] AS [mc] ON [c].CountryCode = [mc].[CountryCode]
		 LEFT JOIN [Mountains] AS [m] ON [mc].[MountainId] = [m].[Id]
		 LEFT JOIN [Peaks] AS [p] ON [m].[Id] = [p].[MountainId]
	) AS [rankData]
WHERE [HighestPeak] = 1
ORDER BY [rankData].[CountryName] ASC, [rankData].[HighestPeak] ASC;


