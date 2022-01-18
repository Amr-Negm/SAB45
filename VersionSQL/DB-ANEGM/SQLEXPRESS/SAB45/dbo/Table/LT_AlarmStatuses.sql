/****** Object:  Table [dbo].[LT_AlarmStatuses]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_AlarmStatuses](
	[AlarmStatusID] [int] IDENTITY(1,1) NOT NULL,
	[AlarmStatusTitle1] [nvarchar](200) NULL,
	[AlarmStatusTitle2] [nvarchar](200) NULL,
	[AlarmStatusDescriptionTitle1] [nvarchar](4000) NULL,
	[AlarmStatusDescriptionTitle2] [nvarchar](4000) NULL,
 CONSTRAINT [AlarmStatuses_PK] PRIMARY KEY CLUSTERED 
(
	[AlarmStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]