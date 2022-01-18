/****** Object:  Table [dbo].[T_Plans]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Plans](
	[PlanID] [int] IDENTITY(1,1) NOT NULL,
	[PlanSiteID] [int] NOT NULL,
	[PlanTitle1] [nvarchar](200) NULL,
	[PlanDescriptionTitle1] [nvarchar](4000) NULL,
	[PlanCode] [nvarchar](200) NULL,
	[PlanXML] [xml] NULL,
	[StateID] [int] NULL,
	[PlanCategoryID] [int] NOT NULL,
	[StatusID] [int] NULL,
 CONSTRAINT [Plans_PK] PRIMARY KEY CLUSTERED 
(
	[PlanID] ASC,
	[PlanSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_PlanPlanCategory] ON [dbo].[T_Plans]
(
	[PlanCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_Plans]  WITH CHECK ADD  CONSTRAINT [FK_PlanPlanCategory] FOREIGN KEY([PlanCategoryID])
REFERENCES [dbo].[LT_PlanCategories] ([PlanCategoryID])
ALTER TABLE [dbo].[T_Plans] CHECK CONSTRAINT [FK_PlanPlanCategory]