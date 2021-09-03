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
    @fpy25 int,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_GoalsInsert @depID, @fiscalYear, @fiscalMonth, @monthly
	
	INSERT INTO [dbo].[QualityGoal] ([larOverall], [larHumacao], [larWarsaw], [fpy25], [fly65], [NCROpen], [goalID])
	SELECT @larOverall, @larHumacao, @larWarsaw, @fpy25, @fly65, @NCROpen, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [larOverall], [larHumacao], [larWarsaw], [fpy25], [fly65], [NCROpen], [goalID]
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
    @fpy25 int,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[QualityGoal]
	SET    [larOverall] = @larOverall, [larHumacao] = @larHumacao, [larWarsaw] = @larWarsaw, [fpy25] = @fpy25, [fly65] = @fly65, [NCROpen] = @NCROpen, [goalID] = @idGoal
	WHERE  [goalID] = @idGoal

	exec usp_GoalsUpdate @idGoal, @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [larOverall], [larHumacao], [larWarsaw], [fpy25], [fly65], [NCROpen], [goalID]
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
    @OEE float,
    @goalID int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[ServiceGoal]
	SET    [op20] = @op20, [op40] = @op40, [op60] = @op60, [op65] = @op65, [op70] = @op70, [intervention] = @intervention, [OEE] = @OEE, [goalID] = @goalID
	WHERE  [goalID] = @idGoal
	
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
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_DepartmentSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_DepartmentSelect] 
END 
GO
CREATE PROC [dbo].[usp_DepartmentSelect] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [id], [name], [description] 
	FROM   [dbo].[Department] 
	WHERE  ([id] = @id OR @id IS NULL) 

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_DepartmentInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_DepartmentInsert] 
END 
GO
CREATE PROC [dbo].[usp_DepartmentInsert] 
    @name varchar(15),
    @description varchar(100)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Department] ([name], [description])
	SELECT @name, @description
	
	-- Begin Return Select <- do not remove
	SELECT [id], [name], [description]
	FROM   [dbo].[Department]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_DepartmentUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_DepartmentUpdate] 
END 
GO
CREATE PROC [dbo].[usp_DepartmentUpdate] 
    @id int,
    @name varchar(15),
    @description varchar(100)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Department]
	SET    [name] = @name, [description] = @description
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [name], [description]
	FROM   [dbo].[Department]
	WHERE  [id] = @id	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_DepartmentDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_DepartmentDelete] 
END 
GO
CREATE PROC [dbo].[usp_DepartmentDelete] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[Department]
	WHERE  [id] = @id

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_AllDepartments	]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_AllDepartments] 
END 
GO
CREATE PROC [dbo].[usp_AllDepartments] 

AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT * FROM Department

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


IF OBJECT_ID('[dbo].[usp_RoleSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_RoleSelect] 
END 
GO
CREATE PROC [dbo].[usp_RoleSelect] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [id], [name], [description] 
	FROM   [dbo].[Role] 
	WHERE  ([id] = @id OR @id IS NULL) 

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_RoleInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_RoleInsert] 
END 
GO
CREATE PROC [dbo].[usp_RoleInsert] 
    @name varchar(50),
    @description varchar(50)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Role] ([name], [description])
	SELECT @name, @description
	
	-- Begin Return Select <- do not remove
	SELECT [id], [name], [description]
	FROM   [dbo].[Role]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_RoleUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_RoleUpdate] 
END 
GO
CREATE PROC [dbo].[usp_RoleUpdate] 
    @id int,
    @name varchar(50),
    @description varchar(50)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Role]
	SET    [name] = @name, [description] = @description
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [name], [description]
	FROM   [dbo].[Role]
	WHERE  [id] = @id	
	-- End Return Select <- do not remove

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_RoleDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_RoleDelete] 
END 
GO
CREATE PROC [dbo].[usp_RoleDelete] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[Role]
	WHERE  [id] = @id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


IF OBJECT_ID('[dbo].[usp_TierSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_TierSelect] 
END 
GO
CREATE PROC [dbo].[usp_TierSelect] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [id], [name], [description] 
	FROM   [dbo].[Tier] 
	WHERE  ([id] = @id OR @id IS NULL) 

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_TierInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_TierInsert] 
END 
GO
CREATE PROC [dbo].[usp_TierInsert] 
    @name varchar(50),
    @description varchar(50)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Tier] ([name], [description])
	SELECT @name, @description
	
	-- Begin Return Select <- do not remove
	SELECT [id], [name], [description]
	FROM   [dbo].[Tier]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_TierUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_TierUpdate] 
END 
GO
CREATE PROC [dbo].[usp_TierUpdate] 
    @id int,
    @name varchar(50),
    @description varchar(50)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Tier]
	SET    [name] = @name, [description] = @description
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [name], [description]
	FROM   [dbo].[Tier]
	WHERE  [id] = @id	
	-- End Return Select <- do not remove

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_TierDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_TierDelete] 
END 
GO
CREATE PROC [dbo].[usp_TierDelete] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[Tier]
	WHERE  [id] = @id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_UsersSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_UsersSelect] 
END 
GO
CREATE PROC [dbo].[usp_UsersSelect] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [id], [name], [username], [depID], [role], [password] 
	FROM   [dbo].[Users] 
	WHERE  ([id] = @id OR @id IS NULL) 

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_UsersInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_UsersInsert] 
END 
GO


CREATE PROC [dbo].[usp_UsersInsert] 
    @name varchar(50),
    @username varchar(50),
    @depID int,
    @role int,
    @password varchar(20)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Users] ([name], [username], [depID], [role], [password])
	SELECT @name, @username, @depID, @role, @password
	
	-- Begin Return Select <- do not remove
	SELECT [id], [name], [username], [depID], [role], [password]
	FROM   [dbo].[Users]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_UsersUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_UsersUpdate] 
END 
GO


CREATE PROC [dbo].[usp_UsersUpdate] 
    @id int,
    @name varchar(50),
    @username varchar(50),
    @depID int,
    @role int,
    @password varchar(20)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Users]
	SET    [name] = @name, [username] = @username, [depID] = @depID, [role] = @role, [password] = @password
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [name], [username], [depID], [role], [password]
	FROM   [dbo].[Users]
	WHERE  [id] = @id	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_UsersDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_UsersDelete] 
END 
GO
CREATE PROC [dbo].[usp_UsersDelete] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[Users]
	WHERE  [id] = @id

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_UsersByDep]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_UsersByDep] 
END 
GO
CREATE PROC [dbo].[usp_UsersByDep]  
    @depID int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select u.* from Users u
	where u.depID = @depID
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ValidateUser]') IS NOT NULL
BEGIN
	DROP PROC [dbo].[usp_ValidateUser]
END
GO
CREATE PROC [dbo].[usp_ValidateUser]
	@username varchar(50),
    @password varchar(20)
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select u.* from Users u
	where u.username = @username
	AND u.password = @password



	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_CardsSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CardsSelect] 
END 
GO
CREATE PROC [dbo].[usp_CardsSelect] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [id], [status], [dueDate], [deparment], [submittedBy], [directedTo], [actionPlan], [createdBy], [modifiedBy], [creationDate], [modifiedDate], [currID], [tier] 
	FROM   [dbo].[Cards] 
	WHERE  ([id] = @id OR @id IS NULL) 

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CardsInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CardsInsert] 
END 
GO
CREATE PROC [dbo].[usp_CardsInsert] 
    @status varchar(10),
    @dueDate date,
    @deparment int,
    @submittedBy int,
    @directedTo int,
    @actionPlan varchar(150) = NULL,
    @createdBy int,
    @modifiedBy int,
    @creationDate date,
    @modifiedDate date,
    @currID int,
    @tier int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Cards] ([status], [dueDate], [deparment], [submittedBy], [directedTo], [actionPlan], [createdBy], [modifiedBy], [creationDate], [modifiedDate], [currID], [tier])
	SELECT @status, @dueDate, @deparment, @submittedBy, @directedTo, @actionPlan, @createdBy, @modifiedBy, @creationDate, @modifiedDate, @currID, @tier
	
	-- Begin Return Select <- do not remove
	SELECT [id], [status], [dueDate], [deparment], [submittedBy], [directedTo], [actionPlan], [createdBy], [modifiedBy], [creationDate], [modifiedDate], [currID], [tier]
	FROM   [dbo].[Cards]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CardsUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CardsUpdate] 
END 
GO
CREATE PROC [dbo].[usp_CardsUpdate] 
    @id int,
    @status varchar(10),
    @dueDate date,
    @deparment int,
    @submittedBy int,
    @directedTo int,
    @actionPlan varchar(150) = NULL,
    @createdBy int,
    @modifiedBy int,
    @creationDate date,
    @modifiedDate date,
    @currID int,
    @tier int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Cards]
	SET    [status] = @status, [dueDate] = @dueDate, [deparment] = @deparment, [submittedBy] = @submittedBy, [directedTo] = @directedTo, [actionPlan] = @actionPlan, [createdBy] = @createdBy, [modifiedBy] = @modifiedBy, [creationDate] = @creationDate, [modifiedDate] = @modifiedDate, [currID] = @currID, [tier] = @tier
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [status], [dueDate], [deparment], [submittedBy], [directedTo], [actionPlan], [createdBy], [modifiedBy], [creationDate], [modifiedDate], [currID], [tier]
	FROM   [dbo].[Cards]
	WHERE  [id] = @id	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CardsDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CardsDelete] 
END 
GO
CREATE PROC [dbo].[usp_CardsDelete] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[Cards]
	WHERE  [id] = @id

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ChangeStatus]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ChangeStatus] 
END 
GO
CREATE PROC [dbo].[usp_ChangeStatus] 
    @idCard int,
    @status varchar(10)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Cards]
	SET    [status] = @status
	WHERE  [id] = @idCard
	
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_GetByStatus]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GetByStatus] 
END 
GO
CREATE PROC [dbo].[usp_GetByStatus] 
    @status varchar(10)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	select c.* from Cards c
	where c.status = @status
	
	COMMIT
GO