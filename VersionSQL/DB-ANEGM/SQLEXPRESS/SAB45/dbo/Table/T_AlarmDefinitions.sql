/****** Object:  Table [dbo].[T_AlarmDefinitions]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_AlarmDefinitions](
	[AlarmDefinitionID] [int] IDENTITY(1,1) NOT NULL,
	[AlarmDefinitionSiteID] [int] NOT NULL,
	[AlarmDefinitionCode] [nvarchar](200) NULL,
	[AlarmDefinitionTitle1] [nvarchar](200) NULL,
	[AlarmDefinitionDescriptionTitle1] [nvarchar](4000) NULL,
	[ExpectedResponseTime] [float] NULL,
	[AlarmDefinitionTimeOut] [float] NULL,
	[PriorityID] [int] NOT NULL,
	[AlarmDefinitionPoliceCode] [nvarchar](200) NULL,
	[AlarmCategoryID] [int] NOT NULL,
	[AlarmClassificationID] [int] NULL,
	[IsAlarmSound] [bit] NULL,
	[IsAlarmNotification] [bit] NULL,
	[NotificationColor] [nvarchar](50) NULL,
	[Duration] [int] NULL,
	[StateID] [int] NULL,
	[StatusID] [int] NULL,
	[MinEventNumber] [int] NULL,
	[IgnoreOrder] [bit] NULL,
	[AlarmColor] [nvarchar](50) NULL,
	[AlarmIcon] [image] NULL,
	[DashboardColor] [nvarchar](20) NULL,
	[IsAggregatedAlarm] [bit] NULL,
	[ConfigData] [nvarchar](max) NULL,
 CONSTRAINT [AlarmDefinitions_PK] PRIMARY KEY CLUSTERED 
(
	[AlarmDefinitionID] ASC,
	[AlarmDefinitionSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_AlarmAlarmCategory] ON [dbo].[T_AlarmDefinitions]
(
	[AlarmCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_AlarmDefinitionAlarmClassification] ON [dbo].[T_AlarmDefinitions]
(
	[AlarmClassificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_AlarmDefinitionPriority] ON [dbo].[T_AlarmDefinitions]
(
	[PriorityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_AlarmDefinitions] ADD  CONSTRAINT [DF_AggregatedAlarm]  DEFAULT ((0)) FOR [IsAggregatedAlarm]
ALTER TABLE [dbo].[T_AlarmDefinitions]  WITH CHECK ADD  CONSTRAINT [FK_AlarmAlarmCategory] FOREIGN KEY([AlarmCategoryID])
REFERENCES [dbo].[LT_AlarmCategories] ([AlarmCategoryID])
ALTER TABLE [dbo].[T_AlarmDefinitions] CHECK CONSTRAINT [FK_AlarmAlarmCategory]
ALTER TABLE [dbo].[T_AlarmDefinitions]  WITH CHECK ADD  CONSTRAINT [FK_AlarmDefinitionAlarmClassification] FOREIGN KEY([AlarmClassificationID])
REFERENCES [dbo].[LT_AlarmClassifications] ([AlarmClassificationID])
ALTER TABLE [dbo].[T_AlarmDefinitions] CHECK CONSTRAINT [FK_AlarmDefinitionAlarmClassification]
ALTER TABLE [dbo].[T_AlarmDefinitions]  WITH CHECK ADD  CONSTRAINT [FK_AlarmDefinitionPriority] FOREIGN KEY([PriorityID])
REFERENCES [dbo].[LT_Priorities] ([PriorityID])
ALTER TABLE [dbo].[T_AlarmDefinitions] CHECK CONSTRAINT [FK_AlarmDefinitionPriority]