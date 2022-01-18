/****** Object:  Procedure [dbo].[UDSP_TotalNumberOfAlarmOverTimeGetTotalAlarmNew]    Committed by VersionSQL https://www.versionsql.com ******/

Create PROCEDURE [dbo].[UDSP_TotalNumberOfAlarmOverTimeGetTotalAlarmNew](        @City nvarchar(100)=null		,
													@Station nvarchar(100)=null     ,
													@Level nvarchar(100)=null       ,
													@Zone nvarchar(100)=null        ,
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
			set @sqlstr+=' select count(*) as ''AlarmID'',convert(varchar(20),Occurance_Date,110) as ''Occurance_Date'' ,PriorityID,31 as StoredProcedureID from [dbo].[UDV_AllAlarms] group by convert(varchar(20),Occurance_Date,110) ,PriorityID '
		end
	else
		begin
		set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
		set @sqlstr+='select count(*) as ''AlarmID'',convert(varchar(20),Occurance_Date,110) as ''Occurance_Date'',PriorityID,31 as StoredProcedureID from [dbo].[UDV_AllAlarms] Where '+@wherecode+' group by convert(varchar(20),Occurance_Date,110) ,PriorityID,31 as StoredProcedureID  '
						
		end
	-- print @sqlstr
	execute(@sqlstr)
END