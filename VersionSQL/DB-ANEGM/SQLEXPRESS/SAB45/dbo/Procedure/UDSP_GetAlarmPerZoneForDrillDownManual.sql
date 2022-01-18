/****** Object:  Procedure [dbo].[UDSP_GetAlarmPerZoneForDrillDownManual]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetAlarmPerZoneForDrillDownManual] (  
													@Location nvarchar(100)=null      ,
													@Type nvarchar(100)=null      ,
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
				
				if(@Location!='' or @Location!=null)
				begin
					set @wherecode+=' [LocationName] ='''+@Location+''' AND'
				end 
				
				if(@Type!='' or @Type!=null)
				begin
					set @wherecode+=' [LocationTypeName] ='''+@Type+''' AND'
				end

				if(@Camera!='' or @Camera!=null)
				begin
					set @wherecode+='  [TouchPointTitle1]='''+@Camera+''' AND'
				end 
				
				if(@StartDate!='' or @StartDate!=null)
				begin
					set @wherecode+=' ( [Occurance_Date]>='''+CONVERT(VARCHAR(25), @StartDate, 121)+''' AND'
				end 
				if(@StartDate ='' or @StartDate is null)
				begin
					set @wherecode+='  (cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' or cast([Occurance_Date] as date) is null ) AND'
				end 


				if(@EndDate!='' or @EndDate!=null)
				begin
					set @wherecode+='  [Occurance_Date]<='''+CONVERT(VARCHAR(25), @EndDate   , 121)+''' or [Occurance_Date] is null) AND'
				end
				if(@EndDate ='' or @EndDate is null)
				begin
					set @wherecode+=' ( cast([Occurance_Date] as date) ='''+CONVERT(VARCHAR(20),cast( getdate() as date)    , 120)+''' or cast([Occurance_Date] as date) is null ) AND'
				end

	if(@wherecode='')
		begin
			--set @sqlstr='select count(A.alarmid) NoOfAlarms ,l.LocationID ,l.Name as LocationName ,l.ParentLocationID ,par.Name as ParentLocationName'+
			--			'From dbo.T_Location l '+
			--			'left join dbo.T_Location par on l.ParentLocationID=par.LocationID '+
			--			'left join dbo.LT_LocationType lt on lt.LocationTypeId = l.LocationTypeId '+
			--			'left join dbo.LT_LocationCategory lc on lc.LocationCategoryId = l.LocationCategoryId '+
			--			'Left join dbo.T_TouchPointLocation tpl on tpl.LocationID = l.LocationID '+
			--			'left JOIN dbo.T_TouchPoints T  on T.TouchPointID=tpl.TouchPointID '+
			--			'left join dbo.LT_TouchPointTypes tpt on tpt.TouchPointTypeID = T.TouchPointTypeID '+
			--			'left JOIN dbo.T_EventDefinitions ED ON ED.TouchPointIDSource=T.TouchPointID '+
			--			'left JOIN dbo.T_Events E ON E.EventDefinitionID = ED.EventDefinitionID '+
			--			'left JOIN dbo.T_EventAlarms EA ON EA.EventID=E.EventID  '+
			--			'left JOIN dbo.T_Alarms A  ON A.AlarmID=EA.AlarmID  '+
			--			'left JOIN dbo.T_AlarmDefinitions AD  ON AD.AlarmDefinitionID=A.AlarmsDefinitionID '+
			--			'group by l.LocationID,l.Name,l.ParentLocationID,par.Name'

						--18-2-2020
					set @sqlstr='select count([AlarmID]) NoOfAlarms ,LocationID ,[LocationName] as LocationName ,ParentLocationID ,[ParentLocationName] as ParentLocationName '+
						'From UDV_AlarmLocationManualAndAuto where (touchpointlocationstateid = 1 or touchpointlocationstateid is null) AND LocationStateId = 1 '+
						' group by LocationID ,[LocationName]  ,ParentLocationID ,[ParentLocationName]   ' 
						
		end
	else
		begin
		set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
		--set @sqlstr='select count(A.alarmid) NoOfAlarms ,l.LocationID ,l.Name as LocationName ,l.ParentLocationID ,par.Name as ParentLocationName '+
		--				'From dbo.T_Location l '+
		--				'left join dbo.T_Location par on l.ParentLocationID=par.LocationID '+
		--				'left join dbo.LT_LocationType lt on lt.LocationTypeId = l.LocationTypeId '+
		--				'left join dbo.LT_LocationCategory lc on lc.LocationCategoryId = l.LocationCategoryId '+
		--				'Left join dbo.T_TouchPointLocation tpl on tpl.LocationID = l.LocationID '+
		--				'left JOIN dbo.T_TouchPoints T  on T.TouchPointID=tpl.TouchPointID '+
		--				'left join dbo.LT_TouchPointTypes tpt on tpt.TouchPointTypeID = T.TouchPointTypeID '+
		--				'left JOIN dbo.T_EventDefinitions ED ON ED.TouchPointIDSource=T.TouchPointID '+
		--				'left JOIN dbo.T_Events E ON E.EventDefinitionID = ED.EventDefinitionID '+
		--				'left JOIN dbo.T_EventAlarms EA ON EA.EventID=E.EventID  '+
		--				'left JOIN dbo.T_Alarms A  ON A.AlarmID=EA.AlarmID  '+
		--				'left JOIN dbo.T_AlarmDefinitions AD  ON AD.AlarmDefinitionID=A.AlarmsDefinitionID WHERE '+@wherecode+
		--				' group by l.LocationID,l.Name,l.ParentLocationID,par.Name'

						--18-2-2020
						set @sqlstr='select count([AlarmID]) NoOfAlarms ,LocationID ,[LocationName] as LocationName ,ParentLocationID ,[ParentLocationName] as ParentLocationName '+
						'From UDV_AlarmLocationManualAndAuto '+
						'WHERE (touchpointlocationstateid = 1 or touchpointlocationstateid is null)  AND ( LocationStateId = 1 or LocationStateId is null)and '+@wherecode+
						' group by LocationID ,[LocationName]  ,ParentLocationID ,[ParentLocationName]   ' 
						
		end
	print @sqlstr
	execute(@sqlstr)

END