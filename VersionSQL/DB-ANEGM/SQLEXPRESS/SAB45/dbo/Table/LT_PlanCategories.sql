/****** Object:  Table [dbo].[LT_PlanCategories]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_PlanCategories](
	[PlanCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[PlanCategoryTitle1] [nvarchar](200) NULL,
	[PlanCategoryTitle2] [nvarchar](200) NULL,
	[PlanCategoryDescriptionTitle1] [nvarchar](4000) NULL,
	[PlanCategoryDescriptionTitle2] [nvarchar](4000) NULL,
 CONSTRAINT [PlanCategories_PK] PRIMARY KEY CLUSTERED 
(
	[PlanCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]