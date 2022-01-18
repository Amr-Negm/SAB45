/****** Object:  Table [dbo].[T_Sounds]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Sounds](
	[SoundID] [int] IDENTITY(1,1) NOT NULL,
	[SoundSiteID] [int] NOT NULL,
	[SoundName] [nvarchar](200) NULL,
	[Sound] [varbinary](max) NULL,
	[StateID] [int] NULL,
	[StatusID] [int] NULL,
 CONSTRAINT [Sounds_PK] PRIMARY KEY CLUSTERED 
(
	[SoundID] ASC,
	[SoundSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]