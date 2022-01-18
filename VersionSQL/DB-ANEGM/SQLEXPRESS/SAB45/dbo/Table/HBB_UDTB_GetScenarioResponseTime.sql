/****** Object:  Table [dbo].[HBB_UDTB_GetScenarioResponseTime]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[HBB_UDTB_GetScenarioResponseTime](
	[ActionId] [bigint] IDENTITY(1,1) NOT NULL,
	[ActionDate] [datetime2](7) NULL,
	[AlarmDefinitionTitle1] [nvarchar](150) NULL,
	[minval] [nvarchar](150) NULL,
	[maxval] [nvarchar](150) NULL,
	[avgval] [nvarchar](150) NULL,
	[StoredProcedureID] [int] NULL,
	[Periodid] [int] NULL
) ON [PRIMARY]