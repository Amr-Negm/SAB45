/****** Object:  Table [dbo].[LT_AlarmClassifications]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_AlarmClassifications](
	[AlarmClassificationID] [int] IDENTITY(1,1) NOT NULL,
	[AlarmClassificationTitle1] [nvarchar](200) NULL,
	[AlarmClassificationTitle2] [nvarchar](200) NULL,
	[AlarmClassificationDescriptionTitle1] [nvarchar](4000) NULL,
	[AlarmClassificationDescriptionTitle2] [nvarchar](4000) NULL,
 CONSTRAINT [AlarmClassifications_PK] PRIMARY KEY CLUSTERED 
(
	[AlarmClassificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]