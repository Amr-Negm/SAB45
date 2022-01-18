/****** Object:  Procedure [dbo].[UDSP_GetAlarmPerZone]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAlarmPerZone](       --@City nvarchar(100)=null		,
													--@Station nvarchar(100)=null     ,
													--@Level nvarchar(100)=null       ,
													--@Zone nvarchar(100)=null        ,
													@Location nvarchar(100)=null      ,
													@Type nvarchar(100)=null      ,
													@Camera nvarchar(100)=null      ,
													@StartDate datetime=null        ,
													@EndDate datetime=null)
AS
BEGIN


SET FMTONLY OFF; 
			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			
			set @sqlstr=''
-------------------------------------------------Alarms Total Number--------------------------------------------------------
		set @wherecode=''
				--if(@City!='' or @City!=null)
				--begin
				--	set @wherecode+='CityTitle1='''+@City+''' AND '
				--end 
				--
				--if(@Station!='' or @Station!=null)
				--begin
				--	set @wherecode+='  [StationTitle1]='''+@Station+''' AND '
				--end 
				--
				--if(@Level!='' or @Level!=null)
				--begin
				--	set @wherecode+='  [LevelTitle1]='''+@Level+''' AND'
				--end 
				--
				--if(@Zone!='' or @Zone!=null)
				--begin
				--	set @wherecode+='  [ZoneTitle1]='''+@Zone+''' AND'
				--end 

				if(@Location!='' or @Location!=null)
				begin
					set @wherecode+='  [LocationName]='''+@Location+''' AND'
				end 
				
				if(@Type!='' or @Type!=null)
				begin
					set @wherecode+='  [LocationTypeName]='''+@Type+''' AND'
				end

				if(@Camera!='' or @Camera!=null)
				begin
					set @wherecode+='  [TouchPointTitle1]='''+@Camera+''' AND'
				end 
				
				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(25), @StartDate, 121)+''' AND'
				end 
				if(@StartDate ='' or @StartDate is null)
				begin
					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' AND'
				end 


				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(25), @EndDate   , 121)+''' AND'
				end
				if(@EndDate ='' or @EndDate is null)
				begin
					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' AND'
				end


	if(@wherecode='')
		begin
			set @sqlstr='select count([AlarmID]) as [value],LocationID , LocationName ,ParentLocationID,ParentLocationName '+
						 'from [dbo].[UDV_AllAlarmsNew]   '+
						 'group by  LocationID , LocationName ,ParentLocationID,ParentLocationName order by 1 desc'
		end
	else
		begin
		set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
		set @sqlstr='select count([AlarmID]) as [value],LocationID , LocationName ,ParentLocationID,ParentLocationName '+
						 'from [dbo].[UDV_AllAlarmsNew]  where '+@wherecode+
						 ' group by  LocationID , LocationName ,ParentLocationID,ParentLocationName order by 1 desc'
		end
	print @sqlstr
	execute(@sqlstr)

END