/****** Object:  Procedure [dbo].[UDSP_CardAlarmsPeekDate]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardAlarmsPeekDate]      @City nvarchar(100)=null	,
													  @Station nvarchar(100)=null ,
													  @Level nvarchar(100)=null   ,
													  @Zone nvarchar(100)=null    ,
													  @Camera nvarchar(100)=null  ,
													  @StartDate datetime=null  ,
													  @EndDate datetime=null,
													  @PeekDate nvarchar(100) output

AS
BEGIN
SET NOCOUNT ON;		
select @PeekDate=a.date from( 
							select top(1) count(*) as 'cx',convert(varchar(50),Occurance_Date,105) as 'date'  
							from [dbo].[UDV_AllAlarms] 
													where  CityTitle1=isnull(@City,CityTitle1)          	AND
													[StationTitle1]=isnull(@Station,[StationTitle1])		AND 
													[LevelTitle1]=isnull(@Level,[LevelTitle1])				AND 
													[ZoneTitle1]=isnull(@Zone,[ZoneTitle1])					AND 
													[TouchPointTitle1]=isnull(@Camera,[TouchPointTitle1])   AND
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])	AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date])
							                        group by CONVERT(varchar(50), Occurance_Date,105) 
							                        order by 1 desc) a
		
		set @PeekDate=isnull(@PeekDate,'00')
		Select @PeekDate
SET NOCOUNT OFF;	
END