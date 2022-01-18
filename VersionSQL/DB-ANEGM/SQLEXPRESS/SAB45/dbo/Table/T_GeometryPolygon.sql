/****** Object:  Table [dbo].[T_GeometryPolygon]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_GeometryPolygon](
	[GeometryPolygonID] [int] IDENTITY(1,1) NOT NULL,
	[LocationMapDataID] [int] NULL,
	[PolygonColor] [nvarchar](50) NULL,
	[MinZoomLevel] [float] NULL,
	[MaxZoomLevel] [float] NULL,
	[StrokeColor] [nvarchar](100) NULL,
	[StrokeWeight] [int] NULL,
	[FillOpacity] [float] NULL,
	[StrokeOpacity] [float] NULL,
	[StringPolygon] [nvarchar](max) NULL,
	[CaptureResolution] [nvarchar](20) NULL,
 CONSTRAINT [PK_GeometryPolygon] PRIMARY KEY CLUSTERED 
(
	[GeometryPolygonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_PolygonLocationMapData] ON [dbo].[T_GeometryPolygon]
(
	[LocationMapDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_GeometryPolygon]  WITH CHECK ADD  CONSTRAINT [FK_PolygonLocationMapData] FOREIGN KEY([LocationMapDataID])
REFERENCES [dbo].[T_LocationMapData] ([LocationMapDataID])
ALTER TABLE [dbo].[T_GeometryPolygon] CHECK CONSTRAINT [FK_PolygonLocationMapData]