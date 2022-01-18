/****** Object:  Table [dbo].[T_TouchPointTypeParms]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_TouchPointTypeParms](
	[TPParmID] [int] IDENTITY(1,1) NOT NULL,
	[TPParmSiteID] [int] NOT NULL,
	[TouchPointTypeID] [int] NULL,
	[TouchPointParmKey] [nvarchar](200) NULL,
	[TouchPointParmTitle1] [nvarchar](200) NULL,
	[TouchPointParmTitle2] [nvarchar](200) NULL,
	[ParmKeyTypeID] [int] NULL,
	[AllowNull] [bit] NULL,
	[StateID] [int] NULL,
	[StatusID] [int] NULL,
	[Col1] [nvarchar](2000) NULL,
	[Col2] [nvarchar](2000) NULL,
	[Col3] [nvarchar](2000) NULL,
	[Col4] [varbinary](max) NULL,
	[Col5] [varbinary](max) NULL,
	[ISVisible] [bit] NULL,
 CONSTRAINT [PK_TouchPointTypeParms] PRIMARY KEY CLUSTERED 
(
	[TPParmID] ASC,
	[TPParmSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_TouchPointTypeParms] ON [dbo].[T_TouchPointTypeParms]
(
	[TouchPointTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_TouchPointTypeParmsKeyTypes] ON [dbo].[T_TouchPointTypeParms]
(
	[ParmKeyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_TouchPointTypeParms]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointTypeParms] FOREIGN KEY([TouchPointTypeID])
REFERENCES [dbo].[LT_TouchPointTypes] ([TouchPointTypeID])
ALTER TABLE [dbo].[T_TouchPointTypeParms] CHECK CONSTRAINT [FK_TouchPointTypeParms]
ALTER TABLE [dbo].[T_TouchPointTypeParms]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointTypeParmsKeyTypes] FOREIGN KEY([ParmKeyTypeID])
REFERENCES [dbo].[LT_ParmKeyTypes] ([ParmKeyTypeID])
ALTER TABLE [dbo].[T_TouchPointTypeParms] CHECK CONSTRAINT [FK_TouchPointTypeParmsKeyTypes]