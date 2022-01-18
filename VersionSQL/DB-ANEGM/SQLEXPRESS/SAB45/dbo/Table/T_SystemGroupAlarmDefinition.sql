/****** Object:  Table [dbo].[T_SystemGroupAlarmDefinition]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_SystemGroupAlarmDefinition](
	[AlarmDefinitionID] [int] NOT NULL,
	[AlarmDefinitionSiteID] [int] NOT NULL,
	[SystemGroupID] [int] NOT NULL,
 CONSTRAINT [PK_SystemGroupAlarmDefinition] PRIMARY KEY CLUSTERED 
(
	[AlarmDefinitionID] ASC,
	[AlarmDefinitionSiteID] ASC,
	[SystemGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_SystemGroupAlarmDefinition]  WITH CHECK ADD  CONSTRAINT [FK_SystemGroupAlarmDefinition1] FOREIGN KEY([AlarmDefinitionID], [AlarmDefinitionSiteID])
REFERENCES [dbo].[T_AlarmDefinitions] ([AlarmDefinitionID], [AlarmDefinitionSiteID])
ALTER TABLE [dbo].[T_SystemGroupAlarmDefinition] CHECK CONSTRAINT [FK_SystemGroupAlarmDefinition1]
ALTER TABLE [dbo].[T_SystemGroupAlarmDefinition]  WITH CHECK ADD  CONSTRAINT [FK_SystemGroupAlarmDefinition2] FOREIGN KEY([SystemGroupID])
REFERENCES [dbo].[LT_SystemGroups] ([SystemGroupID])
ALTER TABLE [dbo].[T_SystemGroupAlarmDefinition] CHECK CONSTRAINT [FK_SystemGroupAlarmDefinition2]