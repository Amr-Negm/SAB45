/****** Object:  Table [dbo].[T_AlarmDefinitionEscalationLevels]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_AlarmDefinitionEscalationLevels](
	[EscalationLevelID] [int] NOT NULL,
	[EscalationLevelSiteID] [int] NOT NULL,
	[AlarmsDefinitionID] [int] NOT NULL,
	[AlarmDefinitionSiteID] [int] NOT NULL,
 CONSTRAINT [AlarmDefinitionEscalationLevels_PK] PRIMARY KEY CLUSTERED 
(
	[EscalationLevelID] ASC,
	[AlarmsDefinitionID] ASC,
	[AlarmDefinitionSiteID] ASC,
	[EscalationLevelSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_AlarmDefinitionEscalationLevels]  WITH CHECK ADD  CONSTRAINT [FK_AlarmDefinitionAlarmDefinitionEscalationLevel] FOREIGN KEY([AlarmsDefinitionID], [AlarmDefinitionSiteID])
REFERENCES [dbo].[T_AlarmDefinitions] ([AlarmDefinitionID], [AlarmDefinitionSiteID])
ALTER TABLE [dbo].[T_AlarmDefinitionEscalationLevels] CHECK CONSTRAINT [FK_AlarmDefinitionAlarmDefinitionEscalationLevel]
ALTER TABLE [dbo].[T_AlarmDefinitionEscalationLevels]  WITH CHECK ADD  CONSTRAINT [FK_EscalationLevelAlarmDefinitionEscalationLevel] FOREIGN KEY([EscalationLevelID], [EscalationLevelSiteID])
REFERENCES [dbo].[T_EscalationLevels] ([EscalationLevelID], [EscalationLevelSiteID])
ALTER TABLE [dbo].[T_AlarmDefinitionEscalationLevels] CHECK CONSTRAINT [FK_EscalationLevelAlarmDefinitionEscalationLevel]