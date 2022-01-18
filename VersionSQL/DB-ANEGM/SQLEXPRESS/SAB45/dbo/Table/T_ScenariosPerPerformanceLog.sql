/****** Object:  Table [dbo].[T_ScenariosPerPerformanceLog]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_ScenariosPerPerformanceLog](
	[ScenarioLogID] [int] NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Impact] [int] NULL,
	[Count] [int] NULL,
	[ResponseTime] [nvarchar](100) NULL,
	[ExpectedTime] [nvarchar](100) NULL,
	[ActionDate] [datetime] NULL
) ON [PRIMARY]