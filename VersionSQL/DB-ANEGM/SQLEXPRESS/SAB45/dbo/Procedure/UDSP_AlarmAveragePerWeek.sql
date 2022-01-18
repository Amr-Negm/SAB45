/****** Object:  Procedure [dbo].[UDSP_AlarmAveragePerWeek]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE   PROCEDURE [dbo].[UDSP_AlarmAveragePerWeek](
													
													@StartDate datetime=null    ,
													@EndDate datetime=null,
													@filter int=0,
													@TimeDiff int=0
													)
AS
BEGIN

SET NOCOUNT ON;	
SET FMTONLY OFF; 
		 --select count([AlarmScenarioID]) as 'AvgBerDay', cast(DATENAME(weekday,Occurance_Date) as varchar(3)) as Dayname ,CityTitle1,StationTitle1,LevelTitle1,ZoneTitle1,TouchPointTitle1,SelectedCreationDate
			--			from [dbo].[UDV_AllScenarios] where CityTitle1=isnull((@City),CityTitle1)				AND
			--										[StationTitle1]=isnull((@Station),[StationTitle1])		AND 
			--										[LevelTitle1]=isnull((@Level),[LevelTitle1])				AND 
			--										[ZoneTitle1]=isnull((@Zone),[ZoneTitle1])					AND 
			--										[TouchPointTitle1]=isnull((@Camera),[TouchPointTitle1])   AND
			--										[SelectedCreationDate]>=isnull((@StartDate),[SelectedCreationDate])	AND 
			--										[SelectedCreationDate]<=isnull(DATEADD(day,1,(@EndDate)),[SelectedCreationDate]) and
			--										IsSelected=1 and
			--										SelectedCreationDate is not null
														
			--			 group by cast(DATENAME(weekday,SelectedCreationDate) as varchar(3)),CityTitle1,StationTitle1,LevelTitle1,ZoneTitle1,TouchPointTitle1,SelectedCreationDate



			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			
			set @sqlstr=''
-------------------------------------------------Alarms Total Number--------------------------------------------------------
		set @wherecode=''
				 
				
				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(20), @StartDate, 120)+':000'' AND'
				end 


				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(20), @EndDate  , 120)+':000'' AND'
				end


				if(@filter=0)
					begin 
									/* 12242018 Abdelfattah set @sqlstr='				  select count(*) as ''AvgBerDay'', cast(DATENAME(weekday,Occurance_Date) as varchar(15)) as Dayname,ScenarioTitle1 as ScenarioTitle '+
																'from [dbo].[UDV_ScenarioAveragePerWeek] where  Occurance_Date is not null and Occurance_Date>=DATEADD(day, DATEDIFF(day, 0, Occurance_Date) /7*7, 0) '+				
																 'group by cast(DATENAME(weekday,Occurance_Date) as varchar(15)) , ScenarioTitle1 order by CASE '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 1 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 2 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 3 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 4 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 5 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 6 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 7 END ASC'
												  */
						/*
						set @sqlstr='select count(*) as ''AvgBerDay'', cast(DATENAME(weekday,Occurance_Date) as varchar(15)) as Dayname,FORMAT(Occurance_Date, ''dddd'', ''de-de'') AS Dayname2,ScenarioTitle1 as ScenarioTitle '+
									'from [dbo].[UDV_ScenarioAveragePerWeek] where  Occurance_Date is not null and Occurance_Date >= CONVERT(VARCHAR(25), getdate()-7, 110) '+				
									'group by cast(DATENAME(weekday,Occurance_Date) as varchar(15)) , ScenarioTitle1,FORMAT(Occurance_Date, ''dddd'', ''de-de'') order by CASE '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 1 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 2 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 3 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 4 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 5 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 6 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 7 END ASC' 
									*/

---------------------  Edit Abouelela 2020.02.12

	--set @sqlstr='select count(*) as ''AvgBerDay'', FORMAT(Occurance_Date, ''dddd'', ''de-de'') AS Dayname2,cast(DATENAME(weekday,Occurance_Date) as varchar(15)) as Dayname,AlarmDefinitionTitle1 as ScenarioTitle '+
	--								'from [dbo].[UDV_AlarmsAverage] where  Occurance_Date is not null and DATEPART(WEEK,Occurance_Date) = DATEPART(ISO_WEEK,getdate())'+				
	--								'group by cast(DATENAME(weekday,Occurance_Date) as varchar(15)) , AlarmDefinitionTitle1,FORMAT(Occurance_Date, ''dddd'', ''de-de'')  order by CASE '+
	--									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 1 '+
	--								'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 2 '+
	--								'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 3 '+
	--								'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 4 '+
	--								'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 5 '+
	--								'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 6 '+
	--								'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 7 END ASC' 
---------------------  Edit Abouelela 2021.07.11

					set @sqlstr='select count(*) as ''AvgBerDay'', FORMAT(Occurance_Date, ''dddd'', ''de-de'') AS Dayname2,cast(DATENAME(weekday,Occurance_Date) as varchar(15)) as Dayname,AlarmDefinitionTitle1 as ScenarioTitle '+
									'from [dbo].[UDV_AlarmsAverage] where  Occurance_Date is not null and DATEPART(WEEK,Occurance_Date) = DATEPART(WEEK,getdate()) and DATEPART(YEAR,Occurance_Date)=DATEPART(YEAR,GETDATE()) '+				
									'group by cast(DATENAME(weekday,Occurance_Date) as varchar(15)) , AlarmDefinitionTitle1,FORMAT(Occurance_Date, ''dddd'', ''de-de'')  order by CASE '+
										'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 1 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 2 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 3 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 4 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 5 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 6 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 7 END ASC' 

									--set @sqlstr='select count(*) as ''AvgBerDay'', FORMAT(Occurance_Date, ''dddd'', ''de-de'') AS Dayname2,cast(DATENAME(weekday,Occurance_Date) as varchar(15)) as Dayname,ScenarioTitle1 as ScenarioTitle '+
									--'from [dbo].[UDV_ScenarioAveragePerWeek] where  Occurance_Date is not null and DATEPART(ISO_WEEK,Occurance_Date) = DATEPART(ISO_WEEK,getdate())'+				
									--'group by cast(DATENAME(weekday,Occurance_Date) as varchar(15)) , ScenarioTitle1,FORMAT(Occurance_Date, ''dddd'', ''de-de'')  order by CASE '+
									--'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 1 '+
									--'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 2 '+
									--'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 3 '+
									--'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 4 '+
									--'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 5 '+
									--'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 6 '+
									--'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 7 END ASC'

----------------------  End Edit 2020.02.12
												
					end
				else
					begin


						if(@wherecode='')
										begin
												/*set @sqlstr='select count(*) as ''AvgBerDay'', cast(DATENAME(weekday,Occurance_Date) as varchar(15)) as Dayname,FORMAT(Occurance_Date, ''dddd'', ''de-de'') AS Dayname2,ScenarioTitle1 as ScenarioTitle '+
																'from [dbo].[UDV_ScenarioAveragePerWeek] where  Occurance_Date is not null '+				
																 'group by cast(DATENAME(weekday,Occurance_Date) as varchar(15)) , ScenarioTitle1,FORMAT(Occurance_Date, ''dddd'', ''de-de'') order by CASE '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 1 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 2 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 3 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 4 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 5 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 6 '+
												  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 7 END ASC'*/

--------------------------------  Edit Abouelela 2020.02.12

							set @sqlstr='select count(*) as ''AvgBerDay'', cast(DATENAME(weekday,Occurance_Date) as varchar(15)) as Dayname,FORMAT(Occurance_Date, ''dddd'', ''de-de'') AS Dayname2,AlarmDefinitionTitle1 as ScenarioTitle '+
																'from [dbo].[UDV_AlarmsAverage] where  Occurance_Date is not null '+				
																 'group by cast(DATENAME(weekday,Occurance_Date) as varchar(15)) , AlarmDefinitionTitle1 ,FORMAT(Occurance_Date, ''dddd'', ''de-de'')  order by CASE '+
												 	'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 1 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 2 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 3 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 4 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 5 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 6 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 7 END ASC' 


												  --set @sqlstr='select count(*) as ''AvgBerDay'', cast(DATENAME(weekday,Occurance_Date) as varchar(15)) as Dayname,FORMAT(Occurance_Date, ''dddd'', ''de-de'') AS Dayname2,ScenarioTitle1 as ScenarioTitle '+
														--		'from [dbo].[UDV_ScenarioAveragePerWeek] where  Occurance_Date is not null '+				
														--		 'group by cast(DATENAME(weekday,Occurance_Date) as varchar(15)) , ScenarioTitle1,FORMAT(Occurance_Date, ''dddd'', ''de-de'')  order by CASE '+
												  --'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 1 '+
												  --'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 2 '+
												  --'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 3 '+
												  --'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 4 '+
												  --'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 5 '+
												  --'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 6 '+
												  --'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 7 END ASC'

-------------------------------  End Edit 2020.02.12


												end
						else
										begin
	set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
		/*set @sqlstr='				  select count(*) as ''AvgBerDay'', cast(DATENAME(weekday,Occurance_Date) as varchar(15)) as Dayname,FORMAT(Occurance_Date, ''dddd'', ''de-de'') AS Dayname2,ScenarioTitle1 as ScenarioTitle '+
						'from [dbo].[UDV_ScenarioAveragePerWeek] where  Occurance_Date is not null AND '+@wherecode+				
						 ' group by cast(DATENAME(weekday,Occurance_Date) as varchar(15)),ScenarioTitle1,FORMAT(Occurance_Date, ''dddd'', ''de-de'') order by CASE '+
						  'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 1 '+
          'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 2 '+
          'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 3 '+
          'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 4 '+
          'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 5 '+
          'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 6 '+
          'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 7 END ASC'*/




--------------------------------  Edit Abouelela 2020.02.12

set @sqlstr='				  select count(*) as ''AvgBerDay'', cast(DATENAME(weekday,DATEADD(hour,'+cast( @TimeDiff as varchar(10))+',Occurance_Date)) as varchar(15)) as Dayname,FORMAT(DATEADD(hour,'+cast( @TimeDiff as varchar(10))+',Occurance_Date), ''dddd'', ''de-de'') AS Dayname2,AlarmDefinitionTitle1 as ScenarioTitle '+
						'from [dbo].[UDV_AlarmsAverage] where  Occurance_Date is not null AND '+@wherecode+				
						 ' group by cast(DATENAME(weekday,DATEADD(hour,'+cast( cast( @TimeDiff as varchar(10)) as varchar(10))+',Occurance_Date)) as varchar(15)),AlarmDefinitionTitle1,FORMAT(DATEADD(hour,'+cast( @TimeDiff as varchar(10))+',Occurance_Date), ''dddd'', ''de-de'')  order by CASE '+
			'WHEN cast(DATENAME(weekday,DATEADD(hour,'+cast( @TimeDiff as varchar(10))+',Occurance_Date)) as varchar(15)) = ''Sunday'' THEN 1 '+
									'WHEN cast(DATENAME(weekday,DATEADD(hour,'+cast( @TimeDiff as varchar(10))+',Occurance_Date)) as varchar(15)) = ''Monday'' THEN 2 '+
									'WHEN cast(DATENAME(weekday,DATEADD(hour,'+cast( @TimeDiff as varchar(10))+',Occurance_Date)) as varchar(15)) = ''Tuesday'' THEN 3 '+
									'WHEN cast(DATENAME(weekday,DATEADD(hour,'+cast( @TimeDiff as varchar(10))+',Occurance_Date)) as varchar(15)) = ''Wednesday'' THEN 4 '+
									'WHEN cast(DATENAME(weekday,DATEADD(hour,'+cast( @TimeDiff as varchar(10))+',Occurance_Date)) as varchar(15)) = ''Thursday'' THEN 5 '+
									'WHEN cast(DATENAME(weekday,DATEADD(hour,'+cast( @TimeDiff as varchar(10))+',Occurance_Date)) as varchar(15)) = ''Friday'' THEN 6 '+
									'WHEN cast(DATENAME(weekday,DATEADD(hour,'+cast( @TimeDiff as varchar(10))+',Occurance_Date)) as varchar(15)) = ''Saturday'' THEN 7 END ASC' 


		  --set @sqlstr='				  select count(*) as ''AvgBerDay'', cast(DATENAME(weekday,Occurance_Date) as varchar(15)) as Dayname,FORMAT(Occurance_Date, ''dddd'', ''de-de'') AS Dayname2,ScenarioTitle1 as ScenarioTitle '+
				--		'from [dbo].[UDV_ScenarioAveragePerWeek] where  Occurance_Date is not null AND '+@wherecode+				
				--		 ' group by cast(DATENAME(weekday,Occurance_Date) as varchar(15)),ScenarioTitle1,FORMAT(Occurance_Date, ''dddd'', ''de-de'')  order by CASE '+
		  --'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 1 '+
    --      'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 2 '+
    --      'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 3 '+
    --      'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 4 '+
    --      'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 5 '+
    --      'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 6 '+
    --      'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 7 END ASC'


-------------------------------  End Edit 2020.02.12

	end
					end
	 print @sqlstr
	execute(@sqlstr)
SET NOCOUNT OFF;	
END


--select DATEPART(wk,getdate()) 