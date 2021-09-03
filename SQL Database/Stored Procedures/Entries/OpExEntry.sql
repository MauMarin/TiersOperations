USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_OpExEntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExEntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_OpExEntrySelect] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.* from Entry e
    inner join OpExEntry c on e.id = c.entry
    where e.id = @idEntry

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExEntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExEntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_OpExEntryInsert] 
	--> Entry variables
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,
    @modifiedDate datetime,

	--> OpEx variables
    @evaluation6S int,
    @trainingOnTime float,
    @completedOnTime int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate
	
	INSERT INTO [dbo].[OpExEntry] ([evaluation6S], [trainingOnTime], [completedOnTime], [entry])
	SELECT @evaluation6S, @trainingOnTime, @completedOnTime, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [evaluation6S], [trainingOnTime], [completedOnTime], [entry]
	FROM   [dbo].[OpExEntry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExEntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExEntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_OpExEntryUpdate] 
    --> Entry variables
	@idEntry int, 
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,
    @modifiedDate datetime,

	--> OpEx variables
    @evaluation6S int,
    @trainingOnTime float,
    @completedOnTime int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[OpExEntry]
	SET    [evaluation6S] = @evaluation6S, [trainingOnTime] = @trainingOnTime, [completedOnTime] = @completedOnTime, [entry] = @idEntry
	WHERE  [entry] = @idEntry

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate
	
	-- Begin Return Select <- do not remove
	SELECT [id], [evaluation6S], [trainingOnTime], [completedOnTime], [entry]
	FROM   [dbo].[OpExEntry]
	WHERE  [id] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExEntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExEntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_OpExEntryDelete] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[OpExEntry]
	WHERE  [entry] = @idEntry

	exec usp_EntryDelete @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_EntriesByOpex]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntriesByOpex] 
END 
GO
CREATE PROC [dbo].[usp_EntriesByOpex]  
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.id, e.fiscalYear, e.fiscalMonth, e.reportDate, u.name as createdBy, u2.name as modifiedBy, e.createdDate, e.modifiedDate, c.* from Entry e
    inner join OpExEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    inner join Users u2 on e.modifiedBy = u2.id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

