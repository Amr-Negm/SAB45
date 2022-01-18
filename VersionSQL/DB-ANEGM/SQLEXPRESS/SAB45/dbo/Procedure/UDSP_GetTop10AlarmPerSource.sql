/****** Object:  Procedure [dbo].[UDSP_GetTop10AlarmPerSource]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetTop10AlarmPerSource](
													@City nvarchar(100)=null		,
													@Station nvarchar(100)=null   ,
													@Level nvarchar(100)=null     ,
													@Zone nvarchar(100)=null      ,
													@Camera nvarchar(100)=null    ,
													@StartDate datetime=null    ,
													@EndDate datetime=null
													)
AS
BEGIN

			declare @AverageBerHour int 
			declare @TotalAlarm decimal

-------------------------------------------------Alarms Total Number--------------------------------------------------------
		
			select @TotalAlarm=count(*)  from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	
		
		
-----------------------------------------------------------------------------------------------------------------------------	
		select @AverageBerHour=cast(round(@TotalAlarm/( 
					select count(a.cx) from ( 
											   select count(*) as 'cx',DATEPART(HOUR,Occurance_Date) as 'hour' 
											   from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	
											    group by DATEPART(HOUR,Occurance_Date)) a),0) as int)

-----------------------------------------------------------------------------------------------------------------------------
		 select top(10) TouchPointTitle1 as 'SourceName',count(*) as 'No_OF_Alarm',@AverageBerHour as 'AverageBerHour',[LevelTitle1] as 'Level',touchpointID 
				 from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	
				  group by  TouchPointTitle1,touchpointID,[LevelTitle1] order by 2 desc
	


END