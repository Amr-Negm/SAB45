/****** Object:  Table [dbo].[T_Top10ResultsSourceAndZoneLog]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Top10ResultsSourceAndZoneLog](
	[Top10LogID] [int] NOT NULL,
	[StoredProcedureID] [int] NULL,
	[RName] [nvarchar](200) NULL,
	[NoOfAlarm] [nvarchar](200) NULL,
	[AvgPerHour] [nvarchar](200) NULL,
	[RLevel] [nvarchar](200) NULL,
	[RID] [int] NULL,
	[ActionDate] [datetime] NULL
) ON [PRIMARY]