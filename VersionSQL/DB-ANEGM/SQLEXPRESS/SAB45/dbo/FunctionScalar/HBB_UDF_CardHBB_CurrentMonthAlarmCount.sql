/****** Object:  Function [dbo].[HBB_UDF_CardHBB_CurrentMonthAlarmCount]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION  [dbo].[HBB_UDF_CardHBB_CurrentMonthAlarmCount]() RETURNS int   
AS
BEGIN
RETURN(
--4 4.	Alarms this month         
SELECT COUNT(*) 
FROM  [dbo].[UDV_AlarmsAverage] AL with (nolock) 
WHERE AL.Occurance_Date
>= DATEADD(hour, -2 , DATEADD(month, DATEDIFF(month, 0, SYSUTCDATETIME()), 0))
-- CURRENT MONTH and last two hours from Previous month
-- select  DATEADD(hour, -2 , DATEADD(month, DATEDIFF(month, 0, SYSUTCDATETIME()), 0))


);
END;