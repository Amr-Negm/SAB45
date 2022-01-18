/****** Object:  Procedure [dbo].[UDSP_CardPeekTimeAck]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardPeekTimeAck]         @City nvarchar(100)=null	,
													  @Station nvarchar(100)=null ,
													  @Level nvarchar(100)=null   ,
													  @Zone nvarchar(100)=null    ,
													  @Camera nvarchar(100)=null  ,
													  @StartDate datetime=null  ,
													  @EndDate datetime=null,
													  @PeekTimeAck nvarchar(20) output
AS
BEGIN
SET NOCOUNT ON;
declare @x decimal(38)			

			 select @x=a.hour from( 
						select top(1) count(*) as 'cx',DATEPART(HOUR,Response_Date) as 'hour'
						from [dbo].[UDV_AllAlarms] 
													where  CityTitle1=isnull(@City,CityTitle1)				AND
													[StationTitle1]=isnull(@Station,[StationTitle1])		AND 
													[LevelTitle1]=isnull(@Level,[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(@Zone,[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(@Camera,[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date]) AND
													ResponseTimeDifference!=0
													group by DATEPART(HOUR,Response_Date) 
													order by 1 desc) a
set @x=isnull(@x,'0')
select @PeekTimeAck=(select cast (dbo.MinutesToDuration_TwoOctet(@x) as varchar(20)) as 'PeekTimeAck')
select @PeekTimeAck	
SET NOCOUNT OFF;
END