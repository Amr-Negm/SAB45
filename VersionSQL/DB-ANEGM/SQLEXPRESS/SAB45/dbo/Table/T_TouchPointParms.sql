/****** Object:  Table [dbo].[T_TouchPointParms]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_TouchPointParms](
	[TPParmID] [int] NOT NULL,
	[TPParmSiteID] [int] NOT NULL,
	[TouchPointID] [int] NOT NULL,
	[TouchPointSiteID] [int] NOT NULL,
	[StringValue] [nvarchar](2000) NULL,
	[BinaryValue] [varbinary](max) NULL,
	[StateID] [int] NULL,
	[Col1] [nvarchar](2000) NULL,
	[Col2] [nvarchar](2000) NULL,
	[Col3] [nvarchar](2000) NULL,
	[Col4] [varbinary](max) NULL,
	[Col5] [varbinary](max) NULL,
 CONSTRAINT [PK_TouchPointParms] PRIMARY KEY CLUSTERED 
(
	[TPParmID] ASC,
	[TPParmSiteID] ASC,
	[TouchPointID] ASC,
	[TouchPointSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[T_TouchPointParms]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointParms] FOREIGN KEY([TouchPointID])
REFERENCES [dbo].[T_TouchPoints] ([TouchPointID])
ALTER TABLE [dbo].[T_TouchPointParms] CHECK CONSTRAINT [FK_TouchPointParms]
ALTER TABLE [dbo].[T_TouchPointParms]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointTypeParmsValues] FOREIGN KEY([TPParmID], [TPParmSiteID])
REFERENCES [dbo].[T_TouchPointTypeParms] ([TPParmID], [TPParmSiteID])
ALTER TABLE [dbo].[T_TouchPointParms] CHECK CONSTRAINT [FK_TouchPointTypeParmsValues]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create TRIGGER [dbo].[DeleteTPParm]
   ON  [dbo].[T_TouchPointParms]
   AFTER Delete
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Delete from tpp 
	from SAB45_EVENTS..T_TouchPointParms tpp
	inner join deleted d on
		tpp.[TPParmID] = d.[TPParmID]
		and tpp.[TPParmSiteID] = d.[TPParmSiteID]
		and tpp.[TouchPointID] = d.[TouchPointID]
		and tpp.[TouchPointSiteID] = d.[TouchPointSiteID]
    

END

ALTER TABLE [dbo].[T_TouchPointParms] ENABLE TRIGGER [DeleteTPParm]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

Create TRIGGER [dbo].[NewTPParm]
   ON  [dbo].[T_TouchPointParms]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	insert into SAB45_EVENTS..T_TouchPointParms select * from inserted
    -- Insert statements for trigger here

END

ALTER TABLE [dbo].[T_TouchPointParms] ENABLE TRIGGER [NewTPParm]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

Create TRIGGER [dbo].[UpdateTPParms] on [dbo].[T_TouchPointParms]
after update
as
begin

UPDATE tpp 
   SET 
       tpp.[StringValue] = d.[StringValue]
      ,tpp.[BinaryValue] = d.[BinaryValue]
      ,tpp.[StateID]	 = d.[StateID]	
      ,tpp.[Col1]		 = d.[Col1]		
      ,tpp.[Col2]		 = d.[Col2]		
      ,tpp.[Col3]		 = d.[Col3]		
      ,tpp.[Col4]		 = d.[Col4]		
      ,tpp.[Col5]		 = d.[Col5]		
 From sab45_events..[T_TouchPointParms] tpp 
 inner join inserted d on
tpp.[TPParmID] = d.[TPParmID]
and tpp.[TPParmSiteID] = d.[TPParmSiteID]
and tpp.[TouchPointID] = d.[TouchPointID]
and tpp.[TouchPointSiteID] = d.[TouchPointSiteID]

end


ALTER TABLE [dbo].[T_TouchPointParms] ENABLE TRIGGER [UpdateTPParms]