/****** Object:  Table [dbo].[LT_OccasionTypes]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_OccasionTypes](
	[TypeId] [int] IDENTITY(1,1) NOT NULL,
	[TypeName1] [nvarchar](50) NULL,
	[TypeName2] [nvarchar](50) NULL,
 CONSTRAINT [PK_OccasionTypes] PRIMARY KEY CLUSTERED 
(
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]