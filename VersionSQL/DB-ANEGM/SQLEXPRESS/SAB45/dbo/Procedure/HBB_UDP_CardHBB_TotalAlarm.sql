/****** Object:  Procedure [dbo].[HBB_UDP_CardHBB_TotalAlarm]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure  [dbo].[HBB_UDP_CardHBB_TotalAlarm](		@StartDate datetime=null    ,
													@EndDate datetime=null)    
AS
BEGIN

--6 6.	Total Alarm  
SELECT COUNT(*) FROM [dbo].[UDV_AlarmsAverage] with (nolock) 
where Occurance_Date>=@StartDate and Occurance_Date<=@EndDate

END;