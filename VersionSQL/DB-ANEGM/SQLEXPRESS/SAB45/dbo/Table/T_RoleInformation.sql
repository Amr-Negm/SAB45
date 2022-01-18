/****** Object:  Table [dbo].[T_RoleInformation]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_RoleInformation](
	[RoleInformationID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Value] [nvarchar](200) NULL,
 CONSTRAINT [PK_RoleInformation] PRIMARY KEY CLUSTERED 
(
	[RoleInformationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_RoleInformation] ON [dbo].[T_RoleInformation]
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_RoleInformation]  WITH CHECK ADD  CONSTRAINT [FK_RoleInformation] FOREIGN KEY([RoleID])
REFERENCES [dbo].[T_Role] ([RoleID])
ALTER TABLE [dbo].[T_RoleInformation] CHECK CONSTRAINT [FK_RoleInformation]