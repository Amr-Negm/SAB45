/****** Object:  Table [dbo].[LT_TouchPointCategories]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_TouchPointCategories](
	[TouchPointCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[TouchPointCategoryTitle1] [nvarchar](200) NULL,
	[TouchPointCategoryTitle2] [nvarchar](200) NULL,
	[TouchPointCategoryDescriptionTitle1] [nvarchar](4000) NULL,
	[TouchPointCategoryDescriptionTitle2] [nvarchar](4000) NULL,
	[Code] [nvarchar](200) NULL,
 CONSTRAINT [TouchPointCategories_PK] PRIMARY KEY CLUSTERED 
(
	[TouchPointCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_TPCat_Code] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]