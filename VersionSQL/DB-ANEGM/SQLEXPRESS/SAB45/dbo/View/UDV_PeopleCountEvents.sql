/****** Object:  View [dbo].[UDV_PeopleCountEvents]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE VIEW dbo.UDV_PeopleCountEvents
AS
SELECT dbo.T_EventParms.EventID, dbo.T_EventParms.EventParmKey, dbo.T_EventParms.StringValue, dbo.T_Events.Occurance_Date, dbo.T_TouchPoints.TouchPointTitle1, dbo.T_Location.LocationID, dbo.T_Location.Name, 
                  dbo.T_TouchPointLocation.StateID, T_Location_1.Name AS ParentLocationName
FROM     dbo.T_EventParms INNER JOIN
                  dbo.T_Events ON dbo.T_EventParms.EventID = dbo.T_Events.EventID AND dbo.T_EventParms.EventSiteID = dbo.T_Events.EventSiteID INNER JOIN
                  dbo.T_EventDefinitions ON dbo.T_Events.EventDefinitionID = dbo.T_EventDefinitions.EventDefinitionID AND dbo.T_Events.EventDefinitionSiteID = dbo.T_EventDefinitions.EventDefinitionSiteID INNER JOIN
                  dbo.T_TouchPoints ON dbo.T_EventDefinitions.TouchPointIDSource = dbo.T_TouchPoints.TouchPointID INNER JOIN
                  dbo.T_TouchPointLocation ON dbo.T_TouchPoints.TouchPointID = dbo.T_TouchPointLocation.TouchPointID INNER JOIN
                  dbo.T_Location ON dbo.T_TouchPointLocation.LocationID = dbo.T_Location.LocationID LEFT OUTER JOIN
                  dbo.T_Location AS T_Location_1 ON dbo.T_Location.ParentLocationID = T_Location_1.LocationID
WHERE  (dbo.T_EventParms.EventParmKey = N'NumberOfPersonsLeavingTheArea' OR
                  dbo.T_EventParms.EventParmKey = N'NumberOfPersonsEnteringTheArea') AND (dbo.T_TouchPointLocation.StateID = 1)