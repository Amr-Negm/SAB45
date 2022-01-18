/****** Object:  Procedure [dbo].[UDSP_GetTouchTypeAlarmsPerZoneDrillDown]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetTouchTypeAlarmsPerZoneDrillDown] (  
													@Location nvarchar(100)=null      ,
													@Type nvarchar(100)=null      ,
													@Camera nvarchar(100)=null      ,
													@StartDate datetime=null        ,
													@EndDate datetime=null		,
													@TouchpointTypeID int = null)
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

				if(@TouchpointTypeID ='' or @TouchpointTypeID is null)
				begin
					set @TouchpointTypeID=0
				end

	if(@wherecode='')
		begin
			
					set @sqlstr='select count([AlarmID]) NoOfAlarms ,LocationID ,[LocationName] as LocationName ,ParentLocationID ,[ParentLocationName] as ParentLocationName '+
						'From [db_owner].[UDV_AlarmsLocation] where (touchpointlocationstateid = 1 or touchpointlocationstateid is null) and [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+
						' group by LocationID ,[LocationName]  ,ParentLocationID ,[ParentLocationName]   ' 
						
		end
	else
		begin
		set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
		
						set @sqlstr='select count([AlarmID]) NoOfAlarms ,LocationID ,[LocationName] as LocationName ,ParentLocationID ,[ParentLocationName] as ParentLocationName '+
						'From [db_owner].[UDV_AlarmsLocation] '+
						' where (touchpointlocationstateid = 1 or touchpointlocationstateid is null) and [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' and '+@wherecode+
						' group by LocationID ,[LocationName]  ,ParentLocationID ,[ParentLocationName]   ' 
						
		end
	print @sqlstr
	execute(@sqlstr)

END