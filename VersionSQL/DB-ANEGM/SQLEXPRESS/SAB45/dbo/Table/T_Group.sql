/****** Object:  Table [dbo].[T_Group]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Group](
	[GroupID] [int] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](50) NULL,
	[GroupDescription] [nvarchar](100) NULL,
	[StateID] [int] NULL,
	[SessionTimeOut] [int] NULL,
	[SessionTimeOutTypeID] [int] NULL,
	[GDPR] [bit] NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[GroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_Group] ADD  DEFAULT ((2)) FOR [SessionTimeOut]
ALTER TABLE [dbo].[T_Group] ADD  DEFAULT ((3)) FOR [SessionTimeOutTypeID]
ALTER TABLE [dbo].[T_Group] ADD  DEFAULT ((0)) FOR [GDPR]
ALTER TABLE [dbo].[T_Group]  WITH CHECK ADD  CONSTRAINT [FK_GroupSessionTimeOutType] FOREIGN KEY([SessionTimeOutTypeID])
REFERENCES [dbo].[LT_SessionTimeOutType] ([SessionTimeOutTypeID])
ALTER TABLE [dbo].[T_Group] CHECK CONSTRAINT [FK_GroupSessionTimeOutType]