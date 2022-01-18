/****** Object:  Procedure [dbo].[UDSP_CardAverageAlarmsPerMonthCalled]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[UDSP_CardAverageAlarmsPerMonthCalled]
AS
BEGIN

/*[UDSP_CardAverageAlarmsPerHourCalled]*/
declare 
@SPValue1 varchar(100),
@SPValue2 varchar(100),
@SPValue3 varchar(100),
@SPValue4 varchar(100),
@SPValue5 varchar(100),
@SPValue6 varchar(100),
@SPValue7 varchar(100),
@SPValue8 varchar(100),
@ActionDate datetime2(7),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_CardTotalAlarms int=1,
@UDSP_CardAverageAlarmsPerDay int=3,
@UDSP_CardHandledAlarms int=32,
@UDSP_CardUnHandledAlarms int=33,
@UDSP_CardAlarmsLastHour int=34,
@UDSP_CardAverageAlarmsPerHour int=4,
@UDSP_CardAverageAlarmsPerWeek int=36,
@UDSP_CardAverageAlarmsPerMonth int=37,
@UDSP_CardAverageResponseTime int=38;
--1. LastHour
Declare @LastHour datetime= DATEADD(HOUR, -1, sysdatetime()) ;
----2. Last4Hour
--Declare @Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime());
----3. Last12Hour
--Declare @Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()) ;
----4. LastDay
--Declare @LastDay datetime=DATEADD(day, -1, sysdatetime());
----5. Last2Day
--Declare @Last2Day datetime=DATEADD(day, -2, sysdatetime());
----6. LastWeek
--Declare @LastWeek datetime=DATEADD(WEEK, -1, sysdatetime());
----7. LastMonth
--Declare @LastMonth datetime=DATEADD(MONTH, -1, sysdatetime());
----8. LastYear
--Declare @LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
1	UDSP_CardTotalAlarms
3	UDSP_CardAverageAlarmsPerDay
--New 1202018
32	UDSP_CardHandledAlarms
33	UDSP_CardUnHandledAlarms
34	UDSP_CardAlarmsLastHour
35	UDSP_CardAverageAlarmsPerHour
36	UDSP_CardAverageAlarmsPerWeek
37	UDSP_CardAverageAlarmsPerMonth
38	UDSP_CardAverageResponseTime
*/
EXEC	[UDSP_CardAverageAlarmsPerMonth]  null,null,@SPValue1 output


--exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,@LastHour,@EndDate,@SPValue1 output 
--exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,@Last4Hour,@EndDate,@SPValue2 output 
--exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,@Last12Hour,@EndDate,@SPValue3 output 
--exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,@LastDay,@EndDate,@SPValue4 output 
--exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,@Last2Day,@EndDate,@SPValue5 output 
--exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,@LastWeek,@EndDate,@SPValue6 output 
--exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,@LastMonth,@EndDate,@SPValue7 output 
--exec [dbo].[UDSP_CardTotalAlarms] null,null,null,null,null,@LastYear,@EndDate,@SPValue8 output 

select @ActionDate=sysdatetime()
delete from [dbo].HBB_Analytics_Cards where [StoredProcedureID]=@UDSP_CardAverageAlarmsPerMonth and PeriodId=0;
insert into [dbo].HBB_Analytics_Cards([StoredProcedureID],[StoredProcedureValue],[ActionDate],PeriodId)
values 
(@UDSP_CardAverageAlarmsPerMonth,@SPValue1,@ActionDate,0)
--,
--(@UDSP_CardTotalAlarms,@SPValue2,@ActionDate,2),
--(@UDSP_CardTotalAlarms,@SPValue3,@ActionDate,3),
--(@UDSP_CardTotalAlarms,@SPValue4,@ActionDate,4),
--(@UDSP_CardTotalAlarms,@SPValue5,@ActionDate,5),
--(@UDSP_CardTotalAlarms,@SPValue6,@ActionDate,6),
--(@UDSP_CardTotalAlarms,@SPValue7,@ActionDate,7),
--(@UDSP_CardTotalAlarms,@SPValue8,@ActionDate,8);


end