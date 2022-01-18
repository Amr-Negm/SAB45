/****** Object:  Table [dbo].[HBB_Temp_Top10ResultsZone]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[HBB_Temp_Top10ResultsZone](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ZoneName] [nvarchar](200) NULL,
	[No_OF_Alarm] [nvarchar](200) NULL,
	[AvgerageBerHour] [nvarchar](200) NULL,
	[Level] [nvarchar](200) NULL,
	[ZoneID] [int] NULL,
	[StoredProcedureID] [int] NULL
) ON [PRIMARY]