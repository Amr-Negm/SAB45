/****** Object:  Table [dbo].[T_ScenariosPerLocationLog]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_ScenariosPerLocationLog](
	[ScenarioLogID] [int] NOT NULL,
	[CityTitle] [nvarchar](100) NULL,
	[Priority] [nvarchar](100) NULL,
	[PTotal] [int] NULL,
	[ActionDate] [datetime] NULL
) ON [PRIMARY]