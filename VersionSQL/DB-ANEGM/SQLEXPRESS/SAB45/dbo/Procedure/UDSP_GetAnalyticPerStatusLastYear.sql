/****** Object:  Procedure [dbo].[UDSP_GetAnalyticPerStatusLastYear]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[UDSP_GetAnalyticPerStatusLastYear]
AS
BEGIN
/*[UDSP_GetAnalyticPerStatus]*/
declare 
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_GetAnalyticPerStatus int=41,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
41	UDSP_GetAnalyticPerStatus
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


delete from [dbo].HBB_UDTB_GetAnalyticPerStatus where [StoredProcedureID]=@UDSP_GetAnalyticPerStatus and PeriodId=8;
CREATE TABLE #TMPGetAnalyticPerStatus (AlarmStatusTitle1 nvarchar(150),value nvarchar(150));
INSERT INTO #TMPGetAnalyticPerStatus
exec [dbo].UDSP_GetAnalyticPerStatus NULL,NULL,NULL,NULL,NULL,@LastYear,@EndDate;

insert into [dbo].[HBB_UDTB_GetAnalyticPerStatus](AlarmStatusTitle1 ,value ,StoredProcedureID,[ActionDate],PeriodId)
SELECT AlarmStatusTitle1 ,value ,@UDSP_GetAnalyticPerStatus,@EndDate,8 FROM #TMPGetAnalyticPerStatus;
DROP TABLE #TMPGetAnalyticPerStatus;
end