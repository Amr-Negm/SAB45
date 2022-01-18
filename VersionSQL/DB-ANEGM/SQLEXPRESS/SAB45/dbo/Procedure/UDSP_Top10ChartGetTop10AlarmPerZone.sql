/****** Object:  Procedure [dbo].[UDSP_Top10ChartGetTop10AlarmPerZone]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_Top10ChartGetTop10AlarmPerZone](
													@City nvarchar(100)=null		,
													@Station nvarchar(100)=null   ,
													@Level nvarchar(100)=null     ,
													@Zone nvarchar(100)=null      ,
													@Camera nvarchar(100)=null    ,
													@StartDate datetime=null    ,
													@EndDate datetime=null)
AS
BEGIN
SET NOCOUNT ON;	

SET FMTONLY OFF; 

			
			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			
			set @sqlstr='declare @AverageBerHour int declare @TotalAlarm decimal set @TotalAlarm=0 '
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
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(25), @StartDate, 121)+''' AND'
				end 


				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(25) , @EndDate    , 121)+''' AND'
				end

				if(@wherecode!='')
					set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )

			
-------------------------------------------------Alarms Total Number----------------------------------------
if(@wherecode='')
set @sqlstr+=' select @TotalAlarm=count(AlarmID)  from [dbo].[UDV_AllAlarmsNew] '
else
set @sqlstr+=' select @TotalAlarm=count(AlarmID)  from [dbo].[UDV_AllAlarmsNew] Where '+@wherecode
----------------------------------------------------------------------------------------------
		
		if(@wherecode='')
		begin
			set @sqlstr+=' select @AverageBerHour=cast(round(@TotalAlarm/(  '+
					   'select   isnull(NULLIF(count(a.cx), ''0''),1)   from ( '+
											   'select count(*) as ''cx'',DATEPART(HOUR,Occurance_Date) as ''hour'',21 as StoredProcedureID '+
											   'from [dbo].[UDV_AllAlarmsNew] 	'+
											    'group by DATEPART(HOUR,Occurance_Date)) a),0) as int)'
		end
		else
		begin
		set @sqlstr+=' select @AverageBerHour=cast(round(@TotalAlarm/(  '+
					   'select   isnull(NULLIF(count(a.cx), ''0''),1)   from ( '+
											   'select count(*) as ''cx'',DATEPART(HOUR,Occurance_Date) as ''hour'',21 as StoredProcedureID '+
											   'from [dbo].[UDV_AllAlarmsNew] 	Where '+@wherecode+
											    ' group by DATEPART(HOUR,Occurance_Date)) a),0) as int)'
		end


		if(@wherecode='')
		begin
					set @sqlstr+=' select top(10) ZoneTitle1 as ''ZoneName'',count(*) as ''No_OF_Alarms'',@AverageBerHour as ''AverageBerHour'',[LevelTitle1] as ''Level'',ZoneID,21 as StoredProcedureID  '+
									 'from [dbo].[UDV_AllAlarmsNew] '+
									  'group by  ZoneTitle1,ZoneID,[LevelTitle1] order by 2 desc'
		 end
		else
		begin
					--set @sqlstr+=' select top(10) ZoneTitle1 as ''ZoneName'',count(*) as ''No_OF_Alarms'',@AverageBerHour as ''AverageBerHour'',[LevelTitle1] as ''Level'',ZoneID,21 as StoredProcedureID  '+
					--				 'from [dbo].[UDV_AllAlarms] Where'+@wherecode+
					--				  ' group by  ZoneTitle1,ZoneID,[LevelTitle1] order by 2 desc'
						set @sqlstr+=' select top(10) ZoneTitle1 as ''ZoneName'',count(*) as ''No_OF_Alarms'',@AverageBerHour as ''AverageBerHour'',[LevelTitle1] as ''Level'',ZoneID,21 as StoredProcedureID  '+
									 'from [dbo].[UDV_AllAlarmsNew] Where '+@wherecode+
									  ' group by  ZoneTitle1,ZoneID,[LevelTitle1] order by 2 desc'
		end

-- Create Temp Table
create table #Temp_Top10ResultsZone
(
RowID int identity(1,1),
ZoneName nvarchar(200),
No_OF_Alarm nvarchar(200),
AvgerageBerHour nvarchar(200),
Level nvarchar(200),
ZoneID int,
StoredProcedureID int
)

insert into #Temp_Top10ResultsZone
execute(@sqlstr)

-- Update Avg Per Hour
declare 
@AvgPerHour int, 
@i$RowID int,
@i$NumberOfAlarm int,
@i$ZoneID int

declare Cur_AveragePerHour_i cursor local forward_only
	for select RowID,No_OF_Alarm,ZoneID from #Temp_Top10ResultsZone

open Cur_AveragePerHour_i
fetch Cur_AveragePerHour_i into @i$RowID,@i$NumberOfAlarm,@i$ZoneID
while @@FETCH_STATUS=0 
begin

select @AvgPerHour=@i$NumberOfAlarm/( 
	select isnull(NULLIF(count(a.cx), '0'),1) from ( 
			select count(*) as 'cx',DATEPART(HOUR,Occurance_Date) as 'hour' 
				from [dbo].[UDV_AllAlarmsNew] 
					group by [ZoneID],DATEPART(HOUR,Occurance_Date) having [ZoneID]=@i$ZoneID)a)

update #Temp_Top10ResultsZone
	set AvgerageBerHour=@AvgPerHour
		where RowID=@i$RowID

fetch Cur_AveragePerHour_i into @i$RowID,@i$NumberOfAlarm,@i$ZoneID
end
close Cur_AveragePerHour_i
deallocate Cur_AveragePerHour_i
select 	ZoneName,No_OF_Alarm,AvgerageBerHour,Level,ZoneID,StoredProcedureID
from #Temp_Top10ResultsZone
END