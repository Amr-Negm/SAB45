/****** Object:  Procedure [dbo].[UDSP_GeometryByLocation]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_GeometryByLocation] @Location int
as
begin

Select distinct 
LMD.MapTypeID,
cast(GMP.GeometryPolygon as nvarchar(max)) as "GeometryPolygon"
from 
dbo.T_LocationMapData LMD
inner join 
dbo.T_GeometryPolygon GMP
on
GMP.LocationMapDataID=LMD.LocationMapDataID
where 
LMD.StateID=1 and
LMD.LocationID=@Location;
end;