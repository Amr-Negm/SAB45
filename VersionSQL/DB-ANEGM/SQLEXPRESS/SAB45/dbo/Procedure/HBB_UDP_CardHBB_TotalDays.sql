/****** Object:  Procedure [dbo].[HBB_UDP_CardHBB_TotalDays]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE  [dbo].[HBB_UDP_CardHBB_TotalDays](@StartDate datetime=null,
													@EndDate datetime=null)    
AS
BEGIN



SELECT COUNT(DISTINCT(CONVERT(DATE,Occurance_Date))) FROM [dbo].[UDV_AlarmsAverage]  with (nolock) 
where Occurance_Date>=@StartDate and Occurance_Date<=@EndDate

END