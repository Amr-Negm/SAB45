/****** Object:  Table [dbo].[T_ConfigurationAdmin]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_ConfigurationAdmin](
	[ConfigurationID] [int] NOT NULL,
	[ConfigurationDataTypeID] [int] NULL,
	[AliasName] [nvarchar](50) NULL,
	[ConfigurationTypeID] [int] NULL,
	[LocalizedAliasName] [nvarchar](max) NULL,
 CONSTRAINT [PK_ConfigurationAdmin] PRIMARY KEY CLUSTERED 
(
	[ConfigurationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ConfigurationAdminConfigurationType] ON [dbo].[T_ConfigurationAdmin]
(
	[ConfigurationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ConfigurationAdminDataType] ON [dbo].[T_ConfigurationAdmin]
(
	[ConfigurationDataTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_ConfigurationAdmin]  WITH CHECK ADD  CONSTRAINT [FK_Configuration] FOREIGN KEY([ConfigurationID])
REFERENCES [dbo].[T_Configuration] ([ConfigurationID])
ALTER TABLE [dbo].[T_ConfigurationAdmin] CHECK CONSTRAINT [FK_Configuration]
ALTER TABLE [dbo].[T_ConfigurationAdmin]  WITH CHECK ADD  CONSTRAINT [FK_ConfigurationAdminConfigurationType] FOREIGN KEY([ConfigurationTypeID])
REFERENCES [dbo].[LT_ConfigurationType] ([ConfigurationTypeID])
ALTER TABLE [dbo].[T_ConfigurationAdmin] CHECK CONSTRAINT [FK_ConfigurationAdminConfigurationType]
ALTER TABLE [dbo].[T_ConfigurationAdmin]  WITH CHECK ADD  CONSTRAINT [FK_ConfigurationAdminDataType] FOREIGN KEY([ConfigurationDataTypeID])
REFERENCES [dbo].[LT_ConfigurationDataType] ([ConfigurationDataTypeID])
ALTER TABLE [dbo].[T_ConfigurationAdmin] CHECK CONSTRAINT [FK_ConfigurationAdminDataType]