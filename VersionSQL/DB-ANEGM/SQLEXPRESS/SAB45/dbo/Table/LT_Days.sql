/****** Object:  Table [dbo].[LT_Days]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_Days](
	[DayId] [int] IDENTITY(1,1) NOT NULL,
	[DaySiteId] [int] NOT NULL,
	[DayName1] [nvarchar](50) NULL,
	[WorkingDay] [bit] NULL,
	[WeekEnd] [bit] NULL,
	[DayName2] [nvarchar](50) NULL,
	[DayIndex] [int] NULL,
 CONSTRAINT [PK_Days] PRIMARY KEY CLUSTERED 
(
	[DayId] ASC,
	[DaySiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]