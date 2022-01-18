/****** Object:  Table [dbo].[T_PriorityChartLog]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_PriorityChartLog](
	[PriorityChartLogID] [int] IDENTITY(1,1) NOT NULL,
	[PriorityID] [int] NULL,
	[AlarmPriority] [nvarchar](100) NULL,
	[AlarmTotalNumber] [int] NULL,
	[AvgResponseTime] [int] NULL,
	[ExpectedResponseTime] [int] NULL,
	[Comment] [nvarchar](200) NULL,
	[ActionDate] [datetime] NULL,
	[CountResponseAlarm] [int] NULL,
 CONSTRAINT [PK_T_PriorityChartLog] PRIMARY KEY CLUSTERED 
(
	[PriorityChartLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]