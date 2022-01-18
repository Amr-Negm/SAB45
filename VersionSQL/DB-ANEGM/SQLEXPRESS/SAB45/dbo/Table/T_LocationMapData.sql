/****** Object:  Table [dbo].[T_LocationMapData]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_LocationMapData](
	[LocationMapDataID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NOT NULL,
	[MapTypeID] [int] NULL,
	[GeographyZoomLevel] [float] NULL,
	[MapFileID] [int] NULL,
	[StateID] [int] NULL,
	[HasImage] [bit] NULL,
	[X_Coordination] [nvarchar](max) NULL,
	[Y_Coordination] [nvarchar](max) NULL,
 CONSTRAINT [PK_LocationMapData] PRIMARY KEY CLUSTERED 
(
	[LocationMapDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_LocationMapData] ON [dbo].[T_LocationMapData]
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_LocationMapDataFile] ON [dbo].[T_LocationMapData]
(
	[MapFileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_LocationMapDataState] ON [dbo].[T_LocationMapData]
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_MapType] ON [dbo].[T_LocationMapData]
(
	[MapTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_LocationMapData] ADD  CONSTRAINT [DF_T_LocationMapData_HasImage]  DEFAULT ((1)) FOR [HasImage]
ALTER TABLE [dbo].[T_LocationMapData]  WITH CHECK ADD  CONSTRAINT [FK_LocationMapData] FOREIGN KEY([LocationID])
REFERENCES [dbo].[T_Location] ([LocationID])
ALTER TABLE [dbo].[T_LocationMapData] CHECK CONSTRAINT [FK_LocationMapData]
ALTER TABLE [dbo].[T_LocationMapData]  WITH CHECK ADD  CONSTRAINT [FK_LocationMapDataFile] FOREIGN KEY([MapFileID])
REFERENCES [dbo].[T_MapFile] ([MapFileID])
ALTER TABLE [dbo].[T_LocationMapData] CHECK CONSTRAINT [FK_LocationMapDataFile]
ALTER TABLE [dbo].[T_LocationMapData]  WITH CHECK ADD  CONSTRAINT [FK_LocationMapDataState] FOREIGN KEY([StateID])
REFERENCES [dbo].[LT_State] ([StateID])
ALTER TABLE [dbo].[T_LocationMapData] CHECK CONSTRAINT [FK_LocationMapDataState]
ALTER TABLE [dbo].[T_LocationMapData]  WITH CHECK ADD  CONSTRAINT [FK_MapType] FOREIGN KEY([MapTypeID])
REFERENCES [dbo].[LT_MapType] ([MapTypeID])
ALTER TABLE [dbo].[T_LocationMapData] CHECK CONSTRAINT [FK_MapType]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


-- =============================================
-- Author:		Shahed
-- Create date: 16 July 2020
-- Description:	To keep event definition iin sab events db updated
-- =============================================
Create TRIGGER [dbo].[NewLocationMapData]
   ON  [dbo].[T_LocationMapData]
   AFTER INSERT , UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

ALTER TABLE [SAB45_Events].[dbo].[T_LocationMapData] DROP CONSTRAINT [FK_LocationMapDataFile]

DELETE [SAB45_Events].[dbo].[T_LocationMapData] WHERE LocationMapDataID IN (SELECT LocationMapDataID FROM deleted d)

INSERT [SAB45_Events].[dbo].[T_LocationMapData] SELECT * FROM inserted i

ALTER TABLE [SAB45_Events].[dbo].[T_LocationMapData]  WITH NOCHECK ADD  CONSTRAINT [FK_LocationMapDataFile] FOREIGN KEY([MapFileID])
REFERENCES [SAB45_Events].[dbo].[T_MapFile] ([MapFileID])

END

ALTER TABLE [dbo].[T_LocationMapData] ENABLE TRIGGER [NewLocationMapData]