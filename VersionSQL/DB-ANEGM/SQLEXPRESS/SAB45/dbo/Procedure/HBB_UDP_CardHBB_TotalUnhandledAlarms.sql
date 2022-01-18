/****** Object:  Procedure [dbo].[HBB_UDP_CardHBB_TotalUnhandledAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure  [dbo].[HBB_UDP_CardHBB_TotalUnhandledAlarms](@StartDate datetime=null,
													@EndDate datetime=null)    
AS
BEGIN

      
SELECT COUNT(*) FROM [dbo].[UDV_AlarmsAverage]  with (nolock) WHERE Response_Date IS NULL
and Occurance_Date>=@StartDate and Occurance_Date<=@EndDate

END;