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

	--> Cost variables
    @larOverall float,
    @larHumacao float,
    @larWarsaw float,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate
	
	INSERT INTO [dbo].[QualityEntry] ([larOverall], [larHumacao], [larWarsaw], [fly65], [NCROpen], [entry])
	SELECT @larOverall, @larHumacao, @larWarsaw, @fly65, @NCROpen, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [larOverall], [larHumacao], [larWarsaw], [fly65], [NCROpen], [entry]
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

	--> Cost variables
    @larOverall float,
    @larHumacao float,
    @larWarsaw float,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[QualityEntry]
	SET    [larOverall] = @larOverall, [larHumacao] = @larHumacao, [larWarsaw] = @larWarsaw, [fly65] = @fly65, [NCROpen] = @NCROpen, [entry] = @idEntry
	WHERE  [entry] = @idEntry

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate
	
	-- Begin Return Select <- do not remove
	SELECT [id], [larOverall], [larHumacao], [larWarsaw], [fly65], [NCROpen], [entry]
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
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.id, e.fiscalYear, e.fiscalMonth, e.reportDate, u.name as createdBy, u2.name as modifiedBy, e.createdDate, e.modifiedDate, c.* from Entry e
    inner join QualityEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    inner join Users u2 on e.modifiedBy = u2.id

	COMMIT
GO

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

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

	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate
	
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
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.id, e.fiscalYear, e.fiscalMonth, e.reportDate, u.name as createdBy, u2.name as modifiedBy, e.createdDate, e.modifiedDate, c.* from Entry e
    inner join ServiceEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    inner join Users u2 on e.modifiedBy = u2.id

	COMMIT
GO

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

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
	
	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate
	
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

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate, @modifiedDate
	
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
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.id, e.fiscalYear, e.fiscalMonth, e.reportDate, u.name as createdBy, u2.name as modifiedBy, e.createdDate, e.modifiedDate, c.* from Entry e
    inner join CostEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    inner join Users u2 on e.modifiedBy = u2.id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

