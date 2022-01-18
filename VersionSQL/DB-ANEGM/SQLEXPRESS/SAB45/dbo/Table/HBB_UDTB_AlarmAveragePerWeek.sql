/****** Object:  Table [dbo].[HBB_UDTB_AlarmAveragePerWeek]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[HBB_UDTB_AlarmAveragePerWeek](
	[ActionId] [bigint] IDENTITY(1,1) NOT NULL,
	[ActionDate] [datetime2](7) NULL,
	[AvgBerDay] [int] NULL,
	[Dayname] [nvarchar](150) NULL,
	[ScenarioTitle] [nvarchar](150) NULL,
	[StoredProcedureID] [int] NULL,
	[Periodid] [int] NULL
) ON [PRIMARY]