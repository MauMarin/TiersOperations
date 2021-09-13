USE [TiersOperations];
GO

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

IF OBJECT_ID('[dbo].[usp_AllDepartments	]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_AllDepartments] 
END 
GO
CREATE PROC [dbo].[usp_AllDepartments] 

AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT * FROM Department

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------


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

	SELECT c.*, d.name
	FROM   [dbo].[Cards] c
	inner join Department d on c.deparment = d.id
	WHERE  (c.[id] = @id OR @id IS NULL) 

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
GOUSE [TiersOperations];
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

	select u.*, r.name as 'RoleName' from Users u
	inner join Role r on u.role = r.id
	where u.username = @username
	AND u.password = @password



	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_GetAllUsers]') IS NOT NULL
BEGIN
	DROP PROC [dbo].[usp_GetAllUsers]
END
GO
CREATE PROC [dbo].[usp_GetAllUsers]
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select u.id, u.name, u.username, d.name as "Department", r.name as "Role" from Users u
	inner join Department d on u.depID = d.id
    inner join Role r on u.role = r.id
    order by d.name asc

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

