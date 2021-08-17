USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_ServiceEntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceEntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_ServiceEntrySelect] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.* from Entry e
    inner join ServiceEntry c on e.id = c.entry
    where e.id = @idEntry 

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceEntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceEntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_ServiceEntryInsert] 
    --> Entry variables
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,
    @modifiedDate datetime,
    @tier int,

	--> Service variables
	@op20 int,
    @op40 int,
    @op60 int,
    @op65 int,
    @op70 int,
    @intervention int,
    @OEE float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate, @tier
	
	INSERT INTO [dbo].[ServiceEntry] ([op20], [op40], [op60], [op65], [op70], [intervention], [OEE], [entry])
	SELECT @op20, @op40, @op60, @op65, @op70, @intervention, @OEE, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [op20], [op40], [op60], [op65], [op70], [intervention], [OEE], [entry]
	FROM   [dbo].[ServiceEntry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceEntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceEntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_ServiceEntryUpdate] 
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

	--> Service variables
    @op20 int,
    @op40 int,
    @op60 int,
    @op65 int,
    @op70 int,
    @intervention int,
    @OEE float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[ServiceEntry]
	SET    [op20] = @op20, [op40] = @op40, [op60] = @op60, [op65] = @op65, [op70] = @op70, [intervention] = @intervention, [OEE] = @OEE, [entry] = @idEntry
	WHERE  [entry] = @idEntry
	
	-- Begin Return Select <- do not remove
	SELECT [id], [op20], [op40], [op60], [op65], [op70], [intervention], [OEE], [entry]
	FROM   [dbo].[ServiceEntry]
	WHERE  [id] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceEntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceEntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_ServiceEntryDelete] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[ServiceEntry]
	WHERE  [entry] = @idEntry

	exec usp_EntryDelete @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_EntriesByService]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntriesByService] 
END 
GO
CREATE PROC [dbo].[usp_EntriesByService]  
    @depID int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.* from Entry e
    inner join ServiceEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
	where u.depID = @depID

	COMMIT
GO

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

