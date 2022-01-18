/****** Object:  Function [dbo].[HBB_UDF_CardHBB_TotalAlarm]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION  [dbo].[HBB_UDF_CardHBB_TotalAlarm]() RETURNS int   
AS
BEGIN
RETURN(
--6 6.	Total Alarm  
SELECT COUNT(*) FROM  [dbo].[UDV_AlarmsAverage] AL with (nolock) 
);
END;