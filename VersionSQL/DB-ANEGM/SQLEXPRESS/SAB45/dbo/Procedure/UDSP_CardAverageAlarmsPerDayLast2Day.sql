/****** Object:  Procedure [dbo].[UDSP_CardAverageAlarmsPerDayLast2Day]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[UDSP_CardAverageAlarmsPerDayLast2Day]
AS
BEGIN

/*[UDSP_CardAverageAlarmsPerDay]*/
declare  
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_CardAverageAlarmsPerDay int=3,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
3	UDSP_CardAverageAlarmsPerDay
*/
EXEC	[UDSP_CardAverageAlarmsPerDay]  null,null,null,null,null,@Last2Day,@EndDate,@SPValue1 output
delete from [dbo].HBB_Analytics_Cards where [StoredProcedureID]=@UDSP_CardAverageAlarmsPerDay and PeriodId=5;
insert into [dbo].HBB_Analytics_Cards([StoredProcedureID],[StoredProcedureValue],[ActionDate],PeriodId)
values 
(@UDSP_CardAverageAlarmsPerDay,@SPValue1,@ActionDate,5);
end