/****** Object:  Table [dbo].[T_Schedules]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Schedules](
	[ScheduleId] [int] IDENTITY(1,1) NOT NULL,
	[ScheduleSiteId] [int] NOT NULL,
	[ScheduleTypeId] [int] NULL,
	[ScheduleName] [nvarchar](50) NULL,
	[State] [bit] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Schedules] PRIMARY KEY CLUSTERED 
(
	[ScheduleId] ASC,
	[ScheduleSiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ScheduleType] ON [dbo].[T_Schedules]
(
	[ScheduleTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_Schedules]  WITH CHECK ADD  CONSTRAINT [FK_ScheduleType] FOREIGN KEY([ScheduleTypeId])
REFERENCES [dbo].[LT_ScheduleTypes] ([ScheduleTypeId])
ALTER TABLE [dbo].[T_Schedules] CHECK CONSTRAINT [FK_ScheduleType]