/****** Object:  Function [dbo].[HBB_UDF_CardHBB_CurrentDateAlarmCount]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION  [dbo].[HBB_UDF_CardHBB_CurrentDateAlarmCount]() RETURNS int   
AS
BEGIN
RETURN(
--2 2.	Alarms  this day             
SELECT COUNT(*) 
FROM [dbo].[UDV_AlarmsAverage] AL with (nolock) 
WHERE AL.Occurance_Date
	>= DATEADD(hour, -2 , cast(cast(GETUTCDATE() as date) as datetime))
	and AL.Occurance_Date < DATEADD(hour, 24 , cast(cast(GETUTCDATE() as date) as datetime))



);
END;