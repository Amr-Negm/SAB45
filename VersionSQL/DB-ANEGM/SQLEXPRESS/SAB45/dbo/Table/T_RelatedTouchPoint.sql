/****** Object:  Table [dbo].[T_RelatedTouchPoint]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_RelatedTouchPoint](
	[RelatedTouchPointID] [int] IDENTITY(1,1) NOT NULL,
	[MasterTouchPoint] [int] NOT NULL,
	[RelatedTouchPoint] [int] NOT NULL,
	[TimeInSecond] [int] NOT NULL,
 CONSTRAINT [PK_RelatedTouchPoint] PRIMARY KEY CLUSTERED 
(
	[RelatedTouchPointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_MasterTouchPoint] ON [dbo].[T_RelatedTouchPoint]
(
	[MasterTouchPoint] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_RelatedTouchPoint] ON [dbo].[T_RelatedTouchPoint]
(
	[RelatedTouchPoint] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_RelatedTouchPoint]  WITH CHECK ADD  CONSTRAINT [FK_MasterTouchPoint] FOREIGN KEY([MasterTouchPoint])
REFERENCES [dbo].[T_TouchPoints] ([TouchPointID])
ALTER TABLE [dbo].[T_RelatedTouchPoint] CHECK CONSTRAINT [FK_MasterTouchPoint]
ALTER TABLE [dbo].[T_RelatedTouchPoint]  WITH CHECK ADD  CONSTRAINT [FK_RelatedTouchPoint] FOREIGN KEY([RelatedTouchPoint])
REFERENCES [dbo].[T_TouchPoints] ([TouchPointID])
ALTER TABLE [dbo].[T_RelatedTouchPoint] CHECK CONSTRAINT [FK_RelatedTouchPoint]