/****** Object:  Table [dbo].[LT_ConfigurationStaticListValue]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_ConfigurationStaticListValue](
	[StaticListValueID] [int] IDENTITY(1,1) NOT NULL,
	[ConfigurationID] [int] NULL,
	[Value] [nvarchar](50) NULL,
	[LocalizedValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_ConfigurationStaticListValue] PRIMARY KEY CLUSTERED 
(
	[StaticListValueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ConfigurationStaticListValueConfigurationAdmin] ON [dbo].[LT_ConfigurationStaticListValue]
(
	[ConfigurationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[LT_ConfigurationStaticListValue]  WITH CHECK ADD  CONSTRAINT [FK_ConfigurationStaticListValueConfigurationAdmin] FOREIGN KEY([ConfigurationID])
REFERENCES [dbo].[T_ConfigurationAdmin] ([ConfigurationID])
ALTER TABLE [dbo].[LT_ConfigurationStaticListValue] CHECK CONSTRAINT [FK_ConfigurationStaticListValueConfigurationAdmin]