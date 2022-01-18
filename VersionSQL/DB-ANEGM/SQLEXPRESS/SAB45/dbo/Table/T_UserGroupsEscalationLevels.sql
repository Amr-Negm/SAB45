/****** Object:  Table [dbo].[T_UserGroupsEscalationLevels]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_UserGroupsEscalationLevels](
	[UserGroupID] [int] NOT NULL,
	[EscalationLevelID] [int] NOT NULL,
	[EscalationLevelSiteID] [int] NOT NULL,
 CONSTRAINT [UserGroupsEscalation_PK] PRIMARY KEY CLUSTERED 
(
	[UserGroupID] ASC,
	[EscalationLevelID] ASC,
	[EscalationLevelSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_UserGroupsEscalationLevels]  WITH CHECK ADD  CONSTRAINT [FK_UserGroupEscalationLevelEscalation] FOREIGN KEY([EscalationLevelID], [EscalationLevelSiteID])
REFERENCES [dbo].[T_EscalationLevels] ([EscalationLevelID], [EscalationLevelSiteID])
ALTER TABLE [dbo].[T_UserGroupsEscalationLevels] CHECK CONSTRAINT [FK_UserGroupEscalationLevelEscalation]
ALTER TABLE [dbo].[T_UserGroupsEscalationLevels]  WITH CHECK ADD  CONSTRAINT [FK_UserGroupEscalationLevelGroup] FOREIGN KEY([UserGroupID])
REFERENCES [dbo].[LT_UserGroups] ([UserGroupID])
ALTER TABLE [dbo].[T_UserGroupsEscalationLevels] CHECK CONSTRAINT [FK_UserGroupEscalationLevelGroup]