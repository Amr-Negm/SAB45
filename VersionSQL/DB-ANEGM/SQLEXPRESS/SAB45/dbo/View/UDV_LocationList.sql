/****** Object:  View [dbo].[UDV_LocationList]    Committed by VersionSQL https://www.versionsql.com ******/

/*----------------------------------------------------------*/
CREATE VIEW [dbo].[UDV_LocationList]
AS

SELECT distinct LOC1.ParentLocationID "ParentID",LOC2.Name "ParentName",LOC1.LocationID "ChildID",LOC1.Name "ChildName",tp.TouchPointTypeID,tploc.StateID
FROM  dbo.T_Location LOC1 LEFT JOIN dbo.T_Location LOC2 
ON 
LOC1.ParentLocationID=LOC2.LocationID 
LEFT join 
[dbo].[T_TouchPointLocation] tploc 
on
tploc.locationID=LOC1.locationID 
LEFT join 
[dbo].[T_TouchPoints] tp
on
tp.touchpointid=tploc.touchpointid ;
--where tploc.StateID=1 or tploc.StateID IS NULL;
  