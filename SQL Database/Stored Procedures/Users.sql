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

