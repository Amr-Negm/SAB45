/****** Object:  Procedure [dbo].[UDSP_CardAverageAlarmsPerWeek]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardAverageAlarmsPerWeek]  
													  @StartDate datetime=null  ,
													  @EndDate datetime=null	,
													  @AverageAlarmsPerWeek int output
													  

AS
BEGIN
SET NOCOUNT ON;		
declare @TotalAlarms decimal(38)
--declare @AverageAlarmsPerWeek int

exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,@StartDate,@EndDate,@TotalAlarms  output

			 set @AverageAlarmsPerWeek= @TotalAlarms/(select  case when count(a.cx)=0 then @TotalAlarms+1 else COUNT(a.cx) end from ( 
													select count(*) as 'cx',
													'Week ' + cast(datepart(wk, Occurance_Date) as varchar(2)) as 'Week'
													from [dbo].[UDV_AllAlarms] 
													where 
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date]) 

													 group by 'Week ' + cast(datepart(wk, Occurance_Date) as varchar(2)) ) a) 
													
select @AverageAlarmsPerWeek as 'AverageAlarmsPerWeek'
SET NOCOUNT OFF;		
END