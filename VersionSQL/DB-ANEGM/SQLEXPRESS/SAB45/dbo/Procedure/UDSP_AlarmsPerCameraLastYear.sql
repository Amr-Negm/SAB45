/****** Object:  Procedure [dbo].[UDSP_AlarmsPerCameraLastYear]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[UDSP_AlarmsPerCameraLastYear]
AS
BEGIN
/*[UDSP_AlarmsPerCamera]*/
declare 
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_AlarmsPerCamera int=45,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
45	UDSP_AlarmsPerCamera
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

Delete from [dbo].HBB_UDTB_AlarmsPerCamera where [StoredProcedureID]=@UDSP_AlarmsPerCamera and PeriodId=8;

CREATE TABLE #TMPAlarmsPerCamera (SourceName nvarchar(150),No_OF_Alarm nvarchar(150));

INSERT INTO #TMPAlarmsPerCamera
exec [dbo].[UDSP_AlarmsPerCamera] @LastYear,@EndDate

insert into [dbo].HBB_UDTB_AlarmsPerCamera(SourceName ,No_OF_Alarm ,StoredProcedureID,[ActionDate],PeriodId)
SELECT SourceName ,No_OF_Alarm ,@UDSP_AlarmsPerCamera,@EndDate,8 FROM #TMPAlarmsPerCamera;

DROP TABLE #TMPAlarmsPerCamera;
end