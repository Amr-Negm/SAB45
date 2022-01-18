/****** Object:  Table [dbo].[LT_SessionTimeOutType]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_SessionTimeOutType](
	[SessionTimeOutTypeID] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [SessionTimeOutType_PK] PRIMARY KEY CLUSTERED 
(
	[SessionTimeOutTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]