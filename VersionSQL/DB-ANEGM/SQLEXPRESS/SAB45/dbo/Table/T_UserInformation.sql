/****** Object:  Table [dbo].[T_UserInformation]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_UserInformation](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserCode] [nvarchar](50) NULL,
	[UserName] [nvarchar](100) NULL,
	[PWD] [nvarchar](100) NULL,
	[Status] [bit] NULL,
	[EmailAddress] [nvarchar](200) NULL,
	[FirstName] [nvarchar](200) NULL,
	[LastName] [nvarchar](200) NULL,
 CONSTRAINT [UserInformation_PK] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[T_UserInformation] ADD  DEFAULT ((1)) FOR [Status]