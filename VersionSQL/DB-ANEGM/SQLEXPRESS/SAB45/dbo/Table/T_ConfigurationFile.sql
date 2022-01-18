/****** Object:  Table [dbo].[T_ConfigurationFile]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_ConfigurationFile](
	[ConfigurationFileID] [int] IDENTITY(1,1) NOT NULL,
	[ConfigurationID] [int] NULL,
	[File] [varbinary](max) NULL,
 CONSTRAINT [PK_ConfigurationFile] PRIMARY KEY CLUSTERED 
(
	[ConfigurationFileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ConfigurationFile] ON [dbo].[T_ConfigurationFile]
(
	[ConfigurationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_ConfigurationFile]  WITH CHECK ADD  CONSTRAINT [FK_ConfigurationFile] FOREIGN KEY([ConfigurationID])
REFERENCES [dbo].[T_Configuration] ([ConfigurationID])
ALTER TABLE [dbo].[T_ConfigurationFile] CHECK CONSTRAINT [FK_ConfigurationFile]