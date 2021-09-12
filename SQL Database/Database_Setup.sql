create database TiersOperations;
Go

USE [TiersOperations]
GO
/****** Object:  Table [dbo].[Cards]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cards](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[status] [varchar](10) NOT NULL,
	[dueDate] [date] NOT NULL,
	[deparment] [int] NOT NULL,
	[submittedBy] [int] NOT NULL,
	[directedTo] [int] NOT NULL,
	[actionPlan] [varchar](1000) NULL,
	[createdBy] [int] NOT NULL,
	[modifiedBy] [int] NOT NULL,
	[creationDate] [date] NOT NULL,
	[modifiedDate] [date] NOT NULL,
	[tier] [int] NOT NULL,
	[description] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_Cards] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[CostEntry]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CostEntry](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[scrap] [float] NOT NULL,
	[conversionLoss] [float] NOT NULL,
	[toolConsumption] [float] NOT NULL,
	[toolRate] [float] NOT NULL,
	[earnHours] [int] NOT NULL,
	[energyRate] [float] NOT NULL,
	[entry] [int] NOT NULL,
 CONSTRAINT [PK_CostEntry] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CostGoals]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CostGoals](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[scrap] [float] NOT NULL,
	[conversionLoss] [float] NOT NULL,
	[toolConsumption] [float] NOT NULL,
	[toolRate] [float] NOT NULL,
	[earnHours] [int] NOT NULL,
	[energyRate] [float] NOT NULL,
	[goalID] [int] NOT NULL,
 CONSTRAINT [PK_CostGoals] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](15) NOT NULL,
	[description] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Entry]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entry](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fiscalYear] [varchar](4) NOT NULL,
	[fiscalMonth] [nchar](10) NOT NULL,
	[reportDate] [date] NOT NULL,
	[createdBy] [int] NOT NULL,
	[modifiedBy] [int] NOT NULL,
	[createdDate] [datetime] NOT NULL,
	[modifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Entry] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Goals]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Goals](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[depID] [int] NOT NULL,
	[fiscalYear] [varchar](10) NOT NULL,
	[fiscalMonth] [varchar](10) NOT NULL,
	[monthly] [bit] NOT NULL,
 CONSTRAINT [PK_Goals] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpExEntry]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpExEntry](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[evaluation6S] [int] NOT NULL,
	[trainingOnTime] [float] NOT NULL,
	[completedOnTime] [int] NOT NULL,
	[entry] [int] NOT NULL,
 CONSTRAINT [PK_OpEx] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpExGoal]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpExGoal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eval6S] [int] NOT NULL,
	[tOT] [float] NOT NULL,
	[cOT] [int] NOT NULL,
	[goalID] [int] NOT NULL,
 CONSTRAINT [PK_OpExGoal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QualityEntry]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QualityEntry](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[larOverall] [float] NOT NULL,
	[larHumacao] [float] NOT NULL,
	[larWarsaw] [float] NOT NULL,
	[fly65] [float] NOT NULL,
	[NCROpen] [int] NOT NULL,
	[entry] [int] NOT NULL,
 CONSTRAINT [PK_QualityEntry] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QualityGoal]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QualityGoal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[larOverall] [float] NOT NULL,
	[larHumacao] [float] NOT NULL,
	[larWarsaw] [float] NOT NULL,
	[fly65] [float] NOT NULL,
	[NCROpen] [int] NOT NULL,
	[goalID] [int] NOT NULL,
 CONSTRAINT [PK_QualityGoal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SafetyEntry]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SafetyEntry](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[HOs] [int] NOT NULL,
	[TRIR] [float] NOT NULL,
	[firstAid] [int] NOT NULL,
	[nearMiss] [int] NOT NULL,
	[entry] [int] NOT NULL,
 CONSTRAINT [PK_SafetyEntry] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SafetyGoal]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SafetyGoal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[HOs] [int] NOT NULL,
	[TRIR] [float] NOT NULL,
	[firstAid] [int] NOT NULL,
	[nearMiss] [int] NOT NULL,
	[goalID] [int] NOT NULL,
 CONSTRAINT [PK_SafetyGoal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceEntry]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceEntry](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[op20] [int] NOT NULL,
	[op40] [int] NOT NULL,
	[op60] [int] NOT NULL,
	[op65] [int] NOT NULL,
	[op70] [int] NOT NULL,
	[intervention] [int] NOT NULL,
	[OEE] [float] NOT NULL,
	[entry] [int] NOT NULL,
 CONSTRAINT [PK_ServiceEntry] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceGoal]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceGoal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[op20] [int] NOT NULL,
	[op40] [int] NOT NULL,
	[op60] [int] NOT NULL,
	[op65] [int] NOT NULL,
	[op70] [int] NOT NULL,
	[intervention] [int] NOT NULL,
	[OEE] [float] NOT NULL,
	[goalID] [int] NOT NULL,
 CONSTRAINT [PK_ServiceGoal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tier]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tier](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Tier] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 9/1/2021 19:23:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[depID] [int] NOT NULL,
	[role] [int] NOT NULL,
	[password] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cards]  WITH CHECK ADD  CONSTRAINT [FK_Cards_Department] FOREIGN KEY([deparment])
REFERENCES [dbo].[Department] ([id])
GO
ALTER TABLE [dbo].[Cards] CHECK CONSTRAINT [FK_Cards_Department]
GO
ALTER TABLE [dbo].[Cards]  WITH CHECK ADD  CONSTRAINT [FK_Cards_Tier] FOREIGN KEY([tier])
REFERENCES [dbo].[Tier] ([id])
GO
ALTER TABLE [dbo].[Cards] CHECK CONSTRAINT [FK_Cards_Tier]
GO
ALTER TABLE [dbo].[Cards]  WITH CHECK ADD  CONSTRAINT [FK_Cards_Users] FOREIGN KEY([submittedBy])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Cards] CHECK CONSTRAINT [FK_Cards_Users]
GO
ALTER TABLE [dbo].[CostEntry]  WITH CHECK ADD  CONSTRAINT [FK_CostEntry_Entry] FOREIGN KEY([entry])
REFERENCES [dbo].[Entry] ([id])
GO
ALTER TABLE [dbo].[CostEntry] CHECK CONSTRAINT [FK_CostEntry_Entry]
GO
ALTER TABLE [dbo].[CostGoals]  WITH CHECK ADD  CONSTRAINT [FK_CostGoals_Goals] FOREIGN KEY([goalID])
REFERENCES [dbo].[Goals] ([id])
GO
ALTER TABLE [dbo].[CostGoals] CHECK CONSTRAINT [FK_CostGoals_Goals]
GO
ALTER TABLE [dbo].[Entry]  WITH CHECK ADD  CONSTRAINT [FK_Entry_Users] FOREIGN KEY([createdBy])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Entry] CHECK CONSTRAINT [FK_Entry_Users]
GO
ALTER TABLE [dbo].[Goals]  WITH CHECK ADD  CONSTRAINT [FK_Goals_Department] FOREIGN KEY([depID])
REFERENCES [dbo].[Department] ([id])
GO
ALTER TABLE [dbo].[Goals] CHECK CONSTRAINT [FK_Goals_Department]
GO
ALTER TABLE [dbo].[OpExEntry]  WITH CHECK ADD  CONSTRAINT [FK_OpExEntry_Entry] FOREIGN KEY([entry])
REFERENCES [dbo].[Entry] ([id])
GO
ALTER TABLE [dbo].[OpExEntry] CHECK CONSTRAINT [FK_OpExEntry_Entry]
GO
ALTER TABLE [dbo].[OpExGoal]  WITH CHECK ADD  CONSTRAINT [FK_OpExGoal_Goals] FOREIGN KEY([goalID])
REFERENCES [dbo].[Goals] ([id])
GO
ALTER TABLE [dbo].[OpExGoal] CHECK CONSTRAINT [FK_OpExGoal_Goals]
GO
ALTER TABLE [dbo].[QualityEntry]  WITH CHECK ADD  CONSTRAINT [FK_QualityEntry_Entry] FOREIGN KEY([entry])
REFERENCES [dbo].[Entry] ([id])
GO
ALTER TABLE [dbo].[QualityEntry] CHECK CONSTRAINT [FK_QualityEntry_Entry]
GO
ALTER TABLE [dbo].[QualityGoal]  WITH CHECK ADD  CONSTRAINT [FK_QualityGoal_Goals] FOREIGN KEY([goalID])
REFERENCES [dbo].[Goals] ([id])
GO
ALTER TABLE [dbo].[QualityGoal] CHECK CONSTRAINT [FK_QualityGoal_Goals]
GO
ALTER TABLE [dbo].[SafetyEntry]  WITH CHECK ADD  CONSTRAINT [FK_SafetyEntry_Entry] FOREIGN KEY([entry])
REFERENCES [dbo].[Entry] ([id])
GO
ALTER TABLE [dbo].[SafetyEntry] CHECK CONSTRAINT [FK_SafetyEntry_Entry]
GO
ALTER TABLE [dbo].[SafetyGoal]  WITH CHECK ADD  CONSTRAINT [FK_SafetyGoal_Goals] FOREIGN KEY([goalID])
REFERENCES [dbo].[Goals] ([id])
GO
ALTER TABLE [dbo].[SafetyGoal] CHECK CONSTRAINT [FK_SafetyGoal_Goals]
GO
ALTER TABLE [dbo].[ServiceEntry]  WITH CHECK ADD  CONSTRAINT [FK_ServiceEntry_Entry] FOREIGN KEY([entry])
REFERENCES [dbo].[Entry] ([id])
GO
ALTER TABLE [dbo].[ServiceEntry] CHECK CONSTRAINT [FK_ServiceEntry_Entry]
GO
ALTER TABLE [dbo].[ServiceGoal]  WITH CHECK ADD  CONSTRAINT [FK_ServiceGoal_Goals] FOREIGN KEY([goalID])
REFERENCES [dbo].[Goals] ([id])
GO
ALTER TABLE [dbo].[ServiceGoal] CHECK CONSTRAINT [FK_ServiceGoal_Goals]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Department1] FOREIGN KEY([depID])
REFERENCES [dbo].[Department] ([id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Department1]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Permission] FOREIGN KEY([role])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Permission]
GO



USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_EntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_EntrySelect] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [id], [fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate] 
	FROM   [dbo].[Entry] 
	WHERE  ([id] = @id OR @id IS NULL) 

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_EntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_EntryInsert] 
    @fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Entry] ([fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate])
	SELECT @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, getdate(), getdate()
	
	-- Begin Return Select <- do not remove
	SELECT [id], [fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate]
	FROM   [dbo].[Entry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_EntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_EntryUpdate] 
    @id int,
    @fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Entry]
	SET    [fiscalYear] = @fiscalYear, [fiscalMonth] = @fiscalMonth, [reportDate] = @reportDate, [createdBy] = @createdBy, [modifiedBy] = @modifiedBy, [createdDate] = @createdDate, [modifiedDate] = getdate()
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [fiscalYear], [fiscalMonth], [reportDate], [createdBy], [modifiedBy], [createdDate], [modifiedDate]
	FROM   [dbo].[Entry]
	WHERE  [id] = @id	
	-- End Return Select <- do not remove

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_EntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_EntryDelete] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[Entry]
	WHERE  [id] = @id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_CostEntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostEntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_CostEntrySelect] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.*, convert(varchar(20), e.createdDate, 103) as createdDateH, u.name as createdByH from Entry e
    inner join CostEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    where c.id = @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_CostEntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostEntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_CostEntryInsert] 
	--> Entry variables
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
	--> Cost variables
    @scrap float,
    @conversionLoss float,
    @toolConsumption float,
    @toolRate float,
    @earnHours int,
    @energyRate float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy
	
	INSERT INTO [dbo].[CostEntry] ([scrap], [conversionLoss], [toolConsumption], [toolRate], [earnHours], [energyRate], [entry])
	SELECT @scrap, @conversionLoss, @toolConsumption, @toolRate, @earnHours, @energyRate, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [scrap], [conversionLoss], [toolConsumption], [toolRate], [earnHours], [energyRate], [entry]
	FROM   [dbo].[CostEntry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CostEntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostEntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_CostEntryUpdate] 
    --> Entry variables
    @id int, 
	@idEntry int, 
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,

	--> Cost variables
    @scrap float,
    @conversionLoss float,
    @toolConsumption float,
    @toolRate float,
    @earnHours int,
    @energyRate float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[CostEntry]
	SET    [scrap] = @scrap, [conversionLoss] = @conversionLoss, [toolConsumption] = @toolConsumption, [toolRate] = @toolRate, [earnHours] = @earnHours, [energyRate] = @energyRate, [entry] = @idEntry
	WHERE  [id] = @id

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate
	
	-- Begin Return Select <- do not remove
	SELECT e.*, c.* from Entry e
    inner join CostEntry c on e.id = c.entry
	WHERE  c.entry = @idEntry
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CostEntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostEntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_CostEntryDelete] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[CostEntry]
	WHERE  [entry] = @idEntry

	exec usp_EntryDelete @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_EntriesByCost]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntriesByCost] 
END 
GO
CREATE PROC [dbo].[usp_EntriesByCost]  
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.id, e.fiscalYear, e.fiscalMonth, convert(varchar(20), e.reportDate, 101) as reportDate, u.name as createdBy, u2.name as modifiedBy, convert(varchar(20), e.createdDate, 103) as createdDate, convert(varchar(20), e.modifiedDate, 103) as modifiedDate, c.* from Entry e
    inner join CostEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    inner join Users u2 on e.modifiedBy = u2.id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_OpExEntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExEntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_OpExEntrySelect] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.*, convert(varchar(20), e.createdDate, 103) as createdDateH, u.name as createdByH from Entry e
    inner join OpExEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    where c.id = @idEntry

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExEntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExEntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_OpExEntryInsert] 
	--> Entry variables
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,

	--> OpEx variables
    @evaluation6S int,
    @trainingOnTime float,
    @completedOnTime int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy
	
	INSERT INTO [dbo].[OpExEntry] ([evaluation6S], [trainingOnTime], [completedOnTime], [entry])
	SELECT @evaluation6S, @trainingOnTime, @completedOnTime, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [evaluation6S], [trainingOnTime], [completedOnTime], [entry]
	FROM   [dbo].[OpExEntry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExEntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExEntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_OpExEntryUpdate] 
    --> Entry variables
    @id int,
	@idEntry int, 
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,

	--> OpEx variables
    @evaluation6S int,
    @trainingOnTime float,
    @completedOnTime int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[OpExEntry]
	SET    [evaluation6S] = @evaluation6S, [trainingOnTime] = @trainingOnTime, [completedOnTime] = @completedOnTime, [entry] = @idEntry
	WHERE  [id] = @id

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate
	
	-- Begin Return Select <- do not remove
	SELECT e.*, c.* from Entry e
    inner join OpExEntry c on e.id = c.entry
	WHERE  c.entry = @idEntry	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExEntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExEntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_OpExEntryDelete] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[OpExEntry]
	WHERE  [entry] = @idEntry

	exec usp_EntryDelete @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_EntriesByOpex]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntriesByOpex] 
END 
GO
CREATE PROC [dbo].[usp_EntriesByOpex]  
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.id, e.fiscalYear, e.fiscalMonth, convert(varchar(20), e.reportDate, 101) as reportDate, u.name as createdBy, u2.name as modifiedBy, convert(varchar(20), e.createdDate, 103) as createdDate, convert(varchar(20), e.modifiedDate, 103) as modifiedDate, c.* from Entry e
    inner join OpExEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    inner join Users u2 on e.modifiedBy = u2.id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_ServiceEntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceEntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_ServiceEntrySelect] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.*, convert(varchar(20), e.createdDate, 103) as createdDateH from Entry e
    inner join ServiceEntry c on e.id = c.entry
    where c.id = @idEntry

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceEntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceEntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_ServiceEntryInsert] 
    --> Entry variables
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,

	--> Service variables
	@op20 int,
    @op40 int,
    @op60 int,
    @op65 int,
    @op70 int,
    @intervention int,
    @OEE float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy
	
	INSERT INTO [dbo].[ServiceEntry] ([op20], [op40], [op60], [op65], [op70], [intervention], [OEE], [entry])
	SELECT @op20, @op40, @op60, @op65, @op70, @intervention, @OEE, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [op20], [op40], [op60], [op65], [op70], [intervention], [OEE], [entry]
	FROM   [dbo].[ServiceEntry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceEntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceEntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_ServiceEntryUpdate] 
    --> Entry variables
    @id int,
	@idEntry int, 
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,

	--> Service variables
    @op20 int,
    @op40 int,
    @op60 int,
    @op65 int,
    @op70 int,
    @intervention int,
    @OEE float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[ServiceEntry]
	SET    [op20] = @op20, [op40] = @op40, [op60] = @op60, [op65] = @op65, [op70] = @op70, [intervention] = @intervention, [OEE] = @OEE, [entry] = @idEntry
	WHERE  [id] = @id

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate
	
	-- Begin Return Select <- do not remove
	SELECT e.*, c.* from Entry e
    inner join ServiceEntry c on e.id = c.entry
	WHERE  c.entry = @idEntry		
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceEntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceEntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_ServiceEntryDelete] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[ServiceEntry]
	WHERE  [entry] = @idEntry

	exec usp_EntryDelete @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_EntriesByService]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntriesByService] 
END 
GO
CREATE PROC [dbo].[usp_EntriesByService]  
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.id, e.fiscalYear, e.fiscalMonth, convert(varchar(20), e.reportDate, 101) as reportDate, u.name as createdBy, u2.name as modifiedBy, convert(varchar(20), e.createdDate, 103) as createdDate, convert(varchar(20), e.modifiedDate, 103) as modifiedDate, c.* from Entry e
    inner join ServiceEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    inner join Users u2 on e.modifiedBy = u2.id

	COMMIT
GO

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_SafetyEntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyEntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_SafetyEntrySelect] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.*, convert(varchar(20), e.createdDate, 103) as createdDateH from Entry e
    inner join SafetyEntry c on e.id = c.entry
    where c.id = @idEntry

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_SafetyEntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyEntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_SafetyEntryInsert] 
	--> Entry variables
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,

	--> Safety variables
    @HOs int,
    @TRIR float,
    @firstAid int,
    @nearMiss int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy
	
	INSERT INTO [dbo].[SafetyEntry] ([HOs], [TRIR], [firstAid], [nearMiss], [entry])
	SELECT @HOs, @TRIR, @firstAid, @nearMiss, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [HOs], [TRIR], [firstAid], [nearMiss], [entry]
	FROM   [dbo].[SafetyEntry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_SafetyEntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyEntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_SafetyEntryUpdate] 
    --> Entry variables
    @id int,
    @idEntry int,
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,

	--> Safety variables
    @HOs int,
    @TRIR float,
    @firstAid int,
    @nearMiss int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[SafetyEntry]
	SET    [HOs] = @HOs, [TRIR] = @TRIR, [firstAid] = @firstAid, [nearMiss] = @nearMiss, [entry] = @idEntry
	WHERE  [id] = @id

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate
	
	-- Begin Return Select <- do not remove
	SELECT e.*, c.* from Entry e
    inner join SafetyEntry c on e.id = c.entry
	WHERE  c.entry = @idEntry	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_SafetyEntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_SafetyEntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_SafetyEntryDelete] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[SafetyEntry]
	WHERE  [entry] = @idEntry

	exec usp_EntryDelete @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_EntriesBySafety]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntriesBySafety] 
END 
GO
CREATE PROC [dbo].[usp_EntriesBySafety]  
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.id, e.fiscalYear, e.fiscalMonth, convert(varchar(20), e.reportDate, 101) as reportDate, u.name as createdBy, u2.name as modifiedBy, convert(varchar(20), e.createdDate, 103) as createdDate, convert(varchar(20), e.modifiedDate, 103) as modifiedDate, c.* from Entry e
    inner join SafetyEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    inner join Users u2 on e.modifiedBy = u2.id

	COMMIT
GO

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_QualityEntrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityEntrySelect] 
END 
GO
CREATE PROC [dbo].[usp_QualityEntrySelect] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.*, c.*, convert(varchar(20), e.createdDate, 103) as createdDateH, u.name as createdByH from Entry e
    inner join QualityEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    where c.id = @idEntry

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityEntryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityEntryInsert] 
END 
GO
CREATE PROC [dbo].[usp_QualityEntryInsert]
	--> Entry variables
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,

	--> Cost variables
    @larOverall float,
    @larHumacao float,
    @larWarsaw float,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_EntryInsert @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy
	
	INSERT INTO [dbo].[QualityEntry] ([larOverall], [larHumacao], [larWarsaw], [fly65], [NCROpen], [entry])
	SELECT @larOverall, @larHumacao, @larWarsaw, @fly65, @NCROpen, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [larOverall], [larHumacao], [larWarsaw], [fly65], [NCROpen], [entry]
	FROM   [dbo].[QualityEntry]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityEntryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityEntryUpdate] 
END 
GO
CREATE PROC [dbo].[usp_QualityEntryUpdate] 
    --> Entry variables
    @id int,
	@idEntry int, 
	@fiscalYear varchar(4),
    @fiscalMonth nchar(10),
    @reportDate date,
    @createdBy int,
    @modifiedBy int,
    @createdDate datetime,

	--> Cost variables
    @larOverall float,
    @larHumacao float,
    @larWarsaw float,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[QualityEntry]
	SET    [larOverall] = @larOverall, [larHumacao] = @larHumacao, [larWarsaw] = @larWarsaw, [fly65] = @fly65, [NCROpen] = @NCROpen, [entry] = @idEntry
	WHERE  [id] = @id

	exec usp_EntryUpdate @idEntry, @fiscalYear, @fiscalMonth, @reportDate, @createdBy, @modifiedBy, @createdDate
	
	-- Begin Return Select <- do not remove
	SELECT e.*, c.* from Entry e
    inner join QualityEntry c on e.id = c.entry
	WHERE  c.entry = @idEntry
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityEntryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityEntryDelete] 
END 
GO
CREATE PROC [dbo].[usp_QualityEntryDelete] 
    @idEntry int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[QualityEntry]
	WHERE  [entry] = @idEntry

	exec usp_EntryDelete @idEntry

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_EntriesByQuality]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_EntriesByQuality] 
END 
GO
CREATE PROC [dbo].[usp_EntriesByQuality]  
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select e.id, e.fiscalYear, e.fiscalMonth, convert(varchar(20), e.reportDate, 101) as reportDate, u.name as createdBy, u2.name as modifiedBy, convert(varchar(20), e.createdDate, 103) as createdDate, convert(varchar(20), e.modifiedDate, 103) as modifiedDate, c.* from Entry e
    inner join QualityEntry c on e.id = c.entry
    inner join Users u on e.createdBy = u.id
    inner join Users u2 on e.modifiedBy = u2.id

	COMMIT
GO

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_GoalsSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsSelect] 
END 
GO
CREATE PROC [dbo].[usp_GoalsSelect] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [id], [depID], [fiscalYear], [fiscalMonth], [monthly] 
	FROM   [dbo].[Goals] 
	WHERE  ([id] = @id OR @id IS NULL) 

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_GoalsInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsInsert] 
END 
GO
CREATE PROC [dbo].[usp_GoalsInsert] 
    @depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Goals] ([depID], [fiscalYear], [fiscalMonth], [monthly])
	SELECT @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [depID], [fiscalYear], [fiscalMonth], [monthly]
	FROM   [dbo].[Goals]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_GoalsUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsUpdate] 
END 
GO
CREATE PROC [dbo].[usp_GoalsUpdate] 
    @id int,
    @depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Goals]
	SET    [depID] = @depID, [fiscalYear] = @fiscalYear, [fiscalMonth] = @fiscalMonth, [monthly] = @monthly
	WHERE  [id] = @id
	
	-- Begin Return Select <- do not remove
	SELECT [id], [depID], [fiscalYear], [fiscalMonth], [monthly]
	FROM   [dbo].[Goals]
	WHERE  [id] = @id	
	-- End Return Select <- do not remove

	COMMIT
GO
IF OBJECT_ID('[dbo].[usp_GoalsDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsDelete] 
END 
GO
CREATE PROC [dbo].[usp_GoalsDelete] 
    @id int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[Goals]
	WHERE  [id] = @id

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_CostGoalsSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostGoalsSelect] 
END 
GO
CREATE PROC [dbo].[usp_CostGoalsSelect] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select c.*, e.* from Entry e
	inner join CostGoals c on c.goalID = c.id
	where e.id = @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CostGoalsInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostGoalsInsert] 
END 
GO
CREATE PROC [dbo].[usp_CostGoalsInsert] 
	--> Goal variables
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> Cost variables
    @scrap float,
    @conversionLoss float,
    @toolConsumption float,
    @toolRate float,
    @earnHours int,
    @energyRate float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_GoalsInsert @depID, @fiscalYear, @fiscalMonth, @monthly
	
	INSERT INTO [dbo].[CostGoals] ([scrap], [conversionLoss], [toolConsumption], [toolRate], [earnHours], [energyRate], [goalID])
	SELECT @scrap, @conversionLoss, @toolConsumption, @toolRate, @earnHours, @energyRate, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [scrap], [conversionLoss], [toolConsumption], [toolRate], [earnHours], [energyRate], [goalID]
	FROM   [dbo].[CostGoals]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CostGoalsUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostGoalsUpdate] 
END 
GO
CREATE PROC [dbo].[usp_CostGoalsUpdate] 
	--> Goal variables
	@idGoal int,
    @depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> Cost variables
    @scrap float,
    @conversionLoss float,
    @toolConsumption float,
    @toolRate float,
    @earnHours int,
    @energyRate float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[CostGoals]
	SET    [scrap] = @scrap, [conversionLoss] = @conversionLoss, [toolConsumption] = @toolConsumption, [toolRate] = @toolRate, [earnHours] = @earnHours, [energyRate] = @energyRate, [goalID] = @idGoal
	WHERE  [goalID] = @idGoal

	exec usp_GoalsUpdate @idGoal, @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [scrap], [conversionLoss], [toolConsumption], [toolRate], [earnHours], [energyRate], [goalID]
	FROM   [dbo].[CostGoals]
	WHERE  [id] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_CostGoalsDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_CostGoalsDelete] 
END 
GO
CREATE PROC [dbo].[usp_CostGoalsDelete] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[CostGoals]
	WHERE  [goalID] = @idGoal

	exec usp_GoalsDelete @idGoal

	COMMIT
GO



IF OBJECT_ID('[dbo].[usp_GoalsByCost]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsByCost] 
END 
GO
CREATE PROC [dbo].[usp_GoalsByCost]
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select g.*, d.name, c.* from Goals g
    inner join CostGoals c on g.id = c.goalID
    inner join Department d on d.id = g.depID

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_OpExGoalSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExGoalSelect] 
END 
GO
CREATE PROC [dbo].[usp_OpExGoalSelect] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select c.*, e.* from Entry e
	inner join OpExGoal c on c.goalID = c.id
	where e.id = @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExGoalInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExGoalInsert] 
END 
GO
CREATE PROC [dbo].[usp_OpExGoalInsert] 
    --> Goal variables
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> OpEx variables
	@eval6S int,
    @tOT float,
    @cOT int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_GoalsInsert @depID, @fiscalYear, @fiscalMonth, @monthly
	
	INSERT INTO [dbo].[OpExGoal] ([eval6S], [tOT], [cOT], [goalID])
	SELECT @eval6S, @tOT, @cOT, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [eval6S], [tOT], [cOT], [goalID]
	FROM   [dbo].[OpExGoal]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExGoalUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExGoalUpdate] 
END 
GO
CREATE PROC [dbo].[usp_OpExGoalUpdate] 
    --> Goal variables
	@idGoal int,
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> OpEx variables
	@eval6S int,
    @tOT float,
    @cOT int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[OpExGoal]
	SET    [eval6S] = @eval6S, [tOT] = @tOT, [cOT] = @cOT, [goalID] = @idGoal
	WHERE  [goalID] = @idGoal

	exec usp_GoalsUpdate @idGoal, @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [eval6S], [tOT], [cOT], [goalID]
	FROM   [dbo].[OpExGoal]
	WHERE  [id] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_OpExGoalDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_OpExGoalDelete] 
END 
GO
CREATE PROC [dbo].[usp_OpExGoalDelete] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[OpExGoal]
	WHERE  [goalID] = @idGoal

	exec usp_GoalsDelete @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_GoalsByOpEx]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsByOpEx] 
END 
GO
CREATE PROC [dbo].[usp_GoalsByOpEx]
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select g.*, d.name, c.* from Goals g
    inner join OpExGoal c on g.id = c.goalID
    inner join Department d on d.id = g.depID

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_ServiceGoalSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceGoalSelect] 
END 
GO
CREATE PROC [dbo].[usp_ServiceGoalSelect] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select c.*, e.* from Entry e
	inner join ServiceGoal c on c.goalID = c.id
	where e.id = @idGoal 

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceGoalInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceGoalInsert] 
END 
GO
CREATE PROC [dbo].[usp_ServiceGoalInsert] 
    --> Goal variables
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> Service variables
	@op20 int,
    @op40 int,
    @op60 int,
    @op65 int,
    @op70 int,
    @intervention int,
    @OEE float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_GoalsInsert @depID, @fiscalYear, @fiscalMonth, @monthly
	
	INSERT INTO [dbo].[ServiceGoal] ([op20], [op40], [op60], [op65], [op70], [intervention], [OEE], [goalID])
	SELECT @op20, @op40, @op60, @op65, @op70, @intervention, @OEE, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [op20], [op40], [op60], [op65], [op70], [intervention], [OEE], [goalID]
	FROM   [dbo].[ServiceGoal]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceGoalUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceGoalUpdate] 
END 
GO
CREATE PROC [dbo].[usp_ServiceGoalUpdate] 
    --> Goal variables
	@idGoal int,
    @depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> Service variables
    @op20 int,
    @op40 int,
    @op60 int,
    @op65 int,
    @op70 int,
    @intervention int,
    @OEE float
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[ServiceGoal]
	SET    [op20] = @op20, [op40] = @op40, [op60] = @op60, [op65] = @op65, [op70] = @op70, [intervention] = @intervention, [OEE] = @OEE, [goalID] = @idGoal
	WHERE  [goalID] = @idGoal

	exec usp_GoalsUpdate @idGoal, @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [op20], [op40], [op60], [op65], [op70], [intervention], [OEE], [goalID]
	FROM   [dbo].[ServiceGoal]
	WHERE  [id] = @@IDENTITY	
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_ServiceGoalDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_ServiceGoalDelete] 
END 
GO
CREATE PROC [dbo].[usp_ServiceGoalDelete] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[ServiceGoal]
	WHERE  [goalID] = @idGoal

	exec usp_GoalsDelete @idGoal

	COMMIT
GO

IF OBJECT_ID('[dbo].[usp_GoalsByService]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsByService] 
END 
GO
CREATE PROC [dbo].[usp_GoalsByService]
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select g.*, d.name, c.* from Goals g
    inner join ServiceGoal c on g.id = c.goalID
    inner join Department d on d.id = g.depID

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

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

	exec usp_GoalsUpdate @idGoal, @depID, @fiscalYear, @fiscalMonth, @monthly
	
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


IF OBJECT_ID('[dbo].[usp_GoalsBySafety]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsBySafety] 
END 
GO
CREATE PROC [dbo].[usp_GoalsBySafety]
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select g.*, d.name, c.* from Goals g
    inner join SafetyGoal c on g.id = c.goalID
    inner join Department d on d.id = g.depID

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

USE [TiersOperations];
GO

IF OBJECT_ID('[dbo].[usp_QualityGoalSelect]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityGoalSelect] 
END 
GO
CREATE PROC [dbo].[usp_QualityGoalSelect] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select c.*, e.* from Entry e
	inner join QualityGoal c on c.goalID = c.id
	where e.id = @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityGoalInsert]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityGoalInsert] 
END 
GO
CREATE PROC [dbo].[usp_QualityGoalInsert] 
    --> Goal variables
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> Quality variables
	@larOverall float,
    @larHumacao float,
    @larWarsaw float,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	exec usp_GoalsInsert @depID, @fiscalYear, @fiscalMonth, @monthly
	
	INSERT INTO [dbo].[QualityGoal] ([larOverall], [larHumacao], [larWarsaw], [fly65], [NCROpen], [goalID])
	SELECT @larOverall, @larHumacao, @larWarsaw, @fly65, @NCROpen, @@IDENTITY
	
	-- Begin Return Select <- do not remove
	SELECT [id], [larOverall], [larHumacao], [larWarsaw], [fly65], [NCROpen], [goalID]
	FROM   [dbo].[QualityGoal]
	WHERE  [id] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityGoalUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityGoalUpdate] 
END 
GO
CREATE PROC [dbo].[usp_QualityGoalUpdate] 
	--> Goal variables
	@idGoal int,
	@depID int,
    @fiscalYear varchar(10),
    @fiscalMonth varchar(10),
    @monthly bit,

	--> Quality variables
    @larOverall float,
    @larHumacao float,
    @larWarsaw float,
    @fly65 float,
    @NCROpen int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[QualityGoal]
	SET    [larOverall] = @larOverall, [larHumacao] = @larHumacao, [larWarsaw] = @larWarsaw, [fly65] = @fly65, [NCROpen] = @NCROpen, [goalID] = @idGoal
	WHERE  [goalID] = @idGoal

	exec usp_GoalsUpdate @idGoal, @depID, @fiscalYear, @fiscalMonth, @monthly
	
	-- Begin Return Select <- do not remove
	SELECT [id], [larOverall], [larHumacao], [larWarsaw], [fly65], [NCROpen], [goalID]
	FROM   [dbo].[QualityGoal]
	WHERE  [id] = @@IDENTITY
	-- End Return Select <- do not remove

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_QualityGoalDelete]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_QualityGoalDelete] 
END 
GO
CREATE PROC [dbo].[usp_QualityGoalDelete] 
    @idGoal int
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[QualityGoal]
	WHERE  [goalID] = @idGoal

	exec usp_GoalsDelete @idGoal

	COMMIT
GO


IF OBJECT_ID('[dbo].[usp_GoalsByQuality]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[usp_GoalsByQuality] 
END 
GO
CREATE PROC [dbo].[usp_GoalsByQuality]
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	select g.*, d.name, c.* from Goals g
    inner join QualityGoal c on g.id = c.goalID
    inner join Department d on d.id = g.depID

	COMMIT
GO
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

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

