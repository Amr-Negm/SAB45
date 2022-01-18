/****** Object:  Table [dbo].[T_Scenarios]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Scenarios](
	[ScenarioID] [int] IDENTITY(1,1) NOT NULL,
	[ScenarioSiteID] [int] NOT NULL,
	[ScenarioTitle1] [nvarchar](200) NULL,
	[ScenarioDescriptionTitle1] [nvarchar](4000) NULL,
	[PriorityID] [int] NOT NULL,
	[ScenarioImpact] [int] NOT NULL,
	[PlanID] [int] NOT NULL,
	[PlanSiteID] [int] NOT NULL,
	[ScenarioCode] [nvarchar](200) NULL,
	[StateID] [int] NULL,
	[StatusID] [int] NULL,
	[DashboardColor] [nvarchar](20) NULL,
 CONSTRAINT [Scenarios_PK] PRIMARY KEY CLUSTERED 
(
	[ScenarioID] ASC,
	[ScenarioSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ScenarioPlan] ON [dbo].[T_Scenarios]
(
	[PlanID] ASC,
	[PlanSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ScenarioPriority] ON [dbo].[T_Scenarios]
(
	[PriorityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_Scenarios]  WITH CHECK ADD  CONSTRAINT [FK_ScenarioPriority] FOREIGN KEY([PriorityID])
REFERENCES [dbo].[LT_Priorities] ([PriorityID])
ALTER TABLE [dbo].[T_Scenarios] CHECK CONSTRAINT [FK_ScenarioPriority]
ALTER TABLE [dbo].[T_Scenarios]  WITH CHECK ADD  CONSTRAINT [FK_ScenariosPlan] FOREIGN KEY([PlanID], [PlanSiteID])
REFERENCES [dbo].[T_Plans] ([PlanID], [PlanSiteID])
ALTER TABLE [dbo].[T_Scenarios] CHECK CONSTRAINT [FK_ScenariosPlan]