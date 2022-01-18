/****** Object:  Table [dbo].[T_EventDefinitions]    Committed by VersionSQL https://www.versionsql.com ******/

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[T_EventDefinitions](
	[EventDefinitionID] [int] IDENTITY(1,1) NOT NULL,
	[EventDefinitionSiteID] [int] NOT NULL,
	[EventDefinitionTitle1] [nvarchar](200) NOT NULL,
	[EventDefinitionDescriptionTitle1] [nvarchar](4000) NULL,
	[TouchPointIDSource] [int] NULL,
	[TouchPointSiteID] [int] NULL,
	[AlgorithmID] [int] NOT NULL,
	[AlgorithmSiteID] [int] NOT NULL,
	[EventDefinitionCode] [nvarchar](200) NULL,
	[ProviderEventName] [nvarchar](200) NULL,
	[StateID] [int] NULL,
	[StatusID] [int] NULL,
	[IsEnabled] [int] NULL,
	[DisabledTimeKey] [int] NULL,
	[DisabledTimeValue] [int] NULL,
	[ExpirationDate] [datetime2](7) NULL,
	[DashboardColor] [nvarchar](20) NULL,
 CONSTRAINT [EventDefinitions_PK] PRIMARY KEY CLUSTERED 
(
	[EventDefinitionID] ASC,
	[EventDefinitionSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Cons_EventDefinitionTitle1] UNIQUE NONCLUSTERED 
(
	[EventDefinitionTitle1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_AlgorithmEventDefinition] ON [dbo].[T_EventDefinitions]
(
	[AlgorithmID] ASC,
	[AlgorithmSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_EventDefinitionTouchPoint] ON [dbo].[T_EventDefinitions]
(
	[TouchPointIDSource] ASC,
	[TouchPointSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
ALTER TABLE [dbo].[T_EventDefinitions]  WITH CHECK ADD  CONSTRAINT [FK_AlgorithmEventDefinition] FOREIGN KEY([AlgorithmID], [AlgorithmSiteID])
REFERENCES [dbo].[T_Algorithms] ([AlgorithmID], [AlgorithmSiteID])
ALTER TABLE [dbo].[T_EventDefinitions] CHECK CONSTRAINT [FK_AlgorithmEventDefinition]
ALTER TABLE [dbo].[T_EventDefinitions]  WITH CHECK ADD  CONSTRAINT [FK_TouchPointInstance] FOREIGN KEY([TouchPointIDSource])
REFERENCES [dbo].[T_TouchPoints] ([TouchPointID])
ALTER TABLE [dbo].[T_EventDefinitions] CHECK CONSTRAINT [FK_TouchPointInstance]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   TRIGGER [dbo].[DeleteEventDefinition]
   ON  [dbo].[T_EventDefinitions]
   After DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @edid int = (select [EventDefinitionID] from deleted)
	
	--update [dbo].[T_EventDefinitions] set StateID = 3 where EventDefinitionID=@edid
	delete from [SAB45_Events]..[T_EventDefinitions]  where EventDefinitionID=@edid
    -- Insert statements for trigger here

END

ALTER TABLE [dbo].[T_EventDefinitions] ENABLE TRIGGER [DeleteEventDefinition]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- =============================================
-- Author:		Shahed
-- Create date: 16 July 2020
-- Description:	To keep event definition iin sab events db updated
-- =============================================
CREATE   TRIGGER [dbo].[NewEventDefinition]
   ON  [dbo].[T_EventDefinitions]
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	insert into SAB45_EVENTS.dbo.[T_EventDefinitions] select * from inserted i

END

ALTER TABLE [dbo].[T_EventDefinitions] ENABLE TRIGGER [NewEventDefinition]
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- =============================================
-- Author:		Shahed
-- Create date: 16 July 2020
-- Description:	To keep event definition iin sab events db updated
-- =============================================
CREATE   TRIGGER [dbo].[UpdateEventDefinition]
   ON  [dbo].[T_EventDefinitions]
   AFTER update
AS 
BEGIN
	SET NOCOUNT ON;

declare @EDID int = (select [EventDefinitionID] from deleted)

Declare @EventDefinitionTitle1			  nvarchar(200)	= (select EventDefinitionTitle1				from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @EventDefinitionDescriptionTitle1 nvarchar(200)	= (select EventDefinitionDescriptionTitle1	from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @TouchPointIDSource			int		= (select TouchPointIDSource				from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @TouchPointSiteID			int		= (select TouchPointSiteID					from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @AlgorithmID				int		= (select AlgorithmID						from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @AlgorithmSiteID			int		= (select AlgorithmSiteID					from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @EventDefinitionCode		nvarchar(200)		= (select EventDefinitionCode				from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @ProviderEventName			nvarchar(200)		= (select ProviderEventName					from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @StateID					int		= (select StateID							from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @StatusID					int		= (select StatusID							from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @IsEnabled					int		= (select IsEnabled							from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @DisabledTimeKey			int		= (select DisabledTimeKey					from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @DisabledTimeValue			int		= (select DisabledTimeValue					from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @ExpirationDate			datetime			= (select ExpirationDate					from t_eventdefinitions where EventDefinitionID  =@EDID)
Declare @DashboardColor			nvarchar(20)			= (select DashboardColor					from t_eventdefinitions where EventDefinitionID  =@EDID)

update SAB45_Events..T_EventDefinitions set 	
EventDefinitionTitle1			= @EventDefinitionTitle1			 
,EventDefinitionDescriptionTitle1 = @EventDefinitionDescriptionTitle1
,TouchPointIDSource		=		@TouchPointIDSource	
,TouchPointSiteID		=		@TouchPointSiteID	
,AlgorithmID				=	@AlgorithmID			
,AlgorithmSiteID			=	@AlgorithmSiteID		
,EventDefinitionCode		= @EventDefinitionCode		
,ProviderEventName			=@ProviderEventName		
,StateID					=	@StateID				
,StatusID				=		@StatusID				
,IsEnabled				=		@IsEnabled				
,DisabledTimeKey			=	@DisabledTimeKey		
,DisabledTimeValue		=		@DisabledTimeValue		
,ExpirationDate			= @ExpirationDate		
,DashboardColor			=@DashboardColor
where EventDefinitionID=@EDID
END

ALTER TABLE [dbo].[T_EventDefinitions] ENABLE TRIGGER [UpdateEventDefinition]