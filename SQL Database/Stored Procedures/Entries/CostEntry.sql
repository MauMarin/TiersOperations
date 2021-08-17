USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_CostEntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostEntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_CostEntrySelect] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.* from Entry e
    inner join CostEntry c on e.id = c.entry
    where e.id = @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_CostEntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostEntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_CostEntryInsert] 
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
    @scrap float,
    @conversionLoss float,
    @toolConsumption float,
    @toolRate float,
    @earnHours int,
    @energyRate float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate, @tier
	
	INSERT INTO [dbo].[CostEntry] ([scrap], [conversionLoss], [toolConsumption], [toolRate], [earnHours], [energyRate], [entry])
	SELECT @scrap, @conversionLoss, @toolConsumption, @toolRate, @earnHours, @energyRate, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [scrap], [conversionLoss], [toolConsumption], [toolRate], [earnHours], [energyRate], [entry]
	FROM   [dbo].[CostEntry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CostEntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostEntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_CostEntryUpdate] 
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
    @scrap float,
    @conversionLoss float,
    @toolConsumption float,
    @toolRate float,
    @earnHours int,
    @energyRate float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[CostEntry]
	SET    [scrap] = @scrap, [conversionLoss] = @conversionLoss, [toolConsumption] = @toolConsumption, [toolRate] = @toolRate, [earnHours] = @earnHours, [energyRate] = @energyRate, [entry] = @idEntry
	WHERE  [entry] = @idEntry

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate, @tier
	
	-- Begin Return Select <- do not remove
	SELECT [id], [scrap], [conversionLoss], [toolConsumption], [toolRate], [earnHours], [energyRate], [entry]
	FROM   [dbo].[CostEntry]
	WHERE  [entry] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CostEntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostEntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_CostEntryDelete] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[CostEntry]
	WHERE  [entry] = @idEntry

	exec usp_EntryDelete @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_EntriesByCost]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntriesByCost] 
END 
GO
CREATE PROC [dbo].[usp_EntriesByCost]  
    @depID int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.* from Entry e
    inner join CostEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
	where u.depID = @depID

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

