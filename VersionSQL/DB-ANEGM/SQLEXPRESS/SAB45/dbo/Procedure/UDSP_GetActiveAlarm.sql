/****** Object:  Procedure [dbo].[UDSP_GetActiveAlarm]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetActiveAlarm](        @City nvarchar(100)=null		,
													@Station nvarchar(100)=null     ,
													@Level nvarchar(100)=null       ,
													@Zone nvarchar(100)=null        ,
													@Camera nvarchar(100)=null      ,
													@StartDate datetime=null        ,
													@EndDate datetime=null)
AS
BEGIN

 select top(10) count([AlarmID]) as value,AlarmDefinitionTitle1 as Name--,[CityTitle1],[StationTitle1],[LevelTitle1],[ZoneTitle1],[TouchPointTitle1]
				 from [dbo].[UDV_AllAlarms]  where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])		
													AND
				                                    Response_Date is null 
				 group by  AlarmDefinitionTitle1--,[CityTitle1],[StationTitle1],[LevelTitle1],[ZoneTitle1],[TouchPointTitle1] 
				 order by 1 desc


END