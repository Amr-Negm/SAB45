/****** Object:  Procedure [dbo].[UDSP_GetAlarmPriorityPerZone]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAlarmPriorityPerZone]
AS
BEGIN
SET NOCOUNT ON;
		select top(10) ZoneTitle1,ZoneID,PriorityID,PriorityTitle1,count(AlarmID) as "value"
			from [dbo].[UDV_AllAlarmsNew]
				where convert(varchar(30),Occurance_Date,105)=convert(varchar(30),GETDATE(),105)--'28-01-2017'
					group by  ZoneTitle1,ZoneID,PriorityID,PriorityTitle1
						order by 5 desc

END