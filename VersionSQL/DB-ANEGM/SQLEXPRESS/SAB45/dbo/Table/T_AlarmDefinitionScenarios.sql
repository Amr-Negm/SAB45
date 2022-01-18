/****** Object:  Table [dbo].[T_AlarmDefinitionScenarios]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_AlarmDefinitionScenarios](
	[ScenarioID] [int] NOT NULL,
	[ScenarioSiteID] [int] NOT NULL,
	[AlarmsDefinitionID] [int] NOT NULL,
	[AlarmDefinitionSiteID] [int] NOT NULL,
	[IsDefault] [bit] NULL,
 CONSTRAINT [AlarmDefinitionScenarios_PK] PRIMARY KEY CLUSTERED 
(
	[ScenarioID] ASC,
	[AlarmsDefinitionID] ASC,
	[AlarmDefinitionSiteID] ASC,
	[ScenarioSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_AlarmDefinitionScenarios]  WITH CHECK ADD  CONSTRAINT [FK_AlarmDefinitionAlarmDefinitionScenario] FOREIGN KEY([AlarmsDefinitionID], [AlarmDefinitionSiteID])
REFERENCES [dbo].[T_AlarmDefinitions] ([AlarmDefinitionID], [AlarmDefinitionSiteID])
ALTER TABLE [dbo].[T_AlarmDefinitionScenarios] CHECK CONSTRAINT [FK_AlarmDefinitionAlarmDefinitionScenario]
ALTER TABLE [dbo].[T_AlarmDefinitionScenarios]  WITH CHECK ADD  CONSTRAINT [FK_ScenarioAlarmDefinitionScenario] FOREIGN KEY([ScenarioID], [ScenarioSiteID])
REFERENCES [dbo].[T_Scenarios] ([ScenarioID], [ScenarioSiteID])
ALTER TABLE [dbo].[T_AlarmDefinitionScenarios] CHECK CONSTRAINT [FK_ScenarioAlarmDefinitionScenario]