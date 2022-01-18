/****** Object:  Table [dbo].[T_ScheduleDays]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_ScheduleDays](
	[ScheduleDayId] [int] IDENTITY(1,1) NOT NULL,
	[ScheduleId] [int] NULL,
	[DayId] [int] NULL,
	[Start] [time](7) NULL,
	[End] [time](7) NULL,
	[ScheduleSiteId] [int] NULL,
	[DaySiteId] [int] NULL,
 CONSTRAINT [PK_ScheduleDays] PRIMARY KEY CLUSTERED 
(
	[ScheduleDayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ScheduleDays] ON [dbo].[T_ScheduleDays]
(
	[DayId] ASC,
	[DaySiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_Schedules] ON [dbo].[T_ScheduleDays]
(
	[ScheduleId] ASC,
	[ScheduleSiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_ScheduleDays]  WITH CHECK ADD  CONSTRAINT [FK_ScheduleDays] FOREIGN KEY([DayId], [DaySiteId])
REFERENCES [dbo].[LT_Days] ([DayId], [DaySiteId])
ALTER TABLE [dbo].[T_ScheduleDays] CHECK CONSTRAINT [FK_ScheduleDays]
ALTER TABLE [dbo].[T_ScheduleDays]  WITH CHECK ADD  CONSTRAINT [FK_Schedules] FOREIGN KEY([ScheduleId], [ScheduleSiteId])
REFERENCES [dbo].[T_Schedules] ([ScheduleId], [ScheduleSiteId])
ALTER TABLE [dbo].[T_ScheduleDays] CHECK CONSTRAINT [FK_Schedules]