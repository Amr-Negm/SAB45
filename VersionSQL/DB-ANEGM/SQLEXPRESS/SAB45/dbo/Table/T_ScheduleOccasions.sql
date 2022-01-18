/****** Object:  Table [dbo].[T_ScheduleOccasions]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_ScheduleOccasions](
	[ScheduleOccasionId] [int] IDENTITY(1,1) NOT NULL,
	[OccasionId] [int] NULL,
	[OccasionSiteId] [int] NULL,
	[ScheduleId] [int] NULL,
	[ScheduleSiteId] [int] NULL,
	[Date] [datetime] NULL,
	[Start] [time](7) NULL,
	[End] [time](7) NULL,
 CONSTRAINT [PK_ScheduleOccasions] PRIMARY KEY CLUSTERED 
(
	[ScheduleOccasionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ScheduleOccasions1] ON [dbo].[T_ScheduleOccasions]
(
	[OccasionId] ASC,
	[OccasionSiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ScheduleOccasions2] ON [dbo].[T_ScheduleOccasions]
(
	[ScheduleId] ASC,
	[ScheduleSiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_ScheduleOccasions]  WITH CHECK ADD  CONSTRAINT [FK_ScheduleOccasions1] FOREIGN KEY([OccasionId], [OccasionSiteId])
REFERENCES [dbo].[T_Occasions] ([OccasionId], [OccasionSiteId])
ALTER TABLE [dbo].[T_ScheduleOccasions] CHECK CONSTRAINT [FK_ScheduleOccasions1]
ALTER TABLE [dbo].[T_ScheduleOccasions]  WITH CHECK ADD  CONSTRAINT [FK_ScheduleOccasions2] FOREIGN KEY([ScheduleId], [ScheduleSiteId])
REFERENCES [dbo].[T_Schedules] ([ScheduleId], [ScheduleSiteId])
ALTER TABLE [dbo].[T_ScheduleOccasions] CHECK CONSTRAINT [FK_ScheduleOccasions2]