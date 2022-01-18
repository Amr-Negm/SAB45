/****** Object:  Function [dbo].[HBB_UDF_CardHBB_TotalDays]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION  [dbo].[HBB_UDF_CardHBB_TotalDays]() RETURNS int   
AS
BEGIN
RETURN(
--7 7.	Total days  
SELECT COUNT(DISTINCT(CONVERT(DATE,AL.Occurance_Date))) FROM [dbo].[UDV_AlarmsAverage] AL with (nolock)
);
END;