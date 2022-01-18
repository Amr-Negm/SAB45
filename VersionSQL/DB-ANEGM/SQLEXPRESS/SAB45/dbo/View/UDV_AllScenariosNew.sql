/****** Object:  View [dbo].[UDV_AllScenariosNew]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE  VIEW [dbo].[UDV_AllScenariosNew]   
  
AS
SELECT       --ROW_NUMBER() OVER (ORDER BY dbo.T_Alarms.AlarmID) AS RowNum, 
dbo.T_Alarms.AlarmID, dbo.T_AlarmDefinitions.AlarmDefinitionTitle1,
 dbo.T_Scenarios.ScenarioID, dbo.T_Scenarios.ScenarioTitle1, dbo.T_Scenarios.ScenarioImpact, dbo.T_Alarms.AlarmCode, 
                         dbo.T_Alarms.Occurance_Date, dbo.T_Alarms.Response_User, dbo.T_Alarms.Response_Date, dbo.T_Alarms.AlarmStatusID, dbo.T_Alarms.AlarmClassificationID, dbo.T_Alarms.AlarmsDefinitionID, 
                         dbo.T_Alarms.AlarmComment, dbo.T_Alarms.StateID, dbo.T_Alarms.StatusID, dbo.T_Alarms.AlarmDefinitionSiteID, dbo.T_Alarms.EscalationLevelID, dbo.T_Alarms.EscalationLevelSiteID, 
                         dbo.T_Alarms.ResponseTimeDifference, dbo.T_Alarms.EscalationDescription, dbo.T_Alarms.EscalationUser, dbo.T_Alarms.EscalationDate, dbo.LT_AlarmStatuses.AlarmStatusTitle1, dbo.LT_AlarmStatuses.AlarmStatusTitle2, 
                         dbo.T_TouchPoints.TouchPointTitle1, dbo.LT_AlarmClassifications.AlarmClassificationTitle1, dbo.LT_AlarmClassifications.AlarmClassificationTitle2, dbo.LT_Priorities.PriorityTitle1, dbo.T_TouchPoints.TouchPointID
						 ,l.[LocationID]
						 ,l.[Code] as LocationCode
						 ,l.[Name] as LocationName
						 ,l.[Description] as LocationDescription
						 ,l.[CreationUserID] as LocationCreationUserID
						 ,l.[CreationDate] as LocationCreationDate
						 ,l.[LocationTypeId]
						 ,l.[LocationCategoryId]
						 ,l.[ParentLocationID]
						 ,par.Name as ParentLocationName

						 ,lt.Name as LocationTypeName
						 ,lc.Name as LocationCategoryName

FROM            dbo.T_AlarmDefinitionScenarios INNER JOIN
                         dbo.T_Scenarios ON dbo.T_AlarmDefinitionScenarios.ScenarioID = dbo.T_Scenarios.ScenarioID INNER JOIN
                         dbo.T_AlarmDefinitions INNER JOIN
                         dbo.T_Alarms ON dbo.T_AlarmDefinitions.AlarmDefinitionID = dbo.T_Alarms.AlarmsDefinitionID ON 
                         dbo.T_AlarmDefinitionScenarios.AlarmsDefinitionID = dbo.T_AlarmDefinitions.AlarmDefinitionID INNER JOIN
                         dbo.LT_AlarmClassifications ON dbo.T_AlarmDefinitions.AlarmClassificationID = dbo.LT_AlarmClassifications.AlarmClassificationID AND 
                         dbo.T_Alarms.AlarmClassificationID = dbo.LT_AlarmClassifications.AlarmClassificationID INNER JOIN
                         dbo.LT_AlarmStatuses ON dbo.T_Alarms.AlarmStatusID = dbo.LT_AlarmStatuses.AlarmStatusID INNER JOIN
                         dbo.T_EventAlarms ON dbo.T_Alarms.AlarmID = dbo.T_EventAlarms.AlarmID INNER JOIN
                         dbo.T_Events ON dbo.T_EventAlarms.EventID = dbo.T_Events.EventID INNER JOIN
                         dbo.T_EventDefinitions ON dbo.T_Events.EventDefinitionID = dbo.T_EventDefinitions.EventDefinitionID INNER JOIN
                         
						 dbo.T_TouchPoints ON dbo.T_EventDefinitions.TouchPointIDSource = dbo.T_TouchPoints.TouchPointID INNER JOIN
                         dbo.T_TouchPointLocation tpl ON dbo.T_TouchPoints.TouchPointID = tpl.TouchPointID INNER JOIN
						 dbo.T_Location l on tpl.LocationID = l.LocationID 
						 left join dbo.T_Location par on l.ParentLocationID=par.LocationID
						 inner join dbo.LT_LocationType lt on lt.LocationTypeId = l.LocationTypeId inner join
						 dbo.LT_LocationCategory lc on lc.LocationCategoryId = l.LocationCategoryId inner join

                         dbo.LT_Priorities ON dbo.T_AlarmDefinitions.PriorityID = dbo.LT_Priorities.PriorityID