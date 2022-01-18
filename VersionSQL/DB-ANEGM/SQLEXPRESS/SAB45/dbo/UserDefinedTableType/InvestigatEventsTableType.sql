/****** Object:  UserDefinedTableType [dbo].[InvestigatEventsTableType]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE TYPE [dbo].[InvestigatEventsTableType] AS TABLE(
	[AlgorithmCategoryID] [int] NULL,
	[EventParmKey] [varchar](200) NULL,
	[StringValue] [nvarchar](max) NULL
)