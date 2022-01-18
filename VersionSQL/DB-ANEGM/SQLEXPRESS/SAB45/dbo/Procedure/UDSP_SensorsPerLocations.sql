/****** Object:  Procedure [dbo].[UDSP_SensorsPerLocations]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_SensorsPerLocations] as
begin
SET NOCOUNT ON;
select location,AlarmsTotalnumbers,[Very High],High,Medium,Low,[Very low]
from
(
select  *
from
(select Cities.CityTitle1 as "Location",
COUNT(Alarms.AlarmID) as"AlarmsPriorities",
Priorities.PriorityTitle1 as "priority"
from 
[dbo].[T_Alarms] as "Alarms"
right outer join
[dbo].[T_AlarmDefinitions] as "AlarmDefinitions"
on (Alarms.AlarmsDefinitionID=AlarmDefinitions.AlarmDefinitionID and Alarms.AlarmDefinitionSiteID=AlarmDefinitions.AlarmDefinitionSiteID)
right outer join
[dbo].[LT_Priorities] as "Priorities"
on(AlarmDefinitions.PriorityID=Priorities.PriorityID)
right outer join
[dbo].[T_EventAlarms] as "EventAlarms"
on(Alarms.AlarmID=EventAlarms.AlarmID and Alarms.AlarmSiteID=EventAlarms.AlarmSiteID)
right outer join
[dbo].[T_Events] as "Events"
on (EventAlarms.EventID= Events.EventID and EventAlarms.EventSiteID=Events.EventSiteID)
right outer join
[dbo].[T_EventDefinitions] as "EventDefinitions"
on(Events.EventDefinitionID=EventDefinitions.EventDefinitionID and Events.EventDefinitionSiteID=EventDefinitions.EventDefinitionSiteID)
right outer join
[dbo].[T_TouchPoints] as "TouchPoints"
on (EventDefinitions.TouchPointIDSource=TouchPoints.TouchPointID and EventDefinitions.TouchPointSiteID=TouchPoints.TouchPointSiteID)
right outer join
[dbo].[T_Zones] as "Zones"
on(TouchPoints.ZoneID=Zones.ZoneID and TouchPoints.ZoneSiteID=Zones.ZoneSiteID)
right outer join
[dbo].[T_Levels] as "Levels"
on(Zones.LevelID=Levels.LevelID and Zones.LevelSiteID=Levels.LevelSiteID)
right outer join
[dbo].[T_Sites] as "Stations"
on(Levels.SiteID=Stations.SiteID)
right outer join
[dbo].[T_Cities] as "Cities"
on(Stations.CityID=Cities.CityID)
group by Cities.CityID,Cities.CityTitle1,Priorities.PriorityTitle1) as "R1"

inner join

(select Cities.CityTitle1 as "City",
COUNT(Alarms.AlarmID) as"AlarmsTotalNumbers"
from 
[dbo].[T_Alarms] as "Alarms"
right outer join
[dbo].[T_AlarmDefinitions] as "AlarmDefinitions"
on (Alarms.AlarmsDefinitionID=AlarmDefinitions.AlarmDefinitionID and Alarms.AlarmDefinitionSiteID=AlarmDefinitions.AlarmDefinitionSiteID)
right outer join
[dbo].[LT_Priorities] as "Priorities"
on(AlarmDefinitions.PriorityID=Priorities.PriorityID)
right outer join
[dbo].[T_EventAlarms] as "EventAlarms"
on(Alarms.AlarmID=EventAlarms.AlarmID and Alarms.AlarmSiteID=EventAlarms.AlarmSiteID)
right outer join
[dbo].[T_Events] as "Events"
on (EventAlarms.EventID= Events.EventID and EventAlarms.EventSiteID=Events.EventSiteID)
right outer join
[dbo].[T_EventDefinitions] as "EventDefinitions"
on(Events.EventDefinitionID=EventDefinitions.EventDefinitionID and Events.EventDefinitionSiteID=EventDefinitions.EventDefinitionSiteID)
right outer join
[dbo].[T_TouchPoints] as "TouchPoints"
on (EventDefinitions.TouchPointIDSource=TouchPoints.TouchPointID and EventDefinitions.TouchPointSiteID=TouchPoints.TouchPointSiteID)
right outer join
[dbo].[T_Zones] as "Zones"
on(TouchPoints.ZoneID=Zones.ZoneID and TouchPoints.ZoneSiteID=Zones.ZoneSiteID)
right outer join
[dbo].[T_Levels] as "Levels"
on(Zones.LevelID=Levels.LevelID and Zones.LevelSiteID=Levels.LevelSiteID)
right outer join
[dbo].[T_Sites] as "Stations"
on(Levels.SiteID=Stations.SiteID)
right outer join
[dbo].[T_Cities] as "Cities"
on(Stations.CityID=Cities.CityID)
group by Cities.CityTitle1) as "R2"
on(R1.Location=R2.City)
) as "ResultSet"
------------------------------------------ pivoting ----------------------------------------------
pivot(
sum (AlarmsPriorities)
for priority in([Very High],[High],[Medium],[Low],[Very low]))
as Pivoting
SET NOCOUNT OFF;
end;