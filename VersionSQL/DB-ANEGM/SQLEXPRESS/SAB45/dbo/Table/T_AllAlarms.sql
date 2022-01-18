/****** Object:  Table [dbo].[T_AllAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_AllAlarms](
	[CityTitle1] [nvarchar](200) NULL,
	[StationTitle1] [nvarchar](200) NULL,
	[LevelTitle1] [nvarchar](200) NULL,
	[ZoneID] [int] NOT NULL,
	[ZoneTitle1] [nvarchar](200) NULL,
	[TouchPointTitle1] [nvarchar](200) NULL,
	[TouchPointID] [int] NOT NULL,
	[Occurance_Date] [datetime] NULL,
	[AlarmID] [int] NOT NULL,
	[Response_Date] [datetime] NULL,
	[ResponseTimeDifference] [int] NULL,
	[AlarmDefinitionTitle1] [nvarchar](200) NULL,
	[ExpectedResponseTime] [float] NULL,
	[PriorityID] [int] NOT NULL,
	[AlarmStatusTitle1] [nvarchar](200) NULL,
	[PriorityTitle1] [nvarchar](200) NULL,
	[AlarmComment] [nvarchar](4000) NULL
) ON [PRIMARY]