/****** Object:  Table [dbo].[LT_ActionCategories]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_ActionCategories](
	[ActionCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ActionCategoryTitle1] [nvarchar](200) NULL,
	[ActionCategoryTitle2] [nvarchar](200) NULL,
	[ActionCategoryDescriptionTitle1] [nvarchar](4000) NULL,
	[ActionCategoryDescriptionTitle2] [nvarchar](4000) NULL,
 CONSTRAINT [ActionCategories_PK] PRIMARY KEY CLUSTERED 
(
	[ActionCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]