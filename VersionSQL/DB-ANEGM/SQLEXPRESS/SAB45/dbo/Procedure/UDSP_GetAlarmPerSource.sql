/****** Object:  Procedure [dbo].[UDSP_GetAlarmPerSource]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAlarmPerSource]
AS
BEGIN
SET NOCOUNT ON;

		select TouchPointTitle1,touchpointID,PriorityID,PriorityTitle1,count(AlarmID) as "value"
			from [dbo].[UDV_AllAlarmsNew]
				where convert(varchar(30),Occurance_Date,105)=convert(varchar(30),getdate(),105)--'28-01-2017'
					group by TouchPointTitle1,touchpointID,PriorityID,PriorityTitle1
						order by 5 desc
END