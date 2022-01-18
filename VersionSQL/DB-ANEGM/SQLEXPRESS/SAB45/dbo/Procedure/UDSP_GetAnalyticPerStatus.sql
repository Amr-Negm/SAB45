/****** Object:  Procedure [dbo].[UDSP_GetAnalyticPerStatus]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAnalyticPerStatus]( 
												--@City nvarchar(max)=		null,
												--@Station nvarchar(max)=		null,
												--@Level nvarchar(max)=		null,
												--@Zone nvarchar(max)=		null,
												@Location nvarchar(max)=		null,
												@Camera nvarchar(max)=		null,
												@StartDate datetime=		null,
												@EndDate datetime=			null
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
				--if(@City!='' or @City!=null)
				--begin
				--	set @wherecode+='CityTitle1='''+@City+''' AND '
				--end 
				--
				--if(@Station!='' or @Station!=null)
				--begin
				--	set @wherecode+='  [StationTitle1]='''+@Station+''' AND '
				--end 
				--
				--if(@Level!='' or @Level!=null)
				--begin
				--	set @wherecode+='  [LevelTitle1]='''+@Level+''' AND'
				--end 
				--
				--if(@Zone!='' or @Zone!=null)
				--begin
				--	set @wherecode+='  [ZoneTitle1]='''+@Zone+''' AND'
				--end 
				
				if(@Location!='' or @Location!=null)
				begin
					set @wherecode+='  l.name='''+@Location+''' AND'
				end 
				if(@Camera!='' or @Camera!=null)
				begin
					set @wherecode+='  [TouchPointTitle1]='''+@Camera+''' AND'
				end 
				
				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]>='''+CONVERT(VARCHAR(20), @StartDate, 120)+':000'' AND'
				end 
				if(@StartDate ='' or @StartDate is null)
				begin
					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date), 120)+''' AND'
				end 

				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(20), @EndDate    , 120)+':000'' AND'
				end
				if(@EndDate ='' or @EndDate is null)
				begin
					set @wherecode+='  cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' AND'
				end
				
				
	if(@wherecode='')
		begin		
		--set @sqlstr='					select AlarmStatusTitle1,count(AlarmID) as value	'+
		--								'from [dbo].[UDV_AllAlarmsNew] group by AlarmStatusTitle1'

		--2019-02-13 Edit by Abouelela
		--set @sqlstr='					select   LT_AlarmStatuses.AlarmStatusID,AlarmStatusTitle1,count(AlarmID) as value	'+
		--								'FROM            T_Alarms INNER JOIN LT_AlarmStatuses ON T_Alarms.AlarmStatusID = LT_AlarmStatuses.AlarmStatusID group by AlarmStatusTitle1, LT_AlarmStatuses.AlarmStatusID'

		--abdelwahed 17-2-2020
			set @sqlstr='	select   AlarmStatusID,AlarmStatusTitle1,AlarmStatusTitle2,count(*) as value	'+
										' FROM [dbo].[UDV_AlarmsAverage]'+
										' group by AlarmStatusTitle1,AlarmStatusTitle2, AlarmStatusID'

				--set @sqlstr='	select   LT_AlarmStatuses.AlarmStatusID,AlarmStatusTitle1,AlarmStatusTitle2,count(a.AlarmID) as value	'+
				--						' FROM T_Alarms a INNER JOIN LT_AlarmStatuses 	'+
				--						' ON a.AlarmStatusID = LT_AlarmStatuses.AlarmStatusID'+
				--						' inner join T_EventAlarms ea on ea.AlarmID = a.AlarmID'+
				--						' inner join T_Events e on e.EventID=ea.EventID'+
				--						' inner join T_EventDefinitions ed on ed.EventDefinitionID = e.EventDefinitionID'+
				--						' inner join T_TouchPoints tp on tp.TouchPointID = ed.TouchPointIDSource	'+
				--						' inner join T_TouchPointLocation tpl on tpl.TouchPointID=tp.TouchPointID'+
				--						' inner join T_Location l on l.LocationID=tpl.LocationID'+
				--						' group by AlarmStatusTitle1,AlarmStatusTitle2, LT_AlarmStatuses.AlarmStatusID'
		end
	else
		begin
		set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )		
		--set @sqlstr='					select AlarmStatusTitle1,count(AlarmID) as value	'+
		--								'from [dbo].[UDV_AllAlarmsNew] where '+@wherecode+' group by AlarmStatusTitle1'

		--abdelwahed 17-2-2020
			set @sqlstr='	select   AlarmStatusID,AlarmStatusTitle1,AlarmStatusTitle2,count(*) as value	'+
										' FROM [dbo].[UDV_AlarmsAverage] where '+@wherecode +
										' group by AlarmStatusTitle1,AlarmStatusTitle2, AlarmStatusID'

		--set @sqlstr='					select   LT_AlarmStatuses.AlarmStatusID,AlarmStatusTitle1,AlarmStatusTitle2,count(a.AlarmID) as value	'+
		--								' FROM T_Alarms a INNER JOIN LT_AlarmStatuses 	'+
		--								' ON a.AlarmStatusID = LT_AlarmStatuses.AlarmStatusID'+
		--								' inner join T_EventAlarms ea on ea.AlarmID = a.AlarmID'+
		--								' inner join T_Events e on e.EventID=ea.EventID'+
		--								' inner join T_EventDefinitions ed on ed.EventDefinitionID = e.EventDefinitionID'+
		--								' inner join T_TouchPoints tp on tp.TouchPointID = ed.TouchPointIDSource	'+
		--								' inner join T_TouchPointLocation tpl on tpl.TouchPointID=tp.TouchPointID'+
		--								' inner join T_Location l on l.LocationID=tpl.LocationID where' + @wherecode +
		--								' group by AlarmStatusTitle1,AlarmStatusTitle2, LT_AlarmStatuses.AlarmStatusID'
									end
		print @sqlstr
	execute(@sqlstr)
END