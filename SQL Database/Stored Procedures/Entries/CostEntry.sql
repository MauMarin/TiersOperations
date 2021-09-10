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

	select e.*, c.*, convert(varchar(20), e.createdDate, 103) as createdDateH, u.name as createdByH from Entry e
    inner join CostEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    where c.id = @idEntry

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
	
	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy
	
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
    @id int, 
	@idEntry int, 
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,

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
	WHERE  [id] = @id

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate
	
	-- Begin Return Select <- do not remove
	SELECT e.*, c.* from Entry e
    inner join CostEntry c on e.id = c.entry
	WHERE  c.entry = @idEntry
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
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.id, e.fiscalYear, e.fiscalMonth, convert(varchar(20), e.reportDate, 101) as reportDate, u.name as createdBy, u2.name as modifiedBy, convert(varchar(20), e.createdDate, 103) as createdDate, convert(varchar(20), e.modifiedDate, 103) as modifiedDate, c.* from Entry e
    inner join CostEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    inner join Users u2 on e.modifiedBy = u2.id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

