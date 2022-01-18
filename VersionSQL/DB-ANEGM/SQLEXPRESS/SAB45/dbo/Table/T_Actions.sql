/****** Object:  Table [dbo].[T_Actions]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Actions](
	[ActionID] [int] IDENTITY(1,1) NOT NULL,
	[ActionSiteID] [int] NOT NULL,
	[ActionTitle1] [nvarchar](200) NULL,
	[ActionDescriptionTitle1] [nvarchar](4000) NULL,
	[StateID] [int] NULL,
	[ActionSubject] [nvarchar](150) NULL,
	[ActionBody] [nvarchar](max) NULL,
	[ActionPerformTime] [int] NULL,
	[ActionResponseDate] [datetime] NULL,
	[ActionResponseUser] [nvarchar](200) NULL,
	[ActionResponse] [int] NULL,
	[PlanID] [int] NOT NULL,
	[PlanSiteID] [int] NOT NULL,
	[ActionBehaviorID] [int] NULL,
	[UserGroupID] [int] NULL,
	[UserGroupName] [nvarchar](200) NULL,
	[ActionTypeID] [int] NULL,
	[ActionCategoryID] [int] NULL,
	[DesignerItemId] [nvarchar](50) NULL,
	[StatusID] [int] NULL,
 CONSTRAINT [Actions_PK] PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC,
	[ActionSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ActionActionBehavior] ON [dbo].[T_Actions]
(
	[ActionBehaviorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ActionActionCategory] ON [dbo].[T_Actions]
(
	[ActionCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ActionActionType] ON [dbo].[T_Actions]
(
	[ActionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ActionPlan] ON [dbo].[T_Actions]
(
	[PlanID] ASC,
	[PlanSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ActionUserGroup] ON [dbo].[T_Actions]
(
	[UserGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_Actions]  WITH CHECK ADD  CONSTRAINT [FK_ActionActionBehavior] FOREIGN KEY([ActionBehaviorID])
REFERENCES [dbo].[LT_ActionBehaviors] ([ActionBehaviorID])
ALTER TABLE [dbo].[T_Actions] CHECK CONSTRAINT [FK_ActionActionBehavior]
ALTER TABLE [dbo].[T_Actions]  WITH CHECK ADD  CONSTRAINT [FK_ActionActionCategory] FOREIGN KEY([ActionCategoryID])
REFERENCES [dbo].[LT_ActionCategories] ([ActionCategoryID])
ALTER TABLE [dbo].[T_Actions] CHECK CONSTRAINT [FK_ActionActionCategory]
ALTER TABLE [dbo].[T_Actions]  WITH CHECK ADD  CONSTRAINT [FK_ActionActionType] FOREIGN KEY([ActionTypeID])
REFERENCES [dbo].[LT_ActionTypes] ([ActionTypeID])
ALTER TABLE [dbo].[T_Actions] CHECK CONSTRAINT [FK_ActionActionType]
ALTER TABLE [dbo].[T_Actions]  WITH CHECK ADD  CONSTRAINT [FK_ActionPlan] FOREIGN KEY([PlanID], [PlanSiteID])
REFERENCES [dbo].[T_Plans] ([PlanID], [PlanSiteID])
ALTER TABLE [dbo].[T_Actions] CHECK CONSTRAINT [FK_ActionPlan]
ALTER TABLE [dbo].[T_Actions]  WITH CHECK ADD  CONSTRAINT [FK_ActionUserGroup] FOREIGN KEY([UserGroupID])
REFERENCES [dbo].[LT_UserGroups] ([UserGroupID])
ALTER TABLE [dbo].[T_Actions] CHECK CONSTRAINT [FK_ActionUserGroup]