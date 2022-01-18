/****** Object:  Procedure [dbo].[UDSP_Top10ChartGetAlarmAveragePerHourByDay]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_Top10ChartGetAlarmAveragePerHourByDay](@day nvarchar(10)=null			,
														@City nvarchar(max)=null		,
														@Station nvarchar(max)=null     ,
														@Level nvarchar(max)=null       ,
														@Zone nvarchar(max)=null        ,
														@Camera nvarchar(max)=null      ,
														@StartDate datetime=null        ,
														@EndDate datetime=null
														)
AS
BEGIN
SET NOCOUNT ON;	
	--select convert(varchar(15),cast(dbo.MinutesToDuration(a.hour*60) as time),100) as 'HourBerDay',
	--						a.Value  as 'AvgBerDay',CityTitle1,StationTitle1,LevelTitle1,ZoneTitle1,TouchPointTitle1,Occurance_Date
	--				         from  
	--						 (select count(*) as Value,DATEPART(hour,SelectedCreationDate)  as hour  ,CityTitle1,StationTitle1,LevelTitle1,ZoneTitle1,TouchPointTitle1,Occurance_Date
	--								from [dbo].[UDV_AllScenarios]  where CityTitle1=isnull(NULLIF(@City,''),CityTitle1)				AND
	--												[StationTitle1]=isnull(NULLIF(@Station,''),[StationTitle1])		AND 
	--												[LevelTitle1]=isnull(NULLIF(@Level,''),[LevelTitle1])				AND 
	--												[ZoneTitle1]=isnull(NULLIF(@Zone,''),[ZoneTitle1])					AND 
	--												[TouchPointTitle1]=isnull(NULLIF(@Camera,''),[TouchPointTitle1])   AND
	--												[Occurance_Date]>=isnull(@StartDate,[Occurance_Date])	AND 
	--												[Occurance_Date]<=isnull(DATEADD(day,1,NULLIF(@EndDate,'')),[Occurance_Date])	AND
	--											    LOWER(cast(DATENAME(weekday,SelectedCreationDate) as varchar(3)))=isnull(NULLIF(LOWER(@day),''),
	--												 LOWER(cast(DATENAME(weekday,SelectedCreationDate) as varchar(3)))) AND
	--												  IsSelected=1 and SelectedCreationDate is not null
	--								 group by DATEPART(hour,SelectedCreationDate),CityTitle1,StationTitle1,LevelTitle1,ZoneTitle1,TouchPointTitle1,Occurance_Date ) a 


	declare @wherecode nvarchar(max)
			declare @sqlstr nvarchar(max)
			
			set @sqlstr=''
-------------------------------------------------Alarms Total Number--------------------------------------------------------
		set @wherecode=''


		
		       if(@day!='')
				begin
					set @wherecode+='LOWER(cast(DATENAME(weekday,SelectedCreationDate) as varchar(3)))='''+@day+''' AND '
				end 

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
				set @sqlstr='  select convert(varchar(15),cast(cast(a.hour as varchar(2))+'':00:00'' as time(0)),100) as ''HourBerDay'', a.Value  as ''AvgBerDay'',20 as StoredProcedureID '+
					         'from  '+
							 '(select count(*) as Value,DATEPART(hour,SelectedCreationDate)  as hour ,20 as StoredProcedureID '+
									'from [dbo].[UDV_AllScenarios]  where '+
													  'IsSelected=1 and SelectedCreationDate is not null group by DATEPART(hour,SelectedCreationDate)) a'
		end
		else
		begin
		set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
						set @sqlstr='  select convert(varchar(15),cast(cast(a.hour as varchar(2))+'':00:00'' as time(0)),100) as ''HourBerDay'', a.Value  as ''AvgBerDay'',20 as StoredProcedureID '+
					         'from  '+
							 '(select count(*) as Value,DATEPART(hour,SelectedCreationDate)  as hour  '+
									'from [dbo].[UDV_AllScenarios]  where '+@wherecode+' AND '+
													  'IsSelected=1 and SelectedCreationDate is not null group by DATEPART(hour,SelectedCreationDate)) a'
		end									  

		execute(@sqlstr)
SET NOCOUNT OFF;	
END