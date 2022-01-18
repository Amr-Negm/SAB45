/****** Object:  Procedure [dbo].[USDP_GetAllTPs]    Committed by VersionSQL https://www.versionsql.com ******/

-- exec [dbo].[USDP_GetTPParms] '(117535,117537)' 
Create procedure [dbo].[USDP_GetAllTPs] @username nvarchar(max)

as

declare @roleTypeID int = (select RoleTypeID from LT_RoleType where RoleTypeName='Location')
--Declare @userName nvarchar(100) = 'user10' ;
Declare @userID int = (select UserID from T_User where UserName = @userName and StateID=1)


select 
TP.TouchPointID, 
TP.TouchPointTitle1 AS TouchpointName,
l.Name as locationName,
lp.Name as ParentLocationName,
tp.TouchPointTypeID,
TPGEO.[X_Coordination],
TPGEO.[Y_Coordination],
TPGEO.MinZoomLevel,
TPGEO.MaxZoomLevel,
TPGEO.ZoomLevel,
TPGEO.CaptureResolution,
TPGEO.RotationAngle,
tpp.TPParmID,
tptp.TouchPointParmKey,
tpp.StringValue,
tptp.TouchPointParmTitle1,
tp.StateID

FROM		
T_TouchPoints			TP	
LEFT JOIN dbo.T_TouchPointGeographyDetails TPGEO on TPGEO.TouchPointID=TP.TouchPointID
inner join T_TouchPointTypeParms tptp on tptp.TouchPointTypeID = tp.TouchPointTypeID
inner join T_TouchPointLocation tpl on tpl.TouchPointID=tp.TouchPointID and tpl.StateID=1
inner join T_Location l on l.LocationID=tpl.LocationID and l.stateid = 1
left join T_Location lp on lp.LocationID=l.ParentLocationID and lp.StateID=1
inner join T_TouchPointParms tpp on tpp.TouchPointID = tp.TouchPointID and tpp.TPParmID=tptp.TPParmID
left join LT_ParmLookups pl on pl.[ParmLookupID] = try_convert(int,tpp.StringValue)
inner join (
select r.RoleName as LocationName 
  from T_Role r 
  inner join T_RoleGroup rg on rg.RoleID = r.RoleID
  inner join T_UserGroup ug on ug.GroupID = rg.GroupID and ug.UserID = @userID
  where r.StateID=1  and RoleTypeID = @roleTypeID
) locs on locs.LocationName=l.Name

WHERE TP.StateID = 1 