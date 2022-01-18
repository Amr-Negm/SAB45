/****** Object:  Procedure [dbo].[UDSP_GetScenarioResponseTime]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetScenarioResponseTime]( 
												@StartDate datetime=		null,
												@EndDate datetime=			null,
												@ExceptVal int=0
												)
AS
BEGIN
			SET NOCOUNT ON
			SET FMTONLY off	

			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)

			set @sqlstr=''
			set @wherecode=''
-------------------------------------------------Filter--------------------------------------------------------
				set @wherecode=''
				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(25), @StartDate, 121)+''' AND'
				end 
				if(@StartDate ='' or @StartDate is null)
				begin
					set @wherecode+='  (cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' or cast([Occurance_Date] as date) is null ) AND'
				end 


				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(25), @EndDate   , 121)+''' AND'
				end
				if(@EndDate ='' or @EndDate is null)
				begin
					set @wherecode+=' ( cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' or cast([Occurance_Date] as date) is null ) AND'
				end
--------------------------------------------------------------------------------------------------------------		
-------------------------------------------------Query--------------------------------------------------------	

	if(@wherecode='')
		begin	
		
			if(@ExceptVal=0 or @ExceptVal is null)
				begin
			
							set @sqlstr='	SELECT   AlarmDefinitionTitle1 ,min(ResponseTimeDifference) as ''minval'',max(ResponseTimeDifference) as ''maxval'',avg(ResponseTimeDifference) as ''avgval'''+
									   'FROM   UDV_AlarmsAverage WHERE (ResponseTimeDifference >= 0 and ResponseTimeDifference IS NOT NULL)  GROUP BY AlarmDefinitionTitle1 '
				end
			else
				begin
						/*31122018 set @sqlstr='	SELECT   REVERSE(PARSENAME(REPLACE(REVERSE(AlarmDefinitionTitle1), '' '', ''.''), 1)) +'' ''+REVERSE(PARSENAME(REPLACE(REVERSE(AlarmDefinitionTitle1), '' '', ''.''), 2)) as ''AlarmDefinitionTitle1'',min(ResponseTimeDifference) as ''minval'',max(ResponseTimeDifference) as ''maxval'',avg(ResponseTimeDifference) as ''avgval'''+
									   'FROM   UDV_AllAlarmsNew WHERE (ResponseTimeDifference IS NOT NULL)  GROUP BY AlarmDefinitionTitle1 having max(ResponseTimeDifference)<='+cast(@ExceptVal as varchar(10))*/

									   set @sqlstr='	SELECT   AlarmDefinitionTitle1 ,min(ResponseTimeDifference) as ''minval'',max(ResponseTimeDifference) as ''maxval'',avg(ResponseTimeDifference) as ''avgval'''+
									   'FROM   UDV_AlarmsAverage WHERE (ResponseTimeDifference >= 0 and ResponseTimeDifference IS NOT NULL and ResponseTimeDifference <= '+cast(@ExceptVal as varchar(10))+')  GROUP BY AlarmDefinitionTitle1 '
				end
		end
	else
		begin
				set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )		

			if(@ExceptVal=0 or @ExceptVal is null)
					begin
						set @sqlstr='SELECT  AlarmDefinitionTitle1 ,min(ResponseTimeDifference) as ''minval'',max(ResponseTimeDifference) as ''maxval'',avg(ResponseTimeDifference) as ''avgval'''+
									'FROM  UDV_AlarmsAverage WHERE (ResponseTimeDifference >= 0 and ResponseTimeDifference IS NOT NULL) and '+@wherecode+' GROUP BY AlarmDefinitionTitle1 '
					end
			else
					begin
						/*31122018 set @sqlstr='SELECT  REVERSE(PARSENAME(REPLACE(REVERSE(AlarmDefinitionTitle1), '' '', ''.''), 1)) +'' ''+REVERSE(PARSENAME(REPLACE(REVERSE(AlarmDefinitionTitle1), '' '', ''.''), 2)) as ''AlarmDefinitionTitle1'',min(ResponseTimeDifference) as ''minval'',max(ResponseTimeDifference) as ''maxval'',avg(ResponseTimeDifference) as ''avgval'''+
									'FROM  UDV_AllAlarmsNew WHERE (ResponseTimeDifference IS NOT NULL) and '+@wherecode+' GROUP BY AlarmDefinitionTitle1 having max(ResponseTimeDifference)<='+cast( @ExceptVal as varchar(10))*/
									set @sqlstr='SELECT  AlarmDefinitionTitle1 ,min(ResponseTimeDifference) as ''minval'',max(ResponseTimeDifference) as ''maxval'',avg(ResponseTimeDifference) as ''avgval'''+
									'FROM  UDV_AlarmsAverage WHERE (ResponseTimeDifference >= 0 and ResponseTimeDifference IS NOT NULL and ResponseTimeDifference <= '+cast( @ExceptVal as varchar(10))+') and '+@wherecode+' GROUP BY AlarmDefinitionTitle1 '
					end
		end	
		print @sqlstr
---------------------------------------------------------------------------------------------------------------------	

	   exec(@sqlstr)
	   SET NOCOUNT OFF;	
END