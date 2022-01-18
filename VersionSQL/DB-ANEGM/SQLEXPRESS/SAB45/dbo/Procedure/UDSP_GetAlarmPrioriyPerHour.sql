/****** Object:  Procedure [dbo].[UDSP_GetAlarmPrioriyPerHour]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAlarmPrioriyPerHour]
AS
BEGIN
SET NOCOUNT ON;	

	select count([AlarmID]) as "Value",
		   CONVERT(varchar(3),Occurance_Date,108)+'00'  as "Hour" 
				from [dbo].[UDV_AllAlarmsNew] 
					where convert(varchar(30), Occurance_Date,105)=convert(varchar(30), GETDATE(),105)--'31-01-2017' 
						group by CONVERT(varchar(3),Occurance_Date,108)+'00'
							order by 2 

END