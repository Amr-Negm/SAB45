/****** Object:  Table [dbo].[T_BusinessFeaturesAlarmStatuses]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_BusinessFeaturesAlarmStatuses](
	[BusinessFeaturesAlarmStatuses_ID] [int] NOT NULL,
	[BusinessFeatures_ID] [int] NOT NULL,
	[AlarmStatusID] [int] NOT NULL,
 CONSTRAINT [PK_T_BusinessFeaturesAlarmStatuses] PRIMARY KEY CLUSTERED 
(
	[BusinessFeaturesAlarmStatuses_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_BusinessFeaturesAlarmStatuses]  WITH CHECK ADD  CONSTRAINT [FK_AlarmStatuses_BusinessFeaturesAlarmStatuses_1] FOREIGN KEY([AlarmStatusID])
REFERENCES [dbo].[LT_AlarmStatuses] ([AlarmStatusID])
ALTER TABLE [dbo].[T_BusinessFeaturesAlarmStatuses] CHECK CONSTRAINT [FK_AlarmStatuses_BusinessFeaturesAlarmStatuses_1]
ALTER TABLE [dbo].[T_BusinessFeaturesAlarmStatuses]  WITH CHECK ADD  CONSTRAINT [FK_BusinessFeatures_BusinessFeaturesAlarmStatuses_2] FOREIGN KEY([BusinessFeatures_ID])
REFERENCES [dbo].[LT_BusinessFeatures] ([BusinessFeatures_ID])
ALTER TABLE [dbo].[T_BusinessFeaturesAlarmStatuses] CHECK CONSTRAINT [FK_BusinessFeatures_BusinessFeaturesAlarmStatuses_2]