/****** Object:  Table [dbo].[LT_SystemGroups]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_SystemGroups](
	[SystemGroupID] [int] IDENTITY(1,1) NOT NULL,
	[SystemGroupTitle] [nvarchar](200) NULL,
 CONSTRAINT [PK_SystemGroups] PRIMARY KEY CLUSTERED 
(
	[SystemGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]