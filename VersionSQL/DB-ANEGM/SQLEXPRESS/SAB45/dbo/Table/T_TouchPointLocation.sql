/****** Object:  Table [dbo].[T_TouchPointLocation]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_TouchPointLocation](
	[TouchPointLocationID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NOT NULL,
	[TouchPointID] [int] NOT NULL,
	[AssignUserID] [nvarchar](50) NULL,
	[AssignDate] [datetime2](7) NULL,
	[StateID] [int] NULL,
 CONSTRAINT [PK_TouchPointLocation] PRIMARY KEY CLUSTERED 
(
	[TouchPointLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_Location_TouchPointLocation] ON [dbo].[T_TouchPointLocation]
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_TouchPoint_TouchPointLocation] ON [dbo].[T_TouchPointLocation]
(
	[TouchPointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_TouchPointLocationState] ON [dbo].[T_TouchPointLocation]
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_TouchPointLocation]  WITH CHECK ADD  CONSTRAINT [FK_Location_TouchPointLocation] FOREIGN KEY([LocationID])
REFERENCES [dbo].[T_Location] ([LocationID])
ALTER TABLE [dbo].[T_TouchPointLocation] CHECK CONSTRAINT [FK_Location_TouchPointLocation]
ALTER TABLE [dbo].[T_TouchPointLocation]  WITH CHECK ADD  CONSTRAINT [FK_TouchPoint_TouchPointLocation] FOREIGN KEY([TouchPointID])
REFERENCES [dbo].[T_TouchPoints] ([TouchPointID])
ALTER TABLE [dbo].[T_TouchPointLocation] CHECK CONSTRAINT [FK_TouchPoint_TouchPointLocation]
ALTER TABLE [dbo].[T_TouchPointLocation]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointLocationState] FOREIGN KEY([StateID])
REFERENCES [dbo].[LT_State] ([StateID])
ALTER TABLE [dbo].[T_TouchPointLocation] CHECK CONSTRAINT [FK_TouchPointLocationState]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON



-- =============================================
-- Author:		Shahed
-- Create date: 16 July 2020
-- Description:	To keep event definition iin sab events db updated
-- =============================================
CREATE TRIGGER [dbo].[NewTouchpointLocation]
   ON  [dbo].[T_TouchPointLocation]
   AFTER INSERT , UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	
DELETE [SAB45_Events].[dbo].[T_TouchPointLocation] WHERE TouchPointLocationID IN (SELECT TouchPointLocationID FROM deleted d)

INSERT [SAB45_Events].[dbo].[T_TouchPointLocation] SELECT * FROM inserted i

END

ALTER TABLE [dbo].[T_TouchPointLocation] ENABLE TRIGGER [NewTouchpointLocation]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE trigger [dbo].[UDT_TouchPointLocationTrack] on [dbo].[T_TouchPointLocation]
after update
as
begin
if UPDATE(LocationID) or UPDATE(StateID)
begin
insert into [dbo].[T_TouchPointLocationTrack]
([TouchPointLocationID]
      ,[LocationID]
      ,[TouchPointID]
      ,[AssignUserID]
      ,[AssignDate]
      ,[StateID])
select 
d.[TouchPointLocationID]
      ,d.[LocationID]
      ,d.[TouchPointID]
      ,d.[AssignUserID]
      ,d.[AssignDate]
      ,d.[StateID]
  FROM deleted d;
  end
end
ALTER TABLE [dbo].[T_TouchPointLocation] ENABLE TRIGGER [UDT_TouchPointLocationTrack]