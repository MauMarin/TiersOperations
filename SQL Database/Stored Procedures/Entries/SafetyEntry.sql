USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_SafetyEntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyEntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_SafetyEntrySelect] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.* from Entry e
    inner join SafetyEntry c on e.id = c.entry
    where e.id = @idEntry

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_SafetyEntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyEntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_SafetyEntryInsert] 
	--> Entry variables
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,
    @modifiedDate datetime,

	--> Safety variables
    @HOs int,
    @TRIR float,
    @firstAid int,
    @nearMiss int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate
	
	INSERT INTO [dbo].[SafetyEntry] ([HOs], [TRIR], [firstAid], [nearMiss], [entry])
	SELECT @HOs, @TRIR, @firstAid, @nearMiss, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [HOs], [TRIR], [firstAid], [nearMiss], [entry]
	FROM   [dbo].[SafetyEntry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_SafetyEntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyEntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_SafetyEntryUpdate] 
    --> Entry variables
    @idEntry int,
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,
    @modifiedDate datetime,

	--> Safety variables
    @HOs int,
    @TRIR float,
    @firstAid int,
    @nearMiss int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[SafetyEntry]
	SET    [HOs] = @HOs, [TRIR] = @TRIR, [firstAid] = @firstAid, [nearMiss] = @nearMiss, [entry] = @idEntry
	WHERE  [entry] = @idEntry

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate
	
	-- Begin Return Select <- do not remove
	SELECT [id], [HOs], [TRIR], [firstAid], [nearMiss], [entry]
	FROM   [dbo].[SafetyEntry]
	WHERE  [id] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_SafetyEntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyEntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_SafetyEntryDelete] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[SafetyEntry]
	WHERE  [entry] = @idEntry

	exec usp_EntryDelete @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_EntriesBySafety]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntriesBySafety] 
END 
GO
CREATE PROC [dbo].[usp_EntriesBySafety]  
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.id, e.fiscalYear, e.fiscalMonth, e.reportDate, u.name as createdBy, u2.name as modifiedBy, e.createdDate, e.modifiedDate, c.* from Entry e
    inner join SafetyEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    inner join Users u2 on e.modifiedBy = u2.id

	COMMIT
GO

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

