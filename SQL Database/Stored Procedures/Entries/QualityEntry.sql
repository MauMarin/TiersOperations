USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_QualityEntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityEntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_QualityEntrySelect] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.* from Entry e
    inner join QualityEntry c on e.id = c.entry
    where e.id = @idEntry

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityEntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityEntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_QualityEntryInsert]
	--> Entry variables
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,
    @modifiedDate datetime,
    @tier int,

	--> Cost variables
    @larOverall float,
    @larHumacao float,
    @larWarsaw float,
    @fpy25 float,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate, @tier
	
	INSERT INTO [dbo].[QualityEntry] ([larOverall], [larHumacao], [larWarsaw], [fpy25], [fly65], [NCROpen], [entry])
	SELECT @larOverall, @larHumacao, @larWarsaw, @fpy25, @fly65, @NCROpen, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [larOverall], [larHumacao], [larWarsaw], [fpy25], [fly65], [NCROpen], [entry]
	FROM   [dbo].[QualityEntry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityEntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityEntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_QualityEntryUpdate] 
    --> Entry variables
	@idEntry int, 
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,
    @modifiedDate datetime,
    @tier int,

	--> Cost variables
    @larOverall float,
    @larHumacao float,
    @larWarsaw float,
    @fpy25 float,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[QualityEntry]
	SET    [larOverall] = @larOverall, [larHumacao] = @larHumacao, [larWarsaw] = @larWarsaw, [fpy25] = @fpy25, [fly65] = @fly65, [NCROpen] = @NCROpen, [entry] = @idEntry
	WHERE  [entry] = @idEntry

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate, @tier
	
	-- Begin Return Select <- do not remove
	SELECT [id], [larOverall], [larHumacao], [larWarsaw], [fpy25], [fly65], [NCROpen], [entry]
	FROM   [dbo].[QualityEntry]
	WHERE  [entry] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityEntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityEntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_QualityEntryDelete] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[QualityEntry]
	WHERE  [entry] = @idEntry

	exec usp_EntryDelete @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_EntriesByQuality]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntriesByQuality] 
END 
GO
CREATE PROC [dbo].[usp_EntriesByQuality]  
    @depID int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.* from Entry e
    inner join QualityEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
	where u.depID = @depID

	COMMIT
GO

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

