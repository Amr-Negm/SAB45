/****** Object:  Table [dbo].[T_TouchPointLocationTrack]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_TouchPointLocationTrack](
	[TouchPointLocationTrackID] [int] IDENTITY(1,1) NOT NULL,
	[TouchPointLocationID] [int] NULL,
	[LocationID] [int] NOT NULL,
	[TouchPointID] [int] NOT NULL,
	[AssignUserID] [nvarchar](50) NULL,
	[AssignDate] [datetime2](7) NULL,
	[StateID] [int] NULL,
 CONSTRAINT [PK_TouchPointLocationTrack] PRIMARY KEY CLUSTERED 
(
	[TouchPointLocationTrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_Location_TouchPointLocationTrack] ON [dbo].[T_TouchPointLocationTrack]
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_TouchPoint_TouchPointLocationTrack] ON [dbo].[T_TouchPointLocationTrack]
(
	[TouchPointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_TouchPointLocationTrackState] ON [dbo].[T_TouchPointLocationTrack]
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_TouchPointLocationTrack]  WITH CHECK ADD  CONSTRAINT [FK_Location_TouchPointLocationTrack] FOREIGN KEY([LocationID])
REFERENCES [dbo].[T_Location] ([LocationID])
ALTER TABLE [dbo].[T_TouchPointLocationTrack] CHECK CONSTRAINT [FK_Location_TouchPointLocationTrack]
ALTER TABLE [dbo].[T_TouchPointLocationTrack]  WITH CHECK ADD  CONSTRAINT [FK_TouchPoint_TouchPointLocationTrack] FOREIGN KEY([TouchPointID])
REFERENCES [dbo].[T_TouchPoints] ([TouchPointID])
ALTER TABLE [dbo].[T_TouchPointLocationTrack] CHECK CONSTRAINT [FK_TouchPoint_TouchPointLocationTrack]
ALTER TABLE [dbo].[T_TouchPointLocationTrack]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointLocationTrackState] FOREIGN KEY([StateID])
REFERENCES [dbo].[LT_State] ([StateID])
ALTER TABLE [dbo].[T_TouchPointLocationTrack] CHECK CONSTRAINT [FK_TouchPointLocationTrackState]