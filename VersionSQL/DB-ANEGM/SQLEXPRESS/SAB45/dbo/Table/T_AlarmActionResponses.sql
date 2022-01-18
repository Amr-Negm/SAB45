/****** Object:  Table [dbo].[T_AlarmActionResponses]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_AlarmActionResponses](
	[AlarmActionResponseID] [int] IDENTITY(1,1) NOT NULL,
	[AlarmScenarioID] [int] NOT NULL,
	[AlarmID] [int] NOT NULL,
	[AlarmSiteID] [int] NOT NULL,
	[ScenarioID] [int] NOT NULL,
	[ScenarioSiteID] [int] NOT NULL,
	[ActionResponse] [int] NULL,
	[ActionResponseDate] [datetime] NULL,
	[ActionTitle1] [nvarchar](200) NULL,
	[ActionSubject] [nvarchar](150) NULL,
	[ActionBody] [nvarchar](max) NULL,
	[ActionPerformTime] [int] NULL,
	[ActionDescriptionTitle1] [nvarchar](4000) NULL,
	[DesignerItemId] [nvarchar](50) NULL,
	[ActionBehaviorID] [int] NULL,
	[ActionTypeID] [int] NULL,
	[ActionCategoryID] [int] NULL,
	[UserGroupID] [int] NULL,
	[PlanID] [int] NULL,
	[PlanSiteID] [int] NULL,
	[UserGroupName] [nvarchar](200) NULL,
	[GroupItems] [nvarchar](max) NULL,
 CONSTRAINT [AlarmActionResponses_PK] PRIMARY KEY CLUSTERED 
(
	[AlarmID] ASC,
	[ScenarioID] ASC,
	[AlarmSiteID] ASC,
	[ScenarioSiteID] ASC,
	[AlarmScenarioID] ASC,
	[AlarmActionResponseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_AlarmActionResponseActionBehavior] ON [dbo].[T_AlarmActionResponses]
(
	[ActionBehaviorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_AlarmActionResponseActionCategory] ON [dbo].[T_AlarmActionResponses]
(
	[ActionCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_AlarmActionResponseActionType] ON [dbo].[T_AlarmActionResponses]
(
	[ActionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_AlarmActionResponsePlan] ON [dbo].[T_AlarmActionResponses]
(
	[PlanID] ASC,
	[PlanSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_AlarmActionResponseUserGroup] ON [dbo].[T_AlarmActionResponses]
(
	[UserGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_AlarmActionResponses]  WITH CHECK ADD  CONSTRAINT [FK_AlarmActionResponseActionBehavior] FOREIGN KEY([ActionBehaviorID])
REFERENCES [dbo].[LT_ActionBehaviors] ([ActionBehaviorID])
ALTER TABLE [dbo].[T_AlarmActionResponses] CHECK CONSTRAINT [FK_AlarmActionResponseActionBehavior]
ALTER TABLE [dbo].[T_AlarmActionResponses]  WITH CHECK ADD  CONSTRAINT [FK_AlarmActionResponseActionCategory] FOREIGN KEY([ActionCategoryID])
REFERENCES [dbo].[LT_ActionCategories] ([ActionCategoryID])
ALTER TABLE [dbo].[T_AlarmActionResponses] CHECK CONSTRAINT [FK_AlarmActionResponseActionCategory]
ALTER TABLE [dbo].[T_AlarmActionResponses]  WITH CHECK ADD  CONSTRAINT [FK_AlarmActionResponseActionType] FOREIGN KEY([ActionTypeID])
REFERENCES [dbo].[LT_ActionTypes] ([ActionTypeID])
ALTER TABLE [dbo].[T_AlarmActionResponses] CHECK CONSTRAINT [FK_AlarmActionResponseActionType]
ALTER TABLE [dbo].[T_AlarmActionResponses]  WITH CHECK ADD  CONSTRAINT [FK_AlarmActionResponsePlan] FOREIGN KEY([PlanID], [PlanSiteID])
REFERENCES [dbo].[T_Plans] ([PlanID], [PlanSiteID])
ALTER TABLE [dbo].[T_AlarmActionResponses] CHECK CONSTRAINT [FK_AlarmActionResponsePlan]
ALTER TABLE [dbo].[T_AlarmActionResponses]  WITH CHECK ADD  CONSTRAINT [FK_AlarmActionResponseUserGroup] FOREIGN KEY([UserGroupID])
REFERENCES [dbo].[LT_UserGroups] ([UserGroupID])
ALTER TABLE [dbo].[T_AlarmActionResponses] CHECK CONSTRAINT [FK_AlarmActionResponseUserGroup]
ALTER TABLE [dbo].[T_AlarmActionResponses]  WITH CHECK ADD  CONSTRAINT [FK_AlarmScenarioAlarmActionResponse] FOREIGN KEY([AlarmID], [ScenarioID], [AlarmSiteID], [ScenarioSiteID], [AlarmScenarioID])
REFERENCES [dbo].[T_AlarmScenarios] ([AlarmID], [ScenarioID], [AlarmSiteID], [ScenarioSiteID], [AlarmScenarioID])
ALTER TABLE [dbo].[T_AlarmActionResponses] CHECK CONSTRAINT [FK_AlarmScenarioAlarmActionResponse]