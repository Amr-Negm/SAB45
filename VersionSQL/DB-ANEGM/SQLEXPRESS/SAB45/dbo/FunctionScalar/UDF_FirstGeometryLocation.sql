/****** Object:  Function [dbo].[UDF_FirstGeometryLocation]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE FUNCTION [dbo].[UDF_FirstGeometryLocation]
(
    @LocationMapDataID int 
)
RETURNS  NVARCHAR(MAX)

AS
BEGIN
--return(select top 1 GeometryPolygon from dbo.T_GeometryPolygon where LocationMapDataID=@LocationMapDataID); 
return(select top 1 [StringPolygon]  from dbo.T_GeometryPolygon where LocationMapDataID=@LocationMapDataID);

END