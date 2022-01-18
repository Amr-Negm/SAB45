/****** Object:  Function [dbo].[HBB_UDF_CardHBB_LastHourAlarmCount]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION  [dbo].[HBB_UDF_CardHBB_LastHourAlarmCount]() RETURNS int   
AS
BEGIN
RETURN(

--1 1.	Alarms of Last hour      
SELECT  COUNT(*) FROM [dbo].[UDV_AlarmsAverage] AL with (nolock)  WHERE AL.Occurance_Date between DATEADD(HOUR, -1, SYSUTCDATETIME()) and SYSUTCDATETIME() --TOTAL ALARMS LAST HOUR
);
END;