/****** Object:  Procedure [dbo].[UDSP_CardAverageAlarmsPer10Minute]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardAverageAlarmsPer10Minute]				  
													  @City nvarchar(100)=null	,
													  @Station nvarchar(100)=null ,
													  @Level nvarchar(100)=null   ,
													  @Zone nvarchar(100)=null    ,
													  @Camera nvarchar(100)=null  ,
													  @StartDate datetime=null  ,
													  @EndDate datetime=null,
													  @AverageAlarmsPer10Minute decimal(38) output
AS
BEGIN
/*SET NOCOUNT ON;
declare @TotalAlarms decimal(38)
exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,null,null,@TotalAlarms output
		
select @AverageAlarmsPer10Minute=cast(round(@TotalAlarms/( 
					select  isnull(NULLIF(count(a.cx), '0'),1) from ( 
											   select count(*) as 'cx',DATEPART(MINUTE,Occurance_Date)/10 as '10minute' 
											   from [dbo].[UDV_AllAlarms] 
											   where  CityTitle1=isnull(@City,CityTitle1)    				AND
													[StationTitle1]=isnull(@Station,[StationTitle1])		AND 
													[LevelTitle1]=isnull(@Level,[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(@Zone,[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(@Camera,[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date])
											    group by DATEPART(MINUTE,Occurance_Date)/10 
											   ) a),0) as int)
select @AverageAlarmsPer10Minute		
SET NOCOUNT OFF;*/
/*Abdelfattah 02272018*/

SET NOCOUNT ON;
--Abdelfattah 03052018
/*declare @TotalAlarms decimal(38)
exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,null,null,@TotalAlarms output
select @AverageAlarmsPer10Minute=(@TotalAlarms/( 
					select isnull(NULLIF(count(a.cx), '0'),1) from ( 
											   select count(*) as 'cx',DATEPART(HOUR,Occurance_Date) as 'hour' 
											   from [dbo].[UDV_AllAlarms] 
											   where CityTitle1=isnull(@City,CityTitle1)				    AND
													[StationTitle1]=isnull(@Station,[StationTitle1])		AND 
													[LevelTitle1]=isnull(@Level,[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(@Zone,[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(@Camera,[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date])	
											    group by DATEPART(HOUR,Occurance_Date)) a))/6;


SELECT @AverageAlarmsPer10Minute
	*/
	declare @AveragePerHour int;	
	exec [dbo].UDSP_CardAverageAlarmsPerHour null,null,null,null,null,null,null,@AveragePerHour output
	select @AverageAlarmsPer10Minute=@AveragePerHour/6;

SET NOCOUNT OFF;
END