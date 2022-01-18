/****** Object:  Table [dbo].[LT_TouchPointTypes]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_TouchPointTypes](
	[TouchPointTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TouchPointTypeTitle1] [nvarchar](200) NULL,
	[TouchPointTypeTitle2] [nvarchar](200) NULL,
	[TouchPointTypeDescriptionTitle1] [nvarchar](4000) NULL,
	[TouchPointTypeDescriptionTitle2] [nvarchar](4000) NULL,
	[TouchPointTypeICON] [varbinary](max) NULL,
	[TouchPointCategoryID] [int] NULL,
	[TouchPointTypeAlarmICON] [varbinary](max) NULL,
	[MapMarkerICON] [varbinary](max) NULL,
	[MapMarkerAlarmICON] [varbinary](max) NULL,
	[TouchPointTypeSelectedICON] [varbinary](max) NULL,
	[ImageFormat] [nvarchar](50) NULL,
	[IsActionable] [bit] NULL,
	[Code] [nvarchar](200) NULL,
 CONSTRAINT [TouchPointTypes_PK] PRIMARY KEY CLUSTERED 
(
	[TouchPointTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_TPT_Code] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_TouchPointCategories] ON [dbo].[LT_TouchPointTypes]
(
	[TouchPointCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[LT_TouchPointTypes]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointCategories] FOREIGN KEY([TouchPointCategoryID])
REFERENCES [dbo].[LT_TouchPointCategories] ([TouchPointCategoryID])
ALTER TABLE [dbo].[LT_TouchPointTypes] CHECK CONSTRAINT [FK_TouchPointCategories]