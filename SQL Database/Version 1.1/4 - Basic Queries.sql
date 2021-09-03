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
		@name = N'User 1',
		@username = N'U1',
		@depID = 1,
		@role = 4,
		@password = N'U1_PWD'
GO

EXEC	[dbo].[usp_UsersInsert]
		@name = N'User 2',
		@username = N'U2',
		@depID = 1,
		@role = 3,
		@password = N'U2_PWD'
GO

EXEC	[dbo].[usp_UsersInsert]
		@name = N'User 3',
		@username = N'U3',
		@depID = 1,
		@role = 2,
		@password = N'U3_PWD'
GO

EXEC	[dbo].[usp_UsersInsert]
		@name = N'User 4',
		@username = N'U4',
		@depID = 2,
		@role = 4,
		@password = N'U4_PWD'
GO

EXEC	[dbo].[usp_UsersInsert]
		@name = N'User 5',
		@username = N'U5',
		@depID = 2,
		@role = 3,
		@password = N'U5_PWD'
GO

EXEC	[dbo].[usp_UsersInsert]
		@name = N'User 6',
		@username = N'U6',
		@depID = 2,
		@role = 2,
		@password = N'U6_PWD'
GO

EXEC	[dbo].[usp_UsersInsert]
		@name = N'User 7',
		@username = N'U7',
		@depID = 3,
		@role = 4,
		@password = N'U7_PWD'
GO

