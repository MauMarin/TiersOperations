USE [TiersOperations]
GO

-- Departments
EXEC	[dbo].[usp_DepartmentInsert]
		@name = N'Cost',
		@description = N'Cost department stuff'

GO

EXEC	[dbo].[usp_DepartmentInsert]
		@name = N'OpEx',
		@description = N'OpEx department stuff'

GO

EXEC	[dbo].[usp_DepartmentInsert]
		@name = N'Quality',
		@description = N'Quality department stuff'

GO

EXEC	[dbo].[usp_DepartmentInsert]
		@name = N'Safety',
		@description = N'Safety department stuff'

GO

EXEC	[dbo].[usp_DepartmentInsert]
		@name = N'Service',
		@description = N'Service department stuff'

GO

EXEC	[dbo].[usp_DepartmentInsert]
		@name = N'Service',
		@description = N'Service department stuff'

GO


-- Roles
EXEC	[dbo].[usp_RoleInsert]
		@name = N'Guest',
		@description = N'User that is not logged in. Can view data, but cannot insert anything'
GO

EXEC	[dbo].[usp_RoleInsert]
		@name = N'Default',
		@description = N'Normal user; can insert entries in their respective department'
GO

EXEC	[dbo].[usp_RoleInsert]
		@name = N'Manager',
		@description = N'Can view any and every entry, plus can edit goals'
GO

EXEC	[dbo].[usp_RoleInsert]
		@name = N'Administrator',
		@description = N'Can manage user permissions'
GO


--Tiers
EXEC	[dbo].[usp_TierInsert]
		@name = N'Tier 1',
		@description = N'Tier 1 stuff'
GO

EXEC	[dbo].[usp_TierInsert]
		@name = N'Tier 2',
		@description = N'Tier 2 stuff'
GO

EXEC	[dbo].[usp_TierInsert]
		@name = N'Tier 3',
		@description = N'Tier 3 stuff'
GO

USE [TiersOperations]
GO

EXEC	[dbo].[usp_UsersInsert]
		@name = N'Super User',
		@username = N'SU',
		@depID = 1,
		@role = 4,
		@password = N'medtronic2021'
GO

