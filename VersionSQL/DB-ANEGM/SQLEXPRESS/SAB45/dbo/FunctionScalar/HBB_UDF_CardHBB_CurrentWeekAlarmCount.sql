/****** Object:  Function [dbo].[HBB_UDF_CardHBB_CurrentWeekAlarmCount]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION  [dbo].[HBB_UDF_CardHBB_CurrentWeekAlarmCount]() RETURNS int   
AS
BEGIN
RETURN(
--3 3.	Alarms this week           
SELECT COUNT(*) 
FROM [dbo].[UDV_AlarmsAverage] AL with (nolock)  
WHERE AL.Occurance_Date
>= DATEADD(hour, -2 , DATEADD(wk, 0, DATEADD(DAY, 1-DATEPART(WEEKDAY, GETUTCDATE()), DATEDIFF(dd, 0, GETUTCDATE()))))


);
END;