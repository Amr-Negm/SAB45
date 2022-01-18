/****** Object:  Table [dbo].[HBB_UDTB_GetPropablitiyAlarm]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[HBB_UDTB_GetPropablitiyAlarm](
	[ActionId] [bigint] IDENTITY(1,1) NOT NULL,
	[ActionDate] [datetime2](7) NULL,
	[ScenarioTitle1] [nvarchar](150) NULL,
	[ScenarioImpact] [nvarchar](50) NULL,
	[ScenarioID] [int] NULL,
	[AlarmScenarioID] [int] NULL,
	[StoredProcedureID] [int] NULL,
	[Periodid] [int] NULL
) ON [PRIMARY]