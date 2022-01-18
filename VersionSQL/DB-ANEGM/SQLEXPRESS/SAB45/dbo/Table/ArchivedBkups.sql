/****** Object:  Table [dbo].[ArchivedBkups]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ArchivedBkups](
	[ArchId] [int] IDENTITY(1,1) NOT NULL,
	[ArchivedYear] [int] NULL,
 CONSTRAINT [PK_ArchivedBkups] PRIMARY KEY CLUSTERED 
(
	[ArchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]