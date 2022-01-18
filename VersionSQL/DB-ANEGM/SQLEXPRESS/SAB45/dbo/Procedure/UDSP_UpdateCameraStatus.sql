/****** Object:  Procedure [dbo].[UDSP_UpdateCameraStatus]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROC [dbo].[UDSP_UpdateCameraStatus] (@TPStatus TPStatus READONLY)
AS

UPDATE c
SET c.StringValue = a.StringValue
FROM @TPStatus AS a
JOIN T_TouchPoints as b
ON a.TouchPointID = b.TouchPointID AND b.TouchPointTypeID = 1
JOIN T_TouchPointParms as c
ON a.TouchPointID = c.TouchPointID AND c.TPParmID = 38

INSERT T_TouchPointParms (TouchPointID,StringValue,TPParmID,TPParmSiteID,TouchPointSiteID)

SELECT DISTINCT a.TouchPointID,a.StringValue,'38' AS TPParmID, 1 AS TPParmSiteID,1 AS TouchPointSiteID
FROM @TPStatus AS a
JOIN T_TouchPoints as b
ON a.TouchPointID = b.TouchPointID AND b.TouchPointTypeID = 1
JOIN T_TouchPointParms as c
ON a.TouchPointID = c.TouchPointID
LEFT JOIN T_TouchPointParms as d
ON a.TouchPointID = d.TouchPointID AND d.TPParmID = 38
WHERE d.TPParmID IS NULL