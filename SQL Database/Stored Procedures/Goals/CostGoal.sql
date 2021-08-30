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

