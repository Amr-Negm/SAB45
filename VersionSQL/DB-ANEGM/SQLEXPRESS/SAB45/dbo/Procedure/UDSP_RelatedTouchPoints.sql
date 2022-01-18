/****** Object:  Procedure [dbo].[UDSP_RelatedTouchPoints]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_RelatedTouchPoints] @TouchPointID int , @MapTypeID int

as

SELECT
MT.TouchPointID AS MasterTouchPointID,
E.EventID, E.EventCode, E.Occurance_Date AS EventDate, ME.Occurance_Date AS MasterEventDate, ME.EventCode As MaseterEventCode, ED.EventDefinitionTitle1 AS EventDefinitionTitle,
T.TouchPointCode, T.TouchPointTitle1,L.LocationID, LM.MapTypeID,
TG.X_Coordination, TG.Y_Coordination, --TG.GeographyPoint, 
TG.RotationAngle, TG.ZoomLevel,
EP.EventParmKey, EP.StringValue, EP.BinaryValue

FROM		T_Events						E	
LEFT JOIN	T_EventParms					EP	ON	E.EventID = EP.EventID
INNER JOIN	T_EventDefinitions				ED	ON	E.EventDefinitionID = ED.EventDefinitionID
INNER JOIN	T_TouchPoints					T	ON	ED.TouchPointIDSource = T.TouchPointID
INNER JOIN	T_RelatedTouchPoint				RT	ON	T.TouchPointID = RT.RelatedTouchPoint
INNER JOIN	T_TouchPoints					MT	ON	RT.MasterTouchPoint = MT.TouchPointID
INNER JOIN	T_TouchPointLocation			TL	ON	T.TouchPointID = Tl.TouchPointID
INNER JOIN	T_Location						L	ON	TL.LocationID = L.LocationID
INNER JOIN	T_LocationMapData				LM	ON	L.LocationID = LM.LocationID
INNER JOIN	T_TouchPointGeographyDetails	TG	ON	T.TouchPointID = TG.TouchPointID AND LM.MapTypeID = TG.MapTypeID 
INNER JOIN	T_EventDefinitions				MED	On	MED.TouchPointIDSource = MT.TouchPointID
INNER JOIN	T_Events						ME	On	ME.EventDefinitionID = MED.EventDefinitionID

WHERE
E. StateID = 1	AND	E. StatusID = 1	AND
EP.StateID = 1	AND	EP.StatusID = 1	AND
ED.StateID = 1	AND	ED.StatusID = 1	AND
T. StateID = 1	AND	
MT.StateID = 1	AND
TL.StateID = 1	AND	
L .StateID = 1	AND
LM.StateID = 1	AND	
MED.StateID= 1	AND	MED.StatusID= 1 AND
ME.StateID = 1	AND	ME.StatusID = 1 AND
LM.MapTypeID = @MapTypeID AND MT.TouchPointID = @TouchPointID AND
DATEDIFF(SECOND, E.Occurance_Date, ME.Occurance_Date) <= RT.TimeInSecond
--AND
--E.EventID in (
--SELECT NearestEvents.EventId FROM
--	(SELECT DISTINCT E2.EventDefinitionID, MIN(E2.Occurance_Date)AS Latest, E2.EventId FROM T_Events E2 
--	WHERE DATEDIFF(SECOND, E2.Occurance_Date, ME.Occurance_Date) <= RT.TimeInSecond AND
--	E.EventDefinitionID = E2.EventDefinitionID AND
--	E.EventCode = E2.EventCode AND
--	E2. StateID = 1	AND	E2. StatusID = 1
--	GROUP BY E2.EventId, E2.EventDefinitionID) NearestEvents)