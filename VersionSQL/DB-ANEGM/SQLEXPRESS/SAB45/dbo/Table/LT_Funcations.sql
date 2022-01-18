/****** Object:  Table [dbo].[LT_Funcations]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_Funcations](
	[FunId] [int] NOT NULL,
	[FuncationName] [nvarchar](200) NULL,
 CONSTRAINT [PK_Funcations] PRIMARY KEY CLUSTERED 
(
	[FunId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]