--  01. Records’ Count

SELECT COUNT(*) AS [Count]
FROM [WizzardDeposits]


--  02. Longest Magic Wand

SELECT MAX([MagicWandSize]) AS [LongestMagicWand]
FROM [WizzardDeposits]


--  03. Longest Magic Wand per Deposit Groups

SELECT 
		[DepositGroup],
		MAX([MagicWandSize]) AS [LongestMagicWand]
FROM [WizzardDeposits]
GROUP BY [DepositGroup]


--  04. * Smallest Deposit Group Per Magic Wand Size

SELECT 
		[g].[DepositGroup]
	FROM(
			SELECT
			TOP 2
				[DepositGroup],
				AVG([MagicWandSize]) AS [AvgWandSize]
			FROM [WizzardDeposits]
			GROUP BY [DepositGroup]
			ORDER BY [AvgWandSize]
		)AS [g]


-- 05. Deposits Sum

SELECT 
		[DepositGroup],
		SUM([DepositAmount]) AS [TotalSum]
FROM [WizzardDeposits]
GROUP BY [DepositGroup]


--  06. Deposits Sum for Ollivander Family

SELECT 
		[DepositGroup],
		SUM([DepositAmount]) AS [TotalSum]
FROM [WizzardDeposits]
WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]


--  07. Deposits Filter

SELECT 
		[DepositGroup],
		SUM([DepositAmount]) AS [TotalSum]
FROM [WizzardDeposits]
WHERE [MagicWandCreator] = 'Ollivander family' 
GROUP BY [DepositGroup]
HAVING SUM([DepositAmount]) < 150000
ORDER BY [TotalSum] DESC;


-- 08. Deposit Charge

SELECT 
		[DepositGroup],
		[MagicWandCreator],
		MIN([DepositCharge]) AS [MinDepositCharge]
FROM [WizzardDeposits]
GROUP BY [MagicWandCreator],[DepositGroup]
ORDER BY [MagicWandCreator] ASC, [DepositGroup] ASC


--  09. Age Groups

SELECT	
		CASE
			WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
			WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN [Age] BETWEEN 31 AND 40 THEN '[31-40]'
			WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
			WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
			WHEN [Age] >= 61 THEN '[61+]'
		END AS [AgeGroup],
		COUNT(*) AS [WizzardCount]
FROM [WizzardDeposits]
GROUP BY (
			CASE
			WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
			WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN [Age] BETWEEN 31 AND 40 THEN '[31-40]'
			WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
			WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
			WHEN [Age] >= 61 THEN '[61+]'
		END
		)


--  10. First Letter

SELECT DISTINCT LEFT([FirstName],1) AS [FirstLetter]
FROM [WizzardDeposits]
WHERE [DepositGroup] = 'Troll Chest'
ORDER BY [FirstLetter]


--  11. Average Interest 

SELECT 
    [DepositGroup],
    [IsDepositExpired],
    AVG([DepositInterest]) AS [AverageInterest]
FROM 
    [WizzardDeposits]
WHERE
    [DepositStartDate] > '01-01-1985' 
GROUP BY 
    [DepositGroup], 
    [IsDepositExpired]
ORDER BY 
    [DepositGroup] DESC, 
    [IsDepositExpired] ASC;

GO


--  13. Departments Total Salaries

SELECT 
		[DepartmentID],
		SUM([Salary]) AS [TotalSalary]
FROM [Employees]
GROUP BY [DepartmentID]
ORDER BY [DepartmentID] ASC;


--  14. Employees Minimum Salaries

SELECT 
		[DepartmentID],
		MIN([Salary]) AS [MinimumSalary]
FROM [Employees]
WHERE [DepartmentID] IN (2,5,7) AND [HireDate] > '01-01-2000'
GROUP BY [DepartmentID]


--  15. Employees Average Salaries

SELECT * 
INTO [NewTable]
FROM [Employees]
WHERE [Salary] > 30000;

DELETE FROM [NewTable]
WHERE [ManagerID] = 42;

UPDATE [NewTable]
SET [Salary] = [Salary] + 5000
WHERE [DepartmentID] = 1;

SELECT 
	[DepartmentID],
	AVG([Salary]) AS [AvrageSalary]
FROM [NewTable]
GROUP BY [DepartmentID];


--  16.  Employees Maximum Salaries

SELECT 
		[DepartmentID],
		MAX([Salary]) AS [MaxSalary]
FROM [Employees]
GROUP BY [DepartmentID]
HAVING MAX([Salary]) NOT BETWEEN 30000 AND 70000


-- 17.  Employees Count Salaries

SELECT COUNT([Salary]) AS [Count]
FROM [Employees]
WHERE [ManagerID] IS NULL
GROUP BY [ManagerID];

