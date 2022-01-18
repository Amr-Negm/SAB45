/****** Object:  Table [dbo].[T_Occasions]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Occasions](
	[OccasionId] [int] IDENTITY(1,1) NOT NULL,
	[OccasionSiteId] [int] NOT NULL,
	[OccasionName] [nvarchar](50) NULL,
	[OccasionStartDate] [datetime] NULL,
	[OccasionEndDate] [datetime] NULL,
	[TypeId] [int] NULL,
	[State] [bit] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Occasions] PRIMARY KEY CLUSTERED 
(
	[OccasionId] ASC,
	[OccasionSiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_OccasionTypes] ON [dbo].[T_Occasions]
(
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_Occasions]  WITH CHECK ADD  CONSTRAINT [FK_OccasionTypes] FOREIGN KEY([TypeId])
REFERENCES [dbo].[LT_OccasionTypes] ([TypeId])
ALTER TABLE [dbo].[T_Occasions] CHECK CONSTRAINT [FK_OccasionTypes]