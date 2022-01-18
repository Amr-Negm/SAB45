/****** Object:  Table [dbo].[LT_ActionBehaviors]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_ActionBehaviors](
	[ActionBehaviorID] [int] IDENTITY(1,1) NOT NULL,
	[ActionBehaviorTitle1] [nvarchar](200) NULL,
	[ActionBehaviorTitle2] [nvarchar](200) NULL,
	[ActionBehaviorDescriptionTitle1] [nvarchar](4000) NULL,
	[ActionBehaviorDescriptionTitle2] [nvarchar](4000) NULL,
 CONSTRAINT [ActionBehaviors_PK] PRIMARY KEY CLUSTERED 
(
	[ActionBehaviorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]