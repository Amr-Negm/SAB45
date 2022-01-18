/****** Object:  Procedure [dbo].[UDSP_GetAlarmAveragePerDay]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAlarmAveragePerDay](
													@City nvarchar(max)=null		,
													@Station nvarchar(max)=null   ,
													@Level nvarchar(max)=null     ,
													@Zone nvarchar(max)=null      ,
													@Camera nvarchar(max)=null    ,
													@StartDate datetime=null    ,
													@EndDate datetime=null
													)
AS
BEGIN
SET FMTONLY OFF;
		 --select count([AlarmScenarioID]) as 'AvgBerDay', cast(DATENAME(weekday,SelectedCreationDate) as varchar(3)) as Dayname ,CityTitle1,StationTitle1,LevelTitle1,ZoneTitle1,TouchPointTitle1,Occurance_Date
			--			from [dbo].[UDV_AllScenarios] where CityTitle1=isnull((@City),CityTitle1)				AND
			--										[StationTitle1]=isnull((@Station),[StationTitle1])		AND 
			--										[LevelTitle1]=isnull((@Level),[LevelTitle1])				AND 
			--										[ZoneTitle1]=isnull((@Zone),[ZoneTitle1])					AND 
			--										[TouchPointTitle1]=isnull((@Camera),[TouchPointTitle1])   AND
			--										[Occurance_Date]>=isnull((@StartDate),[Occurance_Date])	AND 
			--										[Occurance_Date]<=isnull(DATEADD(day,1,(@EndDate)),[Occurance_Date]) and
			--										IsSelected=1 and
			--										SelectedCreationDate is not null
														
			--			 group by cast(DATENAME(weekday,SelectedCreationDate) as varchar(3)),CityTitle1,StationTitle1,LevelTitle1,ZoneTitle1,TouchPointTitle1,Occurance_Date



			declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			
		set @sqlstr=' SET STATISTICS TIME ON '
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
		set @sqlstr+='				  select count([AlarmScenarioID]) as ''AvgBerDay'', cast(DATENAME(weekday,SelectedCreationDate) as varchar(3)) as Dayname '+
						'from [dbo].[T_AllScenarios] where IsSelected=1 and SelectedCreationDate is not null '+				
						 'group by cast(DATENAME(weekday,SelectedCreationDate) as varchar(3))'
		end
else
	begin
	set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
		set @sqlstr+='				  select count([AlarmScenarioID]) as ''AvgBerDay'', cast(DATENAME(weekday,SelectedCreationDate) as varchar(3)) as Dayname '+
						'from [dbo].[T_AllScenarios] where IsSelected=1 and SelectedCreationDate is not null AND '+@wherecode+				
						 ' group by cast(DATENAME(weekday,SelectedCreationDate) as varchar(3))'
	end

	print @sqlstr
	execute(@sqlstr)
END