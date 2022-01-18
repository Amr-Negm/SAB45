/****** Object:  Table [dbo].[T_TouchPointTypeActions]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_TouchPointTypeActions](
	[TouchpointTypeActionID] [int] IDENTITY(1,1) NOT NULL,
	[TouchPointTypeID] [int] NOT NULL,
	[ActionTitle1] [nvarchar](100) NULL,
	[ActionTitle2] [nvarchar](100) NULL,
	[ActionCode] [nvarchar](50) NULL,
	[SequenceID] [int] NULL,
	[Icon] [image] NULL,
	[StatusID] [int] NULL,
	[Description] [nvarchar](1000) NULL,
	[StateID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TouchpointTypeActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[T_TouchPointTypeActions]  WITH CHECK ADD  CONSTRAINT [FK_T_TouchPointTypeActions_LT_State] FOREIGN KEY([StateID])
REFERENCES [dbo].[LT_State] ([StateID])
ALTER TABLE [dbo].[T_TouchPointTypeActions] CHECK CONSTRAINT [FK_T_TouchPointTypeActions_LT_State]
ALTER TABLE [dbo].[T_TouchPointTypeActions]  WITH CHECK ADD  CONSTRAINT [FK_T_TouchPointTypeActions_LT_TouchPointTypes] FOREIGN KEY([TouchPointTypeID])
REFERENCES [dbo].[LT_TouchPointTypes] ([TouchPointTypeID])
ALTER TABLE [dbo].[T_TouchPointTypeActions] CHECK CONSTRAINT [FK_T_TouchPointTypeActions_LT_TouchPointTypes]