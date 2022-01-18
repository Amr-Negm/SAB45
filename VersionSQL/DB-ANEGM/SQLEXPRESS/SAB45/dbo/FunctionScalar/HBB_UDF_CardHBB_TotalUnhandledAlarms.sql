/****** Object:  Function [dbo].[HBB_UDF_CardHBB_TotalUnhandledAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION  [dbo].[HBB_UDF_CardHBB_TotalUnhandledAlarms]() RETURNS int   
AS
BEGIN
RETURN(
--9 9.	Unhandled Alarms        
SELECT COUNT(*) FROM T_Alarms AL with (nolock) WHERE AL.Response_Date IS NULL
);
END;