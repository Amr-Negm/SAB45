/****** Object:  Function [dbo].[HBB_UDF_CardHBB_TotalHandledAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION  [dbo].[HBB_UDF_CardHBB_TotalHandledAlarms]() RETURNS int   
AS
BEGIN
RETURN(
--8 8.	Handled Alarms             
SELECT COUNT(*) FROM T_Alarms AL with (nolock)  WHERE AL.Response_Date IS NOT NULL
);
END;