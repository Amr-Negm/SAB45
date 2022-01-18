/****** Object:  Procedure [dbo].[UDSP_GetTop10AlarmPerZone]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetTop10AlarmPerZone](
													@City nvarchar(100)=null		,
													@Station nvarchar(100)=null   ,
													@Level nvarchar(100)=null     ,
													@Zone nvarchar(100)=null      ,
													@Camera nvarchar(100)=null    ,
													@StartDate datetime=null    ,
													@EndDate datetime=null)
AS
BEGIN


			declare @AverageBerHour int 
			declare @TotalAlarm decimal
			set @TotalAlarm=0
-------------------------------------------------Alarms Total Number----------------------------------------
			 select @TotalAlarm=count(AlarmID)  from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	
----------------------------------------------------------------------------------------------
		
		 select @AverageBerHour=cast(round(@TotalAlarm/( 
					select   isnull(NULLIF(count(a.cx), '0'),1)   from ( 
											   select count(*) as 'cx',DATEPART(HOUR,Occurance_Date) as 'hour'
											   from [dbo].[UDV_AllAlarms] where  CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	
											    group by DATEPART(HOUR,Occurance_Date)) a),0) as int)


	     select top(10) ZoneTitle1 as 'ZoneName',count(*) as 'No_OF_Alarms',@AverageBerHour as 'AverageBerHour',[LevelTitle1] as 'Level',ZoneID  
		 from [dbo].[UDV_AllAlarms] 
		 where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	
		  group by  ZoneTitle1,ZoneID,[LevelTitle1] order by 2 desc

END