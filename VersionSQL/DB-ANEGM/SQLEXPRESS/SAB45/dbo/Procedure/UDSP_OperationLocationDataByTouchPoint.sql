/****** Object:  Procedure [dbo].[UDSP_OperationLocationDataByTouchPoint]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_OperationLocationDataByTouchPoint] @TouchPointList TouchPointList READONLY
as
Begin
select 
TP.TouchPointID
--,cast(TPGEO.GeographyPoint as nvarchar(max)) as "GeographyPoint"
,TPGEO.MapTypeID 
,MF.FileData
from
dbo.T_TouchPointGeographyDetails TPGEO
inner join
dbo.T_TouchPoints TP
on
TP.TouchPointID=TPGEO.TouchPointID
inner join
dbo.T_TouchPointLocation TPL
on
TPL.TouchPointID=TP.TouchPointID
inner join
dbo.T_Location LOC
on
LOC.LocationID=TPL.LocationID
inner join
dbo.T_LocationMapData LMD
on
LMD.LocationID=LOC.LocationID
inner join
dbo.T_MapFile MF
on
MF.MapFileID=LMD.MapFileID
inner join
@TouchPointList TPList
on
TP.TouchPointID=TPList.TouchPointID;
end