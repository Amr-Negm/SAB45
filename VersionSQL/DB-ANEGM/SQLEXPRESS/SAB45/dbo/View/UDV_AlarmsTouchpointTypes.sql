/****** Object:  View [dbo].[UDV_AlarmsTouchpointTypes]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE VIEW [dbo].[UDV_AlarmsTouchpointTypes]
AS
SELECT DISTINCT 
                         dbo.T_Alarms.AlarmID, dbo.T_Alarms.AlarmCode, dbo.T_Alarms.Occurance_Date, dbo.T_Alarms.Response_Date, dbo.T_Alarms.StateID, 
                         dbo.T_Alarms.ResponseTimeDifference, dbo.T_TouchPoints.TouchPointID, dbo.T_TouchPoints.TouchPointTitle1, dbo.LT_TouchPointTypes.TouchPointTypeTitle1, 
                         dbo.T_AlarmDefinitions.AlarmDefinitionTitle1, dbo.LT_TouchPointTypes.TouchPointTypeID
FROM            dbo.T_TouchPoints INNER JOIN
                         dbo.LT_TouchPointTypes ON dbo.LT_TouchPointTypes.TouchPointTypeID = dbo.T_TouchPoints.TouchPointTypeID INNER JOIN
                         dbo.T_EventDefinitions ON dbo.T_EventDefinitions.TouchPointIDSource = dbo.T_TouchPoints.TouchPointID INNER JOIN
                         dbo.T_Events ON dbo.T_Events.EventDefinitionID = dbo.T_EventDefinitions.EventDefinitionID INNER JOIN
                         dbo.T_EventAlarms ON dbo.T_EventAlarms.EventID = dbo.T_Events.EventID INNER JOIN
                         dbo.T_Alarms ON dbo.T_Alarms.AlarmID = dbo.T_EventAlarms.AlarmID INNER JOIN
                         dbo.T_AlarmDefinitions ON dbo.T_AlarmDefinitions.AlarmDefinitionID = dbo.T_Alarms.AlarmsDefinitionID