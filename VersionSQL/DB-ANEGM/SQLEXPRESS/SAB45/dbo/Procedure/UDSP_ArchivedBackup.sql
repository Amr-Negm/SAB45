/****** Object:  Procedure [dbo].[UDSP_ArchivedBackup]    Committed by VersionSQL https://www.versionsql.com ******/

Create procedure [dbo].[UDSP_ArchivedBackup] @FilePath nvarchar(200),@DatabaseName sysname
as
begin
Declare @count int,@CurrentYear int;
select @CurrentYear=Year(getdate());
select @count=count(*)from [dbo].[ArchivedBkups] where ArchivedYear=@CurrentYear;

if @count =0
begin
declare @FileName nvarchar(300)
SELECT @FileName=@FilePath +N'\'+ @DatabaseName+N'_V1.0_' + REPLACE(convert(nvarchar(20),GetDate(),120),':','-') + 'Archived.bak'
BACKUP DATABASE @DatabaseName TO DISK=@FileName WITH CHECKSUM
RESTORE VERIFYONLY FROM  DISK = @FileName

--Start Clear
DELETE FROM [dbo].[T_AlarmActionResponses]

DELETE FROM [dbo].[T_AllAlarms]

DELETE FROM [dbo].[T_AllScenarios]

DELETE FROM [dbo].[T_EventAlarms]

DELETE FROM [dbo].[T_EventParms]

DELETE FROM [dbo].[T_MapAlarms]

DELETE FROM [dbo].[T_MapAlarmsLog]

DELETE FROM [dbo].[T_PriorityChart]

DELETE FROM [dbo].[T_PriorityChartLog]

DELETE FROM [dbo].[T_Results]

DELETE FROM [dbo].[T_ResultsLog]

DELETE FROM [dbo].[T_ScenariosPerLocation]

DELETE FROM [dbo].[T_ScenariosPerLocationLog]

DELETE FROM [dbo].[T_ScenariosPerPerformance]

DELETE FROM [dbo].[T_ScenariosPerPerformanceLog]

DELETE FROM [dbo].[T_Top10Results]

DELETE FROM [dbo].[T_Top10ResultsLog]

DELETE FROM [dbo].[T_Top10ResultsSourceAndZone]

DELETE FROM [dbo].[T_Top10ResultsSourceAndZoneLog]

DELETE FROM [dbo].[T_TotalNumberOfAlarm]

DELETE FROM [dbo].[T_TotalNumberOfAlarmLog]


DELETE FROM [dbo].[T_WeeksPriorities]

DELETE FROM [dbo].[T_WeeksPrioritiesLog]

DELETE FROM [dbo].[T_AlarmScenarios]

DELETE FROM [dbo].[T_Events]

DELETE FROM [dbo].[T_Alarms]
--Reset  Identity


DBCC CHECKIDENT ('T_AlarmActionResponses', RESEED, 0)

DBCC CHECKIDENT ('T_EventParms', RESEED, 0)

DBCC CHECKIDENT ('T_MapAlarms', RESEED, 0)
DBCC CHECKIDENT ('T_Alarms', RESEED, 0)

DBCC CHECKIDENT ('T_Actions', RESEED, 0)

DBCC CHECKIDENT ('T_Events', RESEED, 0)

--End Clear

insert into [dbo].[ArchivedBkups]
values
(@CurrentYear);
end
end;