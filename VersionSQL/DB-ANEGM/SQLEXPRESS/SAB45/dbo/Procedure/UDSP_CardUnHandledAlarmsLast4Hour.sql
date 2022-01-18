/****** Object:  Procedure [dbo].[UDSP_CardUnHandledAlarmsLast4Hour]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[UDSP_CardUnHandledAlarmsLast4Hour]
AS
BEGIN

/*[[UDSP_CardUnHandledAlarmsLastHour]]*/
declare 
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_CardUnHandledAlarms int=33,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
33	UDSP_CardUnHandledAlarms
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
EXEC	[dbo].[UDSP_CardUnHandledAlarms] @Last4Hour,@EndDate,@SPValue1 output;
select @ActionDate=sysdatetime()
delete from [dbo].HBB_Analytics_Cards where [StoredProcedureID]=@UDSP_CardUnHandledAlarms and PeriodId=2;
insert into [dbo].HBB_Analytics_Cards([StoredProcedureID],[StoredProcedureValue],[ActionDate],PeriodId)
values 
(@UDSP_CardUnHandledAlarms,@SPValue1,@ActionDate,2);
end