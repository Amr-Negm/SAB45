/****** Object:  Table [dbo].[T_NotificationGroupsClients]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_NotificationGroupsClients](
	[NotificationClientID] [int] NOT NULL,
	[NotificationClientSiteID] [int] NOT NULL,
	[NotificationGroupID] [int] NOT NULL,
	[NotificationGroupSiteID] [int] NOT NULL,
 CONSTRAINT [NotificationGroupsClients_PK] PRIMARY KEY CLUSTERED 
(
	[NotificationClientID] ASC,
	[NotificationGroupID] ASC,
	[NotificationClientSiteID] ASC,
	[NotificationGroupSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_NotificationGroupsClients]  WITH CHECK ADD  CONSTRAINT [FK_NotificationGroupClientsNotificationClient] FOREIGN KEY([NotificationClientID], [NotificationClientSiteID])
REFERENCES [dbo].[T_NotificationClients] ([NotificationClientID], [NotificationClientSiteID])
ALTER TABLE [dbo].[T_NotificationGroupsClients] CHECK CONSTRAINT [FK_NotificationGroupClientsNotificationClient]
ALTER TABLE [dbo].[T_NotificationGroupsClients]  WITH CHECK ADD  CONSTRAINT [FK_NotificationGroupClientsNotificationGroup] FOREIGN KEY([NotificationGroupID], [NotificationGroupSiteID])
REFERENCES [dbo].[T_NotificationGroups] ([NotificationGroupID], [NotificationGroupSiteID])
ALTER TABLE [dbo].[T_NotificationGroupsClients] CHECK CONSTRAINT [FK_NotificationGroupClientsNotificationGroup]