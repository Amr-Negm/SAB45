/****** Object:  Table [dbo].[Pictures]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Pictures](
	[pictureName] [nvarchar](40) NOT NULL,
	[picFileName] [nvarchar](100) NULL,
	[PictureData] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[pictureName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]