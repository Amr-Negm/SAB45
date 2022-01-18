/****** Object:  Procedure [dbo].[UDSP_LocationByZoomLevel_old]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_LocationByZoomLevel_old] @ZoomLevel float
as
begin

SELECT 
DISTINCT
LOC.Name "LocationName",LMD.LocationID
--,CAST(LMD.GeographyPoint AS NVARCHAR(MAX)) "GeographyPoint"
,LMD.[X_Coordination]
,LMD.[Y_Coordination]
,LMD.GeographyZoomLevel "ZoomLevel",LOC.LocationTypeId
,CAST([dbo].[UDF_FirstGeometryLocation](LMD.LocationMapDataID) AS NVARCHAR(MAX)) "StringPolygon"
,GOP.StrokeColor,GOP.StrokeOpacity,GOP.StrokeWeight,GOP.FillOpacity
,GOP.MinZoomLevel,GOP.MaxZoomLevel
,[dbo].[UDF_#TPByLocation](LMD.LocationID) "NumberOfTPByLocation",[dbo].[UDF_#ChildByParent](LMD.LocationID) "NumberOfChildByLocation",GOP.PolygonColor,LOC.Description
FROM 
dbo.T_LocationMapData LMD
LEFT JOIN
dbo.T_Location LOC
on
LOC.LocationID=LMD.LocationID
LEFT JOIN
dbo.T_GeometryPolygon GOP
on
GOP.LocationMapDataID=LMD.LocationMapDataID
LEFT JOIN
dbo.T_TouchPointLocation TPL on TPL.LocationID=LOC.LocationID AND (TPL.StateID=1 OR TPL.StateID IS NULL ) 
WHERE 
(LMD.StateID=1 or LMD.StateID is null) 
--AND (TPL.StateID=1 OR TPL.StateID IS NULL ) 
AND LMD.GeographyZoomLevel=@ZoomLevel
and (LOC.StateID=1 or LOC.StateID is null);
end;