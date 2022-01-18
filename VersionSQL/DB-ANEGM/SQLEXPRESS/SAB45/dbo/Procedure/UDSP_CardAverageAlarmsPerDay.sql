/****** Object:  Procedure [dbo].[UDSP_CardAverageAlarmsPerDay]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardAverageAlarmsPerDay]  @City nvarchar(100)=null	,
													  @Station nvarchar(100)=null ,
													  @Level nvarchar(100)=null   ,
													  @Zone nvarchar(100)=null    ,
													  @Camera nvarchar(100)=null  ,
													  @StartDate datetime=null  ,
													  @EndDate datetime=null,
													  @AverageAlarmsPerDay decimal(38) output

AS
BEGIN
SET NOCOUNT ON;		
declare @TotalAlarms decimal(38)
exec [dbo].[UDSP_CardTotalAlarms] @City,@Station,@Level,@Zone,@Camera,@StartDate,@EndDate,@TotalAlarms output
			 set @AverageAlarmsPerDay= @TotalAlarms/(select  isnull(count(a.cx),1) from ( 
													select count(*) as 'cx',day(Occurance_Date) as 'day'
													from [dbo].[UDV_AllAlarms] 
													where CityTitle1=isnull(@City,CityTitle1)							AND
													[StationTitle1]=isnull(@Station,[StationTitle1])					AND 
													[LevelTitle1]=isnull(@Level,[LevelTitle1])							AND 
													[ZoneTitle1]=isnull(@Zone,[ZoneTitle1])								AND 
													[TouchPointTitle1]=isnull(@Camera,[TouchPointTitle1])				AND
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date]) 
													 group by day(Occurance_Date)) a) 
													 select @AverageAlarmsPerDay

SET NOCOUNT OFF;		
END