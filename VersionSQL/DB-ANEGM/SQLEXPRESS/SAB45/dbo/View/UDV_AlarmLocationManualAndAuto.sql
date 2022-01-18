/****** Object:  View [dbo].[UDV_AlarmLocationManualAndAuto]    Committed by VersionSQL https://www.versionsql.com ******/

create view UDV_AlarmLocationManualAndAuto
as

SELECT DISTINCT 
                  T_TouchPointLocation.LocationID AS TouchPointLocationLocationID, T_TouchPointLocation.TouchPointID AS TouchPointLocationTouchPointID, dbo.T_Alarms.AlarmID, dbo.T_Alarms.AlarmCode, dbo.T_Alarms.Occurance_Date, 
                  dbo.T_Alarms.Response_Date, dbo.T_Alarms.StateID, dbo.T_Alarms.ResponseTimeDifference, dbo.T_Location.LocationID, dbo.T_Location.Name AS LocationName, dbo.T_Location.Description, dbo.T_Location.ParentLocationID, 
                  dbo.LT_LocationType.Name AS LocationTypeName, dbo.T_TouchPoints.TouchPointID, dbo.T_TouchPoints.TouchPointTitle1, dbo.LT_TouchPointTypes.TouchPointTypeTitle1, dbo.T_AlarmDefinitions.AlarmDefinitionTitle1, 
                  par.Name AS ParentLocationName, dbo.LT_TouchPointTypes.TouchPointTypeID, dbo.T_Location.StateID AS LocationStateId, dbo.T_TouchPoints.StateID AS TouchpointStateId, 
                  T_TouchPointLocation.StateID AS TouchPointLocationStateID
FROM     dbo.T_Location LEFT OUTER JOIN
                  dbo.T_Location AS par ON dbo.T_Location.ParentLocationID = par.LocationID LEFT OUTER JOIN
                  dbo.LT_LocationType ON dbo.LT_LocationType.LocationTypeId = dbo.T_Location.LocationTypeId LEFT OUTER JOIN
                  dbo.T_TouchPointLocation AS T_TouchPointLocation ON T_TouchPointLocation.LocationID = dbo.T_Location.LocationID LEFT OUTER JOIN
                  dbo.T_TouchPoints ON dbo.T_TouchPoints.TouchPointID = T_TouchPointLocation.TouchPointID LEFT OUTER JOIN
                  dbo.LT_TouchPointTypes ON dbo.LT_TouchPointTypes.TouchPointTypeID = dbo.T_TouchPoints.TouchPointTypeID LEFT OUTER JOIN
                  dbo.T_EventDefinitions ON dbo.T_EventDefinitions.TouchPointIDSource = dbo.T_TouchPoints.TouchPointID LEFT OUTER JOIN
                  dbo.T_Events ON dbo.T_Events.EventDefinitionID = dbo.T_EventDefinitions.EventDefinitionID LEFT OUTER JOIN
                  dbo.T_EventAlarms ON dbo.T_EventAlarms.EventID = dbo.T_Events.EventID LEFT OUTER JOIN
                  dbo.T_Alarms ON dbo.T_Alarms.AlarmID = dbo.T_EventAlarms.AlarmID LEFT OUTER JOIN
                  dbo.T_AlarmDefinitions ON dbo.T_AlarmDefinitions.AlarmDefinitionID = dbo.T_Alarms.AlarmsDefinitionID

				    --where T_Events.Occurance_Date > '2020-2-26' and T_Events.Occurance_Date < '2021-01-06'
union all
--Manual Alarms
SELECT DISTINCT 
                  NULL AS TouchPointLocationLocationID, NULL AS TouchPointLocationTouchPointID, dbo.T_Alarms.AlarmID, dbo.T_Alarms.AlarmCode, dbo.T_Alarms.Occurance_Date, 
                  dbo.T_Alarms.Response_Date, dbo.T_Alarms.StateID, dbo.T_Alarms.ResponseTimeDifference, dbo.T_Location.LocationID, dbo.T_Location.Name AS LocationName, dbo.T_Location.Description, dbo.T_Location.ParentLocationID, 
                  dbo.LT_LocationType.Name AS LocationTypeName, NULL as TouchPointID,NULL AS TouchPointTitle1, NULL AS TouchPointTypeTitle1, dbo.T_AlarmDefinitions.AlarmDefinitionTitle1, 
                  par.Name AS ParentLocationName, NULL AS TouchPointTypeID, dbo.T_Location.StateID AS LocationStateId, NULL AS TouchpointStateId, 
                  NULL AS TouchPointLocationStateID
FROM     (SELECT distinct [EventID],StringValue as 'LocationIDManual' FROM [SAB45].[dbo].[T_EventParms]  where [EventParmKey] = 'LocationId') manl 
                  
				  left outer join dbo.T_Location  
				   on 
                  manl.LocationIDManual=dbo.T_Location.LocationID 
                  LEFT OUTER JOIN
                  dbo.T_Location AS par ON dbo.T_Location.ParentLocationID = par.LocationID LEFT OUTER JOIN
                  dbo.LT_LocationType ON dbo.LT_LocationType.LocationTypeId = dbo.T_Location.LocationTypeId LEFT OUTER JOIN
                  /*
				  dbo.T_TouchPointLocation AS T_TouchPointLocation ON T_TouchPointLocation.LocationID = dbo.T_Location.LocationID LEFT OUTER JOIN
                  dbo.T_TouchPoints ON dbo.T_TouchPoints.TouchPointID = T_TouchPointLocation.TouchPointID LEFT OUTER JOIN
                  dbo.LT_TouchPointTypes ON dbo.LT_TouchPointTypes.TouchPointTypeID = dbo.T_TouchPoints.TouchPointTypeID LEFT OUTER JOIN
                  
				  dbo.T_EventDefinitions ON dbo.T_EventDefinitions.TouchPointIDSource = dbo.T_TouchPoints.TouchPointID LEFT OUTER JOIN
                  */
				  dbo.T_Events ON dbo.T_Events.EventID= manl.EventID LEFT OUTER JOIN
                  dbo.T_EventAlarms ON dbo.T_EventAlarms.EventID = dbo.T_Events.EventID LEFT OUTER JOIN
                  dbo.T_Alarms ON dbo.T_Alarms.AlarmID = dbo.T_EventAlarms.AlarmID LEFT OUTER JOIN
                  dbo.T_AlarmDefinitions ON dbo.T_AlarmDefinitions.AlarmDefinitionID = dbo.T_Alarms.AlarmsDefinitionID

				    --where T_Events.Occurance_Date > '2020-12-26' and T_Events.Occurance_Date < '2021-01-06'