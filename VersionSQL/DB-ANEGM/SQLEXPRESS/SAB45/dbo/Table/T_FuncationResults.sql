/****** Object:  Table [dbo].[T_FuncationResults]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_FuncationResults](
	[FunId] [int] NOT NULL,
	[ActionDate] [datetime2](7) NULL,
	[RetrunValue] [nvarchar](100) NULL,
 CONSTRAINT [PK_FuncationResults] PRIMARY KEY CLUSTERED 
(
	[FunId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_FuncationResults] ADD  DEFAULT (getdate()) FOR [ActionDate]