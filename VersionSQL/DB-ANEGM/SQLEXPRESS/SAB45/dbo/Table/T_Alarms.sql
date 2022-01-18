/****** Object:  Table [dbo].[T_Alarms]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Alarms](
	[AlarmID] [int] IDENTITY(1,1) NOT NULL,
	[AlarmSiteID] [int] NOT NULL,
	[AlarmCode] [nvarchar](200) NULL,
	[Occurance_Date] [datetime] NULL,
	[Response_User] [nvarchar](200) NULL,
	[Response_Date] [datetime] NULL,
	[AlarmStatusID] [int] NOT NULL,
	[AlarmClassificationID] [int] NOT NULL,
	[AlarmsDefinitionID] [int] NOT NULL,
	[AlarmDefinitionSiteID] [int] NOT NULL,
	[EscalationLevelID] [int] NOT NULL,
	[EscalationLevelSiteID] [int] NOT NULL,
	[ResponseTimeDifference] [int] NULL,
	[EscalationDescription] [nvarchar](4000) NULL,
	[EscalationUser] [nvarchar](200) NULL,
	[EscalationDate] [datetime] NULL,
	[AlarmComment] [nvarchar](max) NULL,
	[StateID] [int] NULL,
	[StatusID] [int] NULL,
	[TransitionStatusID] [int] NULL,
	[LatestCADStatusID] [int] NULL,
 CONSTRAINT [Alarms_PK] PRIMARY KEY CLUSTERED 
(
	[AlarmID] ASC,
	[AlarmSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_AlarmAlarmClassification] ON [dbo].[T_Alarms]
(
	[AlarmClassificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_AlarmAlarmDefinition] ON [dbo].[T_Alarms]
(
	[AlarmsDefinitionID] ASC,
	[AlarmDefinitionSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_AlarmAlarmStatus] ON [dbo].[T_Alarms]
(
	[AlarmStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_AlarmEscalationLevel] ON [dbo].[T_Alarms]
(
	[EscalationLevelID] ASC,
	[EscalationLevelSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_AlarmsCADStatus] ON [dbo].[T_Alarms]
(
	[LatestCADStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_AlarmTransitionStatus] ON [dbo].[T_Alarms]
(
	[TransitionStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_OccuranceDate] ON [dbo].[T_Alarms]
(
	[Occurance_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_Alarms]  WITH CHECK ADD  CONSTRAINT [FK_AlarmAlarmClassification] FOREIGN KEY([AlarmClassificationID])
REFERENCES [dbo].[LT_AlarmClassifications] ([AlarmClassificationID])
ALTER TABLE [dbo].[T_Alarms] CHECK CONSTRAINT [FK_AlarmAlarmClassification]
ALTER TABLE [dbo].[T_Alarms]  WITH CHECK ADD  CONSTRAINT [FK_AlarmAlarmDefinition] FOREIGN KEY([AlarmsDefinitionID], [AlarmDefinitionSiteID])
REFERENCES [dbo].[T_AlarmDefinitions] ([AlarmDefinitionID], [AlarmDefinitionSiteID])
ALTER TABLE [dbo].[T_Alarms] CHECK CONSTRAINT [FK_AlarmAlarmDefinition]
ALTER TABLE [dbo].[T_Alarms]  WITH CHECK ADD  CONSTRAINT [FK_AlarmAlarmStatus] FOREIGN KEY([AlarmStatusID])
REFERENCES [dbo].[LT_AlarmStatuses] ([AlarmStatusID])
ALTER TABLE [dbo].[T_Alarms] CHECK CONSTRAINT [FK_AlarmAlarmStatus]
ALTER TABLE [dbo].[T_Alarms]  WITH CHECK ADD  CONSTRAINT [FK_AlarmEscalationLevel] FOREIGN KEY([EscalationLevelID], [EscalationLevelSiteID])
REFERENCES [dbo].[T_EscalationLevels] ([EscalationLevelID], [EscalationLevelSiteID])
ALTER TABLE [dbo].[T_Alarms] CHECK CONSTRAINT [FK_AlarmEscalationLevel]
ALTER TABLE [dbo].[T_Alarms]  WITH CHECK ADD  CONSTRAINT [FK_CADStatusAlarms] FOREIGN KEY([LatestCADStatusID])
REFERENCES [dbo].[LT_CADStatus] ([CADStatusID])
ALTER TABLE [dbo].[T_Alarms] CHECK CONSTRAINT [FK_CADStatusAlarms]
ALTER TABLE [dbo].[T_Alarms]  WITH CHECK ADD  CONSTRAINT [FK_TransitionStatus_Alarms] FOREIGN KEY([TransitionStatusID])
REFERENCES [dbo].[LT_TransitionStatus] ([TransitionStatusID])
ALTER TABLE [dbo].[T_Alarms] CHECK CONSTRAINT [FK_TransitionStatus_Alarms]