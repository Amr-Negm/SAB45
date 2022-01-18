/****** Object:  Table [dbo].[LT_EscalationLevelCategories]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_EscalationLevelCategories](
	[EscalationLevelCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[EscalationLevelCategoryTitle1] [nvarchar](200) NULL,
	[EscalationLevelCategoryTitle2] [nvarchar](200) NULL,
	[EscalationLevelCategoryDescriptionTitle1] [nvarchar](4000) NULL,
	[EscalationLevelCategoryDescriptionTitle2] [nvarchar](4000) NULL,
 CONSTRAINT [EscalationLevelCategories_PK] PRIMARY KEY CLUSTERED 
(
	[EscalationLevelCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]