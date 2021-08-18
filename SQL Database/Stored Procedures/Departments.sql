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

