/****** Object:  Table [dbo].[T_AlarmScenarios]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_AlarmScenarios](
	[AlarmScenarioID] [int] IDENTITY(1,1) NOT NULL,
	[AlarmID] [int] NOT NULL,
	[AlarmSiteID] [int] NOT NULL,
	[ScenarioID] [int] NOT NULL,
	[ScenarioSiteID] [int] NOT NULL,
	[IsSelected] [bit] NULL,
	[SelectedCreationDate] [datetime] NULL,
	[SelectedUser] [nvarchar](100) NULL,
 CONSTRAINT [AlarmScenarios_PK] PRIMARY KEY CLUSTERED 
(
	[AlarmID] ASC,
	[ScenarioID] ASC,
	[AlarmSiteID] ASC,
	[ScenarioSiteID] ASC,
	[AlarmScenarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_AlarmScenarios]  WITH CHECK ADD  CONSTRAINT [FK_AlarmAlarmScenario] FOREIGN KEY([AlarmID], [AlarmSiteID])
REFERENCES [dbo].[T_Alarms] ([AlarmID], [AlarmSiteID])
ALTER TABLE [dbo].[T_AlarmScenarios] CHECK CONSTRAINT [FK_AlarmAlarmScenario]
ALTER TABLE [dbo].[T_AlarmScenarios]  WITH CHECK ADD  CONSTRAINT [FK_ScenariosAlarmScenarios] FOREIGN KEY([ScenarioID], [ScenarioSiteID])
REFERENCES [dbo].[T_Scenarios] ([ScenarioID], [ScenarioSiteID])
ALTER TABLE [dbo].[T_AlarmScenarios] CHECK CONSTRAINT [FK_ScenariosAlarmScenarios]