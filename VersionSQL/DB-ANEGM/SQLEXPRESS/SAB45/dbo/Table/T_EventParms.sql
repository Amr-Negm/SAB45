/****** Object:  Table [dbo].[T_EventParms]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_EventParms](
	[EventParmID] [int] IDENTITY(1,1) NOT NULL,
	[EventParmSiteID] [int] NOT NULL,
	[EventID] [int] NULL,
	[EventSiteID] [int] NULL,
	[EventParmKey] [nvarchar](200) NULL,
	[ParmKeyTypeID] [int] NULL,
	[StringValue] [nvarchar](max) NULL,
	[BinaryValue] [varbinary](max) NULL,
	[AllowNull] [bit] NULL,
	[StateID] [int] NULL,
	[StatusID] [int] NULL,
	[Col1] [nvarchar](2000) NULL,
	[Col2] [nvarchar](2000) NULL,
	[Col3] [nvarchar](2000) NULL,
	[Col4] [varbinary](max) NULL,
	[Col5] [varbinary](max) NULL,
 CONSTRAINT [PK_EventParms] PRIMARY KEY CLUSTERED 
(
	[EventParmID] ASC,
	[EventParmSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_EventParmKeyTypes] ON [dbo].[T_EventParms]
(
	[ParmKeyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_EventParms] ON [dbo].[T_EventParms]
(
	[EventID] ASC,
	[EventSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_EventParms]  WITH CHECK ADD  CONSTRAINT [FK_EventParmKeyTypes] FOREIGN KEY([ParmKeyTypeID])
REFERENCES [dbo].[LT_ParmKeyTypes] ([ParmKeyTypeID])
ALTER TABLE [dbo].[T_EventParms] CHECK CONSTRAINT [FK_EventParmKeyTypes]
ALTER TABLE [dbo].[T_EventParms]  WITH CHECK ADD  CONSTRAINT [FK_EventParms] FOREIGN KEY([EventID], [EventSiteID])
REFERENCES [dbo].[T_Events] ([EventID], [EventSiteID])
ALTER TABLE [dbo].[T_EventParms] CHECK CONSTRAINT [FK_EventParms]