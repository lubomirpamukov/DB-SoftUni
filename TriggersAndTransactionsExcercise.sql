--  01. Create Table Logs

CREATE TABLE [Logs]
(
	[LogId] INT PRIMARY KEY IDENTITY,
	[AccountId] INT NOT NULL,
	[OldSum] DECIMAL (15,2) NOT NULL,
	[NewSum] DECIMAL(15,2) NOT NULL
)

CREATE OR ALTER TRIGGER [dbo].tr_TableLog
ON [dbo].[Accounts]
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
		-- Taking the values for the log table from the deleted and inserted tables
		DECLARE @accountID INT = (SELECT [Id] FROM [inserted]);
		DECLARE @oldSum DECIMAL(15,2) = (SELECT [Balance] FROM [deleted]);
		DECLARE @newSum DECIMAL(15,2) = (SELECT [Balance] FROM [inserted]);

		-- Inserting the values into the log table
		INSERT INTO [Logs]([AccountId],[OldSum],[NewSum])
			VALUES
			(@accountID,@oldSum,@newSum)
END


--  02. Create Table Emails

CREATE TABLE [NotificationEmails]
(
	[Id] INT PRIMARY KEY IDENTITY,
	[Recipient] INT NOT NULL,
	[Subject] VARCHAR(100) NOT NULL,
	[Body] VARCHAR(300) NOT NULL
)

CREATE OR ALTER TRIGGER [dbo].[tr_EmailNotification]
ON [dbo].[Logs]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
		DECLARE @recipient INT = (SELECT [LogId] FROM [inserted]);
		DECLARE @subject VARCHAR(100) = CONCAT_WS(' ','Balance change for account:',@recipient);
		DECLARE @oldBalance DECIMAL(15,2) = (SELECT [OldSum] FROM [inserted]);
		DECLARE @newBalance DECIMAL(15,2) = (SELECT [NewSum] FROM [inserted]);
		DECLARE @body VARCHAR(300) = CONCAT_WS(' ','On',GETDATE(),'your balance was changed from',@oldBalance,'to',@newBalance,'.');
		INSERT INTO [dbo].[NotificationEmails]([Recipient],[Subject],[Body])
			VALUES
			(@recipient,@subject,@body)
END
GO

--  03. Deposit Money

CREATE OR ALTER PROCEDURE usp_DepositMoney
	(@accountId INT, @moneyAmount DECIMAL(20,4))
AS
BEGIN
	IF @moneyAmount < 0
	BEGIN
		THROW 50001, 'Cant deposit negative amount',16
	END

	UPDATE [Accounts]
	SET [Balance] = CAST([Balance] + @moneyAmount AS DECIMAL (20,4))
	WHERE [Id] = @accountId

END


-- 04. Withdraw Money Procedure

CREATE OR ALTER PROCEDURE usp_WithdrawMoney
	(@accountId INT, @moneyAmount DECIMAL(20,4))
AS
BEGIN
	IF @moneyAmount < 0
	BEGIN
		THROW 50002,'Cant widraw negative amount',16
	END

	UPDATE [Accounts]
	SET [Balance] = CAST([Balance] - @moneyAmount AS DECIMAL(20,4))
	WHERE [Id] = @accountId
END
GO

-- 05. Money Transfer

CREATE OR ALTER PROCEDURE usp_TransferMoney
    @senderId INT,
    @receiverId INT,
    @amount DECIMAL(20,4)
AS
BEGIN 
	BEGIN TRANSACTION
		-- Check if transfer amount is negative
		IF @amount < 0
		BEGIN
			ROLLBACK;
			THROW 50003, 'Cannot transfer negative amount', 16;
		END

		--Checks if sender exists
		IF NOT EXISTS (SELECT 1 FROM [Accounts] WHERE [Id] = @senderId)
		BEGIN
			ROLLBACK;
			THROW 50005, 'Sender account does not exist', 16;
		END
    
		--Check if sender has sufficient funds
		DECLARE @senderBalance DECIMAL(20,4) = (SELECT [Balance] FROM [Accounts] WHERE [Id] = @senderId)
		IF @senderBalance - @amount < 0
		BEGIN
			ROLLBACK;
			THROW 50004, 'Sender insufficient funds', 16;
		END

		--Check if receiver exists
		IF NOT EXISTS (SELECT 1 FROM [Accounts] WHERE [Id] = @receiverId)
		BEGIN
			ROLLBACK;
			THROW 50006, 'Receiver account does not exist', 16;
		END

		--Withdraw money from sender
		EXECUTE [dbo].[usp_WithdrawMoney] @senderId, @amount;

		--Deposit money to receiver
		EXECUTE [dbo].[usp_DepositMoney] @receiverId, @amount;

	COMMIT TRANSACTION
END


-- 08. Employees with Three Projects


EXECUTE [dbo].[usp_TransferMoney] 3,1,10000

EXECUTE [dbo].[usp_DepositMoney] 1,10
EXECUTE [dbo].[usp_WithdrawMoney] 1,10

SELECT * FROM [NotificationEmails]

SELECT * FROM AccountHolders
SELECT * FROM Accounts
SELECT * FROM [Logs]
SELECT * FROM [NotificationEmails]
GO


-- Part II - Queries for Diablo Database
USE [Diablo]


SELECT * 
FROM [UsersGames] AS [ug]
LEFT JOIN [Characters] AS [c] ON [ug].[CharacterId] = [c].[Id]
LEFT JOIN [Statistics] AS [s] ON [c].[StatisticId] = [s].[Id]
LEFT JOIN 
