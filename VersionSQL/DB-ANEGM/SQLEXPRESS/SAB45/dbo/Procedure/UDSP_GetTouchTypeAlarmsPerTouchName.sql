/****** Object:  Procedure [dbo].[UDSP_GetTouchTypeAlarmsPerTouchName]    Committed by VersionSQL https://www.versionsql.com ******/

CREATE PROCEDURE [dbo].[UDSP_GetTouchTypeAlarmsPerTouchName](
													@StartDate datetime=null    ,
													@EndDate datetime=null,
													@TouchpointTypeID int=0
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
-------------------------------------------------Quiry--------------------------------------------------------

				if(@wherecode='')
				begin
							
					set @sqlstr='select TouchPointTitle1 as TouchPointName , AlarmDefinitionTitle1 as AlarmName , count(*) as AlarmsCount '+
								' from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+				
								'  group by TouchPointTitle1 , AlarmDefinitionTitle1  order by TouchPointTitle1 ASC' 
				end
				else
				begin
					set @wherecode=SUBSTRING ( @wherecode ,0 ,LEN ( @wherecode ) -3  )
					set @sqlstr='select TouchPointTitle1 as TouchPointName , AlarmDefinitionTitle1 as AlarmName , count(*) as AlarmsCount '+
								' from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' AND '+@wherecode+				
								'  group by TouchPointTitle1 , AlarmDefinitionTitle1  order by TouchPointTitle1 ASC'
				end
			
	 print @sqlstr
	execute(@sqlstr)
SET NOCOUNT OFF;	
END