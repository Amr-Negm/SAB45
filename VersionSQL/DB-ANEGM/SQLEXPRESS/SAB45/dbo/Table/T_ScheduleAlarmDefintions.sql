/****** Object:  Table [dbo].[T_ScheduleAlarmDefintions]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_ScheduleAlarmDefintions](
	[ScheduleId] [int] NOT NULL,
	[AlarmDefinitionID] [int] NOT NULL,
	[AlarmDefinitionSiteID] [int] NOT NULL,
	[ScheduleSiteId] [int] NOT NULL,
 CONSTRAINT [PK_ScheduleAlarmDefintions] PRIMARY KEY CLUSTERED 
(
	[ScheduleId] ASC,
	[AlarmDefinitionID] ASC,
	[AlarmDefinitionSiteID] ASC,
	[ScheduleSiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_ScheduleAlarmDefintions]  WITH CHECK ADD  CONSTRAINT [FK_ScheduleAlarmDefintions1] FOREIGN KEY([AlarmDefinitionID], [AlarmDefinitionSiteID])
REFERENCES [dbo].[T_AlarmDefinitions] ([AlarmDefinitionID], [AlarmDefinitionSiteID])
ALTER TABLE [dbo].[T_ScheduleAlarmDefintions] CHECK CONSTRAINT [FK_ScheduleAlarmDefintions1]
ALTER TABLE [dbo].[T_ScheduleAlarmDefintions]  WITH CHECK ADD  CONSTRAINT [FK_ScheduleAlarmDefintions2] FOREIGN KEY([ScheduleId], [ScheduleSiteId])
REFERENCES [dbo].[T_Schedules] ([ScheduleId], [ScheduleSiteId])
ALTER TABLE [dbo].[T_ScheduleAlarmDefintions] CHECK CONSTRAINT [FK_ScheduleAlarmDefintions2]