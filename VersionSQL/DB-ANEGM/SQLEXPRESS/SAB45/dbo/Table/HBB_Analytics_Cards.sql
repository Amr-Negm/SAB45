/****** Object:  Table [dbo].[HBB_Analytics_Cards]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[HBB_Analytics_Cards](
	[ActionID] [int] IDENTITY(1,1) NOT NULL,
	[StoredProcedureID] [int] NULL,
	[ActionDate] [datetime2](7) NULL,
	[PeriodId] [int] NULL,
	[StoredProcedureValue] [nvarchar](100) NULL
) ON [PRIMARY]