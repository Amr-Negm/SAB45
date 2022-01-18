/****** Object:  Table [dbo].[T_EscalationLevels]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_EscalationLevels](
	[EscalationLevelID] [int] IDENTITY(1,1) NOT NULL,
	[EscalationLevelSiteID] [int] NOT NULL,
	[EscalationLevelTitle1] [nvarchar](200) NULL,
	[EscalationLevelDescriptionTitle1] [nvarchar](4000) NULL,
	[EscalationLevelCategoryID] [int] NULL,
	[EscalationLevelCode] [nvarchar](200) NULL,
	[StateID] [int] NULL,
	[StatusID] [int] NULL,
 CONSTRAINT [EscalationLevels_PK] PRIMARY KEY CLUSTERED 
(
	[EscalationLevelID] ASC,
	[EscalationLevelSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_EscalationLevelCategory] ON [dbo].[T_EscalationLevels]
(
	[EscalationLevelCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_EscalationLevels]  WITH CHECK ADD  CONSTRAINT [FK_EscalationLevelCategory] FOREIGN KEY([EscalationLevelCategoryID])
REFERENCES [dbo].[LT_EscalationLevelCategories] ([EscalationLevelCategoryID])
ALTER TABLE [dbo].[T_EscalationLevels] CHECK CONSTRAINT [FK_EscalationLevelCategory]