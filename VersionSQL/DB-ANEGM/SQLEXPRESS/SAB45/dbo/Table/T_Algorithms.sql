/****** Object:  Table [dbo].[T_Algorithms]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Algorithms](
	[AlgorithmID] [int] IDENTITY(1,1) NOT NULL,
	[AlgorithmSiteID] [int] NOT NULL,
	[AlgorithmTitle1] [nvarchar](200) NULL,
	[AlgorithmDescriptionTitle1] [nvarchar](4000) NULL,
	[AlgorithmCategoryID] [int] NOT NULL,
	[AlgorithmCode] [nvarchar](200) NULL,
	[StateID] [int] NULL,
	[StatusID] [int] NULL,
 CONSTRAINT [Algorithms_PK] PRIMARY KEY CLUSTERED 
(
	[AlgorithmID] ASC,
	[AlgorithmSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_AlgorithmAlgorithmCategory] ON [dbo].[T_Algorithms]
(
	[AlgorithmCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_Algorithms]  WITH CHECK ADD  CONSTRAINT [FK_AlgorithmCategoriesAlgorithm] FOREIGN KEY([AlgorithmCategoryID])
REFERENCES [dbo].[LT_AlgorithmCategories] ([AlgorithmCategoryID])
ALTER TABLE [dbo].[T_Algorithms] CHECK CONSTRAINT [FK_AlgorithmCategoriesAlgorithm]