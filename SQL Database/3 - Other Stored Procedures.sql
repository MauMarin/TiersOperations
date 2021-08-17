/*
Department
*/

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

/*
Roles
*/


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

/*
Tiers
*/


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


/*
Users
*/

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
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

