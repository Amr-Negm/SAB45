/****** Object:  Table [dbo].[T_NotificationGroupAlarmDefinitions]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_NotificationGroupAlarmDefinitions](
	[NotificationGroupID] [int] NOT NULL,
	[NotificationGroupSiteID] [int] NOT NULL,
	[AlarmDefinitionID] [int] NOT NULL,
	[AlarmDefinitionSiteID] [int] NOT NULL,
 CONSTRAINT [NotificationGroupAlarmDefinitions_PK] PRIMARY KEY CLUSTERED 
(
	[NotificationGroupID] ASC,
	[NotificationGroupSiteID] ASC,
	[AlarmDefinitionID] ASC,
	[AlarmDefinitionSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_NotificationGroupAlarmDefinitions]  WITH CHECK ADD  CONSTRAINT [FK_AlarmDefinitionNotificationGroupAlarmDefinition] FOREIGN KEY([AlarmDefinitionID], [AlarmDefinitionSiteID])
REFERENCES [dbo].[T_AlarmDefinitions] ([AlarmDefinitionID], [AlarmDefinitionSiteID])
ALTER TABLE [dbo].[T_NotificationGroupAlarmDefinitions] CHECK CONSTRAINT [FK_AlarmDefinitionNotificationGroupAlarmDefinition]
ALTER TABLE [dbo].[T_NotificationGroupAlarmDefinitions]  WITH CHECK ADD  CONSTRAINT [FK_NotificationGroupNotificationGroupAlarmDefinition] FOREIGN KEY([NotificationGroupID], [NotificationGroupSiteID])
REFERENCES [dbo].[T_NotificationGroups] ([NotificationGroupID], [NotificationGroupSiteID])
ALTER TABLE [dbo].[T_NotificationGroupAlarmDefinitions] CHECK CONSTRAINT [FK_NotificationGroupNotificationGroupAlarmDefinition]