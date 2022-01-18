/****** Object:  Procedure [dbo].[UDSP_Top10ChartGetTop10AlarmPerSource]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_Top10ChartGetTop10AlarmPerSource](
													@City nvarchar(100)=null		,
													@Station nvarchar(100)=null   ,
													@Level nvarchar(100)=null     ,
													@Zone nvarchar(100)=null      ,
													@Camera nvarchar(100)=null    ,
													@StartDate datetime='01/01/1900'    ,
													@EndDate datetime='12/30/2050'
													)
AS
BEGIN
SET NOCOUNT ON;	
SET FMTONLY OFF;
declare @Counting int
select @Counting=count(*) from [dbo].[UDV_AllAlarms] 
	where Occurance_Date between @StartDate and @EndDate

if 	@Counting !=0 and @StartDate is not null and @EndDate is not null
begin		
			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			
			set @sqlstr='declare @AverageBerHour int declare @TotalAlarm decimal '
-------------------------------------------------Alarms Total Number--------------------------------------------------------
		set @wherecode=''
				if(@City!='' or @City!=null)
				begin
					set @wherecode+='CityTitle1='''+@City+''' AND '
				end 

				if(@Station!='' or @Station!=null)
				begin
					set @wherecode+='  [StationTitle1]='''+@Station+''' AND '
				end 

				if(@Level!='' or @Level!=null)
				begin
					set @wherecode+='  [LevelTitle1]='''+@Level+''' AND'
				end 

				if(@Zone!='' or @Zone!=null)
				begin
					set @wherecode+='  [ZoneTitle1]='''+@Zone+''' AND'
				end 

				if(@Camera!='' or @Camera!=null)
				begin
					set @wherecode+='  [TouchPointTitle1]='''+@Camera+''' AND'
				end 
				
				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(10), @StartDate, 110)+''' AND'
				end 


				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(10),DATEADD (day , 1 , @EndDate )   , 110)+''' AND'
				end

				if(@wherecode!='')
					set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )


-------------------------------------------------Alarms Total Number--------------------------------------------------------
		if(@wherecode='')
				set @sqlstr+='	select @TotalAlarm=count(*)  from [dbo].[UDV_AllAlarms] '
		else
				set @sqlstr+='	select @TotalAlarm=count(*)  from [dbo].[UDV_AllAlarms] where '+@wherecode
-----------------------------------------------------------------------------------------------------------------------------	


if(@wherecode='')
		set @sqlstr+=' select @AverageBerHour=cast(round(@TotalAlarm/( '+
					'select count(a.cx) from ( '+
											   'select count(*) as ''cx'',DATEPART(HOUR,Occurance_Date) as ''hour'',23 as StoredProcedureID from [dbo].[UDV_AllAlarms] '+
											    'group by DATEPART(HOUR,Occurance_Date)) a),0) as int)'
else
		set @sqlstr+=' select @AverageBerHour=cast(round(@TotalAlarm/( '+
					'select count(a.cx) from ( '+
											   'select count(*) as ''cx'',DATEPART(HOUR,Occurance_Date) as ''hour'',23 as StoredProcedureID from [dbo].[UDV_AllAlarms] Where '+@wherecode+
											    ' group by DATEPART(HOUR,Occurance_Date)) a),0) as int)'
-----------------------------------------------------------------------------------------------------------------------------

if(@wherecode='')
set @sqlstr+=' select top(10) TouchPointTitle1 as ''SourceName'',count(*) as ''No_OF_Alarm'',@AverageBerHour as ''AverageBerHour'',[LevelTitle1] as ''Level'',touchpointID,23 as StoredProcedureID '+
				' from [dbo].[UDV_AllAlarms]   group by  TouchPointTitle1,touchpointID,[LevelTitle1] order by 2 desc'
	
else
set @sqlstr+=' select top(10) TouchPointTitle1 as ''SourceName'',count(*) as ''No_OF_Alarm'',@AverageBerHour as ''AverageBerHour'',[LevelTitle1] as ''Level'',touchpointID,23 as StoredProcedureID '+
				' from [dbo].[UDV_AllAlarms] Where '+@wherecode+'  group by  TouchPointTitle1,touchpointID,[LevelTitle1] order by 2 desc'

-- Create Temp Table
create table #Temp_Top10ResultsSource
(
RowID int identity(1,1),
SourceName nvarchar(200),
No_OF_Alarm nvarchar(200),
AvgerageBerHour nvarchar(200),
Level nvarchar(200),
touchpointID int,
StoredProcedureID int
)

insert into #Temp_Top10ResultsSource
execute(@sqlstr)
--select*from #Temp_Top10ResultsSource

-- Update Avg Per Hour

declare 
@AvgPerHour int, 
@i$RowID int,
@i$NumberOfAlarm int,
@i$TouchPointID int

declare Cur_AveragePerHour_i cursor local forward_only
	for select RowID,No_OF_Alarm,touchpointID from #Temp_Top10ResultsSource

open Cur_AveragePerHour_i
fetch Cur_AveragePerHour_i into @i$RowID,@i$NumberOfAlarm,@i$TouchPointID
while @@FETCH_STATUS=0 
begin

select @AvgPerHour=@i$NumberOfAlarm/( 
	select isnull(NULLIF(count(a.cx), '0'),1) from ( 
			select count(*) as 'cx',DATEPART(HOUR,Occurance_Date) as 'hour' 
				from [dbo].[UDV_AllAlarms] 
					group by [TouchPointID],DATEPART(HOUR,Occurance_Date) having [TouchPointID]=@i$TouchPointID)a)

update #Temp_Top10ResultsSource
	set AvgerageBerHour=@AvgPerHour
		where RowID=@i$RowID

fetch Cur_AveragePerHour_i into @i$RowID,@i$NumberOfAlarm,@i$TouchPointID
end
close Cur_AveragePerHour_i
deallocate Cur_AveragePerHour_i

select SourceName,No_OF_Alarm,AvgerageBerHour,Level,touchpointID,StoredProcedureID
from #Temp_Top10ResultsSource
end
END