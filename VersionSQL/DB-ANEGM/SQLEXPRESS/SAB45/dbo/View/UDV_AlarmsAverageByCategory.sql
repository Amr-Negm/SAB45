/****** Object:  View [dbo].[UDV_AlarmsAverageByCategory]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE   VIEW [dbo].[UDV_AlarmsAverageByCategory]
AS
SELECT dbo.T_AlarmDefinitions.AlarmDefinitionTitle1, dbo.T_AlarmDefinitions.StateID, dbo.T_Alarms.AlarmID, dbo.T_Alarms.Occurance_Date, dbo.T_Alarms.Response_Date, dbo.T_Alarms.AlarmStatusID, dbo.T_Alarms.AlarmsDefinitionID, 
                  dbo.T_Alarms.ResponseTimeDifference, dbo.LT_AlarmCategories.AlarmCategoryID, dbo.LT_AlarmCategories.AlarmCategoryTitle1
FROM     dbo.T_AlarmDefinitions INNER JOIN
                  dbo.T_Alarms ON dbo.T_AlarmDefinitions.AlarmDefinitionID = dbo.T_Alarms.AlarmsDefinitionID AND dbo.T_AlarmDefinitions.AlarmDefinitionSiteID = dbo.T_Alarms.AlarmDefinitionSiteID INNER JOIN
                  dbo.LT_AlarmCategories ON dbo.T_AlarmDefinitions.AlarmCategoryID = dbo.LT_AlarmCategories.AlarmCategoryID
WHERE  (dbo.T_AlarmDefinitions.StateID = 1)