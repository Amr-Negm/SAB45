/****** Object:  Table [dbo].[T_WeeksPrioritiesLog]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_WeeksPrioritiesLog](
	[WPID] [int] NOT NULL,
	[WPValue] [int] NULL,
	[WPWeek] [nvarchar](100) NULL,
	[PriorityTitle1] [nvarchar](100) NULL,
	[StoredProcedureID] [int] NULL,
	[ActionDate] [datetime] NULL
) ON [PRIMARY]