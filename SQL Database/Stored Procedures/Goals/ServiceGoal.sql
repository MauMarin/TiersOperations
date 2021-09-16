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
	inner join ServiceGoal c on c.goalID = e.id
	where c.id = @idGoal 

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

