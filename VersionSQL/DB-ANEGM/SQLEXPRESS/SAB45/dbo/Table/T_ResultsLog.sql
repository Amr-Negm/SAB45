/****** Object:  Table [dbo].[T_ResultsLog]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_ResultsLog](
	[ResultLogID] [int] IDENTITY(1,1) NOT NULL,
	[StoredProcedureID] [int] NULL,
	[StoredProcedureValue] [nvarchar](100) NULL,
	[ActionDate] [datetime] NULL,
 CONSTRAINT [PK_ResultLogID] PRIMARY KEY CLUSTERED 
(
	[ResultLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]