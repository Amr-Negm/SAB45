/****** Object:  Procedure [dbo].[UDSP_OperationRecentAlarms]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_OperationRecentAlarms]
as
Begin
Declare @Top nvarchar(50)=1;
select @Top=(Select top 1 [Value] from dbo.T_Configuration where [SectionName]=N'AlarmModule' and [KEY]=N'MaxAlarmsToLoad')

Declare @SQL nvarchar(max)=N'
Select  TOP '+@Top+'    
 A.AlarmID
,A.AlarmCode
,AD.AlarmDefinitionTitle1 as "AlarmDefinitionName"
,AD.AlarmColor
,AD.AlarmIcon
,A.Occurance_Date
,TP.TouchPointTitle1 as "TouchPointName"
--,cast(TPGD.GeographyPoint as nvarchar(max)) as "GeographyPoint"
,L.Name as "LocationName"
,LP.Name as "LocationParentName"
,A.AlarmClassificationID
from 
T_Alarms A
inner join 
T_AlarmDefinitions AD
on
AD.AlarmDefinitionID=A.AlarmsDefinitionID
inner join
[dbo].[T_AlamDefinitionEventDefinitions] ADED
on
AD.[AlarmDefinitionID]=ADED.[AlarmsDefinitionID]
inner join 
dbo.T_EventDefinitions ED
on
ED.EventDefinitionID=ADED.EventDefinitionID
inner join 
dbo.T_TouchPoints TP
on
TP.TouchPointID=ED.TouchPointIDSource
--left join 
--dbo.T_TouchPointGeographyDetails TPGD
--on
--TPGD.TouchPointID=TP.ParentTouchPointID
inner join 
dbo.T_TouchPointLocation TPL
on
TPL.TouchPointID=TP.TouchPointID
inner join 
dbo.T_Location L
on
L.LocationID=TPL.LocationID
Left join 
dbo.T_Location LP
on
LP.LocationID=L.ParentLocationID
where 
A.StateID=1 and A.StatusID=1 and A.AlarmStatusID=1 and
AD.StateID=1 and AD.StatusID=1 and
ED.StateID=1 and ED.StatusID=1 and
TP.StateID=1 and
TPL.StateID=1 
order by Occurance_Date DESC';

execute(@SQL);


end