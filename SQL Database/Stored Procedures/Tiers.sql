
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

