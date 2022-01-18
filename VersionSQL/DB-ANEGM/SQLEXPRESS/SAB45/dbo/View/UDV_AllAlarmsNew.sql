/****** Object:  View [dbo].[UDV_AllAlarmsNew]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE  VIEW [dbo].[UDV_AllAlarmsNew]
  
AS
SELECT DISTINCT 
                  tpl.LocationID AS TouchPointLocationLocationID, tpl.TouchPointID AS TouchPointLocationTouchPointID, l.LocationID, l.Code AS LocationCode, l.Name AS LocationName, l.Description AS LocationDescription, 
                  l.CreationUserID AS LocationCreationUserID, l.CreationDate AS LocationCreationDate, l.LocationTypeId, l.LocationCategoryId, l.ParentLocationID, par.Name AS ParentLocationName, lt.Name AS LocationTypeName, T.TouchPointTitle1, 
                  tpt.TouchPointTypeID, tpt.TouchPointTypeTitle1 AS TouchPointTypeName, T.TouchPointCode, T.TouchPointID, A.Occurance_Date, A.AlarmID, A.Response_Date, A.ResponseTimeDifference, AD.AlarmDefinitionTitle1, 
                  AD.ExpectedResponseTime, AD.PriorityID, AST.AlarmStatusTitle1, A.AlarmComment, l.StateID AS lStateID, T.StateID AS TStateID, AD.StateID AS ADStateID, tpl.StateID AS TLStateID
FROM     dbo.T_Location AS l LEFT OUTER JOIN
                  dbo.T_Location AS par ON l.ParentLocationID = par.LocationID INNER JOIN
                  dbo.LT_LocationType AS lt ON lt.LocationTypeId = l.LocationTypeId INNER JOIN
                  dbo.T_TouchPointLocation AS tpl ON tpl.LocationID = l.LocationID INNER JOIN
                  dbo.T_TouchPoints AS T ON T.TouchPointID = tpl.TouchPointID INNER JOIN
                  dbo.LT_TouchPointTypes AS tpt ON tpt.TouchPointTypeID = T.TouchPointTypeID INNER JOIN
                  dbo.T_EventDefinitions AS ED ON ED.TouchPointIDSource = T.TouchPointID INNER JOIN
                  dbo.T_Events AS E ON E.EventDefinitionID = ED.EventDefinitionID INNER JOIN
                  dbo.T_EventAlarms AS EA ON EA.EventID = E.EventID INNER JOIN
                  dbo.T_Alarms AS A ON A.AlarmID = EA.AlarmID INNER JOIN
                  dbo.T_AlarmDefinitions AS AD ON AD.AlarmDefinitionID = A.AlarmsDefinitionID INNER JOIN
                  dbo.LT_AlarmStatuses AS AST ON AST.AlarmStatusID = A.AlarmStatusID