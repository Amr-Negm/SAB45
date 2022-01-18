/****** Object:  Table [dbo].[T_TouchPointGeographyDetails]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_TouchPointGeographyDetails](
	[TouchPointGeographyID] [int] IDENTITY(1,1) NOT NULL,
	[TouchPointID] [int] NULL,
	[RotationAngle] [float] NULL,
	[ZoomLevel] [float] NULL,
	[MapTypeID] [int] NULL,
	[X_Coordination] [nvarchar](max) NULL,
	[Y_Coordination] [nvarchar](max) NULL,
	[CaptureResolution] [nvarchar](20) NULL,
	[MinZoomLevel] [float] NULL,
	[MaxZoomLevel] [float] NULL,
	[FlipHorizontal] [bit] NULL,
	[FlipVertical] [bit] NULL,
 CONSTRAINT [PK_TouchPointGeographyDetails] PRIMARY KEY CLUSTERED 
(
	[TouchPointGeographyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_TouchPointGeography] ON [dbo].[T_TouchPointGeographyDetails]
(
	[TouchPointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_TouchPointGeographyMapType] ON [dbo].[T_TouchPointGeographyDetails]
(
	[MapTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_TouchPointGeographyDetails] ADD  DEFAULT ((0)) FOR [FlipHorizontal]
ALTER TABLE [dbo].[T_TouchPointGeographyDetails] ADD  DEFAULT ((0)) FOR [FlipVertical]
ALTER TABLE [dbo].[T_TouchPointGeographyDetails]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointGeography] FOREIGN KEY([TouchPointID])
REFERENCES [dbo].[T_TouchPoints] ([TouchPointID])
ALTER TABLE [dbo].[T_TouchPointGeographyDetails] CHECK CONSTRAINT [FK_TouchPointGeography]
ALTER TABLE [dbo].[T_TouchPointGeographyDetails]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointGeographyMapType] FOREIGN KEY([MapTypeID])
REFERENCES [dbo].[LT_MapType] ([MapTypeID])
ALTER TABLE [dbo].[T_TouchPointGeographyDetails] CHECK CONSTRAINT [FK_TouchPointGeographyMapType]