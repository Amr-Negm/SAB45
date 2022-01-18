/****** Object:  Table [dbo].[InvestigatEventsTable_Temp2]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[InvestigatEventsTable_Temp2](
	[EventID] [int] NULL,
	[EventCode] [nvarchar](250) NULL,
	[EventName] [nvarchar](250) NULL,
	[Occurance_Date] [datetime] NULL,
	[TouchPointID] [int] NULL,
	[TouchpointName] [nvarchar](250) NULL,
	[TouchPointTypeID] [int] NULL,
	[TouchPointTypeTitle1] [nvarchar](250) NULL,
	[TouchpointLocationName] [nvarchar](250) NULL,
	[ParentLocationName] [nvarchar](250) NULL,
	[StatusID] [int] NULL,
	[Algorithm] [nvarchar](50) NULL,
	[AlgorithmCategoryID] [int] NULL,
	[AlgorithmCategoryTitle1] [nvarchar](250) NULL,
	[TimeStamp] [bigint] NULL
) ON [PRIMARY]