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

