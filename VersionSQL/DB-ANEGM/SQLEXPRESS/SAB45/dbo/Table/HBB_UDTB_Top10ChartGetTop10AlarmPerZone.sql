/****** Object:  Table [dbo].[HBB_UDTB_Top10ChartGetTop10AlarmPerZone]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[HBB_UDTB_Top10ChartGetTop10AlarmPerZone](
	[ActionId] [bigint] IDENTITY(1,1) NOT NULL,
	[ActionDate] [datetime2](7) NULL,
	[ZoneName] [nvarchar](150) NULL,
	[No_OF_Alarm] [nvarchar](150) NULL,
	[AvgerageBerHour] [nvarchar](150) NULL,
	[Level] [nvarchar](150) NULL,
	[ZoneID] [int] NULL,
	[StoredProcedureID] [int] NULL,
	[Periodid] [int] NULL
) ON [PRIMARY]