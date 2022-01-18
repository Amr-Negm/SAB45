/****** Object:  Table [dbo].[T_Configuration]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Configuration](
	[ConfigurationID] [int] IDENTITY(1,1) NOT NULL,
	[KEY] [nvarchar](200) NULL,
	[Description] [nvarchar](2000) NULL,
	[SectionNameID] [int] NULL,
	[LocalizedDescription] [nvarchar](max) NULL,
 CONSTRAINT [PK_Configuration] PRIMARY KEY CLUSTERED 
(
	[ConfigurationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ConfigurationSectionName] ON [dbo].[T_Configuration]
(
	[SectionNameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_Configuration]  WITH CHECK ADD  CONSTRAINT [FK_ConfigurationSectionName] FOREIGN KEY([SectionNameID])
REFERENCES [dbo].[LT_ConfigurationSectionName] ([SectionNameID])
ALTER TABLE [dbo].[T_Configuration] CHECK CONSTRAINT [FK_ConfigurationSectionName]