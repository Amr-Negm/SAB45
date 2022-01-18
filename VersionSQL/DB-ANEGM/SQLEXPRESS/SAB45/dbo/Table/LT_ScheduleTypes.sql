/****** Object:  Table [dbo].[LT_ScheduleTypes]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_ScheduleTypes](
	[ScheduleTypeId] [int] IDENTITY(1,1) NOT NULL,
	[ScheduleTypeName1] [nvarchar](50) NULL,
	[ScheduleTypeName2] [nvarchar](50) NULL,
 CONSTRAINT [PK_LT_ScheduleTypes] PRIMARY KEY CLUSTERED 
(
	[ScheduleTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]