/****** Object:  Procedure [dbo].[UDSP_AlarmPriorityOfCurrentAndLastWeekGetAlarmPrioriyOfCurrentAndLastWeak]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_AlarmPriorityOfCurrentAndLastWeekGetAlarmPrioriyOfCurrentAndLastWeak]( @City nvarchar(max)=''		,
												@Station nvarchar(max)=''   ,
												@Level nvarchar(max)=''     ,
												@Zone nvarchar(max)=''      ,
												@Camera nvarchar(max)=''    
												--,@StartDate datetime=null    ,
												--@EndDate datetime=null
												)
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
				
			
			
	if(@wherecode='')
	begin
			set @sqlstr='	select count([AlarmID]) as Value,case when datepart(ww, Occurance_Date)= datepart(ww, getdate()) then ''ThisWeek'' else ''LastWeek'' end as Week,PriorityTitle1 ,26 as StoredProcedureID'+
						   ' , PriorityID from [dbo].[T_AllAlarms] 							'+
							 'group by PriorityTitle1 , PriorityID,datepart(ww, Occurance_Date)  '+
						     'having  datepart(ww, Occurance_Date)>=DATEPART(ww,getdate())-1  order by PriorityID,2'


	end
	else
	begin

	set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
	set @sqlstr='	select count([AlarmID]) as Value, case when datepart(ww, Occurance_Date)= datepart(ww, getdate()) then ''ThisWeek'' else ''LastWeek'' end as Week,PriorityTitle1 ,26 as StoredProcedureID'+
						   ',PriorityID  from [dbo].[T_AllAlarms] 					Where		'+@wherecode+
							 ' group by PriorityTitle1 , PriorityID,datepart(ww, Occurance_Date)  '+
						     'having  datepart(ww, Occurance_Date)>=DATEPART(ww,getdate())-1  order by PriorityID,2'
	end
	print @sqlstr
	execute(@sqlstr)
END