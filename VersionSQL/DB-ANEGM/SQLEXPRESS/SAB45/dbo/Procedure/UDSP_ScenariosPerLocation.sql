/****** Object:  Procedure [dbo].[UDSP_ScenariosPerLocation]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_ScenariosPerLocation] 
@DateFrom datetime='1900-01-01 00:00:00',		--[dbo].[T_Alarms].[Occurance_Date] 
@DateTo datetime='9999-12-31 00:00:00',	    --[dbo].[T_Alarms].[Occurance_Date] 
@City nvarchar(200)='',	--[dbo].[T_Cities].[CityTitle1]            
@Station nvarchar(200)='',	--[dbo].[T_Sites].[StationTitle1]
@Level nvarchar(200)='',	--[dbo].[T_Levels].[LevelTitle1]
@Zone nvarchar(200)='',	--[dbo].[T_Zones].[ZoneTitle1]
@Camera nvarchar(200)='',  --[dbo].[T_TouchPoints].[TouchPointTitle1]
@AlarmStatus nvarchar(200)='', --[dbo].[LT_AlarmStatuses].[AlarmStatusTitle1]
@priority nvarchar(200) =''--[dbo].[LT_Priorities].[PriorityTitle1]      
as
begin
SET NOCOUNT ON;

/*
begin
declare @AlarmID int=NULL;
SELECT *
  FROM [CAECommandControlDB].[dbo].[T_Alarms] 
  where AlarmID = (ISNULL(@AlarmID,AlarmID));

  end;
*/



select location,AlarmsTotalnumbers,[Very High],High,Medium,Low,[Very low]
from
(
select *
from
(
select Cities.CityTitle1 as "Location",
COUNT(Alarms.AlarmID) as "AlarmsPriorities",
Priorities.PriorityTitle1 as "priority"
from 
[dbo].[T_Alarms] as "Alarms"
right outer join
[dbo].[T_AlarmDefinitions] as "AlarmDefinitions"
on (Alarms.AlarmsDefinitionID=AlarmDefinitions.AlarmDefinitionID and Alarms.AlarmDefinitionSiteID=AlarmDefinitions.AlarmDefinitionSiteID)
right outer join
[dbo].[LT_AlarmStatuses] as "AlarmStatuses"
on(AlarmStatuses.AlarmStatusID=Alarms.AlarmStatusID)
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
where Alarms.Occurance_Date between ISNULL(@DateFrom,'1900-01-01 00:00:00') and ISNULL(@DateTo,'9999-12-31 00:00:00')        
and Cities.CityTitle1=isnull(@City,Cities.CityTitle1) 
and Stations.SiteTitle1=isnull(@Station,Stations.SiteTitle1)
and Levels.LevelTitle1=isnull(@Level,Levels.LevelTitle1)
and Zones.ZoneTitle1=isnull(@Zone,Zones.ZoneTitle1)
and TouchPoints.TouchPointTitle1=isnull(@Camera,TouchPoints.TouchPointTitle1)
and AlarmStatuses.AlarmStatusTitle1=isnull(@AlarmStatus,AlarmStatuses.AlarmStatusTitle1)
and Priorities.PriorityTitle1=isnull(@priority,Priorities.PriorityTitle1)
group by Cities.CityID,Cities.CityTitle1,Priorities.PriorityTitle1
) as "R1"

inner join

(select Cities.CityTitle1 as "City",
COUNT(Alarms.AlarmID) as"AlarmsTotalNumbers"
from 
[dbo].[T_Alarms] as "Alarms"
right outer join
[dbo].[T_AlarmDefinitions] as "AlarmDefinitions"
on (Alarms.AlarmsDefinitionID=AlarmDefinitions.AlarmDefinitionID and Alarms.AlarmDefinitionSiteID=AlarmDefinitions.AlarmDefinitionSiteID)
right outer join
[dbo].[LT_AlarmStatuses] as "AlarmStatuses"
on(AlarmStatuses.AlarmStatusID=Alarms.AlarmStatusID)
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
where Alarms.Occurance_Date between ISNULL(@DateFrom,'1900-01-01 00:00:00') and ISNULL(@DateTo,'9999-12-31 00:00:00') 
and Cities.CityTitle1=isnull(@City,Cities.CityTitle1) 
and Stations.SiteTitle1=isnull(@Station,Stations.SiteTitle1)
and Levels.LevelTitle1=isnull(@Level,Levels.LevelTitle1)
and Zones.ZoneTitle1=isnull(@Zone,Zones.ZoneTitle1)
and TouchPoints.TouchPointTitle1=isnull(@Camera,TouchPoints.TouchPointTitle1)
and AlarmStatuses.AlarmStatusTitle1=isnull(@AlarmStatus,AlarmStatuses.AlarmStatusTitle1)
and Priorities.PriorityTitle1=isnull(@priority,Priorities.PriorityTitle1)
group by Cities.CityTitle1
--having [dbo].[T_Sites].StationTitle1=@Station
) as "R2"
on(R1.Location=R2.City)
) as "ResultSet"
------------------------------------------ pivoting ----------------------------------------------
pivot(
sum (AlarmsPriorities)
for priority in([Very High],[High],[Medium],[Low],[Very low]))
as Pivoting
SET NOCOUNT OFF;
end;