/****** Object:  Procedure [dbo].[UDSP_AlarmAveragePerWeekLastHour]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_AlarmAveragePerWeekLastHour]
AS
BEGIN
/*[UDSP_AlarmAveragePerWeek]*/
declare 
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_AlarmAveragePerWeek int=42,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
42	UDSP_AlarmAveragePerWeek
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


delete from [dbo].HBB_UDTB_AlarmAveragePerWeek where [StoredProcedureID]=@UDSP_AlarmAveragePerWeek and PeriodId=1;
CREATE TABLE #TMPAlarmAveragePerWeek (AvgBerDay int,Dayname nvarchar(150),ScenarioTitle nvarchar(150));
INSERT INTO #TMPAlarmAveragePerWeek
exec [dbo].UDSP_AlarmAveragePerWeek @LastHour,@EndDate,1;

insert into [dbo].HBB_UDTB_AlarmAveragePerWeek(AvgBerDay,Dayname,ScenarioTitle,StoredProcedureID,ActionDate,Periodid)
SELECT AvgBerDay,Dayname,ScenarioTitle,@UDSP_AlarmAveragePerWeek,@EndDate,1 FROM #TMPAlarmAveragePerWeek;
DROP TABLE #TMPAlarmAveragePerWeek;
end