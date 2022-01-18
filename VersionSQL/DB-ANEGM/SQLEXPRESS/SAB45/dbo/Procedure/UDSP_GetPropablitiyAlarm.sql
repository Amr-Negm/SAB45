/****** Object:  Procedure [dbo].[UDSP_GetPropablitiyAlarm]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetPropablitiyAlarm](   --@City nvarchar(100)=null		,
													--@Station nvarchar(100)=null     ,
													--@Level nvarchar(100)=null       ,
													--@Zone nvarchar(100)=null        ,
													--@Location nvarchar(100)=null        ,
													@Camera nvarchar(100)=null      ,
													@StartDate datetime=null        ,
													@EndDate datetime=null)
AS
BEGIN


SET FMTONLY OFF; 
			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			
			set @sqlstr=' declare @total decimal '
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

				--if(@Location!='' or @Location!=null)
				--begin
				--	set @wherecode+='  [LocationName]='''+@Location+''' AND'
				--end 
				if(@Camera!='' or @Camera!=null)
				begin
					set @wherecode+='  [TouchPointTitle1]='''+@Camera+''' AND'
				end 
				
				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(20), @StartDate, 120)+':000'' AND'
				end

				if(@StartDate ='' or @StartDate is null)
				begin
				--abdelwahed 13-02-2020
					--set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(20), getdate(), 120)+':000'' AND'
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(11),getdate()  , 120)+'00:00:00:000'' AND'
				end


				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(20),@EndDate  , 120)+':000'' AND'
				end
				if(@EndDate ='' or @EndDate is null)
				begin
				--abdelwahed 13-02-2020
					--set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(20),getdate() , 120)+':000'' AND'
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(11),getdate()  , 120)+'23:59:59:999'' AND'
				end


---------------------------- Edit Abouelela  2020.02.12

if(@wherecode='')
	set @sqlstr+=' select @total=count(*) from UDV_AlarmsAverage '
else
	begin
	set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
	set @sqlstr+=' select @total=count(*) from UDV_AlarmsAverage Where '+@wherecode
	End

if(@wherecode='')
	set @sqlstr+=' select AlarmDefinitionTitle1 as ScenarioTitle1 ,COUNT(*) as ScenarioID '+
				'from UDV_AlarmsAverage   group by AlarmDefinitionTitle1 '
else
	begin
	 
	set @sqlstr+=' select AlarmDefinitionTitle1 as ScenarioTitle1 ,COUNT(*) as ScenarioID '+
				'from UDV_AlarmsAverage where  '+@wherecode+' group by AlarmDefinitionTitle1 '
	end


	print @sqlstr
	execute(@sqlstr)
END


--if(@wherecode='')
--	set @sqlstr+=' select @total=count(*) from UDV_ScenarioAveragePerWeek '
--else
--	begin
--	set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
--	set @sqlstr+=' select @total=count(*) from UDV_ScenarioAveragePerWeek Where '+@wherecode
--	End

--if(@wherecode='')
--	set @sqlstr+=' select ScenarioTitle1,COUNT(*) as ScenarioID '+
--				'from UDV_ScenarioAveragePerWeek   group by ScenarioTitle1 '
--else
--	begin
	 
--	set @sqlstr+=' select ScenarioTitle1,COUNT(*) as ScenarioID '+
--				'from UDV_ScenarioAveragePerWeek where  '+@wherecode+' group by ScenarioTitle1 '
--	end


--	print @sqlstr
--	execute(@sqlstr)
--END
------------------------- End Edit 2020.02.12