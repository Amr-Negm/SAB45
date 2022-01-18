/****** Object:  Procedure [dbo].[UDSP_LocationList]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure  [dbo].[UDSP_LocationList]  (@userName nvarchar(100))
as
begin
--select distinct RoleName from T_Role where RoleTypeID=2 and StateID=1
declare @roleTypeID int = (select RoleTypeID from LT_RoleType where RoleTypeName='Location')
--Declare @userName nvarchar(100) = 'user10' ;
Declare @userID int = (select UserID from T_User where UserName = @userName and StateID=1)

SELECT distinct LOC1.ParentLocationID "ParentID",LOC2.Name "ParentName",
LOC1.LocationID "ChildID",LOC1.Name "ChildName",LOC1.LocationTypeId,tp.TouchPointTypeID,
tploc.StateID,LMD.GeographyZoomLevel
--,CAST (LMD.GeographyPoint as nvarchar(max)) as "GeographyPoint"
,LMD.[X_Coordination]
,LMD.[Y_Coordination]
FROM  dbo.T_Location LOC1 
left JOIN dbo.T_Location LOC2 
ON 
LOC1.ParentLocationID=LOC2.LocationID 
LEFT join 
[dbo].[T_TouchPointLocation] tploc 
on
tploc.locationID=LOC1.locationID and (tploc.StateID = 1 or tploc.StateID is null)  
LEFT join 
[dbo].[T_TouchPoints] tp 
on
tp.touchpointid=tploc.touchpointid
LEFT join 
[dbo].[T_LocationMapData] LMD
on
LMD.LocationID=LOC1.LocationID

inner join (
select r.RoleName as LocationName 
  from T_Role r 
  inner join T_RoleGroup rg on rg.RoleID = r.RoleID
  inner join T_UserGroup ug on ug.GroupID = rg.GroupID and ug.UserID = @userID
  where r.StateID=1  and RoleTypeID = @roleTypeID
) locs on locs.LocationName=LOC1.Name

where lmd.MapTypeID=5
--and (tploc.StateID = 1 or tploc.StateID is null)  
and (LOC1.StateID = 1 or LOC1.StateID is null)  
and (tp.StateID = 1 or tp.StateID is null)  

end;

--select l.Name,tl.* from T_Location l inner join T_TouchPointLocation tl on tl.LocationID=l.LocationID
--select * from T_Location