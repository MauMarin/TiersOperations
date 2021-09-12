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
    @fiscalMonth varchar(10),
    @monthly bit
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Goals]
	SET    [depID] = @depID, [fiscalYear] = @fiscalYear, [fiscalMonth] = @fiscalMonth, [monthly] = @monthly
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [depID], [fiscalYear], [fiscalMonth], [monthly]
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

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_CostGoalsSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostGoalsSelect] 
END 
GO
CREATE PROC [dbo].[usp_CostGoalsSelect] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select c.*, e.* from Entry e
	inner join CostGoals c on c.goalID = c.id
	where e.id = @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CostGoalsInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostGoalsInsert] 
END 
GO
CREATE PROC [dbo].[usp_CostGoalsInsert] 
	--> Goal variables
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

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

	exec usp_GoalsInsert @depID, @fiscalYear, @fiscalMonth, @monthly
	
	INSERT INTO [dbo].[CostGoals] ([scrap], [conversionLoss], [toolConsumption], [toolRate], [earnHours], [energyRate], [goalID])
	SELECT @scrap, @conversionLoss, @toolConsumption, @toolRate, @earnHours, @energyRate, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [scrap], [conversionLoss], [toolConsumption], [toolRate], [earnHours], [energyRate], [goalID]
	FROM   [dbo].[CostGoals]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CostGoalsUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostGoalsUpdate] 
END 
GO
CREATE PROC [dbo].[usp_CostGoalsUpdate] 
	--> Goal variables
	@idGoal int,
    @depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

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

	UPDATE [dbo].[CostGoals]
	SET    [scrap] = @scrap, [conversionLoss] = @conversionLoss, [toolConsumption] = @toolConsumption, [toolRate] = @toolRate, [earnHours] = @earnHours, [energyRate] = @energyRate, [goalID] = @idGoal
	WHERE  [goalID] = @idGoal

	exec usp_GoalsUpdate @idGoal, @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [scrap], [conversionLoss], [toolConsumption], [toolRate], [earnHours], [energyRate], [goalID]
	FROM   [dbo].[CostGoals]
	WHERE  [id] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CostGoalsDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostGoalsDelete] 
END 
GO
CREATE PROC [dbo].[usp_CostGoalsDelete] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[CostGoals]
	WHERE  [goalID] = @idGoal

	exec usp_GoalsDelete @idGoal

	COMMIT
GO



IF OBJECT_ID('[dbo].[usp_GoalsByCost]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsByCost] 
END 
GO
CREATE PROC [dbo].[usp_GoalsByCost]
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select g.*, d.name, c.* from Goals g
    inner join CostGoals c on g.id = c.goalID
    inner join Department d on d.id = g.depID

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_OpExGoalSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExGoalSelect] 
END 
GO
CREATE PROC [dbo].[usp_OpExGoalSelect] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select c.*, e.* from Entry e
	inner join OpExGoal c on c.goalID = c.id
	where e.id = @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExGoalInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExGoalInsert] 
END 
GO
CREATE PROC [dbo].[usp_OpExGoalInsert] 
    --> Goal variables
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> OpEx variables
	@eval6S int,
    @tOT float,
    @cOT int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_GoalsInsert @depID, @fiscalYear, @fiscalMonth, @monthly
	
	INSERT INTO [dbo].[OpExGoal] ([eval6S], [tOT], [cOT], [goalID])
	SELECT @eval6S, @tOT, @cOT, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [eval6S], [tOT], [cOT], [goalID]
	FROM   [dbo].[OpExGoal]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExGoalUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExGoalUpdate] 
END 
GO
CREATE PROC [dbo].[usp_OpExGoalUpdate] 
    --> Goal variables
	@idGoal int,
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> OpEx variables
	@eval6S int,
    @tOT float,
    @cOT int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[OpExGoal]
	SET    [eval6S] = @eval6S, [tOT] = @tOT, [cOT] = @cOT, [goalID] = @idGoal
	WHERE  [goalID] = @idGoal

	exec usp_GoalsUpdate @idGoal, @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [eval6S], [tOT], [cOT], [goalID]
	FROM   [dbo].[OpExGoal]
	WHERE  [id] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExGoalDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExGoalDelete] 
END 
GO
CREATE PROC [dbo].[usp_OpExGoalDelete] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[OpExGoal]
	WHERE  [goalID] = @idGoal

	exec usp_GoalsDelete @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_GoalsByOpEx]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsByOpEx] 
END 
GO
CREATE PROC [dbo].[usp_GoalsByOpEx]
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select g.*, d.name, c.* from Goals g
    inner join OpExGoal c on g.id = c.goalID
    inner join Department d on d.id = g.depID

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_ServiceGoalSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceGoalSelect] 
END 
GO
CREATE PROC [dbo].[usp_ServiceGoalSelect] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select c.*, e.* from Entry e
	inner join ServiceGoal c on c.goalID = c.id
	where e.id = @idGoal 

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceGoalInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceGoalInsert] 
END 
GO
CREATE PROC [dbo].[usp_ServiceGoalInsert] 
    --> Goal variables
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

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

	exec usp_GoalsInsert @depID, @fiscalYear, @fiscalMonth, @monthly
	
	INSERT INTO [dbo].[ServiceGoal] ([op20], [op40], [op60], [op65], [op70], [intervention], [OEE], [goalID])
	SELECT @op20, @op40, @op60, @op65, @op70, @intervention, @OEE, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [op20], [op40], [op60], [op65], [op70], [intervention], [OEE], [goalID]
	FROM   [dbo].[ServiceGoal]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceGoalUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceGoalUpdate] 
END 
GO
CREATE PROC [dbo].[usp_ServiceGoalUpdate] 
    --> Goal variables
	@idGoal int,
    @depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

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

	UPDATE [dbo].[ServiceGoal]
	SET    [op20] = @op20, [op40] = @op40, [op60] = @op60, [op65] = @op65, [op70] = @op70, [intervention] = @intervention, [OEE] = @OEE, [goalID] = @idGoal
	WHERE  [goalID] = @idGoal

	exec usp_GoalsUpdate @idGoal, @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [op20], [op40], [op60], [op65], [op70], [intervention], [OEE], [goalID]
	FROM   [dbo].[ServiceGoal]
	WHERE  [id] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceGoalDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceGoalDelete] 
END 
GO
CREATE PROC [dbo].[usp_ServiceGoalDelete] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[ServiceGoal]
	WHERE  [goalID] = @idGoal

	exec usp_GoalsDelete @idGoal

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_GoalsByService]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsByService] 
END 
GO
CREATE PROC [dbo].[usp_GoalsByService]
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select g.*, d.name, c.* from Goals g
    inner join ServiceGoal c on g.id = c.goalID
    inner join Department d on d.id = g.depID

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_SafetyGoalSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyGoalSelect] 
END 
GO
CREATE PROC [dbo].[usp_SafetyGoalSelect] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select c.*, e.* from Entry e
	inner join SafetyGoal c on c.goalID = c.id
	where e.id = @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_SafetyGoalInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyGoalInsert] 
END 
GO
CREATE PROC [dbo].[usp_SafetyGoalInsert] 
    --> Goal variables
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> Safety variables
	@HOs int,
    @TRIR float,
    @firstAid int,
    @nearMiss int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_GoalsInsert @depID, @fiscalYear, @fiscalMonth, @monthly
	
	INSERT INTO [dbo].[SafetyGoal] ([HOs], [TRIR], [firstAid], [nearMiss], [goalID])
	SELECT @HOs, @TRIR, @firstAid, @nearMiss, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [HOs], [TRIR], [firstAid], [nearMiss], [goalID]
	FROM   [dbo].[SafetyGoal]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_SafetyGoalUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyGoalUpdate] 
END 
GO
CREATE PROC [dbo].[usp_SafetyGoalUpdate] 
    --> Goal variables
	@idGoal int,
    @depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> Cost variables
    @HOs int,
    @TRIR float,
    @firstAid int,
    @nearMiss int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[SafetyGoal]
	SET    [HOs] = @HOs, [TRIR] = @TRIR, [firstAid] = @firstAid, [nearMiss] = @nearMiss, [goalID] = @idGoal
	WHERE  [goalID] = @idGoal

	exec usp_GoalsUpdate @idGoal, @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [HOs], [TRIR], [firstAid], [nearMiss], [goalID]
	FROM   [dbo].[SafetyGoal]
	WHERE  [id] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_SafetyGoalDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyGoalDelete] 
END 
GO
CREATE PROC [dbo].[usp_SafetyGoalDelete] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[SafetyGoal]
	WHERE  [goalID] = @idGoal

	exec usp_GoalsDelete @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_GoalsBySafety]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsBySafety] 
END 
GO
CREATE PROC [dbo].[usp_GoalsBySafety]
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select g.*, d.name, c.* from Goals g
    inner join SafetyGoal c on g.id = c.goalID
    inner join Department d on d.id = g.depID

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_QualityGoalSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityGoalSelect] 
END 
GO
CREATE PROC [dbo].[usp_QualityGoalSelect] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select c.*, e.* from Entry e
	inner join QualityGoal c on c.goalID = c.id
	where e.id = @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityGoalInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityGoalInsert] 
END 
GO
CREATE PROC [dbo].[usp_QualityGoalInsert] 
    --> Goal variables
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> Quality variables
	@larOverall float,
    @larHumacao float,
    @larWarsaw float,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_GoalsInsert @depID, @fiscalYear, @fiscalMonth, @monthly
	
	INSERT INTO [dbo].[QualityGoal] ([larOverall], [larHumacao], [larWarsaw], [fly65], [NCROpen], [goalID])
	SELECT @larOverall, @larHumacao, @larWarsaw, @fly65, @NCROpen, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [larOverall], [larHumacao], [larWarsaw], [fly65], [NCROpen], [goalID]
	FROM   [dbo].[QualityGoal]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityGoalUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityGoalUpdate] 
END 
GO
CREATE PROC [dbo].[usp_QualityGoalUpdate] 
	--> Goal variables
	@idGoal int,
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> Quality variables
    @larOverall float,
    @larHumacao float,
    @larWarsaw float,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[QualityGoal]
	SET    [larOverall] = @larOverall, [larHumacao] = @larHumacao, [larWarsaw] = @larWarsaw, [fly65] = @fly65, [NCROpen] = @NCROpen, [goalID] = @idGoal
	WHERE  [goalID] = @idGoal

	exec usp_GoalsUpdate @idGoal, @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [larOverall], [larHumacao], [larWarsaw], [fly65], [NCROpen], [goalID]
	FROM   [dbo].[QualityGoal]
	WHERE  [id] = @@IDENTITY
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityGoalDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityGoalDelete] 
END 
GO
CREATE PROC [dbo].[usp_QualityGoalDelete] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[QualityGoal]
	WHERE  [goalID] = @idGoal

	exec usp_GoalsDelete @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_GoalsByQuality]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsByQuality] 
END 
GO
CREATE PROC [dbo].[usp_GoalsByQuality]
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select g.*, d.name, c.* from Goals g
    inner join QualityGoal c on g.id = c.goalID
    inner join Department d on d.id = g.depID

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

