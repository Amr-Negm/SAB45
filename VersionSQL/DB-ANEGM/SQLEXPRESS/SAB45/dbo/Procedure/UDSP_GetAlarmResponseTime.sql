/****** Object:  Procedure [dbo].[UDSP_GetAlarmResponseTime]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAlarmResponseTime]
AS
BEGIN
SET NOCOUNT ON;	
	
	select count([AlarmID]) as "Value",
		   CONVERT(varchar(3),Response_Date,108)+'00'  as "Hour"
				from [dbo].[UDV_AllAlarmsNew] 
					where convert(varchar(30), Response_Date,105)=convert(varchar(30), getdate(),105)--'28-01-2017' 
					  and convert(varchar(30), Occurance_Date,105)=convert(varchar(30), getdate(),105) -- 02/11/2018
							group by CONVERT(varchar(3),Response_Date,108)+'00'
								order by 2 

END