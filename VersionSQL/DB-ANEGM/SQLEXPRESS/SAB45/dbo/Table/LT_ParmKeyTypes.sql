/****** Object:  Table [dbo].[LT_ParmKeyTypes]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_ParmKeyTypes](
	[ParmKeyTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ParmKeyTypeTitle1] [nvarchar](200) NULL,
	[ParmKeyTypeTitle2] [nvarchar](200) NULL,
	[ParmKeyTypeDescriptionTitle1] [nvarchar](4000) NULL,
	[ParmKeyTypeDescriptionTitle2] [nvarchar](4000) NULL,
 CONSTRAINT [PK_ParmKeyTypes] PRIMARY KEY CLUSTERED 
(
	[ParmKeyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]