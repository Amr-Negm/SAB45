/****** Object:  Procedure [dbo].[UDSP_GetResponseTimePerformance]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetResponseTimePerformance](@City nvarchar(100)=null	,
													  @Station nvarchar(100)=null ,
													  @Level nvarchar(100)=null   ,
													  @Zone nvarchar(100)=null    ,
													  @Camera nvarchar(100)=null  ,
													  @StartDate datetime=null  ,
													  @EndDate datetime=null)
AS
BEGIN


--cast(round((cast(a.Respcount as decimal)/cast(a.[Alarm Total] as decimal)),0) as int) for rounding the division

 select  a.PriorityID as 'PriorityID', 
				UPPER(a.PriorityTitle1) as 'Alarm Priority',cast(a.[Alarm Total] as varchar(50))+'    ' as 'AlarmTotalNumber', 
			   cast((a.Respcount/a.[Alarm Total]) as int)  as 'Avg Response Time', 
			   cast((a.ExpectedCount/a.[Alarm Total]) as int)  as 'Expected Response Time', 
			   case when  a.Respcount<=a.ExpectedCount 
				then	'Accepetable' 
			   else 
				'Unacceptable'
			   end as 'Comment'
			   from (select sum(isnull(ResponseTimeDifference,0)) as 'Respcount', sum(isnull(ExpectedResponseTime,0)) as 'ExpectedCount',count(*) as 'Alarm Total',PriorityTitle1,PriorityID
			   
						from [dbo].[UDV_AllAlarms] 
						where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
													[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
													[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(NULLIF(@StartDate,''),[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])		
						group by PriorityTitle1,PriorityID)  a  
				order by 1 desc
		
END