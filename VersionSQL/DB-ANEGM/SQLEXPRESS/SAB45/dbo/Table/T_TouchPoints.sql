/****** Object:  Table [dbo].[T_TouchPoints]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_TouchPoints](
	[TouchPointID] [int] IDENTITY(1,1) NOT NULL,
	[TouchPointStandardCode] [nvarchar](100) NULL,
	[TouchPointCode] [nvarchar](200) NULL,
	[TouchPointTitle1] [nvarchar](200) NULL,
	[TouchPointDescriptionTitle1] [nvarchar](4000) NULL,
	[StateID] [int] NULL,
	[TouchPointTypeID] [int] NOT NULL,
	[ZoomLevel] [int] NULL,
	[ParentTouchPointID] [int] NULL,
	[TouchPointBehaviorTypeID] [int] NULL,
 CONSTRAINT [TouchPoints_PK] PRIMARY KEY CLUSTERED 
(
	[TouchPointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_TouchPointBehaviorType] ON [dbo].[T_TouchPoints]
(
	[TouchPointBehaviorTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_TouchPointParent] ON [dbo].[T_TouchPoints]
(
	[ParentTouchPointID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_TouchPointTouchPointType] ON [dbo].[T_TouchPoints]
(
	[TouchPointTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_TouchPoints]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointBehaviorType] FOREIGN KEY([TouchPointBehaviorTypeID])
REFERENCES [dbo].[LT_TouchPointBehaviorType] ([TouchPointBehaviorTypeID])
ALTER TABLE [dbo].[T_TouchPoints] CHECK CONSTRAINT [FK_TouchPointBehaviorType]
ALTER TABLE [dbo].[T_TouchPoints]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointParent] FOREIGN KEY([ParentTouchPointID])
REFERENCES [dbo].[T_TouchPoints] ([TouchPointID])
ALTER TABLE [dbo].[T_TouchPoints] CHECK CONSTRAINT [FK_TouchPointParent]
ALTER TABLE [dbo].[T_TouchPoints]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointType] FOREIGN KEY([TouchPointTypeID])
REFERENCES [dbo].[LT_TouchPointTypes] ([TouchPointTypeID])
ON UPDATE CASCADE
ALTER TABLE [dbo].[T_TouchPoints] CHECK CONSTRAINT [FK_TouchPointType]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

---

CREATE   TRIGGER [dbo].[NewTouchPoints]
   ON  [dbo].[T_TouchPoints]
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	DELETE FROM [SAB45_Events].[dbo].[T_TouchPoints] WHERE TouchPointID IN (SELECT TouchPointID FROM deleted d)
	insert into [SAB45_Events].[dbo].[T_TouchPoints] select * from inserted i
END

ALTER TABLE [dbo].[T_TouchPoints] ENABLE TRIGGER [NewTouchPoints]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE   TRIGGER [dbo].[UDT_DeleteTouchPoint] on [dbo].[T_TouchPoints]
after update
as
begin
declare @TPID int = (select [TouchPointID] from deleted)
--declare @StateID int = (select StateID from [T_TouchPoints] where [TouchPointID]=@TPID)

declare @TouchPointStandardCode		nvarchar(200)	= (select TouchPointStandardCode from t_touchpoints where touchpointid = @TPID)
declare @TouchPointCode				nvarchar(200)	= (select TouchPointCode from t_touchpoints where touchpointid = @TPID)
declare @TouchPointTitle1			nvarchar(200)		= (select TouchPointTitle1 from t_touchpoints where touchpointid = @TPID)
declare @TouchPointDescriptionTitle1	nvarchar(4000) = (select TouchPointDescriptionTitle1 from t_touchpoints where touchpointid = @TPID)
declare @StateID					int	= (select StateID from t_touchpoints where touchpointid = @TPID)
declare @TouchPointTypeID			int		= (select TouchPointTypeID from t_touchpoints where touchpointid = @TPID)
declare @ZoomLevel					int		= (select ZoomLevel from t_touchpoints where touchpointid = @TPID)
declare @ParentTouchPointID			int	= (select ParentTouchPointID from t_touchpoints where touchpointid = @TPID)
declare @TouchPointBehaviorTypeID	int	= (select TouchPointBehaviorTypeID from t_touchpoints where touchpointid = @TPID)

update sab45_events..T_TouchPoints set 
TouchPointStandardCode		= @TouchPointStandardCode		
,TouchPointCode				= @TouchPointCode				
,TouchPointTitle1			= @TouchPointTitle1			
,TouchPointDescriptionTitle1= @TouchPointDescriptionTitle1
,StateID					= @StateID					
,TouchPointTypeID			= @TouchPointTypeID			
,ZoomLevel					= @ZoomLevel					
,ParentTouchPointID			= @ParentTouchPointID			
,TouchPointBehaviorTypeID	= @TouchPointBehaviorTypeID	

where TouchPointID=@TPID
end

ALTER TABLE [dbo].[T_TouchPoints] ENABLE TRIGGER [UDT_DeleteTouchPoint]