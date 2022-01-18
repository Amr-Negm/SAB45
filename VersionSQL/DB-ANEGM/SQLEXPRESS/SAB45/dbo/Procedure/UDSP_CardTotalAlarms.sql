/****** Object:  Procedure [dbo].[UDSP_CardTotalAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardTotalAlarms]
													  @City nvarchar(100)=null	,
													  @Station nvarchar(100)=null ,
													  @Level nvarchar(100)=null   ,
													  @Zone nvarchar(100)=null    ,
													  @Camera nvarchar(100)=null  ,
													  @StartDate datetime=null  ,
													  @EndDate datetime=null,
													  @SPValue decimal(38) output
AS
BEGIN
SET NOCOUNT ON;		
--------------------------------------------------- Get Total Alarms ------------------------------------------------------

	 select @SPValue=count(*)  from [dbo].[UDV_AllAlarmsNew] 
													where CityTitle1=isnull(@City,CityTitle1)				        AND
													[StationTitle1]=isnull(@Station,[StationTitle1])				AND 
													[LevelTitle1]=isnull(@Level,[LevelTitle1])						AND 
													[ZoneTitle1]=isnull(@Zone,[ZoneTitle1])							AND 
													[TouchPointTitle1]=isnull(@Camera,[TouchPointTitle1])			AND
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])			AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date])	
		

				select @SPValue
SET NOCOUNT OFF;	
END