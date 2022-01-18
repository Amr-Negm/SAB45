/****** Object:  Table [dbo].[LT_ActionTypes]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LT_ActionTypes](
	[ActionTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ActionTypeTitle1] [nvarchar](200) NULL,
	[ActionTypeTitle2] [nvarchar](200) NULL,
	[ActionTypeDescriptionTitle1] [nvarchar](4000) NULL,
	[ActionTypeDescriptionTitle2] [nvarchar](4000) NULL,
 CONSTRAINT [ActionTypes_PK] PRIMARY KEY CLUSTERED 
(
	[ActionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]