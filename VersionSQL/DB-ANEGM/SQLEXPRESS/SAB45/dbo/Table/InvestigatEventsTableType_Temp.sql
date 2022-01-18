/****** Object:  Table [dbo].[InvestigatEventsTableType_Temp]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[InvestigatEventsTableType_Temp](
	[AlgorithmCategoryID] [int] NULL,
	[EventParmKey] [nvarchar](200) NULL,
	[StringValue] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]