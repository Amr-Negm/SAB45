/****** Object:  View [dbo].[UDV_ScenarioAveragePerWeek]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE   VIEW [dbo].[UDV_ScenarioAveragePerWeek]
WITH SCHEMABINDING 
AS
SELECT        dbo.T_Alarms.AlarmID, dbo.T_AlarmDefinitions.AlarmDefinitionTitle1, dbo.T_Scenarios.ScenarioID, dbo.T_Scenarios.ScenarioTitle1, dbo.T_Scenarios.ScenarioImpact, dbo.T_Alarms.AlarmCode, dbo.T_Alarms.Occurance_Date, 
                         dbo.T_Alarms.Response_User, dbo.T_Alarms.Response_Date, dbo.T_Alarms.AlarmStatusID, dbo.T_Alarms.AlarmClassificationID, dbo.T_Alarms.AlarmsDefinitionID, dbo.T_Alarms.AlarmComment, dbo.T_Alarms.StateID, 
                         dbo.T_Alarms.StatusID, dbo.T_Alarms.AlarmDefinitionSiteID, dbo.T_Alarms.EscalationLevelID, dbo.T_Alarms.EscalationLevelSiteID, dbo.T_Alarms.ResponseTimeDifference, dbo.T_Alarms.EscalationDescription, 
                         dbo.T_Alarms.EscalationUser, dbo.T_Alarms.EscalationDate
FROM            dbo.T_AlarmDefinitionScenarios INNER JOIN
                         dbo.T_Scenarios ON dbo.T_AlarmDefinitionScenarios.ScenarioID = dbo.T_Scenarios.ScenarioID INNER JOIN
                         dbo.T_AlarmDefinitions INNER JOIN
                         dbo.T_Alarms ON dbo.T_AlarmDefinitions.AlarmDefinitionID = dbo.T_Alarms.AlarmsDefinitionID  ON 
                         dbo.T_AlarmDefinitionScenarios.AlarmsDefinitionID = dbo.T_AlarmDefinitions.AlarmDefinitionID 