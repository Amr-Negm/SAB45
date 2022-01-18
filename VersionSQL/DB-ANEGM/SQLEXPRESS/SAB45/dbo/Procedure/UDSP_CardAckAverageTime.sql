/****** Object:  Procedure [dbo].[UDSP_CardAckAverageTime]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardAckAverageTime]      @City nvarchar(100)=null	,
													  @Station nvarchar(100)=null ,
													  @Level nvarchar(100)=null   ,
													  @Zone nvarchar(100)=null    ,
													  @Camera nvarchar(100)=null  ,
													  @StartDate datetime=null  ,
													  @EndDate datetime=null,
													  @AckAverageTime varchar(20) output
AS
BEGIN
SET NOCOUNT ON;
declare @x decimal(38)		
		 select  @x=cast(round((sum(isnull(ResponseTimeDifference,0))/ isnull(NULLIF(count(*), '0'),1)),0) as int) 
										from [dbo].[UDV_AllAlarms] 
										     where  CityTitle1=isnull(@City,CityTitle1)		         		AND
													[StationTitle1]=isnull(@Station,[StationTitle1])		AND 
													[LevelTitle1]=isnull(@Level,[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(@Zone,[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(@Camera,[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date]) AND
													ResponseTimeDifference!=0
		set @x=isnull(@x,'0')
		--print @x
select @AckAverageTime=(select cast (dbo.UDF_SecondsToDuration(@x) as varchar(20)) as 'AckAverageTime')
--select @AckAverageTime	
SET NOCOUNT OFF;
END