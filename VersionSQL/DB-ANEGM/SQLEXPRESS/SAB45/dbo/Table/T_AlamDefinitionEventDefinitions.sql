/****** Object:  Table [dbo].[T_AlamDefinitionEventDefinitions]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_AlamDefinitionEventDefinitions](
	[EventDefinitionID] [int] NOT NULL,
	[EventDefinitionSiteID] [int] NOT NULL,
	[AlarmsDefinitionID] [int] NOT NULL,
	[AlarmDefinitionSiteID] [int] NOT NULL,
	[AlarmEventSequenceID] [int] NULL,
	[AlarmEventTimeOut] [int] NULL,
	[IsMandatory] [bit] NULL,
 CONSTRAINT [AlamEventDefinitions_PK] PRIMARY KEY CLUSTERED 
(
	[EventDefinitionID] ASC,
	[AlarmsDefinitionID] ASC,
	[EventDefinitionSiteID] ASC,
	[AlarmDefinitionSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_AlamDefinitionEventDefinitions]  WITH CHECK ADD  CONSTRAINT [FK_AlarmDefinitionAlamDefinitionEventDefinition] FOREIGN KEY([AlarmsDefinitionID], [AlarmDefinitionSiteID])
REFERENCES [dbo].[T_AlarmDefinitions] ([AlarmDefinitionID], [AlarmDefinitionSiteID])
ALTER TABLE [dbo].[T_AlamDefinitionEventDefinitions] CHECK CONSTRAINT [FK_AlarmDefinitionAlamDefinitionEventDefinition]
ALTER TABLE [dbo].[T_AlamDefinitionEventDefinitions]  WITH CHECK ADD  CONSTRAINT [FK_EventDefinitionAlamDefinitionEventDefinition] FOREIGN KEY([EventDefinitionID], [EventDefinitionSiteID])
REFERENCES [dbo].[T_EventDefinitions] ([EventDefinitionID], [EventDefinitionSiteID])
ALTER TABLE [dbo].[T_AlamDefinitionEventDefinitions] CHECK CONSTRAINT [FK_EventDefinitionAlamDefinitionEventDefinition]