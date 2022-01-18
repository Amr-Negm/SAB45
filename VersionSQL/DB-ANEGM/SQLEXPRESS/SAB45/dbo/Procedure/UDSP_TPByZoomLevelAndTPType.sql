/****** Object:  Procedure [dbo].[UDSP_TPByZoomLevelAndTPType]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_TPByZoomLevelAndTPType] @ZoomLevel float,@TouchPointTypeID INT
as
begin

SELECT 
TP.TouchPointID
--,cast (TPGEO.GeographyPoint as nvarchar(max)) as"GeographyPoint"
,TPGEO.[X_Coordination]
,TPGEO.[Y_Coordination]
,TPGEO.ZoomLevel "ZoomLevel"
,TP.TouchPointTitle1 "TouchPointName"
,TP.TouchPointDescriptionTitle1 "Description"
,tp.TouchPointTypeID "TouchPointTypeID"
,l.Name as LocationName
,TPGEO.FlipHorizontal
,TPGEO.FlipVertical
,TPGEO.RotationAngle

FROM 
dbo.T_TouchPoints TP
LEFT JOIN dbo.T_TouchPointGeographyDetails TPGEO on TPGEO.TouchPointID=TP.TouchPointID
inner join dbo.T_TouchPointLocation tpl on tpl.TouchPointID = TP.TouchPointID and tpl.StateID=1
inner join dbo.T_Location l on l.LocationID=tpl.LocationID and l.StateID =1
where TPGEO.MapTypeID=5 --and TPGEO.ZoomLevel=@ZoomLevel 
and @ZoomLevel >= TPGEO.MinZoomLevel and @ZoomLevel <= TPGEO.MaxZoomLevel
AND TP.TouchPointTypeID=@TouchPointTypeID;

end;
--//////////////////////////////////////////////////////////////////////