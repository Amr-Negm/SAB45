/****** Object:  Procedure [dbo].[UDSP_GetAlarmPerStatus]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAlarmPerStatus]( @City nvarchar(max)=		null,
												@Station nvarchar(max)=		null,
												@Level nvarchar(max)=		null,
												@Zone nvarchar(max)=		null,
												@Camera nvarchar(max)=		null,
												@StartDate datetime=		null,
												@EndDate datetime=			null
												)
AS
BEGIN
				
				
							select AlarmStatusTitle1,CityTitle1,StationTitle1,ZoneTitle1,TouchPointTitle1,LevelTitle1,Occurance_Date,count(*) as value	
										from [dbo].[UDV_AllAlarms] where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	
										 group by AlarmStatusTitle1,CityTitle1,StationTitle1,ZoneTitle1,TouchPointTitle1,LevelTitle1,Occurance_Date
				
		
END