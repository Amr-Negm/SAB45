/****** Object:  Procedure [dbo].[USDP_DeleteBeforeNDays]    Committed by VersionSQL https://www.versionsql.com ******/

Create procedure [dbo].[USDP_DeleteBeforeNDays] @nDays int
as

--select min(Occurance_Date),max(Occurance_Date) from t_alarms
--Declare @nDays int = 15
declare @DeleteBefore date = (select dateadd(day,-@nDays,cast(getdate() as date)))
--select @DeleteBefore

select AlarmID into #tempAlarms from t_alarms where Occurance_Date < @DeleteBefore
select EventID into #tempEvents from T_Events where Occurance_Date < @DeleteBefore

--delete 
delete from T_AlarmComment where AlarmID in (select * from #tempAlarms)
delete from T_AlarmTrack where AlarmID in (select * from #tempAlarms)
delete from T_EventAlarms where AlarmID in (select * from #tempAlarms)
delete from T_AlarmActionResponses where AlarmID in (select * from #tempAlarms)
delete from T_AlarmScenarios where AlarmID in (select * from #tempAlarms)

delete from T_Alarms where alarmid in (select * from #tempAlarms)
-------------
delete from T_EventAlarms where EventID in (select * from #tempEvents)
delete from T_EventParms where EventID in (select * from #tempEvents)

delete from T_Events where EventID in (select * from #tempEvents)

drop table #tempAlarms 
drop table #tempEvents