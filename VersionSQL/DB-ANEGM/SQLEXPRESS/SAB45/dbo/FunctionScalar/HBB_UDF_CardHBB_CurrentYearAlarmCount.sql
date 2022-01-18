/****** Object:  Function [dbo].[HBB_UDF_CardHBB_CurrentYearAlarmCount]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION  [dbo].[HBB_UDF_CardHBB_CurrentYearAlarmCount]() RETURNS int   
AS
BEGIN
RETURN(
--5 5.	Alarms this year 
SELECT COUNT(*) 
FROM [dbo].[UDV_AlarmsAverage] AL with (nolock) 
WHERE AL.Occurance_Date
>= DATEADD(hour, -2 , DATEADD(hour, -2 , DATEADD(YEAR, DATEDIFF(YEAR, 0, SYSUTCDATETIME()), 0)))
--CURRENT YEAR -- 1420149

-- select  DATEADD(hour, -2 , DATEADD(YEAR, DATEDIFF(YEAR, 0, SYSUTCDATETIME()), 0))

);
END;