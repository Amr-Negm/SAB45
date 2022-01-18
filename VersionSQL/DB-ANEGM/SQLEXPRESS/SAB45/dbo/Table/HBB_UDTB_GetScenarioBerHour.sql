/****** Object:  Table [dbo].[HBB_UDTB_GetScenarioBerHour]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[HBB_UDTB_GetScenarioBerHour](
	[ActionId] [bigint] IDENTITY(1,1) NOT NULL,
	[ActionDate] [datetime2](7) NULL,
	[ScenarioTitle1] [nvarchar](150) NULL,
	[date] [nvarchar](150) NULL,
	[total] [nvarchar](150) NULL,
	[StoredProcedureID] [int] NULL,
	[Periodid] [int] NULL
) ON [PRIMARY]