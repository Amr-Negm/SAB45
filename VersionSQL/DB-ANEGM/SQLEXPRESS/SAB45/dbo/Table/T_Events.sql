/****** Object:  Table [dbo].[T_Events]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_Events](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[EventSiteID] [int] NOT NULL,
	[EventCode] [nvarchar](200) NULL,
	[Occurance_Date] [datetime] NULL,
	[Response_User] [nvarchar](200) NULL,
	[Response_Date] [datetime] NULL,
	[EventBoundaryBox] [nvarchar](4000) NULL,
	[EventDefinitionID] [int] NOT NULL,
	[EventDefinitionSiteID] [int] NOT NULL,
	[ImageURL] [nvarchar](500) NULL,
	[VideoURL] [nvarchar](500) NULL,
	[StateID] [int] NULL,
	[StatusID] [int] NULL,
	[EventType] [nvarchar](200) NULL,
 CONSTRAINT [Events_PK] PRIMARY KEY CLUSTERED 
(
	[EventID] ASC,
	[EventSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_EventEventDefination] ON [dbo].[T_Events]
(
	[EventDefinitionID] ASC,
	[EventDefinitionSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_Events]  WITH CHECK ADD  CONSTRAINT [FK_EventEventDefinition] FOREIGN KEY([EventDefinitionID], [EventDefinitionSiteID])
REFERENCES [dbo].[T_EventDefinitions] ([EventDefinitionID], [EventDefinitionSiteID])
ALTER TABLE [dbo].[T_Events] CHECK CONSTRAINT [FK_EventEventDefinition]