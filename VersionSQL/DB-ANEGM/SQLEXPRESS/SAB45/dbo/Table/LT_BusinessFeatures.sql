/****** Object:  Table [dbo].[LT_BusinessFeatures]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_BusinessFeatures](
	[BusinessFeatures_ID] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
	[StateID] [int] NULL,
 CONSTRAINT [PK_LT_BusinessFeatures] PRIMARY KEY CLUSTERED 
(
	[BusinessFeatures_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_BussinessFeaturesState] ON [dbo].[LT_BusinessFeatures]
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[LT_BusinessFeatures]  WITH CHECK ADD  CONSTRAINT [FK_State_BussinessFeatures] FOREIGN KEY([StateID])
REFERENCES [dbo].[LT_State] ([StateID])
ALTER TABLE [dbo].[LT_BusinessFeatures] CHECK CONSTRAINT [FK_State_BussinessFeatures]