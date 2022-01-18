/****** Object:  Table [dbo].[T_NotificationGroups]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_NotificationGroups](
	[NotificationGroupID] [int] IDENTITY(1,1) NOT NULL,
	[NotificationGroupSiteID] [int] NOT NULL,
	[NotificationGroupTitle1] [nvarchar](200) NULL,
	[NotificationGroupDescriptionTitle1] [nvarchar](4000) NULL,
	[StateID] [bit] NULL,
	[StatusID] [int] NULL,
 CONSTRAINT [NotificationGroups_PK] PRIMARY KEY CLUSTERED 
(
	[NotificationGroupID] ASC,
	[NotificationGroupSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]