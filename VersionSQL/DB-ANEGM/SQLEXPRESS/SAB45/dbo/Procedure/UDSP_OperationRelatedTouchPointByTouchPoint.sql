/****** Object:  Procedure [dbo].[UDSP_OperationRelatedTouchPointByTouchPoint]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE procedure [dbo].[UDSP_OperationRelatedTouchPointByTouchPoint] @TouchPointList TouchPointList READONLY,@ALARMID INT
as
Begin
Select distinct
RTP.MasterTouchPoint
,RTP.RelatedTouchPoint
,E.Occurance_Date
,TP.TouchPointTitle1 as "TouchPointName"
,TP.TouchPointTypeID
,ED.EventDefinitionTitle1 as "EventDefinitionName"
,EP.EventParmID
,EP.EventParmKey
,EP.ParmKeyTypeID
,EP.StringValue
,EP.BinaryValue
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
inner join
dbo.T_RelatedTouchPoint RTP
on
TP.TouchPointID=RTP.RelatedTouchPoint
inner join
@TouchPointList TPList
on
RTP.MasterTouchPoint=TPList.TouchPointID
WHERE 
 
A.StateID=1 and A.StatusID=1 and A.AlarmStatusID=1 and
AD.StateID=1 and AD.StatusID=1 and
ED.StateID=1 and ED.StatusID=1 and
TP.StateID=1 AND E.Occurance_Date <=DATEADD(SECOND, RTP.TimeInSecond, A.Occurance_Date) AND  A.AlarmID=@ALARMID ;

END