/****** Object:  Function [dbo].[UDF_#TPByLocation]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[UDF_#TPByLocation]
(
    @LocationID int 
)
RETURNS  int

AS
BEGIN
return(select count(distinct TouchPointID) from dbo.T_TouchPointLocation where LocationID=@LocationID and StateID = 1);

END