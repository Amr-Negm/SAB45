/****** Object:  Procedure [dbo].[UDSP_AlarmDetails]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE Procedure [dbo].[UDSP_AlarmDetails] @AlarmID int ,
										  @MapTypeID int 

as 

SELECT
E.EventID, E.EventCode, E.Occurance_Date AS EventDate, ED.EventDefinitionTitle1 AS EventDefinitionTitle,
T.TouchPointCode, T.TouchPointID, T.TouchPointTitle1,L.LocationID, LM.MapTypeID,
TG.X_Coordination, TG.Y_Coordination, --TG.GeographyPoint, 
TG.RotationAngle, TG.ZoomLevel,
EP.EventParmKey, EP.StringValue, EP.BinaryValue

FROM		T_EventAlarms					EA
INNER JOIN	T_Events						E	On	EA.EventID = E.EventID
LEFT JOIN	T_EventParms					EP	On	E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions				ED	On	Ed.EventDefinitionID = E.EventDefinitionID
INNER JOIN	T_TouchPoints					T	On	ED.TouchPointIDSource = T.TouchPointID
INNER JOIN	T_TouchPointLocation			TL	On	T.TouchPointID = Tl.TouchPointID
INNER JOIN	T_Location						L	On	TL.LocationID = L.LocationID
INNER JOIN	T_LocationMapData				LM	On	L.LocationID = LM.LocationID
INNER JOIN	T_TouchPointGeographyDetails	TG	On	T.TouchPointID = TG.TouchPointID AND LM.MapTypeID = TG.MapTypeID 

WHERE 
EA.AlarmID	= @AlarmID	AND
E. StateID	= 1 AND E. StatusID	= 1 AND
EP.StateID	= 1	AND EP.StatusID	= 1	AND
ED.StateID	= 1 AND ED.StatusID	= 1 AND
T. StateID	= 1	AND 
TL.StateID	= 1 AND 
L. StateID	= 1 AND 
LM.StateID	= 1 AND LM.MapTypeID= @MapTypeID	AND TG.MapTypeID = 3

ORDER BY E.Occurance_Date DESC