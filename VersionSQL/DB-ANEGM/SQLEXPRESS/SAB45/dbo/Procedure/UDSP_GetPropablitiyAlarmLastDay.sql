/****** Object:  Procedure [dbo].[UDSP_GetPropablitiyAlarmLastDay]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetPropablitiyAlarmLastDay]
AS
BEGIN
/*[UDSP_GetPropablitiyAlarm]*/
declare 
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_GetPropablitiyAlarm int=39,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
39	UDSP_GetPropablitiyAlarm
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

delete from [dbo].[HBB_UDTB_GetPropablitiyAlarm] where [StoredProcedureID]=@UDSP_GetPropablitiyAlarm and PeriodId=4;
CREATE TABLE #TMP 
([ScenarioTitle1] [nvarchar](150) NULL,
	[ScenarioImpact] [nvarchar](50) NULL,
	[ScenarioID] [int] NULL,
	[AlarmScenarioID] [int] NULL);
INSERT INTO #TMP
exec [dbo].UDSP_GetPropablitiyAlarm NULL,NULL,NULL,NULL,NULL,@LastDay,@EndDate;
insert into [dbo].[HBB_UDTB_GetPropablitiyAlarm](ScenarioTitle1,ScenarioImpact,ScenarioID,AlarmScenarioID,[StoredProcedureID],[ActionDate],PeriodId)
SELECT [ScenarioTitle1],[ScenarioImpact],[ScenarioID],[AlarmScenarioID],@UDSP_GetPropablitiyAlarm,@EndDate,4 FROM #TMP;
DROP TABLE #TMP;
end