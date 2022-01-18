/****** Object:  Procedure [dbo].[UDSP_TPByZoomLevel]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_TPByZoomLevel] @ZoomLevel float,@userName nvarchar(100)
as
begin


--select distinct RoleName from T_Role where RoleTypeID=2 and StateID=1
declare @roleTypeID int = (select RoleTypeID from LT_RoleType where RoleTypeName='Location')
--Declare @userName nvarchar(100) = 'user10' ;
Declare @userID int = (select UserID from T_User where UserName = @userName and StateID=1)


SELECT 
TP.TouchPointID
--,cast (TPGEO.GeographyPoint as nvarchar(max)) as"GeographyPoint"
,TPGEO.[X_Coordination]
,TPGEO.[Y_Coordination]
,TPGEO.ZoomLevel "ZoomLevel"
,TP.TouchPointTitle1 "TouchPointName"
,TP.TouchPointDescriptionTitle1 "Description"
,TP.TouchPointTypeID
,l.Name as LocationName
,TPGEO.FlipHorizontal
,TPGEO.FlipVertical
,TPGEO.RotationAngle

FROM 
dbo.T_TouchPoints TP
LEFT JOIN dbo.T_TouchPointGeographyDetails TPGEO on TPGEO.TouchPointID=TP.TouchPointID
inner join dbo.T_TouchPointLocation tpl on tpl.TouchPointID = TP.TouchPointID and tpl.StateID=1
inner join dbo.T_Location l on l.LocationID=tpl.LocationID and l.StateID =1
inner join (
select r.RoleName as LocationName 
  from T_Role r 
  inner join T_RoleGroup rg on rg.RoleID = r.RoleID
  inner join T_UserGroup ug on ug.GroupID = rg.GroupID and ug.UserID = @userID
  where r.StateID=1  and RoleTypeID = @roleTypeID
) locs on locs.LocationName=l.Name

where TPGEO.MapTypeID=5 --and TPGEO.ZoomLevel=@ZoomLevel 
and @ZoomLevel >= TPGEO.MinZoomLevel and @ZoomLevel <= TPGEO.MaxZoomLevel;

end;