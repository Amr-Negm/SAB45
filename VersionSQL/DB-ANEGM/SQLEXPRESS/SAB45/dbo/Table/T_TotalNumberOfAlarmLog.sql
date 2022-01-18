/****** Object:  Table [dbo].[T_TotalNumberOfAlarmLog]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_TotalNumberOfAlarmLog](
	[TotalNumberOfAlarmLogID] [int] NOT NULL,
	[AlarmID] [int] NULL,
	[OccuranceDate] [date] NULL,
	[PriorityID] [int] NULL,
	[StoredProcedureID] [int] NULL,
	[ActionDate] [datetime] NULL
) ON [PRIMARY]