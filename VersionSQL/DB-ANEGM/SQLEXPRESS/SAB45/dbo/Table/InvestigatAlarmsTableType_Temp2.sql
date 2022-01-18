/****** Object:  Table [dbo].[InvestigatAlarmsTableType_Temp2]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[InvestigatAlarmsTableType_Temp2](
	[AlarmCategoryID] [int] NULL,
	[EventParmKey] [nvarchar](200) NULL,
	[StringValue] [nvarchar](max) NULL,
	[TimeStamp] [bigint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]