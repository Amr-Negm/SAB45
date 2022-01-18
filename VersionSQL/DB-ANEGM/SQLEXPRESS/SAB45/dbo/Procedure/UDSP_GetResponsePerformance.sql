/****** Object:  Procedure [dbo].[UDSP_GetResponsePerformance]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetResponsePerformance](@City nvarchar(100)=null	,
													  @Station nvarchar(100)=null ,
													  @Level nvarchar(100)=null   ,
													  @Zone nvarchar(100)=null    ,
													  @Camera nvarchar(100)=null  ,
													  @StartDate datetime=null  ,
													  @EndDate datetime=null)
AS
BEGIN


--cast(round((cast(a.Respcount as decimal)/cast(a.[Alarm Total] as decimal)),0) as int) for rounding the division


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
		set @sqlstr='select  a.PriorityID as ''PriorityID'', '+
				'UPPER(a.PriorityTitle1) as ''Alarm Priority'',a.[Alarm Total]  as ''AlarmTotalNumber'', a.countResp as ''CountResponseAlarm''/*02272018Abdelfattah*/, '+
			   'cast((a.Respcount/a.[Alarm Total]) as int)  as ''Avg Response Time'', '+
			   'cast((a.ExpectedCount/a.[Alarm Total]) as int)  as ''Expected Response Time'', ' +
			   'case when  a.Respcount<=a.ExpectedCount '+
				'then	''Accepetable'' '+
			   'else '+
				'''Unacceptable'' '+
			   'end as ''Comment'' '+
			   'from (select sum(isnull(ResponseTimeDifference,0)) as ''Respcount'',count((Response_Date)) as ''countResp''/*02272018Abdelfattah*/, sum(isnull(ExpectedResponseTime,0)) as ''ExpectedCount'',count(*) as ''Alarm Total'',PriorityTitle1,PriorityID '+
						'from [dbo].[UDV_AllAlarms] group by PriorityTitle1,PriorityID)  a  order by 1 desc'
		end
		else
		begin
			set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
					set @sqlstr='select  a.PriorityID as ''PriorityID'', '+
				'UPPER(a.PriorityTitle1) as ''Alarm Priority'',a.[Alarm Total]  as ''AlarmTotalNumber'', a.countResp as ''CountResponseAlarm''/*02272018Abdelfattah*/, '+
			   'cast((a.Respcount/a.[Alarm Total]) as int)  as ''Avg Response Time'', '+
			   'cast((a.ExpectedCount/a.[Alarm Total]) as int)  as ''Expected Response Time'', ' +
			   'case when  a.Respcount<=a.ExpectedCount '+
				'then	''Accepetable'' '+
			   'else '+
				'''Unacceptable'' '+
			   'end as ''Comment'' '+
			   'from (select sum(isnull(ResponseTimeDifference,0)) as ''Respcount'',count((Response_Date)) as ''countResp''/*02272018Abdelfattah*/, sum(isnull(ExpectedResponseTime,0)) as ''ExpectedCount'',count(*) as ''Alarm Total'',PriorityTitle1,PriorityID '+
						'from [dbo].[UDV_AllAlarms] Where '+@wherecode+' group by PriorityTitle1,PriorityID)  a  order by 1 desc'
		end
		print @sqlstr
		execute(@sqlstr)
END