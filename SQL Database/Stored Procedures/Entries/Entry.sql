/*
USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_EntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_EntrySelect] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [id], [fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate], [tier] 
	FROM   [dbo].[Entry] 
	WHERE  ([id] = @id OR @id IS NULL) 

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_EntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_EntryInsert] 
    @fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,
    @modifiedDate datetime,
    @tier int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Entry] ([fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate], [tier])
	SELECT @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate, @tier
	
	-- Begin Return Select <- do not remove
	SELECT [id], [fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate], [tier]
	FROM   [dbo].[Entry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_EntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_EntryUpdate] 
    @id int,
    @fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,
    @modifiedDate datetime,
    @tier int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Entry]
	SET    [fiscalYear] = @fiscalYear, [fiscalMonth] = @fiscalMonth, [reportDate] = @reportDate, [createdBy] = @createdBy, [modifiedBy] = @modifiedBy, [createdDate] = @createdDate, [modifiedDate] = @modifiedDate, [tier] = @tier
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate], [tier]
	FROM   [dbo].[Entry]
	WHERE  [id] = @id	
	-- End Return Select <- do not remove

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_EntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_EntryDelete] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[Entry]
	WHERE  [id] = @id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

*/

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_EntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_EntrySelect] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [id], [fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate] 
	FROM   [dbo].[Entry] 
	WHERE  ([id] = @id OR @id IS NULL) 

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_EntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_EntryInsert] 
    @fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,
    @modifiedDate datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Entry] ([fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate])
	SELECT @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate
	
	-- Begin Return Select <- do not remove
	SELECT [id], [fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate]
	FROM   [dbo].[Entry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_EntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_EntryUpdate] 
    @id int,
    @fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,
    @modifiedDate datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Entry]
	SET    [fiscalYear] = @fiscalYear, [fiscalMonth] = @fiscalMonth, [reportDate] = @reportDate, [createdBy] = @createdBy, [modifiedBy] = @modifiedBy, [createdDate] = @createdDate, [modifiedDate] = @modifiedDate
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate]
	FROM   [dbo].[Entry]
	WHERE  [id] = @id	
	-- End Return Select <- do not remove

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_EntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_EntryDelete] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[Entry]
	WHERE  [id] = @id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

