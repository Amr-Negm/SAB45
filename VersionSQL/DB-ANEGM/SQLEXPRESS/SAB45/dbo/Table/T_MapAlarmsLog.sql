/****** Object:  Table [dbo].[T_MapAlarmsLog]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_MapAlarmsLog](
	[MapAlarmsLogID] [int] NOT NULL,
	[Longitude] [nvarchar](200) NULL,
	[Latitude] [nvarchar](200) NULL,
	[StationTitle1] [nvarchar](200) NULL,
	[AlarmID] [int] NULL,
	[ActionDate] [datetime] NULL
) ON [PRIMARY]