/****** Object:  Procedure [dbo].[UDSP_Top10ChartGetTop10AlarmPerZoneLastDay]    Committed by VersionSQL https://www.versionsql.com ******/

create PROCEDURE [dbo].[UDSP_Top10ChartGetTop10AlarmPerZoneLastDay]

AS
BEGIN
/*[UDSP_Top10ChartGetTop10AlarmPerZone]*/
declare 
@SPValue1 varchar(100),
@ActionDate datetime2(7)=sysdatetime(),
@EndDate  datetime2(7)=sysdatetime(),
@UDSP_Top10ChartGetTop10AlarmPerZone int=21,
@LastHour datetime= DATEADD(HOUR, -1, sysdatetime()),
@Last4Hour datetime=DATEADD(HOUR, -4, sysdatetime()),
@Last12Hour datetime=DATEADD(HOUR, -12, sysdatetime()),
@LastDay datetime=DATEADD(day, -1, sysdatetime()),
@Last2Day datetime=DATEADD(day, -2, sysdatetime()),
@LastWeek datetime=DATEADD(WEEK, -1, sysdatetime()),
@LastMonth datetime=DATEADD(MONTH, -1, sysdatetime()),
@LastYear datetime=DATEADD(YEAR, -1, sysdatetime());
/*
21	UDSP_Top10ChartGetTop10AlarmPerZone
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

Delete from [dbo].HBB_UDTB_Top10ChartGetTop10AlarmPerZone where [StoredProcedureID]=@UDSP_Top10ChartGetTop10AlarmPerZone and PeriodId=4;

CREATE TABLE #TMPTop10ChartGetTop10AlarmPerZone (ZoneName nvarchar(150),No_OF_Alarm nvarchar(150),AvgerageBerHour nvarchar(150),[Level] nvarchar(150),ZoneID int,StoredProcedureID int);

INSERT INTO #TMPTop10ChartGetTop10AlarmPerZone 
exec [dbo].[UDSP_Top10ChartGetTop10AlarmPerZone_Dashboard] NULL,NULL,NULL,NULL,NULL,@LastDay,@EndDate

insert into [dbo].HBB_UDTB_Top10ChartGetTop10AlarmPerZone(ZoneName ,No_OF_Alarm,AvgerageBerHour,[Level] ,ZoneID,StoredProcedureID,[ActionDate],PeriodId)
SELECT ZoneName ,No_OF_Alarm,AvgerageBerHour,Level ,ZoneID,StoredProcedureID,@EndDate,4 FROM #TMPTop10ChartGetTop10AlarmPerZone;

DROP TABLE #TMPTop10ChartGetTop10AlarmPerZone;
end