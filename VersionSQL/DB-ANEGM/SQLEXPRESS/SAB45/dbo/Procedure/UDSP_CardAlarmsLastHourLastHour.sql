/****** Object:  Procedure [dbo].[UDSP_CardAlarmsLastHourLastHour]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[UDSP_CardAlarmsLastHourLastHour]
AS
BEGIN
/*[UDSP_CardAlarmsLastHour]*/
declare 
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_CardAlarmsLastHour int=34,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
34	UDSP_CardAlarmsLastHour
*/
/*
Periodid	PeriodTitle
1			Lasthour
2			Last4hour
3			Last12hour
4			LastDay
5			Last2Day
6			LastWeek
7			LastMonth
8			LastYear
*/

exec [dbo].[UDSP_CardAlarmsLastHour] @LastHour,@EndDate,@SPValue1 output 
delete from [dbo].HBB_Analytics_Cards where [StoredProcedureID]=@UDSP_CardAlarmsLastHour and PeriodId=1;
insert into [dbo].HBB_Analytics_Cards([StoredProcedureID],[StoredProcedureValue],[ActionDate],PeriodId)
values 
(@UDSP_CardAlarmsLastHour,@SPValue1,@ActionDate,1);
end