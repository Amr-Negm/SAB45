/****** Object:  Procedure [dbo].[UDSP_LocationByZoomLevel]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_LocationByZoomLevel] @ZoomLevel float,@userName nvarchar(100)
as
begin

--select distinct RoleName from T_Role where RoleTypeID=2 and StateID=1
declare @roleTypeID int = (select RoleTypeID from LT_RoleType where RoleTypeName='Location')
--Declare @userName nvarchar(100) = 'user10' ;
Declare @userID int = (select UserID from T_User where UserName = @userName and StateID=1)

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

inner join (
select r.RoleName as LocationName 
  from T_Role r 
  inner join T_RoleGroup rg on rg.RoleID = r.RoleID
  inner join T_UserGroup ug on ug.GroupID = rg.GroupID and ug.UserID = @userID
  where r.StateID=1  and RoleTypeID = @roleTypeID
) locs on locs.LocationName=LOC.Name

WHERE 
(LMD.StateID=1 or LMD.StateID is null) 
--AND (TPL.StateID=1 OR TPL.StateID IS NULL ) 
AND LMD.GeographyZoomLevel=@ZoomLevel
and (LOC.StateID=1 or LOC.StateID is null);
end;