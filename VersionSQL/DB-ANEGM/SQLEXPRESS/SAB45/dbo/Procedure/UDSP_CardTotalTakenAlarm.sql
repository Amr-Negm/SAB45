/****** Object:  Procedure [dbo].[UDSP_CardTotalTakenAlarm]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardTotalTakenAlarm]     @City nvarchar(100)=null,
													  @Station nvarchar(100)=null,
													  @Level nvarchar(100)=null,
													  @Zone nvarchar(100)=null,
													  @Camera nvarchar(100)=null,
													  @StartDate datetime=null,
													  @EndDate datetime=null,
													  @TotalTakenAlarm decimal(38) output 
AS
BEGIN
SET NOCOUNT ON;

			 select @TotalTakenAlarm=count(*)  from [dbo].[UDV_AllAlarmsActions] 
													where CityTitle1=isnull(@City,CityTitle1)				AND
													[StationTitle1]=isnull(@Station,[StationTitle1])		AND 
													[LevelTitle1]=isnull(@Level,[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(@Zone,[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(@Camera,[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date])	
		
SET NOCOUNT OFF;
END