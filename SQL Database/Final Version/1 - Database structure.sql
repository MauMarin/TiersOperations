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
