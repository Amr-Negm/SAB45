/****** Object:  Procedure [dbo].[UDSP_GetScenarioBerHourLast2Day]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[UDSP_GetScenarioBerHourLast2Day]
AS
BEGIN
/*[UDSP_GetScenarioBerHour]*/
declare 
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_GetScenarioBerHour int=44,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
44	UDSP_GetScenarioBerHour
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
delete from [dbo].HBB_UDTB_GetScenarioBerHour where [StoredProcedureID]=@UDSP_GetScenarioBerHour and PeriodId=5;
CREATE TABLE #TMPGetScenarioBerHour (ScenarioTitle1 nvarchar(150),date nvarchar(150),total nvarchar(150));
INSERT INTO #TMPGetScenarioBerHour
exec [dbo].[UDSP_GetScenarioBerHour]  @Last2Day,@EndDate,NULL;
insert into [dbo].HBB_UDTB_GetScenarioBerHour(ScenarioTitle1 ,date ,total ,StoredProcedureID,ActionDate,Periodid)
SELECT ScenarioTitle1 ,date ,total ,@UDSP_GetScenarioBerHour,@EndDate,5 FROM #TMPGetScenarioBerHour;
DROP TABLE #TMPGetScenarioBerHour;
end