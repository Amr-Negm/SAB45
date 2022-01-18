/****** Object:  Table [dbo].[LT_ScenarioImpacts]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_ScenarioImpacts](
	[ScenarioImpactID] [int] IDENTITY(1,1) NOT NULL,
	[ScenarioImpactTitle1] [nvarchar](200) NULL,
	[ScenarioImpactTitle2] [nvarchar](200) NULL,
	[ScenarioImpactFrom] [int] NULL,
	[ScenarioImpactTo] [int] NULL,
	[ScenarioImpactDescriptionTitle1] [nvarchar](4000) NULL,
	[ScenarioImpactDescriptionTitle2] [nvarchar](4000) NULL,
 CONSTRAINT [ScenarioImpacts_PK] PRIMARY KEY CLUSTERED 
(
	[ScenarioImpactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]