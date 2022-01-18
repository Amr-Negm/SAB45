/****** Object:  Procedure [dbo].[UDSP_GetAlarmPrioriyOfCurrentAndLastWeak]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAlarmPrioriyOfCurrentAndLastWeak]( @City nvarchar(max)=''		,
												@Station nvarchar(max)=''   ,
												@Level nvarchar(max)=''     ,
												@Zone nvarchar(max)=''      ,
												@Camera nvarchar(max)=''    
												--,@StartDate datetime=null    ,
												--@EndDate datetime=null
												)
AS
BEGIN

				select count([AlarmID]) as Value, datepart(ww, Occurance_Date) as CurrentWeek,PriorityTitle1 
						     from [dbo].[UDV_AllAlarms] where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   
																
							 group by PriorityTitle1,datepart(ww, Occurance_Date) 
						     having  datepart(ww, Occurance_Date)>=DATEPART(ww,getdate())-6  
									 
							 order by 3,2

	
END