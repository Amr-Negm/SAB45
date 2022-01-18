/****** Object:  Procedure [dbo].[UDSP_TotalAlarmsPriority]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_TotalAlarmsPriority]
AS
BEGIN
SET NOCOUNT ON;

declare @sum decimal(38)
	
select @sum=COUNT(AlarmID) 
	from [dbo].[UDV_AllAlarmsNew] 
		where convert(varchar(30),Occurance_Date,105)=convert(varchar(30),GETDATE(),105)

select cast((count(AlarmID)/@sum)*100 as int) as total,PriorityTitle1,PriorityID,
	replace(CONVERT(varchar, CAST(count(AlarmID) AS money), 1),'.00','')
		 + cast(' Of ' as varchar(6))+replace(CONVERT(varchar, CAST(@sum AS money), 1),'.00','')  as LB_val
			from [dbo].[UDV_AllAlarmsNew] 
				where convert(varchar(30),Occurance_Date,105)=convert(varchar(30),GETDATE(),105)--'28-01-2017'
					group by PriorityTitle1,PriorityID

END