/****** Object:  UserDefinedTableType [dbo].[InvestigatAlarmsTableType]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE TYPE [dbo].[InvestigatAlarmsTableType] AS TABLE(
	[AlgorithmCategoryID] [int] NULL,
	[EventParmKey] [nvarchar](200) NULL,
	[StringValue] [nvarchar](max) NULL
)