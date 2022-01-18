/****** Object:  Procedure [dbo].[HBB_UDP_CardHBB_TotalHandledAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure  [dbo].[HBB_UDP_CardHBB_TotalHandledAlarms](@StartDate datetime=null,
													@EndDate datetime=null)   
AS
BEGIN

--8 8.	Handled Alarms             
SELECT COUNT(*) FROM [dbo].[UDV_AlarmsAverage] with (nolock)  WHERE Response_Date IS NOT NULL
and Occurance_Date>=@StartDate and Occurance_Date<=@EndDate

END;