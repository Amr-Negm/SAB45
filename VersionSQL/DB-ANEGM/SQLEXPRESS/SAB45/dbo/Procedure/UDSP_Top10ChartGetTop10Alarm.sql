/****** Object:  Procedure [dbo].[UDSP_Top10ChartGetTop10Alarm]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_Top10ChartGetTop10Alarm](
											@City nvarchar(100)=null		,
													@Station nvarchar(100)=null   ,
													@Level nvarchar(100)=null     ,
													@Zone nvarchar(100)=null      ,
													@Camera nvarchar(100)=null    ,
													@StartDate datetime=null    ,
													@EndDate datetime=null
											)
AS
BEGIN
SET NOCOUNT ON;	

SET FMTONLY OFF; 
			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			
			set @sqlstr=''
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

	if(@wherecode='')
			begin
				set @sqlstr='select top(10) count(*) as value,AlarmDefinitionTitle1 as Name,17 as StoredProcedureID from [dbo].[UDV_AllAlarmsActions] 	group by  AlarmDefinitionTitle1 order by 1 desc'
			end
	else
			begin
				set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
				set @sqlstr='select top(10) count(*) as value,AlarmDefinitionTitle1 as Name,17 as StoredProcedureID  from [dbo].[UDV_AllAlarmsActions] Where '+@wherecode+' 	group by  AlarmDefinitionTitle1 order by 1 desc'
			end
				-- print @sqlstr
	execute(@sqlstr)
SET NOCOUNT OFF;	
END