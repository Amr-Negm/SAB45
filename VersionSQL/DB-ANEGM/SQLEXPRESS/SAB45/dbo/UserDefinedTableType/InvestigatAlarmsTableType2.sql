/****** Object:  UserDefinedTableType [dbo].[InvestigatAlarmsTableType2]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE TYPE [dbo].[InvestigatAlarmsTableType2] AS TABLE(
	[AlarmCategoryID] [int] NULL,
	[EventParmKey] [nvarchar](200) NULL,
	[StringValue] [nvarchar](max) NULL
)