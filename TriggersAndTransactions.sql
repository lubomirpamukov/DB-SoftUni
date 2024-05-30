USE [SoftUni]
GO

-- 01.  Employees with Salary Above 35000

CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAbove35000  
AS
BEGIN
		SELECT [FirstName],
			   [LastName]
		  FROM [Employees]
		  WHERE [Salary] > 35000
END;

EXECUTE usp_GetEmployeesSalaryAbove35000;

GO
-- 02.  Employees with Salary Above Number

CREATE OR ALTER PROCEDURE usp_GetEmployeesSalaryAboveNumber 
@Salary DECIMAL(18,4)
AS
BEGIN
		SELECT [FirstName],
			   [LastName]
		  FROM [Employees]
		  WHERE [Salary] >= @Salary
END

EXECUTE usp_GetEmployeesSalaryAboveNumber 48100
GO

--  03. Town Names Starting With

CREATE OR ALTER PROCEDURE usp_GetTownsStartingWith 
	@StartsWith VARCHAR(50)
AS
BEGIN
		SELECT [Name]
		FROM [Towns]
		WHERE LOWER([Name]) LIKE LOWER(@StartsWith + '%')

END

EXECUTE usp_GetTownsStartingWith 's'
GO


--  04. Employees from Town

CREATE OR ALTER PROCEDURE usp_GetEmployeesFromTown
	@TownName VARCHAR(50)
AS
BEGIN
		SELECT [e].[FirstName],
			   [e].[LastName]
		FROM [Employees] AS [e]
		LEFT JOIN [Addresses] AS [a] ON [e].[AddressID] = [a].[AddressID]
		LEFT JOIN [Towns] AS [t] ON [a].[TownID] = [t].[TownID]
		WHERE [t].[Name] = @TownName
END

EXECUTE usp_GetEmployeesFromTown 'Bothell'

SELECT [Name] FROM [Towns]
GO


--  05. Salary Level Function

CREATE OR ALTER FUNCTION ufn_GetSalaryLevel
	(@salary DECIMAL(18,4))
RETURNS VARCHAR(7)
AS
BEGIN
		DECLARE @SalaryLevel VARCHAR(7)

		IF @salary < 30000
			BEGIN
				SET @SalaryLevel = 'Low'
			END
		ELSE IF @salary BETWEEN 30000 AND 50000
			BEGIN
				SET @SalaryLevel = 'Average'
			END
		ELSE IF @salary > 50000
			BEGIN
				SET @SalaryLevel = 'High'
			END

		RETURN @SalaryLevel

END

SELECT 
	   [dbo].[ufn_GetSalaryLevel]([Salary]) AS [Salary Level]
FROM [Employees]
GO


--  06. Employees by Salary Level

CREATE OR ALTER PROCEDURE usp_EmployeesBySalaryLevel 
	@SalaryLevel VARCHAR(7) -- low,avrage,high
AS
BEGIN
		SELECT [FirstName],
			   [LastName]
		FROM [Employees]
		WHERE [dbo].[ufn_GetSalaryLevel]([Salary]) = @SalaryLevel
			   
END

EXECUTE usp_EmployeesBySalaryLevel 'High'
GO


--  07. Define Function

CREATE OR ALTER FUNCTION ufn_IsWordComprised
	(@setOfLetters VARCHAR(100), @word VARCHAR(100)) 
	RETURNS  BIT
AS
BEGIN
		DECLARE @Result BIT;
			DECLARE @CharCount INT = 1;
			WHILE @CharCount <= LEN(@word)
			BEGIN
				DECLARE @CurrentChar CHAR  = SUBSTRING(@word,@CharCount,1);

				IF CHARINDEX (@CurrentChar,@setOfLetters) = 0
				RETURN 0

				SET @CharCount += 1;
			END

		RETURN 1;
END

SELECT [dbo].[ufn_IsWordComprised]('oistmiahf' , 'Sofia' ) AS [result]
GO


USE [Bank]
GO

--  09. Find Full Name

CREATE OR ALTER PROCEDURE usp_GetHoldersFullName 
AS
BEGIN
		SELECT CONCAT_WS(' ', [FirstName],[LastName]) AS [Full Name]
		FROM [AccountHolders]
END

EXECUTE dbo.usp_GetHoldersFullName
GO

--  10. People with Balance Higher Than

CREATE OR ALTER PROCEDURE usp_GetHoldersWithBalanceHigherThan
	@money MONEY
AS
BEGIN
	SELECT 
			[result].[FirstName] AS [First Name],
			[result].[LastName] AS [Last Name]
	FROM(
		SELECT 
			[ah].[FirstName],
			[ah].[LastName],
			SUM([Balance]) AS total
		FROM [AccountHolders] AS [ah]
		LEFT JOIN [Accounts] AS [a] ON [ah].[Id] = [a].[AccountHolderId]
		GROUP BY [ah].[FirstName], [ah].[LastName], [ah].[Id]
		) AS [result]
	WHERE
		[result].[total] > @money
	ORDER BY
		[FirstName] ASC, [LastName] ASC
END

EXECUTE usp_GetHoldersWithBalanceHigherThan 6000000
GO

--  11. Future Value Function

CREATE OR ALTER FUNCTION ufn_CalculateFutureValue
    (@sum DECIMAL(20, 4), @interestRate FLOAT, @years INT)
    RETURNS DECIMAL(20, 4)
AS
BEGIN
    RETURN @sum * POWER(1 + @interestRate, @years)
END;

SELECT dbo.ufn_CalculateFutureValue(2000,0.1,5)


--  12. Calculating Interest

CREATE OR ALTER PROCEDURE usp_CalculateFutureValueForAccount
    @accountID INT,
    @interestRate FLOAT
AS
BEGIN
    DECLARE @firstName NVARCHAR(50),
            @lastName NVARCHAR(50),
            @currentBalance DECIMAL(18, 4);

    SELECT 
        @firstName = ah.FirstName,
        @lastName = ah.LastName,
        @currentBalance = a.Balance
    FROM 
        AccountHolders AS ah
    INNER JOIN 
        Accounts AS a ON ah.Id = a.AccountHolderId
    WHERE 
        a.Id = @accountID;

    DECLARE @balanceIn5Years DECIMAL(18, 4);
    SET @balanceIn5Years = dbo.ufn_CalculateFutureValue(@currentBalance, @interestRate, 5);

    SELECT 
        @accountID AS [Account Id],
        @firstName AS [First Name],
        @lastName AS [Last Name],
        @currentBalance AS [Current Balance],
        @balanceIn5Years AS [Balance in 5 years];
END;