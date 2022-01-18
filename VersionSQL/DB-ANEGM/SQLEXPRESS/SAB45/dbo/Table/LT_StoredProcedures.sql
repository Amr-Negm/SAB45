/****** Object:  Table [dbo].[LT_StoredProcedures]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_StoredProcedures](
	[StoredProcedureID] [int] IDENTITY(1,1) NOT NULL,
	[StoredProcedureName] [nvarchar](100) NULL,
 CONSTRAINT [PK_LT_StoredProcedures] PRIMARY KEY CLUSTERED 
(
	[StoredProcedureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]