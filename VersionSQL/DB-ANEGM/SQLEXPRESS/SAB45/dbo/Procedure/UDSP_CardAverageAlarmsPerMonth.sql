/****** Object:  Procedure [dbo].[UDSP_CardAverageAlarmsPerMonth]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardAverageAlarmsPerMonth]  
													  @StartDate datetime=null  ,
													  @EndDate datetime=null	,
													  @AverageAlarmsPerMonth int output
													  

AS
BEGIN
SET NOCOUNT ON;	
SET FMTONLY OFF; 	
declare @TotalAlarms decimal(38)
--declare @AverageAlarmsPerMonth int

exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,@StartDate,@EndDate,@TotalAlarms output
			 set @AverageAlarmsPerMonth= @TotalAlarms/(select    case when count(a.cx)=0 then @TotalAlarms+1 else COUNT(a.cx) end  from ( 
													select count(*) as 'cx',month(Occurance_Date) as 'month'
													from [dbo].[UDV_AllAlarms] 
													where 
													[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
													[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date]) 
													 group by month(Occurance_Date)) a) 

													 select @AverageAlarmsPerMonth as 'AverageAlarmsPerMonth'

SET NOCOUNT OFF;		
END