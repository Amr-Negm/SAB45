/****** Object:  Table [dbo].[T_Top10ResultsLog]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Top10ResultsLog](
	[Top10LogID] [int] NULL,
	[StoredProcedureID] [int] NULL,
	[StoredProcedureValueName] [nvarchar](200) NULL,
	[StoredProcedureValue] [int] NULL,
	[ActionDate] [datetime] NULL
) ON [PRIMARY]