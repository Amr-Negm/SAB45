/****** Object:  Table [dbo].[LT_ParmLookups]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_ParmLookups](
	[ParmLookupID] [int] IDENTITY(1,1) NOT NULL,
	[TPParmID] [int] NULL,
	[TPParmSiteID] [int] NULL,
	[ParmLookupTitle1] [nvarchar](200) NULL,
	[ParmLookupTitle2] [nvarchar](200) NULL,
	[ParmLookupDescriptionTitle1] [nvarchar](4000) NULL,
	[ParmLookupDescriptionTitle2] [nvarchar](4000) NULL,
 CONSTRAINT [ParmLookups_PK] PRIMARY KEY CLUSTERED 
(
	[ParmLookupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_TouchPointParmLookups] ON [dbo].[LT_ParmLookups]
(
	[TPParmID] ASC,
	[TPParmSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[LT_ParmLookups]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointParmLookups] FOREIGN KEY([TPParmID], [TPParmSiteID])
REFERENCES [dbo].[T_TouchPointTypeParms] ([TPParmID], [TPParmSiteID])
ALTER TABLE [dbo].[LT_ParmLookups] CHECK CONSTRAINT [FK_TouchPointParmLookups]