USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_GoalsSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsSelect] 
END 
GO
CREATE PROC [dbo].[usp_GoalsSelect] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [id], [depID], [fiscalYear], [fiscalMonth], [monthly] 
	FROM   [dbo].[Goals] 
	WHERE  ([id] = @id OR @id IS NULL) 

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_GoalsInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsInsert] 
END 
GO
CREATE PROC [dbo].[usp_GoalsInsert] 
    @depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Goals] ([depID], [fiscalYear], [fiscalMonth], [monthly])
	SELECT @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [depID], [fiscalYear], [fiscalMonth], [monthly]
	FROM   [dbo].[Goals]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_GoalsUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsUpdate] 
END 
GO
CREATE PROC [dbo].[usp_GoalsUpdate] 
    @id int,
    @depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Goals]
	SET    [depID] = @depID, [fiscalYear] = @fiscalYear, [fiscalMonth] = @fiscalMonth
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [depID], [fiscalYear], [fiscalMonth]
	FROM   [dbo].[Goals]
	WHERE  [id] = @id	
	-- End Return Select <- do not remove

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_GoalsDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsDelete] 
END 
GO
CREATE PROC [dbo].[usp_GoalsDelete] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[Goals]
	WHERE  [id] = @id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

