/****** Object:  Table [dbo].[T_AlarmMapping]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_AlarmMapping](
	[AlarmID] [int] NOT NULL,
	[AlarmSiteID] [int] NOT NULL,
	[AlarmMappingID] [nvarchar](255) NULL,
 CONSTRAINT [PK_T_AlarmMapping] PRIMARY KEY CLUSTERED 
(
	[AlarmID] ASC,
	[AlarmSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_AlarmsAlarmMapping] ON [dbo].[T_AlarmMapping]
(
	[AlarmID] ASC,
	[AlarmSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_AlarmMapping]  WITH CHECK ADD  CONSTRAINT [FK_Alarms_AlarmMapping] FOREIGN KEY([AlarmID], [AlarmSiteID])
REFERENCES [dbo].[T_Alarms] ([AlarmID], [AlarmSiteID])
ALTER TABLE [dbo].[T_AlarmMapping] CHECK CONSTRAINT [FK_Alarms_AlarmMapping]