/****** Object:  Procedure [dbo].[UDSP_CardAverageAlarmsPerMonthLast12Hour]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[UDSP_CardAverageAlarmsPerMonthLast12Hour]
AS
BEGIN

/*[UDSP_CardAverageAlarmsPerMonth]*/
declare 
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_CardAverageAlarmsPerMonth int=37,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
37	UDSP_CardAverageAlarmsPerMonth
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

EXEC	[UDSP_CardAverageAlarmsPerMonth]  @Last12Hour,@EndDate,@SPValue1 output;

select @ActionDate=sysdatetime()
delete from [dbo].HBB_Analytics_Cards where [StoredProcedureID]=@UDSP_CardAverageAlarmsPerMonth and PeriodId=3;
insert into [dbo].HBB_Analytics_Cards([StoredProcedureID],[StoredProcedureValue],[ActionDate],PeriodId)
values 
(@UDSP_CardAverageAlarmsPerMonth,@SPValue1,@ActionDate,3);
end