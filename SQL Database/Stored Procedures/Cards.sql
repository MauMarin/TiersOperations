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

	SELECT [id], [status], [dueDate], [deparment], [submittedBy], [directedTo], [actionPlan], [createdBy], [modifiedBy], [creationDate], [modifiedDate], [tier], [description] 
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
    @description varchar(1000),
    @submittedBy int,
    @directedTo int,
    @actionPlan varchar(1000) = NULL,
    @createdBy int,
    @modifiedBy int,
    @tier int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Cards] ([status], [dueDate], [deparment], [submittedBy], [directedTo], [actionPlan], [createdBy], [modifiedBy], [creationDate], [modifiedDate], [tier], [description])
	SELECT @status, @dueDate, @deparment, @submittedBy, @directedTo, @actionPlan, @createdBy, @modifiedBy, getdate(), getdate(), @tier, @description
	
	-- Begin Return Select <- do not remove
	SELECT [id], [status], [dueDate], [deparment], [submittedBy], [directedTo], [actionPlan], [createdBy], [modifiedBy], [creationDate], [modifiedDate], [tier], [description]
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
    @actionPlan varchar(1000) = NULL,
    @createdBy int,
    @modifiedBy int,
    @creationDate date,
    @tier int,
    @description varchar(1000)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Cards]
	SET    [status] = @status, [dueDate] = @dueDate, [deparment] = @deparment, [submittedBy] = @submittedBy, [directedTo] = @directedTo, [actionPlan] = @actionPlan, [createdBy] = @createdBy, [modifiedBy] = @modifiedBy, [creationDate] = @creationDate, [modifiedDate] = getdate(), [tier] = @tier, [description] = @description
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [status], [dueDate], [deparment], [submittedBy], [directedTo], [actionPlan], [createdBy], [modifiedBy], [creationDate], [modifiedDate], [tier], [description]
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


	select c.id, c.actionPlan, c.description, u1.name as submittedBy, convert(varchar(20), c.creationDate, 101) as creationDate, d.name as deparment, u2.name as directedTo, convert(varchar(20), c.dueDate, 101) as dueDate, u4.name as modifiedBy, convert(varchar(20), c.modifiedDate, 101) AS modifiedDate, c.status, u3.name as createdBy, c.tier from Cards c
	inner join Users u1 on c.submittedBy = u1.id
	inner join Users u2 on c.directedTo = u2.id
	inner join Users u3 on c.createdBy = u3.id
	inner join Users u4 on c.modifiedBy = u4.id
	inner join Department d on c.deparment = d.id
	where c.status = @status
	

	--select c.* from Cards c
	--where c.status = @status
	
	COMMIT
GO