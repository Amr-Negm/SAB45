/****** Object:  Table [dbo].[T_AlarmComment]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_AlarmComment](
	[AlarmCommentID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[Comment] [nvarchar](max) NULL,
	[Date] [datetime2](7) NULL,
	[AlarmID] [int] NULL,
	[AlarmSiteID] [int] NULL,
 CONSTRAINT [PK_AlarmComment] PRIMARY KEY CLUSTERED 
(
	[AlarmCommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_AlarmComment] ON [dbo].[T_AlarmComment]
(
	[AlarmID] ASC,
	[AlarmSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_AlarmComment]  WITH CHECK ADD  CONSTRAINT [FK_AlarmComment] FOREIGN KEY([AlarmID], [AlarmSiteID])
REFERENCES [dbo].[T_Alarms] ([AlarmID], [AlarmSiteID])
ALTER TABLE [dbo].[T_AlarmComment] CHECK CONSTRAINT [FK_AlarmComment]