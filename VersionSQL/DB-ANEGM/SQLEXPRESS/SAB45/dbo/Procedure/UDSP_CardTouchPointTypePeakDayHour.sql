/****** Object:  Procedure [dbo].[UDSP_CardTouchPointTypePeakDayHour]    Committed by VersionSQL https://www.versionsql.com ******/

---------------------------------------------------------------AbdelwahedElnagar-------------------------------------
CREATE PROCEDURE [dbo].[UDSP_CardTouchPointTypePeakDayHour]( 
												@StartDate datetime=		null,
												@EndDate datetime=			null,
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
	
-------------------------------------------------Query--------------------------------------------------------	

				--set @sqlstr='select top(1) concat ( CONVERT(VARCHAR(20),cast( Occurance_Date as date), 120),'' / '' ,cast( DATEPART(hour, Occurance_Date) as varchar(max)), '':00'',''-'',cast( DATEPART(hour, Occurance_Date) as varchar(max))+1,'':00'') as DayHour,count(*) as total '+ 
				--			' from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' and '+@wherecode+ ' 1=1 '+
				--			' group by  concat ( CONVERT(VARCHAR(20),cast( Occurance_Date as date), 120),'' / '' ,cast( DATEPART(hour, Occurance_Date) as varchar(max)), '':00'',''-'',cast( DATEPART(hour, Occurance_Date) as varchar(max))+1,'':00'') order by total desc'
				
				set @sqlstr='select top(1) concat ( CONVERT(VARCHAR(20),cast( Occurance_Date as date), 120),'' / '' ,cast( DATEPART(hour, Occurance_Date) as varchar(max)), '':00'') as DayHour,count(*) as total '+ 
							' from UDV_AlarmsTouchpointTypes where [TouchPointTypeID] = ' + CAST(@TouchpointTypeID AS CHAR(10))+' and '+@wherecode+ ' 1=1 '+
							' group by  concat ( CONVERT(VARCHAR(20),cast( Occurance_Date as date), 120),'' / '' ,cast( DATEPART(hour, Occurance_Date) as varchar(max)), '':00'') order by total desc'
				
						
			
		
		print @sqlstr
---------------------------------------------------------------------------------------------------------------------	
	   execute(@sqlstr)
END