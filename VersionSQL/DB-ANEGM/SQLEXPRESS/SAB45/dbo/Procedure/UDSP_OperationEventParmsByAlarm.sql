/****** Object:  Procedure [dbo].[UDSP_OperationEventParmsByAlarm]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure UDSP_OperationEventParmsByAlarm @AlarmID int
as
Begin

Select distinct
A.AlarmID
,TP.TouchPointTitle1 as "TouchPointName"
,TP.TouchPointTypeID
,ED.EventDefinitionTitle1 as "EventDefinitionName"
,EP.EventParmID
,EP.EventParmKey
,EP.ParmKeyTypeID
,EP.StringValue
,EP.BinaryValue
,TP.TouchPointID
--,cast(TPGEO.GeographyPoint as nvarchar(max)) as "GeographyPoint"
,AD.AlarmDefinitionDescriptionTitle1
from
dbo.T_Alarms A
inner join
dbo.T_EventAlarms EA
on 
EA.AlarmID=A.AlarmID
inner join
dbo.T_Events E
on
E.EventID=EA.EventID
inner join
dbo.T_EventParms EP
on
EP.EventID=E.EventID
inner join
dbo.T_EventDefinitions ED
on
ED.EventDefinitionID=E.EventDefinitionID
inner join 
T_TouchPoints TP
on
TP.TouchPointID=ED.TouchPointIDSource
inner join
dbo.T_AlarmDefinitions AD
on
AD.AlarmDefinitionID=A.AlarmsDefinitionID
 
where
A.AlarmID=@AlarmID;
end