/****** Object:  Procedure [dbo].[UDSP_GetScenarioResponseTimeLastYear]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[UDSP_GetScenarioResponseTimeLastYear]
AS
BEGIN
/*[UDSP_GetScenarioResponseTime]*/
declare 
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_GetScenarioResponseTime int=43,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
43	UDSP_GetScenarioResponseTime
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


delete from [dbo].HBB_UDTB_GetScenarioResponseTime where [StoredProcedureID]=@UDSP_GetScenarioResponseTime and PeriodId=8;
CREATE TABLE #TMPGetScenarioResponseTime (AlarmDefinitionTitle1 nvarchar(150),minval nvarchar(150),maxval nvarchar(150),avgval nvarchar(150));
INSERT INTO #TMPGetScenarioResponseTime
exec [dbo].[UDSP_GetScenarioResponseTime]  @LastYear,@EndDate,0;

insert into [dbo].HBB_UDTB_GetScenarioResponseTime(AlarmDefinitionTitle1 ,minval ,maxval ,avgval ,StoredProcedureID,ActionDate,Periodid)
SELECT AlarmDefinitionTitle1 ,minval ,maxval ,avgval,@UDSP_GetScenarioResponseTime,@EndDate,8 FROM #TMPGetScenarioResponseTime;
DROP TABLE #TMPGetScenarioResponseTime;
end