/****** Object:  Table [dbo].[T_NotificationClients]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_NotificationClients](
	[NotificationClientID] [int] IDENTITY(1,1) NOT NULL,
	[NotificationClientSiteID] [int] NOT NULL,
	[NotificationClientStandardCode] [nvarchar](200) NULL,
	[NotificationClientCode] [nvarchar](200) NULL,
	[DeviceCode] [nvarchar](500) NULL,
	[NotificationClientTitle1] [nvarchar](200) NULL,
	[NotificationClientDescriptionTitle1] [nvarchar](4000) NULL,
	[NotificationClientIP] [nvarchar](200) NULL,
	[NotificationClientPort] [int] NULL,
	[StateID] [bit] NULL,
	[StatusID] [int] NULL,
 CONSTRAINT [NotificationClients_PK] PRIMARY KEY CLUSTERED 
(
	[NotificationClientID] ASC,
	[NotificationClientSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [NotificationClientStandardCode] UNIQUE NONCLUSTERED 
(
	[NotificationClientStandardCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]