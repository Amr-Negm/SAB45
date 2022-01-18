/****** Object:  Table [dbo].[T_EventAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_EventAlarms](
	[AlarmID] [int] NOT NULL,
	[AlarmSiteID] [int] NOT NULL,
	[EventID] [int] NOT NULL,
	[EventSiteID] [int] NOT NULL,
 CONSTRAINT [EventAlarms_PK] PRIMARY KEY CLUSTERED 
(
	[AlarmID] ASC,
	[EventID] ASC,
	[EventSiteID] ASC,
	[AlarmSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_EventAlarms]  WITH CHECK ADD  CONSTRAINT [FK_AlarmEventAlarm] FOREIGN KEY([AlarmID], [AlarmSiteID])
REFERENCES [dbo].[T_Alarms] ([AlarmID], [AlarmSiteID])
ALTER TABLE [dbo].[T_EventAlarms] CHECK CONSTRAINT [FK_AlarmEventAlarm]
ALTER TABLE [dbo].[T_EventAlarms]  WITH CHECK ADD  CONSTRAINT [FK_EventEventAlarm] FOREIGN KEY([EventID], [EventSiteID])
REFERENCES [dbo].[T_Events] ([EventID], [EventSiteID])
ALTER TABLE [dbo].[T_EventAlarms] CHECK CONSTRAINT [FK_EventEventAlarm]