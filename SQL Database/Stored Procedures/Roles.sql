
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

