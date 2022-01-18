/****** Object:  Procedure [dbo].[UDSP_GetTypeTouchpointNamesPerHour]    Committed by VersionSQL https://www.versionsql.com ******/

---------------------------------------------------------------AbdelwahedElnagar-------------------------------------
CREATE PROCEDURE [dbo].[UDSP_GetTypeTouchpointNamesPerHour]( 
												@StartDate datetime=		null,
												@EndDate datetime=			null,
												@GroupType int=0,
												@TouchpointTypeID int=0
												)
AS
BEGIN
			--SET NOCOUNT ON
			SET FMTONLY OFF

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
					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date), 120)+''' AND'
				end 


				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(25), @EndDate    , 121)+''' AND'
				end

				if(@TouchpointTypeID ='' or @TouchpointTypeID is null)
				begin
					set @TouchpointTypeID=0
				end
--------------------------------------------------------------------------------------------------------------		
-------------------------------------------------Query--------------------------------------------------------	

	if(@wherecode='')
		begin	
		
					--hour
					if(@GroupType=0 or @GroupType is null)
					begin
						--set @sqlstr='select ScenarioTitle1,concat (cast( DATEPART(hour, Occurance_Date) as varchar(max)) , '':00'','' - '',cast( DATEPART(hour, Occurance_Date) as varchar(max))+1,'':00'') as ''date'','''' as ''date2'',count(*) as ''total''  from UDV_ScenarioAveragePerWeek group by ScenarioTitle1, DATEPART(hour, Occurance_Date) order by cast( DATEPART(hour, Occurance_Date) as int)'
						set @sqlstr='select TouchPointTitle1 as TouchPointName ,concat (cast( DATEPART(hour, Occurance_Date) as varchar(max)) , '':00'','' - '',cast( DATEPART(hour, Occurance_Date) as varchar(max))+1,'':00'') as ''date'','''' as ''date2'',count(*) as ''total''  
						from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+'  group by TouchPointTitle1, DATEPART(hour, Occurance_Date) order by cast( DATEPART(hour, Occurance_Date) as int)'


					end
					
					--day
					if(@GroupType=1)
					begin
						--set @sqlstr='select ScenarioTitle1,DATENAME(weekday,Occurance_Date) as ''date'',FORMAT(Occurance_Date, ''dddd'', ''de-de'') as ''date2'',count(*) as ''total''  from UDV_ScenarioAveragePerWeek group by ScenarioTitle1,DATENAME(weekday,Occurance_Date) ,FORMAT(Occurance_Date, ''dddd'', ''de-de'')
						set @sqlstr='select TouchPointTitle1 as TouchPointName ,DATENAME(weekday,Occurance_Date) as ''date'',FORMAT(Occurance_Date, ''dddd'', ''de-de'') as ''date2'',count(*) as ''total''  
							from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' group by TouchPointTitle1  , DATENAME(weekday,Occurance_Date) ,FORMAT(Occurance_Date, ''dddd'', ''de-de'')
						order by CASE '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 1 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 2 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 3 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 4 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 5 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 6 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 7 END ASC'
					end
					
					--minute
					if(@GroupType=2)
					begin
						--set @sqlstr='select ScenarioTitle1,''00:''+    case when   (datepart(MINUTE,Occurance_Date)/5)*5<10 then  ''0''+cast( (datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)) else cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)) end      as ''date'',count(*) as ''total''  from UDV_ScenarioAveragePerWeek group by ScenarioTitle1,datepart(MINUTE,Occurance_Date)/5 order by (datepart(MINUTE,Occurance_Date)/5)*5'
						--set @sqlstr='select ScenarioTitle1,    case when   (datepart(MINUTE,Occurance_Date)/5)*5 <10 and (datepart(MINUTE,Occurance_Date)/5)*5+5 <10   then  concat (''00:'' ,''0'',cast( (datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', ''0'',cast( (datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5) when (datepart(MINUTE,Occurance_Date)/5)*5 <10 and (datepart(MINUTE,Occurance_Date)/5)*5+5 >=10 then concat(''00:''  ,''0'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5)    else concat(''00:'' , cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5)   end as ''date'',NULL as ''date2'',count(*) as ''total''  from UDV_ScenarioAveragePerWeek group by ScenarioTitle1,datepart(MINUTE,Occurance_Date)/5 order by (datepart(MINUTE,Occurance_Date)/5)*5'
						set @sqlstr='select TouchPointTitle1 as TouchPointName ,    case when   (datepart(MINUTE,Occurance_Date)/5)*5 <10 and (datepart(MINUTE,Occurance_Date)/5)*5+5 <10   then  concat (''00:'' ,''0'',cast( (datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', ''0'',cast( (datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5) when (datepart(MINUTE,Occurance_Date)/5)*5 <10 and (datepart(MINUTE,Occurance_Date)/5)*5+5 >=10 then concat(''00:''  ,''0'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5)    else concat(''00:'' , cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5)   end as ''date'','''' as ''date2'',count(*) as ''total''  
							from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' group by TouchPointTitle1  , datepart(MINUTE,Occurance_Date)/5 order by (datepart(MINUTE,Occurance_Date)/5)*5'
					end
					
					--month
					if(@GroupType=3)
					begin

					declare @MonthCount int;
					select @MonthCount=(select count(distinct datepart(month,Occurance_Date))from UDV_ScenarioAveragePerWeek);

					if @MonthCount>1
						--set @sqlstr='select ScenarioTitle1,DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime)))  as ''date'',FORMAT(Occurance_Date, ''MMMM'', ''de-de'') AS ''MonthnameGER'',count(*) as ''total''  from UDV_ScenarioAveragePerWeek group by ScenarioTitle1,DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))),FORMAT(Occurance_Date, ''MMMM'', ''de-de'')
						set @sqlstr='select TouchPointTitle1 as TouchPointName ,DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime)))  as ''date'',FORMAT(Occurance_Date, ''MMMM'', ''de-de'') AS ''MonthnameGER'',count(*) as ''total''  
							from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+'  group by TouchPointTitle1  , DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))),FORMAT(Occurance_Date, ''MMMM'', ''de-de'')
						order by CASE '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''January'' THEN 1 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''February'' THEN 2 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''March'' THEN 3'+ 
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''April'' THEN 4 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''May'' THEN 5 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''June'' THEN 6 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''July'' THEN 7 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''August'' THEN 8 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''September'' THEN 9 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''October'' THEN 10'+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''November'' THEN 11 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''December'' THEN 12 END ASC'--
						
					else
						--set @sqlstr='select ScenarioTitle1,DATENAME(weekday,Occurance_Date) as ''date'',FORMAT(Occurance_Date, ''dddd'', ''de-de'') as ''date2'',count(*) as ''total''  from UDV_ScenarioAveragePerWeek group by ScenarioTitle1,DATENAME(weekday,Occurance_Date) ,FORMAT(Occurance_Date, ''dddd'', ''de-de'')
						set @sqlstr='select TouchPointTitle1 as TouchPointName ,DATENAME(weekday,Occurance_Date) as ''date'',FORMAT(Occurance_Date, ''dddd'', ''de-de'') as ''date2'',count(*) as ''total''  
							from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' group by TouchPointTitle1  ,DATENAME(weekday,Occurance_Date) ,FORMAT(Occurance_Date, ''dddd'', ''de-de'')
						order by CASE '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 1 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 2 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 3 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 4 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 5 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 6 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 7 END ASC'
					end
		
						
				
			
		end
	else
		begin
				set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )	

				--hour
				if(@GroupType=0 or @GroupType is null)
					begin
						--set @sqlstr='select ScenarioTitle1,concat (cast( DATEPART(hour, Occurance_Date) as varchar(max)) , '':00'','' - '',cast( DATEPART(hour, Occurance_Date) as varchar(max))+1,'':00'') as ''date'',NULL as ''date2'',count(*) as ''total'' from UDV_ScenarioAveragePerWeek where '+@wherecode+' group by ScenarioTitle1, DATEPART(hour, Occurance_Date) order by cast( DATEPART(hour, Occurance_Date) as int)'
						set @sqlstr='select TouchPointTitle1 as TouchPointName ,concat (cast( DATEPART(hour, Occurance_Date) as varchar(max)) , '':00'','' - '',cast( DATEPART(hour, Occurance_Date) as varchar(max))+1,'':00'') as ''date'','''' as ''date2'',count(*) as ''total'' 
							from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' and '+@wherecode+' group by TouchPointTitle1  , DATEPART(hour, Occurance_Date) order by cast( DATEPART(hour, Occurance_Date) as int)'
					end
				
				--day
			    if(@GroupType=1)
					begin
						--set @sqlstr='select ScenarioTitle1,DATENAME(weekday,Occurance_Date) as ''date'',FORMAT(Occurance_Date, ''dddd'', ''de-de'') as ''date2'',count(*)   as ''total'' from UDV_ScenarioAveragePerWeek where '+@wherecode+' group by ScenarioTitle1,DATENAME(weekday,Occurance_Date),FORMAT(Occurance_Date, ''dddd'', ''de-de'') order by CASE '+
						set @sqlstr='select TouchPointTitle1 as TouchPointName ,DATENAME(weekday,Occurance_Date) as ''date'',FORMAT(Occurance_Date, ''dddd'', ''de-de'') as ''date2'',count(*)   as ''total'' 
							from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' and  '+@wherecode+' group by TouchPointTitle1 ,DATENAME(weekday,Occurance_Date),FORMAT(Occurance_Date, ''dddd'', ''de-de'') order by CASE '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 1 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 2 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 3 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 4 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 5 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 6 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 7 END ASC'
					end
				
				--minute
		        if(@GroupType=2)
					begin
						--set @sqlstr='select ScenarioTitle1,''00:''+    case when   (datepart(MINUTE,Occurance_Date)/5)*5<10 then  ''0''+cast( (datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)) else cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)) end      as ''date'',count(*) as ''total''  from UDV_ScenarioAveragePerWeek where '+@wherecode+'  group by ScenarioTitle1,datepart(MINUTE,Occurance_Date)/5 order by (datepart(MINUTE,Occurance_Date)/5)*5'
						--set @sqlstr='select ScenarioTitle1, case when   (datepart(MINUTE,Occurance_Date)/5)*5 <10 and (datepart(MINUTE,Occurance_Date)/5)*5+5 <10   then  concat (''00:'' ,''0'',cast( (datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', ''0'',cast( (datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5) when (datepart(MINUTE,Occurance_Date)/5)*5 <10 and (datepart(MINUTE,Occurance_Date)/5)*5+5 >=10 then concat(''00:''  ,''0'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5)    else concat(''00:'' , cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5)   end    as ''date'',NULL as ''date2'',count(*) as ''total''  from UDV_ScenarioAveragePerWeek where '+@wherecode+'  group by ScenarioTitle1,datepart(MINUTE,Occurance_Date)/5 order by (datepart(MINUTE,Occurance_Date)/5)*5'
						set @sqlstr='select TouchPointTitle1 as TouchPointName , case when   (datepart(MINUTE,Occurance_Date)/5)*5 <10 and (datepart(MINUTE,Occurance_Date)/5)*5+5 <10   then  concat (''00:'' ,''0'',cast( (datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', ''0'',cast( (datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5) when (datepart(MINUTE,Occurance_Date)/5)*5 <10 and (datepart(MINUTE,Occurance_Date)/5)*5+5 >=10 then concat(''00:''  ,''0'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5)    else concat(''00:'' , cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10)),'' - '',''00:'', cast((datepart(MINUTE,Occurance_Date)/5)*5 as varchar(10))+5)   end    as ''date'','''' as ''date2'',count(*) as ''total''  
							from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' and  '+@wherecode+'  group by TouchPointTitle1 ,datepart(MINUTE,Occurance_Date)/5 order by (datepart(MINUTE,Occurance_Date)/5)*5'
					end
				
				--month
			    if(@GroupType=3)
					begin
					select @MonthCount=(select count(distinct datepart(month,Occurance_Date))from UDV_ScenarioAveragePerWeek where Occurance_Date between @StartDate and  @EndDate );
					--where Occurance_Date between @StartDate and  @EndDate);

					if @MonthCount>1
						--set @sqlstr='select ScenarioTitle1,DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime)))  as ''date'',FORMAT(Occurance_Date, ''MMMM'', ''de-de'') AS ''date2'' ,count(*) as ''total''  from UDV_ScenarioAveragePerWeek where '+@wherecode+'  group by ScenarioTitle1,DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))),FORMAT(Occurance_Date, ''MMMM'', ''de-de'')
						set @sqlstr='select TouchPointTitle1 as TouchPointName ,DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime)))  as ''date'',FORMAT(Occurance_Date, ''MMMM'', ''de-de'') AS ''date2'' ,count(*) as ''total''  
						from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' and  '+@wherecode+'  group by TouchPointTitle1 ,DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))),FORMAT(Occurance_Date, ''MMMM'', ''de-de'')
						order by CASE '+
									'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''January'' THEN 1 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''February'' THEN 2 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''March'' THEN 3'+ 
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''April'' THEN 4 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''May'' THEN 5 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''June'' THEN 6 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''July'' THEN 7 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''August'' THEN 8 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''September'' THEN 9 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''October'' THEN 10'+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''November'' THEN 11 '+
						'WHEN DATENAME(month, DATEADD(month, (datepart(month,Occurance_Date))-1, CAST(''2018-01-01'' AS datetime))) = ''December'' THEN 12 END ASC'--
						else 
							--set @sqlstr='select ScenarioTitle1,DATENAME(weekday,Occurance_Date) as ''date'',FORMAT(Occurance_Date, ''dddd'', ''de-de'') as ''date2'',count(*)   as ''total'' from UDV_ScenarioAveragePerWeek where '+@wherecode+' group by ScenarioTitle1,DATENAME(weekday,Occurance_Date),FORMAT(Occurance_Date, ''dddd'', ''de-de'') order by CASE '+
							set @sqlstr='select TouchPointTitle1 as TouchPointName ,DATENAME(weekday,Occurance_Date) as ''date'',FORMAT(Occurance_Date, ''dddd'', ''de-de'') as ''date2'',count(*)   as ''total'' 
								from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' and  '+@wherecode+' group by TouchPointTitle1  ,DATENAME(weekday,Occurance_Date),FORMAT(Occurance_Date, ''dddd'', ''de-de'') order by CASE '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Sunday'' THEN 1 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Monday'' THEN 2 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Tuesday'' THEN 3 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Wednesday'' THEN 4 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Thursday'' THEN 5 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Friday'' THEN 6 '+
									'WHEN cast(DATENAME(weekday,Occurance_Date) as varchar(15)) = ''Saturday'' THEN 7 END ASC'


					end
						
			
		end	
		print @sqlstr
---------------------------------------------------------------------------------------------------------------------	
	   execute(@sqlstr)
END