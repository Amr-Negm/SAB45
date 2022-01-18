/****** Object:  Table [dbo].[ExtraColumns]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ExtraColumns](
	[TableName] [nvarchar](200) NOT NULL,
	[ColumnName] [nvarchar](200) NOT NULL,
	[ColumnTitle] [nvarchar](200) NULL,
	[ColumnDescription] [nvarchar](2000) NULL,
 CONSTRAINT [PK_ExtraColumns] PRIMARY KEY CLUSTERED 
(
	[TableName] ASC,
	[ColumnName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]