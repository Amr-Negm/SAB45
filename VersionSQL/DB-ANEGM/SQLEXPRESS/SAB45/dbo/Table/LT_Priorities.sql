/****** Object:  Table [dbo].[LT_Priorities]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_Priorities](
	[PriorityID] [int] IDENTITY(1,1) NOT NULL,
	[PriorityTitle1] [nvarchar](200) NULL,
	[PriorityTitle2] [nvarchar](200) NULL,
	[PriorityDescriptionTitle1] [nvarchar](4000) NULL,
	[PriorityDescriptionTitle2] [nvarchar](4000) NULL,
	[OrderID] [int] NULL,
 CONSTRAINT [Priorities_PK] PRIMARY KEY CLUSTERED 
(
	[PriorityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]