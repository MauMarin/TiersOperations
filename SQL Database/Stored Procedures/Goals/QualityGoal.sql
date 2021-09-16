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
	inner join QualityGoal c on c.goalID = e.id
	where c.id = @idGoal

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

