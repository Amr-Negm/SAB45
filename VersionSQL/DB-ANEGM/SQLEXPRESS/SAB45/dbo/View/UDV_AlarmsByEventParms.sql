/****** Object:  View [dbo].[UDV_AlarmsByEventParms]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE VIEW [dbo].[UDV_AlarmsByEventParms]
AS
SELECT DISTINCT 
                  T_TouchPointLocation.LocationID AS TouchPointLocationLocationID, T_TouchPointLocation.TouchPointID AS TouchPointLocationTouchPointID, dbo.T_Alarms.AlarmID, dbo.T_Alarms.Occurance_Date, dbo.T_Location.LocationID, 
                  dbo.T_Location.Name AS LocationName, dbo.T_Location.ParentLocationID, dbo.T_TouchPoints.TouchPointID, dbo.T_TouchPoints.TouchPointTitle1, dbo.T_AlarmDefinitions.AlarmDefinitionTitle1, 
                  dbo.T_Location.StateID AS LocationStateId, dbo.T_TouchPoints.StateID AS TouchpointStateId, T_TouchPointLocation.StateID AS TouchPointLocationStateID, dbo.T_EventParms.EventParmKey, 
                  dbo.T_EventParms.StringValue AS EventParmStringValue, dbo.T_Events.EventID, dbo.LT_AlarmStatuses.AlarmStatusID, dbo.LT_AlarmStatuses.AlarmStatusTitle1
FROM     dbo.T_EventParms INNER JOIN
                  dbo.T_Events ON dbo.T_EventParms.EventID = dbo.T_Events.EventID AND dbo.T_EventParms.EventSiteID = dbo.T_Events.EventSiteID INNER JOIN
                  dbo.T_Location INNER JOIN
                  dbo.T_TouchPointLocation AS T_TouchPointLocation ON T_TouchPointLocation.LocationID = dbo.T_Location.LocationID INNER JOIN
                  dbo.T_TouchPoints ON dbo.T_TouchPoints.TouchPointID = T_TouchPointLocation.TouchPointID INNER JOIN
                  dbo.T_EventDefinitions ON dbo.T_EventDefinitions.TouchPointIDSource = dbo.T_TouchPoints.TouchPointID ON dbo.T_Events.EventDefinitionID = dbo.T_EventDefinitions.EventDefinitionID INNER JOIN
                  dbo.T_EventAlarms ON dbo.T_EventAlarms.EventID = dbo.T_Events.EventID INNER JOIN
                  dbo.T_Alarms ON dbo.T_Alarms.AlarmID = dbo.T_EventAlarms.AlarmID INNER JOIN
                  dbo.T_AlarmDefinitions ON dbo.T_AlarmDefinitions.AlarmDefinitionID = dbo.T_Alarms.AlarmsDefinitionID INNER JOIN
                  dbo.LT_AlarmStatuses ON dbo.T_Alarms.AlarmStatusID = dbo.LT_AlarmStatuses.AlarmStatusID
WHERE  (T_TouchPointLocation.StateID = 1)