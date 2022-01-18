/****** Object:  Table [dbo].[T_ConfigurationValue]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_ConfigurationValue](
	[ConfigurationValueID] [int] IDENTITY(1,1) NOT NULL,
	[ConfigurationID] [int] NULL,
	[Value] [nvarchar](200) NULL,
	[IsKey] [bit] NULL,
 CONSTRAINT [PK_ConfigurationList] PRIMARY KEY CLUSTERED 
(
	[ConfigurationValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_ConfigurationValue] ADD  CONSTRAINT [IskeyDef]  DEFAULT ((0)) FOR [IsKey]
ALTER TABLE [dbo].[T_ConfigurationValue]  WITH CHECK ADD  CONSTRAINT [FK_ConfigurationValue] FOREIGN KEY([ConfigurationID])
REFERENCES [dbo].[T_Configuration] ([ConfigurationID])
ALTER TABLE [dbo].[T_ConfigurationValue] CHECK CONSTRAINT [FK_ConfigurationValue]