/****** Object:  Table [dbo].[HBB_UDTB_GetAnalyticPerStatus]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[HBB_UDTB_GetAnalyticPerStatus](
	[ActionId] [bigint] IDENTITY(1,1) NOT NULL,
	[ActionDate] [datetime2](7) NULL,
	[AlarmStatusTitle1] [nvarchar](150) NULL,
	[value] [nvarchar](150) NULL,
	[StoredProcedureID] [int] NULL,
	[Periodid] [int] NULL
) ON [PRIMARY]