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

