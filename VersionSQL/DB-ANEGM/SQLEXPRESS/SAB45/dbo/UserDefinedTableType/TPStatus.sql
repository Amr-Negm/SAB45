/****** Object:  UserDefinedTableType [dbo].[TPStatus]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE TYPE [dbo].[TPStatus] AS TABLE(
	[TouchPointID] [int] NULL,
	[StringValue] [nvarchar](150) NULL
)