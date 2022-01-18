/****** Object:  Procedure [dbo].[UDSP_GetAlarmAveragePerHourByDay]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAlarmAveragePerHourByDay](@day nvarchar(10)=null			,
														@City nvarchar(max)=null		,
														@Station nvarchar(max)=null     ,
														@Level nvarchar(max)=null       ,
														@Zone nvarchar(max)=null        ,
														@Camera nvarchar(max)=null      ,
														@StartDate datetime=null        ,
														@EndDate datetime=null
														)
AS
BEGIN
declare @sqlstr nvarchar(max)
---------------------------------------------------Average Number Of Alarm Day ber Hour----------------------------------------------------

		
				select convert(varchar(15),cast(dbo.MinutesToDuration(a.hour*60) as time),100) as 'HourBerDay',
							a.Value  as 'AvgBerDay',CityTitle1,StationTitle1,LevelTitle1,ZoneTitle1,TouchPointTitle1,Occurance_Date
					         from  
							 (select count(*) as Value,DATEPART(hour,SelectedCreationDate)  as hour  ,CityTitle1,StationTitle1,LevelTitle1,ZoneTitle1,TouchPointTitle1,Occurance_Date
									from [dbo].[UDV_AllScenarios]  where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	AND
												    LOWER(cast(DATENAME(weekday,SelectedCreationDate) as varchar(3)))=isnull(NULLIF(LOWER(@day),''),
													 LOWER(cast(DATENAME(weekday,SelectedCreationDate) as varchar(3)))) AND
													  IsSelected=1 and SelectedCreationDate is not null
									 group by DATEPART(hour,SelectedCreationDate),CityTitle1,StationTitle1,LevelTitle1,ZoneTitle1,TouchPointTitle1,Occurance_Date ) a 
		
END