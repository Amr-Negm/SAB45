/****** Object:  Procedure [dbo].[UDSP_GetRatioAlarmScenarionLastDay]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[UDSP_GetRatioAlarmScenarionLastDay]
AS
BEGIN
/*[UDSP_GetRatioAlarmScenarion]*/
declare 
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_GetRatioAlarmScenarion int=40,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
40	UDSP_GetRatioAlarmScenarion
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


delete from [dbo].[HBB_UDTB_GetRatioAlarmScenarion] where [StoredProcedureID]=@UDSP_GetRatioAlarmScenarion and PeriodId=4;
CREATE TABLE #TMPGetRatioAlarmScenarion (Scenario nvarchar(150),Ratio nvarchar(150));
INSERT INTO #TMPGetRatioAlarmScenarion
exec [dbo].UDSP_GetRatioAlarmScenarion @LastDay,@EndDate;

insert into [dbo].[HBB_UDTB_GetRatioAlarmScenarion](Scenario ,Ratio ,StoredProcedureID,[ActionDate],PeriodId)
SELECT Scenario ,Ratio ,@UDSP_GetRatioAlarmScenarion,@EndDate,4 FROM #TMPGetRatioAlarmScenarion;
DROP TABLE #TMPGetRatioAlarmScenarion;
end