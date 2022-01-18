/****** Object:  Table [dbo].[InvestigatAlarmsTable_Temp]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[InvestigatAlarmsTable_Temp](
	[AlarmID] [int] NULL,
	[EventID] [int] NULL,
	[AlarmStatusID] [int] NULL,
	[AlarmStatusTitle1] [nvarchar](250) NULL,
	[AlarmCategoryID] [int] NULL,
	[AlarmCategoryTitle1] [nvarchar](250) NULL,
	[AlarmClassificationID] [int] NULL,
	[AlarmClassificationTitle1] [nvarchar](250) NULL,
	[AlarmCode] [nvarchar](250) NULL,
	[AlarmDefinitionID] [int] NULL,
	[AlarmDefinitionTitle1] [nvarchar](250) NULL,
	[Occurance_Date] [datetime] NULL,
	[Response_User] [nvarchar](250) NULL,
	[Response_Date] [datetime] NULL,
	[TouchpointName] [nvarchar](250) NULL,
	[TouchPointTypeID] [int] NULL,
	[TouchpointLocationId] [int] NULL,
	[TouchpointLocationName] [nvarchar](250) NULL,
	[ParentLocationId] [int] NULL,
	[ParentLocationName] [nvarchar](250) NULL,
	[EventName] [nvarchar](250) NULL,
	[ScenarioTitle1] [nvarchar](250) NULL
) ON [PRIMARY]