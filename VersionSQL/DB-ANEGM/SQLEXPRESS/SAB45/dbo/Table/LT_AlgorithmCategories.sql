/****** Object:  Table [dbo].[LT_AlgorithmCategories]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_AlgorithmCategories](
	[AlgorithmCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[AlgorithmCategoryTitle1] [nvarchar](200) NULL,
	[AlgorithmCategoryTitle2] [nvarchar](200) NULL,
	[AlgorithmCategoryDescriptionTitle1] [nvarchar](4000) NULL,
	[AlgorithmCategoryDescriptionTitle2] [nvarchar](4000) NULL,
	[AlgorithmCategoryCode] [nvarchar](250) NULL,
 CONSTRAINT [AlgorithmCategories_PK] PRIMARY KEY CLUSTERED 
(
	[AlgorithmCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_AlgorithmCat] UNIQUE NONCLUSTERED 
(
	[AlgorithmCategoryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]