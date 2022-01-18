/****** Object:  Procedure [dbo].[UDSP_GetRatioAlarmScenarion]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetRatioAlarmScenarion]( 
														@StartDate datetime=		null,
														@EndDate datetime=			null
												)
AS
BEGIN
SET NOCOUNT ON;				
SET FMTONLY OFF; 

			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			set @sqlstr=' declare @total decimal '
			set @wherecode='  '

-------------------------------------------------Alarms Total Number--------------------------------------------------------

				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(25), @StartDate, 121)+''' AND'
				end 
				if(@StartDate ='' or @StartDate is null)
				begin
					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date), 120)+''' AND'
				end 

				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(25),  @EndDate    , 121)+''' AND'
				end
				if(@EndDate ='' or @EndDate is null)
				begin
					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' AND'
				end
-----------------------------------------------------------------------------------------------------------------------------



----  Edit Abouelela  2020.02.12
if(@wherecode='')
	begin
			
			set @sqlstr+=' select AlarmCategoryTitle1 as ''Scenario'',count(*) as ''Ratio''  from [dbo].[UDV_AlarmsAverage] group by AlarmCategoryTitle1 '
	end
else
	begin
			set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )

			set @sqlstr+=' select AlarmCategoryTitle1 as ''Scenario'',count(*) as ''Ratio''  from [dbo].[UDV_AlarmsAverage] where '+@wherecode+' group by AlarmCategoryTitle1 '
	End

--if(@wherecode='')
--	begin
			
--			set @sqlstr+=' select ScenarioTitle1 as ''Scenario'',count(*) as ''Ratio''  from [dbo].[UDV_ScenarioAveragePerWeek] group by ScenarioTitle1 '
--	end
--else
--	begin
--			set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )

--			set @sqlstr+=' select ScenarioTitle1 as ''Scenario'',count(*) as ''Ratio''  from [dbo].[UDV_ScenarioAveragePerWeek] where '+@wherecode+' group by ScenarioTitle1 '
--	End

--------- End Edit 2020.02.12


	--print @sqlstr
	execute(@sqlstr)


								
SET NOCOUNT OFF;	

END