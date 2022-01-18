/****** Object:  Procedure [dbo].[UDSP_CardAverageResponseTime]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_CardAverageResponseTime] 
													  @StartDate datetime=null  ,
													  @EndDate datetime=null	,
													  @SPVALUE decimal(38) output
													  

AS
BEGIN
SET NOCOUNT ON;		


			select @SPVALUE= (select avg(DATEDIFF(second,Occurance_Date,Response_Date)) as 'ResponseTime' from [dbo].[UDV_AllAlarmsnew] 
			where
					 Response_Date is not null and 
					DATEDIFF(second,Occurance_Date,Response_Date) >0 and
					[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])				AND 
					[Occurance_Date]<=isnull(DATEADD(day,1,@EndDate),[Occurance_Date]) )

					select @SPVALUE;							

SET NOCOUNT OFF;		
END